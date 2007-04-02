From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Distribution of longest common hash prefixes
Date: Mon, 2 Apr 2007 17:28:35 +0200
Message-ID: <20070402152835.GB13293@bohr.gbar.dtu.dk>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 17:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYOSW-0000j1-IQ
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 17:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXDBP2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Apr 2007 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbXDBP2h
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Apr 2007 11:28:37 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:37069 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751209AbXDBP2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2007 11:28:37 -0400
Received: (qmail 15789 invoked by uid 5842); 2 Apr 2007 17:28:35 +0200
Content-Disposition: inline
In-Reply-To: <20070402145857.GA13293@bohr.gbar.dtu.dk>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43601>

On Mon, Apr 02, 2007 at 04:58:57PM +0200, Peter Eriksen wrote:
...
> Why does it look so sparse and strange?

... and here is the nonbroken version, which is neither sparse nor
strange. Thanks to chris on #git for the nice programming lesson.
More correct output and program bellow.

Peter


 0:  1
 1:  2
 2:  4
 3:  8
 4: 16
 5: 32
 6: 64
 7: 128
 8: 256
 9: 512
10: 1024
11: 2048
12: 4096
13: 8192
14: 16384
15: 32685
16: 60921
17: 86511
18: 84426
19: 61518
20: 37450
21: 20728
22: 11035
23: 5562
24: 2812
25: 1467
26: 738
27: 355
28: 191
29: 83
30: 49
31: 27
32: 10
33:  3
34:  1
35:  2
36:  0
37:  1
38:  0
39:  0
40:  0
41:  0
42:  0
43:  0
44:  0
45:  0
46:  0
47:  0
48:  0
49:  0
50:  0
51:  0
52:  0
53:  0
54:  0
55:  0
56:  0
57:  0
58:  0
59:  0
60:  0
61:  0
62:  0
63:  0



#include <stdio.h>
#include <string.h>


int h2d(char c)
{
	if ('a' <= c && c <= 'f')
		return c-'a'+10;
	else
		return c-'0';
}

int lcprefix(char *a, char *b)
{
	int i = 0;
	int j = 4;
	while (a[i] == b[i])
		i++;

	while ((h2d(a[i])<<j & 128) == (h2d(b[i])<<j & 128))
		j++;
	
	return i*4 + j - 4;
}

int max(int a, int b)
{
	return a < b ? b : a;
}

int main(int argc, char **argv)
{
	FILE *fp;
	char old[41];
	char cur[41];
	int lcp = 0;
	int table[64];
	int i;
	int tmp;

	memset(table, 0, 64*sizeof(int));
	memset(old, '0', 40);
	old[40] = '\0';

	fp = fopen(argv[1], "r");
	fscanf(fp, "%s\n", cur);

	tmp = lcprefix(old, cur);
	table[tmp]++;
	lcp = max(lcp, tmp);

	while (fscanf(fp, "%s\n", cur) != EOF) {
		tmp = lcprefix(old, cur);
		table[tmp]++;
		lcp = max(lcp, tmp);
		if (lcp < tmp) {
			printf("%s\n%s\n", old, cur);
			lcp = lcprefix(old, cur);
			printf("lcprefix = %d\n", lcp);
		}
		memcpy(old, cur, 40);
	}

	for(i = 0; i < 64; i++) {
		printf("%2d: %2d\n", i, table[i]);
	}
	
	return 0;
}

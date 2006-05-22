From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: [PATCH 0/2] tagsize < 8kb restriction
Date: Mon, 22 May 2006 16:48:03 +0200
Message-ID: <4471CF23.1070807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 22 16:48:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiBhR-0005F2-5y
	for gcvg-git@gmane.org; Mon, 22 May 2006 16:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWEVOr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 10:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWEVOr7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 10:47:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:40417 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750885AbWEVOr6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 10:47:58 -0400
Received: (qmail invoked by alias); 22 May 2006 14:47:56 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp042) with SMTP; 22 May 2006 16:47:56 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20508>

Hi,

I am currently working on an interface for source code quality assurance
tools to automatically scan newly commited code. Since it is the only
way to add data (scan-results) to an already-existing commit, I decided
to use tags for that.

Since the scan-results will most definitly exeed the 8kb-limit, I would
like to remove this artificial restriction.

I know I could also

    git-hash-object -t tag -w

but prefer using the "official" way.


In order not to write duplicate code I used parts of index_pipe() in
sha1_file.c

What I found odd when writing the patch was that main() in mktag.c uses
xread() to read from stdin (which respects EAGAIN and EINTR return
values), but index_pipe() in sha1_file.c just uses read() for doing
merely the same thing. For unifying both routines i found that xread()
might be the better choice.

Removing the restriction was pretty straightforward but do you think
this would break something in other places ?


[PATCH 1/2]
    remove the < 8kb restrinction from git-mktag

[PATCH 2/2]
    add more informative error messages to git-mktag


Bj

From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 16:43:06 +0100
Message-ID: <201112141643.06656.trast@student.ethz.ch>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:43:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqzT-00051J-AT
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab1LNPnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 10:43:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:29023 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796Ab1LNPnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:43:09 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:43:04 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 16:43:07 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187133>

Brian Gernhardt wrote:
> 
> It's time for my periodic complaint: People assuming `wc -l` outputs
> just a number.  wc on OS X (and perhaps other BSD-like systems)
> always aligns the output in columns, even with the -l flag.

Oops.

> Generally this results in a quick patch from me to remove some
> unneeded quotes.  However, this time it's used in a more complex
> manner:
[...]
> -           "($(git ls-files|wc -l) entries, 0 subtrees)" >expect &&
> +           "($(git ls-files|wc -l|sed -e 's/^ *//') entries, 0 subtrees)" >expect &&

I'm tempted to say we should define

test_wc_l () {
	test $# = 0 || error "bug in test script: passing arguments to wc -l is not portable"
	wc -l | tr -d -c 0-9
}

just to avoid issues if any wc comes across and prints a tab for
padding or says "hi, the number of lines you wanted to know is: 42".



(Oddly, according to 'man 1p wc' here, the POSIXly correct format in
the absence of options is

  "%d %d %d %s\n", <newlines>, <words>, <bytes>, <file>

Taking it literally would mean no padding/alignment whatsoever.
Neither GNU wc on my Linux exactly conforms to this.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

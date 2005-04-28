From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Built-in diff driver shows Index: line.
Date: Thu, 28 Apr 2005 15:30:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281522560.18901@ppc970.osdl.org>
References: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504281236090.18901@ppc970.osdl.org> <7vacni5z9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:25:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHQf-0001zb-Kq
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVD1W3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVD1W3I
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:29:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:44212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262298AbVD1W2n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:28:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SMSbs4019738
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 15:28:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SMSaAd015982;
	Thu, 28 Apr 2005 15:28:36 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacni5z9y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
> 
> So I'd say we'd punt this one for now, unless somebody else has
> a better idea.

It's trivially easy to do it with a external diff helper.

So you can do it with a few lines of GIT_EXTERNAL_DIFF, and the hardest 
part is showing it in a nice format (ie do the normalization of the 
results that diffstat does).

The external diff program can _literally_ just do something like

	#!/bin/sh
	name="$1"
	src="$2"
	dst="$5"
	diff "$src" "$dst" | cut -c1 | grep '[<>]' | sort | uniq -c

and the output should be something like

    458 <
    104 >

which means "458 lines removed, 104 lines added". Pretty-print it some, 
and you're done.

Hacky hacky,

		Linus

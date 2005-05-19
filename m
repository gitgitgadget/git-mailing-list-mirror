From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 15:26:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
 <7vsm0jyryf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
 <7vy8abx8ay.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
 <7vll6ayjok.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 00:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYtQp-00061e-EG
	for gcvg-git@gmane.org; Fri, 20 May 2005 00:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVESWYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVESWYq
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 18:24:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:37823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261280AbVESWYl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 18:24:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JMOYU3021340
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 15:24:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JMOY62012746;
	Thu, 19 May 2005 15:24:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll6ayjok.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
> 
> We are talking about the Plumbing.  Thank you for reminding me,
> but sometimes people end up using the bare Plumbing.

There's a pretty simple and nice way to make it both useful and easy to do 
to arbitrary precision.

Think of the number following the -M as the mantissa.

So -M9 means 0.9 aka "90% match" (or "difference", depending on which way
you want to go), and in general -Mx would have the "10% increments" thing.

But since it's a fraction, you just give more precision by adding more 
numbers, and -M99 would be "99% match", while "-M02" would be "2% match"

Then it would be logical for a plain -M to be 100% match / 0% difference
(ie only show renames that are exact), since a "0% match" / 100%
difference is nonsensical.

Alternatively, we'd have -M (without any number) just default to 
something, and you'd give a separate number of how closely you want to 
mach things, ie

	# These all mean the same thing: (default) 20% difference
	git-diff-tree -M
	git-diff-tree -M --match=80
	git-diff-tree -M --differ=20

	# show only renames that are perfect matches.
	git-diff-tree -M --match=100

	# show _everything_ as a rename, except the
	# matching matrix means that we prefer better
	# matches over worse
	git-diff-tree -M --match=0

Hmm?

		Linus

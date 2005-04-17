From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 12:33:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
 <20050417195742.D13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 21:29:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFRe-00033d-HQ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDQTb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVDQTb6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:31:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:60547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVDQTbc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:31:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HJVOs4012060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 12:31:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HJVNBg031459;
	Sun, 17 Apr 2005 12:31:24 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417195742.D13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
> 
> I still need to work out how to make my noddy script follow different
> branches which may be present though.  However, for my common work
> flow, it fits what I require.

The way to handle that is that you need to 

 - remember (or re-fetch) what the latest HEAD was that you merged with in 
   my tree.

   if you didn't remember, you can just get all my objects and do a

	merge-head $(cat .git/HEAD) $linus-current-head

   or something (using the current git archive that has a "merge-head" 
   program. That gives you the most recent common head.

 - use "rev-tree" to show reachability

	rev-tree $my-current-head $last-merge-head
		| sort -n		# sort by date rather than sha1
		| cut -d' ' -f2		# get the sha1 + "flags" mask
		| grep :1		# show the ones that are only
					# reachable from $my-current-head

and you now have a nice list of sha1's ordered by date.

Or something. I didn't test the above. Testing is for users.

		Linus

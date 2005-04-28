From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 15:22:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281518100.18901@ppc970.osdl.org>
References: <20050428200953.GD8514@redhat.com> <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org> <20050428220626.GC15706@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:16:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRHHv-0001CW-GN
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVD1WUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbVD1WUm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:20:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:60849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVD1WUf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:20:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SMKNs4018949
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 15:20:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SMKLAS015486;
	Thu, 28 Apr 2005 15:20:22 -0700
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050428220626.GC15706@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Dave Jones wrote:
>
> Groovy. Is it 'THE LAW' that the first one it reports will always be
> the most recent tag ?

Nope. They are reported in the order they are found, which is not 
meaningful at all (it depends on the directory ordering, with the 
highest-level bits being obviously ordered by the sha1 number thanks to 
the subdirectory stuff).

So you can only see the name of the tag - there's no ordering. The 
tag-name may of course imply an ordering in itself..

> Hmm, in a fresh rsync from your kernel tree, I get this..
> tagged commit a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3) in 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
> tagged commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (v2.6.12-rc2) in 9e734775f7c22d2f89943ad6c745571f1930105f
> expect dangling commits - potential heads - due to lack of head information
> dangling tag 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
> dangling commit 9acf6597c533f3d5c991f730c6a1be296679018e
> dangling tag 9e734775f7c22d2f89943ad6c745571f1930105f
> 
> Is that last part to be expected ?

It even says so: "expect dangling commits".

The tags will always be dangling, since nothing refers to them. Once you 
have them listed in your tag database (ie you've created files that 
mention them in .git/refs/tags or something), you can tell fsck about 
them, and fsck won't complain. 

Something like

	fsck-cache --unreachable $(cat .git/refs/*/*)

would do it (and depending on exactly how cogito ends up recording them).

		Linus

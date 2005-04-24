From: Linus Torvalds <torvalds@osdl.org>
Subject: Old "sparse" archive converted..
Date: Sat, 23 Apr 2005 18:25:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231815350.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 24 03:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPVlb-0003Mv-47
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 03:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVDXBXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 21:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVDXBXP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 21:23:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:24545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbVDXBXI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 21:23:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3O1N6s4022184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 18:23:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3O1N5EC024665;
	Sat, 23 Apr 2005 18:23:06 -0700
To: sparse mailing list <linux-sparse@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I expanded on "convert-cache" quite a bit, to the point where it could
actually re-write "commit" and "tree" objects entirely, at which point it
now became possible to convert the broken old sparse archive that had the
wrong date format in its commit objects, and had the old flat-file format
for the "tree" objects.

I updated the tree at

	kernel.org:/pub/linux/kernel/people/torvalds/sparse.git

to be this modern-format tree that fsck-cache no longer complains about.

If anybody is keeping an old-format tree around, I'll just warn you that 
I'm not going to necessarily guarantee that git will be able to read it in 
the future, so you should replace it with the modern one (which should 
just be a matter of either deleting the old one and getting a new copy, or 
you could do a

	convert-cache $(cat .git/HEAD)
	echo ..result.. > .git/HEAD
	git-prune-script
	read-tree $(cat .git/HEAD)
	update-cache --refresh
	fsck-cache --unreachable $(cat .git/HEAD)

which _should_ get you a clean tree with a top commit with the name
f765413f020fd2c97c22716320dc96b33cda7c43 if everything went right.

I'm considering turning on SHA1 validation by default when reading
objects, just because it's the right thing to do from a "find any fs
corruption early" angle, and it should be fairly cheap. That will make old 
pre-conversion trees no longer work.

			Linus

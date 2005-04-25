From: Linus Torvalds <torvalds@osdl.org>
Subject: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 12:25:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Apr 25 21:23:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ99v-0008Dr-Ii
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 21:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVDYT0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVDYT0s
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 15:26:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:15490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262781AbVDYTX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 15:23:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PJNPs4022381
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 12:23:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3PJNGCe032138
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 12:23:22 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I just pushed out my "tag" object implementation, and due to some
local braindamage over here, I ended up re-doing one commit, so if you
happened to pull my 'git' tree at _just_ the right time, you will have a
commit object named 06a02346f6a2e9ff113c189629ff7148f5141bb0 in your git 
repository, which is not exactly bogus, but which I ended up undoing.

So if you've been pulling my git stuff, check your "git log" for whether
you find that commit in your stuff. If you do, I guess it doesn't much
matter (ie should all merge in cleanly), but if you want to match my tree,
you should first undo it if it's your HEAD commit (by setting your HEAD to
the _parent_ of that commit, and then running the git-prune-script thing).

Anyway, I decided that my original model for tags was the right one, with 
a trivial extension. Notably, if you want to tag a single file or a tree 
object, go wild. The tag object format is:

	object <sha1>
	type <type>
	tag <tag>
	.. free-form commentary and signature of this all ..

and the "git-mktag" program verifies that the three first lines are valid 
before it accepts it and writes it as a git object.

Right now the tags don't do anything, except fsck can verify them (not the
signature - git doesn't even specify any particular format, and you may
validly have unsigned tags in your tree), and will print out something
like

	tagged commit e83c5163316f89bfbde7d9ab23ca2e25604af290 (v2.6.12-rc2)

if you were to have such a tag-object in your object database (you don't, 
because I've not generated one, but hey..)

		Linus

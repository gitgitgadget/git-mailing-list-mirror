From: Andreas Gal <gal@uci.edu>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 13:23:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 22:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQA3y-0008MZ-FB
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 22:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVDYUYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 16:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVDYUYe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 16:24:34 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:54715 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261155AbVDYUYE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 16:24:04 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3PKNw4E011506;
	Mon, 25 Apr 2005 13:23:58 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3PKNweT011502;
	Mon, 25 Apr 2005 13:23:58 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Are tag objects referenced by trees (and thus limited in scope) or are 
they stand-alone entities in the repository? The latter would be bad for 
shared object storages. Also, if I delete and recreate tags, will the old 
tag remain in the tree or will the file in the object storage disapear? 
So far all objects were always persistent, which is a nice property to 
have.

Andreas

On Mon, 25 Apr 2005, Linus Torvalds wrote:

> 
> Ok, I just pushed out my "tag" object implementation, and due to some
> local braindamage over here, I ended up re-doing one commit, so if you
> happened to pull my 'git' tree at _just_ the right time, you will have a
> commit object named 06a02346f6a2e9ff113c189629ff7148f5141bb0 in your git 
> repository, which is not exactly bogus, but which I ended up undoing.
> 
> So if you've been pulling my git stuff, check your "git log" for whether
> you find that commit in your stuff. If you do, I guess it doesn't much
> matter (ie should all merge in cleanly), but if you want to match my tree,
> you should first undo it if it's your HEAD commit (by setting your HEAD to
> the _parent_ of that commit, and then running the git-prune-script thing).
> 
> Anyway, I decided that my original model for tags was the right one, with 
> a trivial extension. Notably, if you want to tag a single file or a tree 
> object, go wild. The tag object format is:
> 
> 	object <sha1>
> 	type <type>
> 	tag <tag>
> 	.. free-form commentary and signature of this all ..
> 
> and the "git-mktag" program verifies that the three first lines are valid 
> before it accepts it and writes it as a git object.
> 
> Right now the tags don't do anything, except fsck can verify them (not the
> signature - git doesn't even specify any particular format, and you may
> validly have unsigned tags in your tree), and will print out something
> like
> 
> 	tagged commit e83c5163316f89bfbde7d9ab23ca2e25604af290 (v2.6.12-rc2)
> 
> if you were to have such a tag-object in your object database (you don't, 
> because I've not generated one, but hey..)
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

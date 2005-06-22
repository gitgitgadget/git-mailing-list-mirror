From: Linus Torvalds <torvalds@osdl.org>
Subject: The coolest merge EVER!
Date: Wed, 22 Jun 2005 14:46:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jun 22 23:43:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlCzl-0002SC-I2
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 23:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVFVVrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVFVVre
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 17:47:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262416AbVFVVow (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 17:44:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MLikjA026567
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Wed, 22 Jun 2005 14:44:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MLijI9005272
	for <git@vger.kernel.org>; Wed, 22 Jun 2005 14:44:46 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, Junio had some cool octopus merges, but I just one-upped him.

I just merged the "gitk" repository into git, and I did it as a real git
merge, which means that I actually retained all the original gitk
repository information intact. IOW, it's not a "import the data" thing,
it's literally a merge of the two trees, and the result has two roots.

Now, the advantage of this kind of merge is that Paul's original gitk
repository is totally unaffected by it, yet because I now have his history
(and the exact same objects), the normal kind of git merge should work
fine for me to continue to import Paul's work - we have the common parent
needed to resolve all differences.

Now, I don't know how often this ends up being actually used in practice, 
but at least in theory this is a totally generic thing, where you create a 
"union" of two git trees. I did the union merge manually, but in theory it 
should be easy to automate, with simply something like

	git fetch <project-to-union-merge>
	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
	git-update-cache --add -- (GIT_INDEX_FILE=.git/tmp-index git-ls-files)
	cp .git/FETCH_HEAD .git/MERGE_HEAD
	git commit

(this is not exactly how I did it, but that's just because I'd never done
this before so I didn't think it through and I had some stupid extra steps
in between that were unnecessary).

Of course, in order for the union merge to work, the namespaces have to be
fit on top of each other with no clashes, otherwise future merges will be 
quite painful. In the case of gitk, Paul's repository only tracked that 
single file, so that wasn't a problem.

Anyway, you shouldn't notice anything new, except for the fact that "gitk" 
now gets automatically included with the base git distribution. And the 
git repository has two roots, but hey, git itself doesn't care.

			Linus

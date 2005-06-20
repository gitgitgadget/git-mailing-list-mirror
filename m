From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'git commit' duplicates parents?
Date: Mon, 20 Jun 2005 10:44:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506201040140.2268@ppc970.osdl.org>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org> <42B62C85.10701@pobox.com>
 <Pine.LNX.4.58.0506191958010.2268@ppc970.osdl.org> <42B690EA.2080605@gmail.com>
 <Pine.LNX.4.58.0506200808090.2268@ppc970.osdl.org> <42B6FAE5.6060904@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 19:36:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkQC9-0008R3-7V
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 19:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFTRmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 13:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFTRmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 13:42:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261403AbVFTRmA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 13:42:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5KHfvjA022333
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 20 Jun 2005 10:41:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5KHfuuo009415;
	Mon, 20 Jun 2005 10:41:56 -0700
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <42B6FAE5.6060904@gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, Dan Holmsand wrote:
> 
> Yeah, but that was exactly what I was after...
> 
> As far as I understand it, the git-read-tree -u -m doesn't actually do
> anything when the workspace is dirty - so there's actually no merging 
> going on, right?

No, but you can trivially do so by hand afterwards.

For example, git-read-tree -u -m will complain and say "file xyz is 
dirty, cannot merge" (or something), and what you might decide to do is 
just

	git-checkout-cache -f -u xyz
	git resolve $(cat .git/HEAD) $(cat .git/MERGE_HEAD) "..."

and note how you needed to know what the merge head was in order to do 
this.

[ Side note: I should make "git-resolve-script" run "git-rev-parse" on its
  arguments, so that it would expand HEAD and MERGE_HEAD on its own. Maybe 
  somebody who is interested in this script might want to do that? Hint 
  hint. ]

Note how we could make both of us happy by saving that temporary 
MERGE_HEAD information somewhere _else_ instead. Maybe the answer is to 
only use "MERGE_HEAD" for the "merge manually" case, and use something 
else for the "this was the merge you tried to do last" case?

		Linus

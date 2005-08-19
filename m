From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [RFC] Importing from a patch-oriented SCM
Date: Fri, 19 Aug 2005 19:04:24 +1200
Message-ID: <46a038f9050819000417ed436e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 19 09:05:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E60wB-0004gN-KQ
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 09:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVHSHE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 03:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVHSHE2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 03:04:28 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:2177 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964857AbVHSHE1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 03:04:27 -0400
Received: by rproxy.gmail.com with SMTP id i8so454287rne
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 00:04:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HFJNKJL9E7RsYxe4FMzmjqFLjW0afHPB9+wlqTUIBtj8RLCn4yaAts2xQ3RkAHwB+/vqrA4wQ4u2woo9CjJmi+krNETym5cmdBAJcKT+L4yyNct5nOvD3Zf0agbuqgK22fqOuwclN9LyRuEFQ3i4squ1RxJGmNFsaV7SKfDf+6s=
Received: by 10.38.101.7 with SMTP id y7mr20617rnb;
        Fri, 19 Aug 2005 00:04:24 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 19 Aug 2005 00:04:24 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am drafting an import script to turn a GNU Arch into a GIT archive.
Importing the branches and commits increamentally is reasonably
straightforward -- or so it seems so far. Note: the repository
manipulation is based on cvsimport -- so my knowledge of the git repo
internals is still pertty close to zero.

Each patchset has a unique identifier, and can carry metadata with the
identifiers of the patches it "includes". If you are using gnu arch,
when you merge across branches, it'll know to skip a particular
patchset if it has been applied already. AFAICT there is no such
concept in GIT, and I wonder what to do with all this metadata about
merges.

My proto-plan is to keep track of merged stuff (in a cache file
somewhere), and if a particular merge means that the branches are
fully merged up to the last patch of the series (if no commits from
the source branch have been skipped) mark it as a merge in GIT.

If the merges have been done out-of-order, that may show up in the
latest merge. For example, branch A and B of the same project each
have 10 commits from the branching point. If a merge A -> B does
commits 1,2,3,7,8 it gets imported to git as a merge up to commit "3",
although there is more there. The next merge, which does 4,5,6,10 will
show up as a merge of commit 8.

Yuk. 

If I remember correctly, Junio added some stuff in the merge & rebase
code that will identify if a particular patch has been seen and
applied, and skip it even if it's a bit out of order. But I don't know
what that is based on, and whether I can somehow maximize the chances
of the patch being identified as already merged across branches. If
it's based on the initial commit identifier being carried through
(does that travel with commits when you merge?) I stand a small
chance. Otherwise, I'm lost.

Suggestions? 

cheers,


martin

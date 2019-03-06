Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61955202BB
	for <e@80x24.org>; Wed,  6 Mar 2019 06:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfCFGgZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 01:36:25 -0500
Received: from eggs.gnu.org ([209.51.188.92]:47000 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCFGgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 01:36:25 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e]:36355)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <tsdh@gnu.org>)
        id 1h1QA8-00033w-Vl
        for git@vger.kernel.org; Wed, 06 Mar 2019 01:36:22 -0500
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:41693)
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <tsdh@gnu.org>)
        id 1h1QA8-00073P-Od
        for git@vger.kernel.org; Wed, 06 Mar 2019 01:36:20 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id AF13D21CF3
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 01:36:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Mar 2019 01:36:19 -0500
X-ME-Sender: <xms:Y2p_XKhOfkOPNVi4eIBeqduicZbjOCZg84OjhgsmseG1dd5i9OazhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefvrghsshhilhhoucfjohhrnhcuoehtshguhhesghhnuhdrohhrgheq
    necuffhomhgrihhnpeigfehrohdruggvpdhgihhthhhusgdrtghomhenucfkphepudefge
    drudduledrvdegrdduleehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhorhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdekieejfeekjeekgedqieefhedvle
    ekqdhtshguhheppehgnhhurdhorhhgsehfrghsthhmrghilhdrfhhmnecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:Y2p_XHVa_Su1gJUeFqXh_egYSbNLJbOFGx3-IpLioexMUK5ppKxfkQ>
    <xmx:Y2p_XE2r_0IragQp0HZp8NJ_7hMJlDEgFLIUErdyX2EtoKztUPJ6kA>
    <xmx:Y2p_XFG9UsQXepSsn2kBETHPNjNnC0B7V4KyWHIwj-lET7-eKgdhOQ>
    <xmx:Y2p_XP-vLGCsUiwj6Qa92ltm3RIgcbCYbRs275WVPTO6uN0lHrkSFw>
Received: from jiffyarch (j289989.servers.jiffybox.net [134.119.24.195])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F7A110310
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 01:36:19 -0500 (EST)
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Subject: Un-submodule a repository with submodules
Date:   Wed, 06 Mar 2019 07:36:17 +0100
Message-ID: <87h8cgik66.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

my starting point is a Mercurial repository containing several
sub-repositories.  The parent repo itself has very little content itself
but mostly acts as "orchestrator" of the sub-repos, i.e., it contains
build files for building the project as a whole, and it has branches
which are reflected in the sub-repos (i.e., branch r1.0 in the parent
tracks the branch of the same name in all sub-repos).

The reason that this repository has sub-repositories is basically caused
by a injudicious decision a long time ago.  All the sub-repositories are
internal projects developed by the same team which have and will never
be used anywhere else but the current parent project.

My goal is to convert it to Git, do an on-the-fly UTF-8/UNIX-EOL
conversion for all source code files, and get rid of the
sub-repositories.

What I have so far is the Git/UTF-8/EOL conversion using the excellent
fast-export tool [1].  I.e., now I have Git repositories for all the
sub-repos and a parent Git project including all those as Git
submodules.

So what's left is the "un-submoduling" part.  Of course, I've searched
the net for solutions.  The best one I've found is this script [2]
which is based on this blog posting [3].

If I understand that correctly, what it does is essentially:

0. Remove the submodule from the parent project.
1. Use "git filter-branch" to rewrite the submodule's history so that
   it looks like its commits don't modify the files in . but in the
   submodule directory of the parent project.
2. Fetch the rewritten history into the parent project.
3. Do a merge, clone, add, commit combo which I don't quite understand.

   $ git merge -s ours --no-commit --allow-unrelated-histories \
               "${sub}/${branch}"
   # Add submodule content
   $ git clone -b "${branch}" "${url}" "${path}"
   $ git add "${path}"
   $ git commit -m "Merge submodule contents for ${sub}/${branch}"
   
   (Couldn't it just git merge --allow-unrelated-histories
   "${sub}/${branch}"?)
   
Anyway, the result of the procedure is that *after* the commit created
in step 3, the submodule is properly integrated including all its
history.
   
However, what doesn't satisfy me with that solution is that if I
checkout a commit before the "Merge submodule" commit made above (or
some tag or another branch), it'll still have the submodules.

So is there some way to integrate all submodules into the parent project
in such a way that it appears as if they have always been just commits
touching files inside some directory in the parent project?

Well, I guess my wish is not too uncommon and that there seems to be no
ready-made solution might be a good indicator of its infeasibility.  If
so, what would you suggest to mitigate the transition pain?

I'm thinking of a fallback plan like this:

  - Un-submodule just the master branch using the script in [2].
  - On each dev computer, have a git worktree for master and one for
    everything older because I assume it's tedious to frequently switch
    between submodule/non-submodule commits.
  - Bugs are usually fixed on the oldest active applicable branch and
    then merged or cherry-picked upwards.  How do I get them into master
    assuming the commit is in a sub-repository on another branch?  Is
    there something easier than plain diff/patch?

Thanks a lot for any help and suggestions,
Tassilo

* Footnotes
[1] https://github.com/frej/fast-export/
[2] https://github.com/jeremysears/scripts/blob/master/bin/git-submodule-rewrite
[3] https://x3ro.de/2013/09/01/Integrating-a-submodule-into-the-parent-repository.html

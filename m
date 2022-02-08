Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE4C43219
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386859AbiBHWYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBHWUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 17:20:12 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B66C0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 14:20:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29AEB105A2C;
        Tue,  8 Feb 2022 17:20:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=osgx/dxKLaeEYmtOYoaZ8t5aJCh1Eyc+2GdAmA0W154=; b=ABSi
        zaHGq5dHMubKGpQpd3TIhYFwD2W9AxysEmxcP/tivI2S7kpMQUABFE/WPnlvEa8L
        AGWg39Ek/GsRk4VHdfjf0GKl1+OK85z44RteQD1A/z7EKi/l/qJomYDrE9BM9DrH
        KOOXjgX5gQA2EIIO4RgKWlvYTbZ/JQfQwKrtSKQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B22D105A2B;
        Tue,  8 Feb 2022 17:20:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCC79105A2A;
        Tue,  8 Feb 2022 17:20:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, sunshine@sunshineco.com,
        allred.sean@gmail.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 14:20:06 -0800
Message-ID: <xmqqo83hatm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4656A438-892D-11EC-9313-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> index 4e23d73cdca..bccaec7a963 100644
> --- a/Documentation/config/extensions.txt
> +++ b/Documentation/config/extensions.txt
> @@ -6,3 +6,34 @@ extensions.objectFormat::
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
> +
> +extensions.worktreeConfig::
> +	If enabled, then worktrees will load config settings from the
> +	`$GIT_DIR/config.worktree` file in addition to the
> +	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> +	`$GIT_DIR` are the same for the main working tree, while other
> +	working trees have `$GIT_DIR` equal to
> +	`$GIT_COMMON_DIR/worktrees/<id>/`. The settings in the

The mixed use of "worktree" and "working tree" in this paragraph
might confuse readers into thinking that the paragraph is being
careful to make distinction between the two.  All references to
"working tree" in the above paragraph should actually be "worktree",
I would think.

	Side note: "working tree" is in the glossary-content.txt,
	but "worktree", which is one "working tree" + repository
	metadata (i.e. ".git/") that may be partially shared with
	other "worktree"s of a single repository, is not defined.

This is a tangent, but I wonder why we chose to use a different
filename (i.e. not "config" but "config.worktree") for this.  If we
were redoing multi-worktree support from scratch, we would not reuse
the $GIT_DIR used by the primary worktree as $GIT_COMMON_DIR, so
that all worktrees would share a single $GIT_COMMON_DIR and
$GIT_COMMON_DIR/config that has stuff that is shared among all the
worktrees, while per worktree stuff is in $GIT_DIR/config even for
the primary worktree.  But that is all water under the bridge now.

Other than the terminology gotcha, looked sensible.  Migrating
automatically and/or noticing a suspicious setting may be needed to
help end users, but that would not be within the scope of this step.

Attached is a "how about this?" glossary update suggestion.  Most of
the existing mention of "working tree" are fine as-is because they
only care about what is in the "working tree", but some should be
changed to "worktree" to stress the fact that they care not just the
"working tree" part but also the repository metadata part that is
associated with that single "working tree".  The first hunk says
worktree but it is clear that it is interested only in the "working
tree" files.

 Documentation/glossary-content.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
index c077971335..d816512c6a 100644
--- c/Documentation/glossary-content.txt
+++ w/Documentation/glossary-content.txt
@@ -312,7 +312,7 @@ Pathspecs are used on the command line of "git ls-files", "git
 ls-tree", "git add", "git grep", "git diff", "git checkout",
 and many other commands to
 limit the scope of operations to some subset of the tree or
-worktree.  See the documentation of each command for whether
+working tree.  See the documentation of each command for whether
 paths are relative to the current directory or toplevel.  The
 pathspec syntax is as follows:
 +
@@ -446,7 +446,7 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_working_tree,worktree>>, rather than
+	Refs that are per-<<def_worktree,worktree>>, rather than
 	global.  This is presently only <<def_HEAD,HEAD>> and any refs
 	that start with `refs/bisect/`, but might later include other
 	unusual refs.
@@ -669,3 +669,12 @@ The most notable example is `HEAD`.
 	The tree of actual checked out files.  The working tree normally
 	contains the contents of the <<def_HEAD,HEAD>> commit's tree,
 	plus any local changes that you have made but not yet committed.
+
+[[def_work_tree]]worktree::
+	A repository can have zero (i.e. bare repository) or one or
+	more worktrees attached to it. One "worktree" consists of a
+	"working tree" and repository metadata, most of which are
+	shared among other worktrees of a single repository, and
+	some of which are maintained separately per worktree
+	(e.g. the index, HEAD, per-worktree refs and per-worktree
+	configuration file)

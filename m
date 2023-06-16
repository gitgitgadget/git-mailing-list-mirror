Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C6EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjFPQmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjFPQmp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 12:42:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D32D4E
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 09:42:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CF1B18ABE6;
        Fri, 16 Jun 2023 12:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qKqkfCxdXOnXylpGcAsHeTAqXsUX7saPcC1w1K
        cM2Wk=; b=n+jxlG/N7Xj4PlSm9vihAorlDTK16BVgNhnSrUQWfbroHq15M2Q1Qd
        hN0CS+4nDXwElC6zIBr7QfZecPDxkIMEUFiJ/aCaL/yWqlQ5m99mzxzSs+qtF3OW
        PnPvQx7FMovvWQWMb1lSwKrQ+dGTw5fbyIu/qPBIVYPMT5orRLVcU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33D6F18ABE5;
        Fri, 16 Jun 2023 12:42:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9264E18ABE4;
        Fri, 16 Jun 2023 12:42:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>,
        Nadav Goldstein <nadav.goldstein@blazepod.co>
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
Date:   Fri, 16 Jun 2023 09:42:41 -0700
In-Reply-To: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com> (Nadav
        Goldstein via GitGitGadget's message of "Fri, 16 Jun 2023 11:00:09
        +0000")
Message-ID: <xmqqjzw3qry6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D04F55AC-0C64-11EE-BB9E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nadav Goldstein <nadav.goldstein@blazepod.co>
>
> In this patch, we introduce a new subcommand preserve to
> git stash. The purpose of this subcommand is to save the
> current changes into the stash and then immediately re-apply
> those changes to the working directory.

Why a new subcommand, not a new option to "push"?  Adding a new
subcommand would mean it would be another unfamiliar thing users
need to learn, as opposed to a slight variation of what they are
already familiar with.

> Implementation-wise, this is achieved by adding a new branch
> to the conditional in the cmd_stash function, where we check
> if argv[0] is "preserve". If it is, we push_stash with the
> new argument that we added to it preserve=1.
> In all other cases we call push_stack/do_push_stack preserve=0

The proposed log message is lacking "why".  What problem does it
want to solve?  What are the things you cannot do without the
feature, and what does the new feature allow you to do that you
couldn't do before?  On the other hand, the implementation detail,
unless it is tricky to read from the patch, does not have to be
repeated here---please aim to make the patch and new code clear
enough not to require such commentary.

More on this in "Describe your changes well" section in the
Documentation/SubmittingPatches document.

> Signed-off-by: Nadav Goldstein <nadav.goldstein96@gmail.com>
> ---
>     Add 'preserve' subcommand to 'git stash'
>     
>     In this patch, we introduce a new subcommand preserve to git stash. The
>     purpose of this subcommand is to save the current changes into the stash
>     and then immediately re-apply those changes to the working directory.
>     
>     Implementation-wise, this is achieved by adding a new branch to the
>     conditional in the cmd_stash function, where we check if argv[0] is
>     "preserve". If it is, we push_stash with the new argument that we added
>     to it preserve=1. In all other cases we call push_stack/do_push_stack
>     preserve=0

Please do not repeat what you already said in your log message here.
This is a place to give additional message that would help only
during the review.

>     If the community will approve, I will modify the patch to include help
>     messages for the new subcommand

Please don't think this way.  If the new feature is not worth
completing to document and tests for your own use, it is not worth
community's time to review or "approve" it.  Instead, we try to send
a patch that is already perfected, with tests and docs, in order to
improve the chance reviewers will understand the new feature and its
motivation better when they review the patch.

>  static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
> -			 int keep_index, int patch_mode, int include_untracked, int only_staged)
> +			 int keep_index, int patch_mode, int include_untracked, int only_staged, int preserve)
>  {
>  	int ret = 0;
>  	struct stash_info info = STASH_INFO_INIT;
> @@ -1643,7 +1643,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  				ret = -1;
>  				goto done;
>  			}
> -		} else {
> +		} else if (!preserve) {
>  			struct child_process cp = CHILD_PROCESS_INIT;
>  			cp.git_cmd = 1;
>  			/* BUG: this nukes untracked files in the way */

While this does skip the "reset --hard" step,

 * With --include-untracked and without a pathspec, we have run "clean
   --force --quiet" already, removing the untracked files that have
   been stored in the stash.  Wasn't the objective of the change to
   ensure that the working tree files are unaffected?

 * When run with a pathspec, this change has no effect, no?  We've
   added updated files with "add -u" to the index, compared the
   contents between HEAD and what was added with "add -u" and
   applied the reverse of it to both the index and the working tree,
   which amounts to reverting the changes to the paths that match
   the pathspec.

 * When run with --keep-index, there is another block after this
   part that uses "checkout --no-overlay" to ensure that the
   contents of the working tree matches what is in the index.

 * When the outermost "if (!(patch_mode || only_staged))" block is
   not entered, we'd run "apply -R" to revert the changes in the
   patch, whose point is to update the working tree contents.

What the patch does seem to fall far short of "preserving" in many
cases.  In some modes, I suspect that it might not make sense to use
"preserve" (for example, it could be that "--keep-index" may be
totally incompatible with "--preserve"), but that is hard to guess
without knowing _why_ you wanted to this new feature in the first
place.  Adding a separate subcommand that gives users no access to
these modes would be an easy way to avoid having to think about
these issues, but may close too many doors, including ones those
that do not have to be closed if this feature is done as a new
option to existing "push" command.  I dunno.

Thanks.

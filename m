Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9FC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 09:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiGRJGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiGRJGB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 05:06:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55EE033
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:06:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d16so16036228wrv.10
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TWy1XvWcXP1BNqP7KIzAtZdBM57Mc/sLlELXogCIdk=;
        b=A5tBkkpqR3fJdFbRELi8b2cJtDvBn0rWSCSz68nAcy3h+RQIUD/RdZFclxZ59Vsbp5
         foBCufh0nvhw1E1O8ywiMu2uGmL7ZsPhAXx9ZL4Jgn5lSfQfbuqJRs0jQXrgs2F3HxpK
         ix/V6lAYoFtqV4RHvNmZYPzU9e7xg4XLTGS42vtcCXqPKLEBDUf2dMN0ntbzkjgmRoUS
         yyK1bN1Hqlf3zFgL97TKqB92zarG0tOaM/TTktbTWDBH5ND9LrnYKBUwUwTkX+P19Jo5
         9ZvXIQwqCuQfrHPj8YbOakW2tG7lNMnRL+suM+mwGlt3HWs8GWAPinvc7ayRhMOGACUU
         w2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TWy1XvWcXP1BNqP7KIzAtZdBM57Mc/sLlELXogCIdk=;
        b=KiQCheyCnbBMPD9/UyX3BRPr3u5HU4jLLw22N1PtUuEj8WNMzhQJYn7h0t5WVV2ZzP
         4kKmuJqBFKuD27eAg2/omD8EFawd8HpZiDMQelqIkVnXUj4i55RHfJuDklNZoM48n0mc
         E2131xR8MO3ZtCx/aqBu1uG83sgRKEhbLu0mxBvXQtVY36izHrf3+TuTiqb9K9vRHb5S
         h6XcuRfOEaKl2se1EWJsj6dsQfcxBSJnRMEiQBcqRTQ1dQPvhUbwEZ9nzOKfcDwc5gvM
         BEFZY6adfRObaXZtV9PPcvuCgS3p9Il/F5gvwPPYm98u/hLF79e/VIL/KAAJjplKa2sV
         VPEw==
X-Gm-Message-State: AJIora83ukmPPINwhh3u9nJwe0pp9KMnSygHvJ0iG9qk1R4rn6Fm/L0G
        Jc2umRaKlup6YpXE8xr+z8+wSFBGVf8=
X-Google-Smtp-Source: AGRyM1vUMsNAVEh7q6LCFja7ugV0A30uynkeoWsiM6dz4OI7eHtbwzENxd6blIsipkfvdm2mKIhO8Q==
X-Received: by 2002:a5d:44d1:0:b0:21d:7471:2094 with SMTP id z17-20020a5d44d1000000b0021d74712094mr22159383wrr.374.1658135159265;
        Mon, 18 Jul 2022 02:05:59 -0700 (PDT)
Received: from localhost (92-249-246-211.pool.digikabel.hu. [92.249.246.211])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003a30c3d0c9csm11286064wma.8.2022.07.18.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:05:58 -0700 (PDT)
Date:   Mon, 18 Jul 2022 11:05:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
Message-ID: <20220718090557.GA5616@szeder.dev>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 01:07:00PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When working on a large feature, it can be helpful to break that feature
> into multiple smaller parts that become reviewed in sequence. During
> development or during review, a change to one part of the feature could
> affect multiple of these parts. An interactive rebase can help adjust
> the multi-part "story" of the branch.
> 
> However, if there are branches tracking the different parts of the
> feature, then rebasing the entire list of commits can create commits not
> reachable from those "sub branches". It can take a manual step to update
> those branches.
> 
> Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
> <ref>' steps to the todo file whenever a commit that is being rebased is
> decorated with that <ref>. At the very end, the rebase process updates
> all of the listed refs to the values stored during the rebase operation.
> 
> Be sure to iterate after any squashing or fixups are placed. Update the
> branch only after those squashes and fixups are complete. This allows a
> --fixup commit at the tip of the feature to apply correctly to the sub
> branch, even if it is fixing up the most-recent commit in that part.
> 
> One potential problem here is that refs decorating commits that are
> already marked as "fixup!" or "squash!" will not be included in this
> list. Generally, the reordering of the "fixup!" and "squash!" is likely
> to change the relative order of these refs, so it is not recommended.
> The workflow here is intended to allow these kinds of commits at the tip
> of the rebased branch while the other sub branches come along for the
> ride without intervention.
> 
> This change update the documentation and builtin to accept the
> --update-refs option as well as updating the todo file with the
> 'update-ref' commands. Tests are added to ensure that these todo
> commands are added in the correct locations.
> 
> This change does _not_ include the actual behavior of tracking the
> updated refs and writing the new ref values at the end of the rebase
> process. That is deferred to a later change.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-rebase.txt  |   8 +++
>  builtin/rebase.c              |   5 ++
>  sequencer.c                   | 107 ++++++++++++++++++++++++++++++++++
>  sequencer.h                   |   1 +
>  t/t2407-worktree-heads.sh     |  22 +++++++
>  t/t3404-rebase-interactive.sh |  70 ++++++++++++++++++++++
>  6 files changed, 213 insertions(+)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 262fb01aec0..e7611b4089c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
>  start would be overridden by the presence of
>  `rebase.rescheduleFailedExec=true` configuration.
>  
> +--update-refs::

So the option is called '--update-refs', but ...

> +--no-update-refs::
> +	Automatically force-update any branches that point to commits that

... its description talks about "branches".

> +	are being rebased. Any branches that are checked out in a worktree
> +	or point to a `squash! ...` or `fixup! ...` commit are not updated
> +	in this way.
> +
>  INCOMPATIBLE OPTIONS
>  --------------------
>  

> @@ -1124,6 +1126,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
>  			    "squash!/fixup! under -i")),
> +		OPT_BOOL(0, "update-refs", &options.update_refs,
> +			 N_("update local refs that point to commits "

And its short help talks about "local refs".

I think at least the documentation and short help should use
consistent terminology.

> +			    "that are being rebased")),
>  		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
>  			N_("GPG-sign commits"),
>  			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },

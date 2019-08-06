Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E061F731
	for <e@80x24.org>; Tue,  6 Aug 2019 20:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfHFU2g (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 16:28:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40191 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 16:28:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so42120220pfp.7
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t03s723DY45XfS2f4g/aN0F+Qz1Wi4zzDTblieylNdM=;
        b=gKC8Qyps2e9j+SRk7Idmya8hovcAVlh8JuDQGK4JgHQCjD+RESYtqzd9aNcmb5+BI+
         nZUO2jVo0Ulg7vR4VX0puYy0eKp0VCByaB8ejZsUsk6d88YTkNozrqYAknatsnh3x1xW
         fJ6QGEjCk8NoBuxaw004NGMAob4hBPBs2m9Dqnu/zBPEtLKLCARUWVR7F4S0Q3sZZc4M
         d04QxUz1c5BBBEgN9lYMHJl+3qF5pYZYdzfLYr5tDfWYVV2O9WJyrxrtJK8MWsGNG4qp
         PfNnHDadPtMTjvF7dX2cJrNnhxkQ53ysQ+gpOhHdeRkiwcbKAMSN69/DDLl6Oxh8SvAn
         +uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t03s723DY45XfS2f4g/aN0F+Qz1Wi4zzDTblieylNdM=;
        b=TTExq/VMfpst1p/DQWnxboLjQWfUyLEY/QOlbYc5WE6bNs8p+dlsBlkRjbuaVJzSCl
         G5Slj32vgmAt/wNurR39OZOecy9TY0JdRMEJN70rZDRlZWiDSxEa6iaYGiOwtwy2i5ZG
         QL5MuzGOmW5VUpm04aF4PSeNpAEOP5Qkuu+ny2Hl2aEDewZkePHuW1soPle7Ajhce05C
         uIjzpgUzU5tR5D6F+nQAi+buqBD7nTrbL85Lg6q/QxHXXbQp7fISypSedz0eD41i2/ZH
         lKX68grMfjO7o854a8lC8ZAGo7iEsq4jIzOrgYTFQAab12dhM4ozqmTktV4cWmvUPWxg
         RZ2w==
X-Gm-Message-State: APjAAAVdOg9eKDDSTjLk6/h/FfMNfT+idr4ib+agM0W3Nc7R3SSwcUDI
        BQAX0bwLnVEXEVFsejBCArbnmQ==
X-Google-Smtp-Source: APXvYqxyQM3CjE17AHbdi08vTVJrQDf+qD3awK5b00TUaGOliRhrCtIP1yRApzcHgXdR+cOFqxihWg==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr4887518pju.63.1565123314716;
        Tue, 06 Aug 2019 13:28:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id t11sm100004604pgb.33.2019.08.06.13.28.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 13:28:34 -0700 (PDT)
Date:   Tue, 6 Aug 2019 13:28:29 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] merge-recursive: avoid directory rename detection in
 recursive case
Message-ID: <20190806202829.GB26909@google.com>
References: <20190726220928.GG113966@google.com>
 <20190805223350.27504-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805223350.27504-1-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 03:33:50PM -0700, Elijah Newren wrote:
> Ever since commit 8c8e5bd6eb33 ("merge-recursive: switch directory
> rename detection default", 2019-04-05), the default handling with
> directory rename detection was to report a conflict and leave unstaged
> entries in the index.  However, when creating a virtual merge base in
> the recursive case, we absolutely need a tree, and the only way a tree
> can be written is if we have no unstaged entries -- otherwise we hit a
> BUG().
> 
> There are a few fixes possible here which at least fix the BUG(), but
> none of them seem optimal for other reasons; see the comments with the
> new testcase 13e in t6043 for details (which testcase triggered a BUG()
> prior to this patch).  As such, just opt for a very conservative and
> simple choice that is still relatively reasonable: have the recursive
> case treat 'conflict' as 'false' for opt->detect_directory_renames.
> 
> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> 
> I really should introduce constants like
>   DETECT_DIRECTORY_RENAMES_NEVER    = 0
>   DETECT_DIRECTORY_RENAMES_CONFLICT = 1
>   DETECT_DIRECTORY_RENAMES_YES      = 2
> and then use them in the code to make it clearer, but I wanted to make
> the code change as simple and contained as possible given that this is
> built on maint, fixes a BUG() and we're already in -rc1.
> 
> I know this bug doesn't satisfy the normal criteria for making it into
> 2.23 (it's a bug that was present in 2.22 rather than a regression in
> 2.23), but given that it's a BUG() condition, I was hoping it is
> important and safe enough to include anyway.
> 
> (This fix does merge down cleanly to master, next, and pu.)

Thanks for picking this up and sorry I didn't end up sending anything -
priority shifts on this end. :)

> 
>  merge-recursive.c                   |   3 +-
>  t/t6043-merge-rename-directories.sh | 111 ++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d2e380b7ed..c7691d9b54 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2856,7 +2856,8 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	head_pairs = get_diffpairs(opt, common, head);
>  	merge_pairs = get_diffpairs(opt, common, merge);
>  
> -	if (opt->detect_directory_renames) {
So we used to say, "If you want to apply directory renames, or mark
directory renames as merge conflicts, we will go look for renames no
matter what."

> +	if ((opt->detect_directory_renames == 2) ||
> +	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {
But now we say, "If you want to apply directory renames always, or if
you want to mark them as conflicts AND you aren't below the first layer
of a recursive merge, then we will go look for renames."

>  		dir_re_head = get_directory_renames(head_pairs);
>  		dir_re_merge = get_directory_renames(merge_pairs);
That means that when we usually prefer to mark directory renames as
conflicts and we are putting together a virtual ancestor, we
don't try to detect renames at all, which I imagine leaves it to the top
level merge to mark as conflicts for the user to resolve much later.
>  
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index 50b7543483..c966147d5d 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -4403,4 +4403,115 @@ test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual
>  	)
>  '
>  
> +# Testcase 13e, directory rename in virtual merge base
> +#
> +# This testcase has a slightly different setup than all the above cases, in
> +# order to include a recursive case:
> +#
> +#      A   C
> +#      o - o
> +#     / \ / \
> +#  O o   X   ?
> +#     \ / \ /
> +#      o   o
> +#      B   D
> +#
> +#   Commit O: a/{z,y}
> +#   Commit A: b/{z,y}
> +#   Commit B: a/{z,y,x}
> +#   Commit C: b/{z,y,x}
> +#   Commit D: b/{z,y}, a/x
> +#   Expected: b/{z,y,x}  (sort of; see below for why this might not be expected)
> +#
> +#   NOTES: 'X' represents a virtual merge base.  With the default of
> +#          directory rename detection yielding conflicts, merging A and B
> +#          results in a conflict complaining about whether 'x' should be
> +#          under 'a/' or 'b/'.  However, when creating the virtual merge
> +#          base 'X', since virtual merge bases need to be written out as a
> +#          tree, we cannot have a conflict, so some resolution has to be
> +#          picked.
> +#
> +#          In choosing the right resolution, it's worth noting here that
> +#          commits C & D are merges of A & B that choose different
> +#          locations for 'x' (i.e. they resolve the conflict differently),
> +#          and so it would be nice when merging C & D if git could detect
> +#          this difference of opinion and report a conflict.  But the only
> +#          way to do so that I can think of would be to have the virtual
> +#          merge base place 'x' in some directory other than either 'a/' or
> +#          'b/', which seems a little weird -- especially since it'd result
> +#          in a rename/rename(1to2) conflict with a source path that never
> +#          existed in any version.
> +#
> +#          So, for now, when directory rename detection is set to
> +#          'conflict' just avoid doing directory rename detection at all in
> +#          the recursive case.  This will not allow us to detect a conflict
> +#          in the outer merge for this special kind of setup, but it at
> +#          least avoids hitting a BUG().
> +#
> +test_expect_success '13e-setup: directory rename detection in recursive case' '
> +	test_create_repo 13e &&
> +	(
> +		cd 13e &&
> +
> +		mkdir a &&
> +		echo z >a/z &&
> +		echo y >a/y &&
> +		git add a &&
> +		test_tick &&
> +		git commit -m "O" &&
> +
> +		git branch O &&
> +		git branch A &&
> +		git branch B &&
> +
> +		git checkout A &&
> +		git mv a/ b/ &&
> +		test_tick &&
> +		git commit -m "A" &&
So we do a directory rename in branch A...

> +
> +		git checkout B &&
> +		echo x >a/x &&
> +		git add a &&
> +		test_tick &&
> +		git commit -m "B" &&
... And we add a new file to the directory in question in branch B...

So A and B will be the ones combined to make a virtual ancestor.
> +
> +		git branch C A &&
> +		git branch D B &&
> +
> +		git checkout C &&
> +		test_must_fail git -c merge.directoryRenames=conflict merge B &&
> +		git add b/x &&
> +		test_tick &&
> +		git commit -m "C" &&

Then we merge C with B which places B as a mutual ancestor of D as well
as C.

> +
> +
> +		git checkout D &&
> +		test_must_fail git -c merge.directoryRenames=conflict merge A &&

Now we do the same thing merging A with D, which means that D has
ancestors B from branching and A from merge, and C has ancestors A from
branching and B from merge. So D and C have two closest ancestors
(criss-cross merge).

> +		git add b/x &&
> +		mkdir a &&
> +		git mv b/x a/x &&

Now D adds contention over a/x and b/x (which were both mentioned in the
ancestry too) to induce a conflict... or is this adding a resolution
which can be decided on automatically? I guess later you are looking to
make sure no CONFLICT still exists in the output, so you must be
resolving the conflict here?

> +		test_tick &&
> +		git commit -m "D"
> +	)
> +'
> +
> +test_expect_success '13e-check: directory rename detection in recursive case' '
> +	(
> +		cd 13e &&
> +
> +		git checkout --quiet D^0 &&
> +
> +		git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&

Now we finally do the recursive merge - C and D have equally likely
ancestors A and B, and A and B have a rename conflict.

> +
> +		test_i18ngrep ! CONFLICT out &&
> +		test_i18ngrep ! BUG: err &&

The BUG is gone. But should it not use i18ngrep? BUG() isn't localized.

> +		test_i18ngrep ! core.dumped err &&
> +		test_must_be_empty err &&
> +
> +		git ls-files >paths &&
> +		! grep a/x paths &&
Finally, make sure that a/x has been truly disappeared...

> +		grep b/x paths
...and b/x is the only x left standing.
> +	)
> +'
> +
>  test_done
> -- 
> 2.22.0.246.g5ddf3d502a
> 

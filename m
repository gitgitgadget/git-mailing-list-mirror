Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F0C4332E
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1315D64E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbhCDAWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843009AbhCCKXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CD3C061D7E
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 01:02:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id i14so3740120pjz.4
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dYKP8k6GUlKcDmL5Ym+rpuFM8qcEcsPljKcJymJgIAY=;
        b=USsRmZBQ5T3Myi7IIeCNxykzOmBH3QNZ2iyZiL43P5dUoMhEK+nYANPwaRxlTvmmXF
         VtvH56w/SOSZYvCAw8P4gs6hd/Qy69zjDZz6O8OCJdORTJhldrIMTLHQ01iOcnCW+BBc
         pzfbC5iKvDkb7YEjoAl1hno/sse5HJt6bpfE4VTQImK2oRCAhFT63J1aUlzmu1EWg3+N
         G7VxW/BAR49ecnThMAwu/oj8yzq+wFBK8Shy74/5cQGOjeahjuB8k/6XJG3TRNmZWPn0
         BS8HLCyNBPlfxwhnLgU0764uRjXtVMwoBx0H4MPl1P9fACY79Qx6kiM5XLVpYQnXIvYN
         N5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYKP8k6GUlKcDmL5Ym+rpuFM8qcEcsPljKcJymJgIAY=;
        b=aYaqMjgVhy/2YzPD9DguFzJ9TdC5HAjwjzI0mjFLK8yN2BJIjUJYhvzxhYKKaeBNWh
         xsWoAHPEkzdU2Yzp0uc3hRNi60dYpQzudTjGmdhw1/A1oSuSODqSD2g3uut6Y8tlNkXD
         wZIfrkP6zOcB2u62A5H9PqzlM2LJWeQ7udBZPVG2B6o4xvrOV1cw55EqmaPL3lxPO9YK
         kPRo81zTge3/7vgGGTaEcSAyNbSm3NOp7q3A+GLjJ3UAvBQiSG42HNg45JdO5d3WYaoa
         ouY50CfEzDPPeucrL4Z4eP9ltHpk7eyzH8X+R06B1C60xx2zGDtCLD8FizCFhitzPSOy
         Eo8g==
X-Gm-Message-State: AOAM532iA0BQ8C+NMuuMtKqModatiOtcBb2sWnbry+xywhUAwxsSp95C
        BAbvSa8/9gCEFp/5NZZa3Sk=
X-Google-Smtp-Source: ABdhPJyzv2QgDqI8Sd+11u18ze0e1FVSrgCtERqmPFcFRyLjA19qI/RycY+QTzG1yGhzpazH7eCm2A==
X-Received: by 2002:a17:90a:7847:: with SMTP id y7mr8976018pjl.65.1614762178862;
        Wed, 03 Mar 2021 01:02:58 -0800 (PST)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id w202sm26346761pff.198.2021.03.03.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:02:58 -0800 (PST)
Date:   Wed, 3 Mar 2021 01:02:55 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
Message-ID: <YD9Qv/sTDmOE9jlq@generichostname>
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
 <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

Thanks for picking up the issue. It's good to see that the GGG issue
tracker is helpful.

On Mon, Mar 01, 2021 at 08:40:29AM +0000, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Usually we can only use `format-patch -v<n>` to generate integral
> version numbers patches, but sometimes a same fixup should be
> laveled as a non-integral versions like `v1.1`,so teach format-patch

Some typos:

s/laveled/labeled/; s/1.1`,/& /; s/format-patch/& to/

> allow a non-integral versions may be helpful to send those patches.
> 
> Since the original `format-patch` logic, if we specify a version `-v<n>`
> and commbine with `--interdiff` or `--rangediff`, the patch will output
> "Interdiff again v<n-1>:" or "Range-diff again v<n-1>:`, but this does
> not meet the requirements of our fractional version numbers, so provide
> `format patch` a new option `--previous-count=<n>`, the patch can output
> user-specified previous version number. If the user use a integral version
> number `-v<n>`, ensure that the output in the patch is still `v<n-1>`.
> (let `--previous-count` become invalid.)

Hmm, others may disagree but I don't really like the idea of
`--previous-count`. It may be useful for populating "Range-diff vs <n>"
instead of just "Range-diff" but I don't think it's worth the cost of
maintaining this option.


> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

[...]

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 3e49bf221087..f10fa6527f5f 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -22,6 +22,7 @@ SYNOPSIS
>  		   [--cover-from-description=<mode>]
>  		   [--rfc] [--subject-prefix=<subject prefix>]
>  		   [(--reroll-count|-v) <n>]
> +		   [--previous-count=<n>]
>  		   [--to=<email>] [--cc=<email>]
>  		   [--[no-]cover-letter] [--quiet]
>  		   [--[no-]encode-email-headers]
> @@ -221,6 +222,15 @@ populated with placeholder text.
>  	`--subject-prefix` option) has ` v<n>` appended to it.  E.g.
>  	`--reroll-count=4` may produce `v4-0001-add-makefile.patch`
>  	file that has "Subject: [PATCH v4 1/20] Add makefile" in it.
> +	now can support non-integrated version number like `-v1.1`.
> +
> +--previous-count=<n>::
> +	Under the premise that we have used `--reroll-count=<n>`,
> +	we can use `--previous-count=<n>` to specify the previous
> +	version number. E.g. When we use the `--range-diff` or
> +	`--interdiff` option and combine with `-v2.3 --previous-count=2.2`,
> +	"Interdiff against v2.2:" or "Range-diff against v2.2:"
> +	will be output in the patch.
>  
>  --to=<email>::
>  	Add a `To:` header to the email headers. This is in addition
> diff --git a/builtin/log.c b/builtin/log.c
> index f67b67d80ed1..95c95eab5393 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1662,13 +1662,15 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
>  	oidclr(&bases->base_commit);
>  }
>  
> -static const char *diff_title(struct strbuf *sb, int reroll_count,
> -		       const char *generic, const char *rerolled)
> +static const char *diff_title(struct strbuf *sb, const char *reroll_count, int reroll_count_is_integer,
> +			const char*previous_count, const char *generic, const char *rerolled)
>  {
> -	if (reroll_count <= 0)
> +	if (!reroll_count || (!reroll_count_is_integer && !previous_count))
>  		strbuf_addstr(sb, generic);
> -	else /* RFC may be v0, so allow -v1 to diff against v0 */
> -		strbuf_addf(sb, rerolled, reroll_count - 1);
> +	else if (reroll_count_is_integer)/* RFC may be v0, so allow -v1 to diff against v0 */
> +		strbuf_addf(sb, rerolled, atoi(reroll_count) - 1);
> +	else if (previous_count)
> +		strbuf_addf(sb, rerolled, previous_count);
>  	return sb->buf;
>  }

 I would just remove this hunk entirely and keep the existing logic...

> @@ -1717,7 +1719,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	struct strbuf buf = STRBUF_INIT;
>  	int use_patch_format = 0;
>  	int quiet = 0;
> -	int reroll_count = -1;
> +	int reroll_count_is_integer = 0;
> +	const char *reroll_count = NULL;
> +	const char *previous_count = NULL;

...then over here, we can do something like

	const char *reroll_count = NULL;
	int reroll_count_int = -1;

and then...

>  	char *cover_from_description_arg = NULL;
>  	char *branch_name = NULL;
>  	char *base_commit = NULL;
> @@ -1751,8 +1755,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  			    N_("use <sfx> instead of '.patch'")),
>  		OPT_INTEGER(0, "start-number", &start_number,
>  			    N_("start numbering patches at <n> instead of 1")),
> -		OPT_INTEGER('v', "reroll-count", &reroll_count,
> -			    N_("mark the series as Nth re-roll")),
> +		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
> +			    N_("mark the series as specified version re-roll")),
> +		OPT_STRING(0, "previous-count", &previous_count, N_("previous-count"),
> +			    N_("specified as the last version while we use --reroll-count")),
>  		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>  			    N_("max length of output filename")),
>  		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
> @@ -1861,10 +1867,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  
>  	if (cover_from_description_arg)
>  		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
> -
> -	if (0 < reroll_count) {
> +	if (previous_count && !reroll_count)
> +		usage(_("previous-count can only used when reroll-count is used"));
> +	if (reroll_count) {
>  		struct strbuf sprefix = STRBUF_INIT;
> -		strbuf_addf(&sprefix, "%s v%d",
> +		char ch;
> +		size_t i = 0 , reroll_count_len = strlen(reroll_count);
> +
> +		for (; i != reroll_count_len; i++) {
> +			ch = reroll_count[i];
> +			if(!isdigit(ch))
> +				break;
> +		}
> +		reroll_count_is_integer = i == reroll_count_len ? 1 : 0;
> +		strbuf_addf(&sprefix, "%s v%s",
>  			    rev.subject_prefix, reroll_count);
>  		rev.reroll_count = reroll_count;
>  		rev.subject_prefix = strbuf_detach(&sprefix, NULL);

...over here we can use Junio's integer parsing example and assign
reroll_count_int only if reroll_count can be parsed into an integer.

Thanks,
Denton

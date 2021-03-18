Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46AC433E9
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5EE64F1C
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 16:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCRQaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhCRQ35 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 12:29:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBCC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 09:29:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t18so3200979pjs.3
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Or3UP95tyMQLlLofgOzS3BrV0utnTWP8rVeB54mZwU=;
        b=kblj4moxx+tQ/uzt8okN9J+Vb39z5tQmqkJfokb3t8/Pnq88EZWgc+TdxCOytilobe
         rqZhi9C6XmZz5/sSa+7PEf9vD1EX/NfFck8D4EMwhE+Ji1C2sKg8gigRQAeUwPXWHECG
         R3+4gS1kyVv7JrJRNAcOi3PhyuB5EDIqqyTatu9ThqOq6YlCdghhYsnrDoB0kk4tCzRf
         EZM7NFN8fC7KEYoGzKNXJtIcl5kMs7L7Pup7wNsb80+k1jYlc6kgmzEMwh/yH8x34z75
         Nccm9DuATdU1gOwfhAvIVllbWbbS1d0PBvKCTqwC6DD3vsX9T8xjX6TLLZTkeaEtid4q
         SVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Or3UP95tyMQLlLofgOzS3BrV0utnTWP8rVeB54mZwU=;
        b=C474AFmwbMIgGMZ2z2ol6Gc/45whN0DaCk+B0gOk5G8c8U53TCW59Rfdsuuq3tQrWJ
         k8OjZUaFrFYWQXJRqu0kGAX9y7VWts4DxHuiryu7uwxHFMvuxo2ys6UIYI3z4XyIIZm4
         1U4yCgIP7drSxUWXSJGVPrKnOwj5trJI2M+iw4T4y5/c4IKOG9geaB7d7o+BHMEsIh7e
         5Ix17Wq7Rlx9f5+2EMfEyEkGTO4VMyL7ed8hH6/Kh8BWUOQkQneZExnibUuo26GEVyqy
         hIYb/gUToamlpfur7i+ST8mdJq0maAM6bBu/QxPNZYGIOZ3ENQLeCbXJWFusnelub2RZ
         lXXw==
X-Gm-Message-State: AOAM5311Z7JgsSBkoe8Wg51LtcOkhuMNUpzk/ocQdGVBOZWYe0/GmWpR
        n08rLMOT7jkvahKD6Ir7LdY=
X-Google-Smtp-Source: ABdhPJzcxO0eNmDUqeZ4SkaLgHD1sGxI7ihAfOLCUZrlNJPy+E6upmtykw95lp5TJWh3maafOmXTug==
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr4993075pjh.222.1616084996342;
        Thu, 18 Mar 2021 09:29:56 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c037:a704:f99b:eeaa:7066])
        by smtp.gmail.com with ESMTPSA id q184sm2975313pfc.78.2021.03.18.09.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:29:55 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:29:53 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 1/3] [GSOC] commit: add --trailer option
Message-ID: <YFOAAQmVqUVOpLK1@danh.dev>
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
 <949faf9ee56a3146a643ba634771779efa89bbc5.1616066156.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949faf9ee56a3146a643ba634771779efa89bbc5.1616066156.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-03-18 11:15:54+0000, ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Historically, Git has supported the 'Signed-off-by' commit trailer
> using the '--signoff' and the '-s' option from the command line.
> But users may need to provide other trailer information from the
> command line such as "Helped-by", "Reported-by", "Mentored-by",
> 
> Now implement a new `--trailer <token>[(=|:)<value>]` option to pass
> other trailers to `interpret-trailers` and insert them into commit
> messages.
> 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-commit.txt |  10 +-
>  builtin/commit.c             |  23 +++
>  t/t7502-commit-porcelain.sh  | 336 +++++++++++++++++++++++++++++++++++
>  3 files changed, 368 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 17150fa7eabe..c5de981cd40d 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	   [-S[<keyid>]] [--] [<pathspec>...]
> +	   [-S[<keyid>]] [--] [<pathspec>...] [(--trailer <token>[(=|:)<value>])...]

Please move all options before non-option arguments.
In other words, please move --trailer before [--].

This form implies that there are no way to specify pathspec "--trailer"

>  
>  DESCRIPTION
>  -----------
> @@ -166,6 +166,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>  
>  include::signoff-option.txt[]
>  
> +--trailer <token>[(=|:)<value>]::
> +	Specify a (<token>, <value>) pair that should be applied as a
> +	trailer. (e.g. `git commit --trailer "Signed-off-by:C O Mitter \
> +	<committer@example.com>" --trailer "Helped-by:C O Mitter \
> +	<committer@example.com>"` will add the "Signed-off-by" trailer
> +	and the "Helped-by" trailer in the commit message.)
> +	Use `git -c trailer.* commit --trailer` to make the appropriate
> +	configuration. See linkgit:git-interpret-trailers[1] for details.
>  -n::
>  --no-verify::
>  	This option bypasses the pre-commit and commit-msg hooks.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..7a79aae48f43 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,7 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +static struct strvec trailer_args = STRVEC_INIT;
>  
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -131,6 +132,14 @@ static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
> +{
> +	BUG_ON_OPT_NEG(unset);
> +
> +	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
> +	return 0;
> +}
> +
>  static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
>  {
>  	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> @@ -958,6 +967,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(s->fp);
>  
> +	if (trailer_args.nr) {
> +		struct child_process run_trailer = CHILD_PROCESS_INIT;
> +
> +		strvec_pushl(&run_trailer.args, "interpret-trailers",
> +			     "--in-place", git_path_commit_editmsg(), NULL);
> +		strvec_pushv(&run_trailer.args, trailer_args.v);
> +		run_trailer.git_cmd = 1;
> +		if (run_command(&run_trailer)) {
> +			die(_("unable to pass tailers to --trailers"));

s/tailers/trailers/ perhap?
Also we usually not put {} around single statement.

> +		}
> +		strvec_clear(&trailer_args);
> +	}
> +
>  	/*
>  	 * Reject an attempt to record a non-merge empty commit without
>  	 * explicit --allow-empty. In the cherry-pick case, it may be
> @@ -1507,6 +1529,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 6396897cc818..6df71fa00bcb 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -154,6 +154,342 @@ test_expect_success 'sign off' '
>  
>  '
>  
> +test_expect_success 'commit --trailer without -c' '
> +	echo "fun" >>file &&
> +	git add file &&
> +	cat >expected <<-\EOF &&
> +
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C1 E1
> +	Helped-by: C2 E2
> +	Reported-by: C3 E3
> +	Mentored-by: C4 E4
> +	EOF
> +	git commit -s --trailer "Signed-off-by:C1 E1 " \
> +		--trailer "Helped-by:C2 E2 " \
> +		--trailer "Reported-by:C3 E3" \
> +		--trailer "Mentored-by:C4 E4" \
> +		-m "hello" &&

It's documented that we're supporting --trailer <token>[(=|:)<value>]
However, only --trailer <token>:<value> is tested.
I think it's better to have 
	
	--trailer "Helped-by=C2 E2" --trailer "Reported-by"


-- 
Danh

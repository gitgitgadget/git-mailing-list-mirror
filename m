Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2383C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 21:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5961058
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 21:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhKHVvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbhKHVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 16:51:47 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A2C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 13:49:02 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id f10so18542463ilu.5
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0+tm5f9yniNNr32WOtRTAyfHkwVaD1mJqm4ubTaE/JM=;
        b=0spp9Oy83hI+Ubl/W8/she3w+YrT1S0wywD8PNFNlctHdfWmTeU/aLyX5lXQVtcyN3
         KDg0CrCHT1pNl3NXqs6lNNJXGz9kqqdLkavWD1rSe+1yq+nKfw/uTwna8TxHmk3+20Uq
         dwULG4iryUKeggTbIsum1sJONHYaVM3pYFwwvPbmaK618lhM13AIkqBWrVsd8q/wM6Ag
         JZLk+nK35W4FzdO5LEhibCQxfmPjmVUVIzkjtb8G8GekWmHPS7VEUps2Vk1L7RGo4Zvy
         UQelidjQEtJd1CRmkXYPqZscUOwvleRomlyS65ObWtCt2us6pnZLfK0rTRP92EyG7nz5
         sshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0+tm5f9yniNNr32WOtRTAyfHkwVaD1mJqm4ubTaE/JM=;
        b=Sv+mErvvpQMGM7OQ/O4r7gGEUBGqwM/PB1ZiyrN69fRmnHmZGMWfVth7Ykyleh0c8F
         AUqpj+tIeUDWdEeoEIluaREBdBIhAB4njzeqPRKTcEQQYoqbkiprAXHoC62D6egUcBup
         u0RJ3XA6jFWF72EKQOfQVo1e2R5Oz8Fi7HeTcZLEiJdslLyMIewFbLHAglNEacqnFCmY
         9rmrUkef5rKObzW+Q8wOtwrHzR6FMLJKBrVB4kYN2tGxToH4J5g6sb00TzkEqYRpqXVp
         4SCkIpITbO9SaE5kEWpEZIgYwEUTf9CDts0HrTty1EMCfqzMecGNQ5HwHDFcugk15+2/
         arwg==
X-Gm-Message-State: AOAM5318gXn/M3qXzEuVh5TkQNBAyeT9zu2rl22sg2CWip3aNE761Qv2
        6ZCMrbzwEY/lpNDpZQbLgHCPbA==
X-Google-Smtp-Source: ABdhPJylLCUaocIAUVLcF0Dcwo8Kx+LFtVzDMIvUT1IClafvsJ0r3T9w659fDGjG1SSU1CvjjDUUvw==
X-Received: by 2002:a92:520f:: with SMTP id g15mr1609989ilb.217.1636408141923;
        Mon, 08 Nov 2021 13:49:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18sm5980540ioe.13.2021.11.08.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:49:01 -0800 (PST)
Date:   Mon, 8 Nov 2021 16:49:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 6/8] grep API: call grep_config() after grep_init()
Message-ID: <YYmbTOR+uk7prM8A@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-6.8-933ac853bca-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.8-933ac853bca-20211106T210711Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 10:10:52PM +0100, Ævar Arnfjörð Bjarmason wrote:
> The grep_init() function used the odd pattern of initializing the
> passed-in "struct grep_opt" with a statically defined "grep_defaults"
> struct, which would be modified in-place when we invoked
> grep_config().
>
> So we effectively (b) initialized config, (a) then defaults, (c)
> followed by user options. Usually those are ordered as "a", "b" and
> "c" instead.

Do we risk changing any user-visible behavior here? Based on my reading
of grep.c before and after this patch, I think the answer is "no", but I
wasn't sure if you had done a similar analysis.

In any case, I think the "bring your own structure" instead of getting
one copied around is much easier to reason about. Even if we weren't
accidentally stomping on ownership of the struct before, not having to
reason about it is a nice benefit.

> As the comments being removed here show the previous behavior needed
> to be carefully explained as we'd potentially share the populated
> configuration among different instances of grep_init(). In practice we
> didn't do that, but now that it can't be a concern anymore let's
> remove those comments.

Makes sense, I agree.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 960c7aac123..7f95f44e948 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -288,7 +288,7 @@ static int wait_all(void)
>  static int grep_cmd_config(const char *var, const char *value, void *cb)
>  {
>  	int st = grep_config(var, value, cb);
> -	if (git_color_default_config(var, value, cb) < 0)
> +	if (git_color_default_config(var, value, NULL) < 0)

This doesn't appear strictly related to the rest of your changes, but
only serves to prevent the caller-provided data from being sent down to
git_color_default_config().

It didn't matter before because (a) the caller doesn't specify any data
to begin with, and git_color_default_config() (or the functions that it
calls) don't do anything with the extra pointer. Now cmd_grep() is going
to start passing around a pointer to a struct grep_opt.

But git_color_default_config() still doesn't do anything with the
pointer it receives, and passing that pointer around is standard
practice among config.c code. So I don't think that this hunk is
strictly necessary, and it's somewhat different than the pattern
established within config.c.

I wouldn't be sad to see this hunk dropped (and in fact have a slight
preference leaning this way), but I don't mind keeping it around,
either.

>  		st = -1;
>
>  	if (!strcmp(var, "grep.threads")) {
> @@ -969,8 +969,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>
> -	git_config(grep_cmd_config, NULL);
>  	grep_init(&opt, the_repository);
> +	git_config(grep_cmd_config, &opt);
>  	opt.caller_priv = &opt_cmd;
>
>  	/*
> diff --git a/builtin/log.c b/builtin/log.c
> index f75d87e8d7f..bfddacdfa6c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -505,8 +505,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>
> -	if (grep_config(var, value, cb) < 0)
> -		return -1;
>  	if (git_gpg_config(var, value, cb) < 0)
>  		return -1;
>  	return git_diff_ui_config(var, value, cb);
> @@ -521,6 +519,8 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
>  	git_config(git_log_config, NULL);
>
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +
>  	rev.diff = 1;
>  	rev.simplify_history = 0;
>  	memset(&opt, 0, sizeof(opt));
> @@ -635,6 +635,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>
>  	memset(&match_all, 0, sizeof(match_all));
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +
>  	rev.diff = 1;
>  	rev.always_show_header = 1;
>  	rev.no_walk = 1;
> @@ -718,6 +720,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
>
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	init_reflog_walk(&rev.reflog_info);
> +	git_config(grep_config, &rev.grep_filter);
> +
>  	rev.verbose_header = 1;
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
> @@ -751,6 +755,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>  	git_config(git_log_config, NULL);
>
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +
>  	rev.always_show_header = 1;
>  	memset(&opt, 0, sizeof(opt));
>  	opt.def = "HEAD";
> @@ -1833,10 +1839,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	extra_hdr.strdup_strings = 1;
>  	extra_to.strdup_strings = 1;
>  	extra_cc.strdup_strings = 1;
> +
>  	init_log_defaults();
>  	init_display_notes(&notes_opt);
>  	git_config(git_format_config, NULL);
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +
>  	rev.show_notes = show_notes;
>  	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
>  	rev.commit_format = CMIT_FMT_EMAIL;
> diff --git a/grep.c b/grep.c
> index c9065254aeb..fb3f63c63ef 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -19,27 +19,6 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
>  	fwrite(buf, size, 1, stdout);
>  }
>
> -static struct grep_opt grep_defaults = {
> -	.relative = 1,
> -	.pathname = 1,
> -	.max_depth = -1,
> -	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
> -	.colors = {
> -		[GREP_COLOR_CONTEXT] = "",
> -		[GREP_COLOR_FILENAME] = "",
> -		[GREP_COLOR_FUNCTION] = "",
> -		[GREP_COLOR_LINENO] = "",
> -		[GREP_COLOR_COLUMNNO] = "",
> -		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
> -		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
> -		[GREP_COLOR_SELECTED] = "",
> -		[GREP_COLOR_SEP] = GIT_COLOR_CYAN,
> -	},
> -	.only_matching = 0,
> -	.color = -1,
> -	.output = std_output,
> -};
> -
>  static const char *color_grep_slots[] = {
>  	[GREP_COLOR_CONTEXT]	    = "context",
>  	[GREP_COLOR_FILENAME]	    = "filename",
> @@ -75,20 +54,12 @@ define_list_config_array_extra(color_grep_slots, {"match"});
>   */
>  int grep_config(const char *var, const char *value, void *cb)
>  {
> -	struct grep_opt *opt = &grep_defaults;
> +	struct grep_opt *opt = cb;
>  	const char *slot;
>
>  	if (userdiff_config(var, value) < 0)
>  		return -1;
>
> -	/*
> -	 * The instance of grep_opt that we set up here is copied by
> -	 * grep_init() to be used by each individual invocation.
> -	 * When populating a new field of this structure here, be
> -	 * sure to think about ownership -- e.g., you might need to
> -	 * override the shallow copy in grep_init() with a deep copy.
> -	 */
> -
>  	if (!strcmp(var, "grep.extendedregexp")) {
>  		opt->extended_regexp_option = git_config_bool(var, value);
>  		return 0;
> @@ -134,14 +105,10 @@ int grep_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>
> -/*
> - * Initialize one instance of grep_opt and copy the
> - * default values from the template we read the configuration
> - * information in an earlier call to git_config(grep_config).
> - */
>  void grep_init(struct grep_opt *opt, struct repository *repo)
>  {
> -	*opt = grep_defaults;
> +	struct grep_opt blank = GREP_OPT_INIT;
> +	memcpy(opt, &blank, sizeof(*opt));

I'm nit-picking, but creating a throwaway struct for the convenience of
using designated initialization (at the cost of having to memcpy an
entire struct around) seems like overkill.

Especially since we're just going to write into the other fields of the
the target struct anyway, I'd probably rather have seen everything
written out explicitly without the throwaway or memcpy.

Thanks,
Taylor

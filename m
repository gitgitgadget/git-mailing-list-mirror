Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A70C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 22:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460F62072A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 22:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIUnYJPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgAGW5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:57:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgAGW5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 17:57:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so1439904wrq.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bps20zJ31ejzVUHqEsMExUanbwsjU/ejkjUWTCSts3I=;
        b=gIUnYJPVjD9qc9qpMPHPnFv+V5Cu+5PdtfpY2P1ydkn6BJNn+bk/TVJkjFhuBTyYgo
         Gl5y+UmpEz0h8yuUOmWs2SThCQMjt32SlF2xUi8XOeCMTJsf0wLrAjtobvHezHMwcXi1
         3FSUOQ0hTeyjBvbcFlKnF8LlyFi9n3YUYiWhM2FcDuEj5RgcEOdngzkkAG+yR6kxD1Zc
         xO5WEz3kNWcGexvQ/IGe5fVtrvDyzkgwgKQ/l+YSpE/MP4yA1eSaGVAo5B6Re/AtB4Xj
         6ReoLyKRXHOJ3Y3zekXQtIyqttZbBs5UaxIgBa6SASWN+5nYJyiCDCprTxI61XOmrVLK
         6bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bps20zJ31ejzVUHqEsMExUanbwsjU/ejkjUWTCSts3I=;
        b=Hu/IaEDgg9I8zEaCB6vHn/UpUrSBUKNwjEvhJSNaQR/xl5BHJO+JsBJ/aN7NnKXWBC
         0ZUeZ7GKX1lkJMjmbn6PS5+T/7QtZTZAcauzs+UqyU4wfyvtGwQJB0l7EQbpHwvBtd2g
         FTRBKBc4D/Quta6Hu/ZEAfLtgRPY4QoiUNKVbeg+RvKQv+pFPWAoofkeXH0faxH18i/Z
         eAxVLt52Mlw+U2h3uWrb+4zL8aZMDrWTNK7rFTHNTgF2hZxQ4bt/u/tGkGe5fcH6RW6x
         rGTU9D7OZI7ys7iI81tJee2XeKCe/YuTZZ34V8A7/j7mo08RtlV3wVUWpyH0KcSZZeHI
         +z8g==
X-Gm-Message-State: APjAAAXF5RhNY/la30s6hcHutqdd88fwC1wkrS6OxcGQ0fcz+h+45fuF
        HzSVsc931Ln72CqznMRRnik=
X-Google-Smtp-Source: APXvYqwlLSIOk80t5RWG5icsMGNMdBcbhwVqFkVOcyhpmEnIdm9dSyatAam59VCSn+p/ciu8voBDYg==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr1374021wrx.204.1578437872714;
        Tue, 07 Jan 2020 14:57:52 -0800 (PST)
Received: from szeder.dev (x4db602e4.dyn.telefonica.de. [77.182.2.228])
        by smtp.gmail.com with ESMTPSA id g21sm1311075wmh.17.2020.01.07.14.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 14:57:52 -0800 (PST)
Date:   Tue, 7 Jan 2020 23:57:49 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] built-in add -p: support interactive.diffFilter
Message-ID: <20200107225749.GD32750@szeder.dev>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
 <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <f45ff08bd0a0a2e2aba9ae929b6e5ecb3bdd4e07.1577275020.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f45ff08bd0a0a2e2aba9ae929b6e5ecb3bdd4e07.1577275020.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 25, 2019 at 11:56:52AM +0000, Johannes Schindelin via GitGitGadget wrote:
> The Perl version supports post-processing the colored diff (that is
> generated in addition to the uncolored diff, intended to offer a
> prettier user experience) by a command configured via that config
> setting, and now the built-in version does that, too.

So this patch makes the test 'detect bogus diffFilter output' in
't3701-add-interactive.sh' succeed with the builtin interactive add,
but I stumbled upon a test failure caused by SIGPIPE in an
experimental Travis CI s390x build:

  expecting success of 3701.49 'detect bogus diffFilter output': 
          git reset --hard &&
  
          echo content >test &&
          test_config interactive.diffFilter "echo too-short" &&
          printf y >y &&
          test_must_fail force_color git add -p <y
  
  + git reset --hard
  HEAD is now at 6ee5ee5 test
  + echo content
  + test_config interactive.diffFilter echo too-short
  + printf y
  + test_must_fail force_color git add -p
  test_must_fail: died by signal 13: force_color git add -p
  error: last command exited with $?=1

Turns out it's a general issue, and

  GIT_TEST_ADD_I_USE_BUILTIN=1 ./t3701-add-interactive.sh -r 39,49 --stress

fails within 10 seconds on my Linux box, whereas the scripted 'add -p'
managed to survive a couple hundred repetitions.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.c | 12 ++++++++++++
>  add-interactive.h |  3 +++
>  add-patch.c       | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index a5bb14f2f4..1786ea29c4 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -52,6 +52,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>  		diff_get_color(s->use_color, DIFF_FILE_OLD));
>  	init_color(r, s, "new", s->file_new_color,
>  		diff_get_color(s->use_color, DIFF_FILE_NEW));
> +
> +	FREE_AND_NULL(s->interactive_diff_filter);
> +	git_config_get_string("interactive.difffilter",
> +			      &s->interactive_diff_filter);
> +}
> +
> +void clear_add_i_state(struct add_i_state *s)
> +{
> +	FREE_AND_NULL(s->interactive_diff_filter);
> +	memset(s, 0, sizeof(*s));
> +	s->use_color = -1;
>  }
>  
>  /*
> @@ -1149,6 +1160,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
>  	strbuf_release(&print_file_item_data.worktree);
>  	strbuf_release(&header);
>  	prefix_item_list_clear(&commands);
> +	clear_add_i_state(&s);
>  
>  	return res;
>  }
> diff --git a/add-interactive.h b/add-interactive.h
> index b2f23479c5..46c73867ad 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -15,9 +15,12 @@ struct add_i_state {
>  	char context_color[COLOR_MAXLEN];
>  	char file_old_color[COLOR_MAXLEN];
>  	char file_new_color[COLOR_MAXLEN];
> +
> +	char *interactive_diff_filter;
>  };
>  
>  void init_add_i_state(struct add_i_state *s, struct repository *r);
> +void clear_add_i_state(struct add_i_state *s);
>  
>  struct repository;
>  struct pathspec;
> diff --git a/add-patch.c b/add-patch.c
> index 46c6c183d5..78bde41df0 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -398,6 +398,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  
>  	if (want_color_fd(1, -1)) {
>  		struct child_process colored_cp = CHILD_PROCESS_INIT;
> +		const char *diff_filter = s->s.interactive_diff_filter;
>  
>  		setup_child_process(s, &colored_cp, NULL);
>  		xsnprintf((char *)args.argv[color_arg_index], 8, "--color");
> @@ -407,6 +408,24 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  		argv_array_clear(&args);
>  		if (res)
>  			return error(_("could not parse colored diff"));
> +
> +		if (diff_filter) {
> +			struct child_process filter_cp = CHILD_PROCESS_INIT;
> +
> +			setup_child_process(s, &filter_cp,
> +					    diff_filter, NULL);
> +			filter_cp.git_cmd = 0;
> +			filter_cp.use_shell = 1;
> +			strbuf_reset(&s->buf);
> +			if (pipe_command(&filter_cp,
> +					 colored->buf, colored->len,
> +					 &s->buf, colored->len,
> +					 NULL, 0) < 0)
> +				return error(_("failed to run '%s'"),
> +					     diff_filter);
> +			strbuf_swap(colored, &s->buf);
> +		}
> +
>  		strbuf_complete_line(colored);
>  		colored_p = colored->buf;
>  		colored_pend = colored_p + colored->len;
> @@ -531,6 +550,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  						   colored_pend - colored_p);
>  			if (colored_eol)
>  				colored_p = colored_eol + 1;
> +			else if (p != pend)
> +				/* colored shorter than non-colored? */
> +				goto mismatched_output;
>  			else
>  				colored_p = colored_pend;
>  
> @@ -555,6 +577,15 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  		 */
>  		hunk->splittable_into++;
>  
> +	/* non-colored shorter than colored? */
> +	if (colored_p != colored_pend) {
> +mismatched_output:
> +		error(_("mismatched output from interactive.diffFilter"));
> +		advise(_("Your filter must maintain a one-to-one correspondence\n"
> +			 "between its input and output lines."));
> +		return -1;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1612,6 +1643,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	    parse_diff(&s, ps) < 0) {
>  		strbuf_release(&s.plain);
>  		strbuf_release(&s.colored);
> +		clear_add_i_state(&s.s);
>  		return -1;
>  	}
>  
> @@ -1630,5 +1662,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	strbuf_release(&s.buf);
>  	strbuf_release(&s.plain);
>  	strbuf_release(&s.colored);
> +	clear_add_i_state(&s.s);
>  	return 0;
>  }
> -- 
> gitgitgadget
> 

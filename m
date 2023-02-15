Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39256C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 06:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjBOGyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 01:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjBOGyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 01:54:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A8DBFF
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 22:53:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pv3-20020a17090b3c8300b002342e23955cso610598pjb.7
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 22:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NA/NmSlxs4i04GvxVX6ntin0TTOkdHaJLEUwPpoE938=;
        b=PRfadeUE3Robhddft17W9yewqP+krTp65JjOHbjrnrWdlJ+e7G0DhzErq4oMOv5bMj
         r73Uy53h8+Qsp/ZntRJcnfuG79oT2stfnKd/sSs6nfpYlp7l02Gbc6ILMVWuk7vZCQsR
         y+WtfPRSCA3WNpbLsF7sZlJ9J5q181roeGEHr1KF8Tc8zr7551j7EjYVKkcAwHBoOzEr
         91moImaBKo2+33DPPyrwsm9XGmDPnDmQ3YQNjZ1bOiO8PVumPxLWt12ueW3W8dTZTWCI
         YfskwBOmN5hVWhWtMsmcSPhknBr6EEeunkUAZuxO+OIuKHUBz8y2NZa9NO+x/nOLQsw4
         BwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NA/NmSlxs4i04GvxVX6ntin0TTOkdHaJLEUwPpoE938=;
        b=iZe4QMDTN2fe0aNyfkjs2Ig9/AZBpbTmEstaOpOyp4KOWcCovG7NZ2Aa1fYIG3K6rb
         6BrRgiR7BCmkhs9J2Y/fHn5GzXeJrZiPA5bGsCjjkEuusap5VWtahRU7nrXJkVe+bhu+
         z8uiopUeaRpBL1kKoh/8Zy4yLlMs/NHFUFScqTsLYsFDrV4J8rLUlBrkHxuAv+3B/XJT
         n0dsV4fCNap6+PHA+IKWHjj0zOrldEAMNJSa22qer5LAO0VBcr7glCnm1u37sZsqlYw7
         bQvX+5OYIufE5lRkWiDr5TXMqn33Rbx6Wtfku2dg1ke+TNB+7iyQa8svXcRX/GbKwjzf
         Ms3w==
X-Gm-Message-State: AO0yUKVY+fwQbjRzsCRGjLKESh9wcE9jAziso5E9zdvhKCnd14lCwT+a
        v5ddkWhJ+wcNSfUmpYq8oBl7qmjbCTOcGw==
X-Google-Smtp-Source: AK7set8qc6DPYbTeQPIzfHHlvTvKIUqi3Wn9j9m9PnEQFN1xUJpHII57tcXszwg7cX2xnCvmxFHHx/R7moI4VQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:3813:0:b0:4fb:a38d:c09b with SMTP id
 f19-20020a633813000000b004fba38dc09bmr171657pga.10.1676444038511; Tue, 14 Feb
 2023 22:53:58 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:53:56 +0800
In-Reply-To: <xmqqzg9kew1q.fsf@gitster.g>
Mime-Version: 1.0
References: <CAFA9we-QLQRzJdGMMCPatmfrk1oHeiUu9msMRXXk1MLE5HRxBQ@mail.gmail.com>
 <xmqqsffdf0ji.fsf@gitster.g> <xmqqmt5lezi3.fsf@gitster.g> <xmqqzg9kew1q.fsf@gitster.g>
Message-ID: <kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: BUG: git config --global --get ITEM ignores ~/.config/git/config
 when ~/.gitconfig is present
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jade Lovelace <lists@jade.fyi>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> My gut feeling is that this is merely a bug that we can fix without
>> worrying too much about users screaming at us complaining that they
>> relied on the current behaviour.  Without --global we do read from
>> both, so with with "--global" the behaviour is inconsistent.
>
> So, here is what I think happens, if anybody wants to get their
> hands dirty.
>
> builtin/config.c::cmd_config() notices "--global", and
> tries to choose between user_config and xdg_config and
> picks one.
>
> The choice is stored in given_config_source.file

Yeah, I think this is the crux of the problem. builtin/config.c assumes
that there should be a unique "given_config_source", but in the case of
reading global config, there are actually two "config_source"s.

>            Ideally, it would be very nice if the high level caller
> in cmd_config() loses the duplicated logic and instead just sets a
> single "we are dealing with --global" bit in given_config_source
> structure, and config_with_options() is taught to reuse the "we need
> to read both of them" logic in do_git_config_sequence() when the bit
> is set.

I mostly agree, except that I think we should leverage the existing
"ignore" flags in "config_options". "do_git_config_sequence()" already
uses some of them to mean "read from X but not from Y" (e.g. to
implement very early config, protected config), so we could add the
missing ignore flags like so...

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

  diff --git a/config.c b/config.c
  index e9d52ee7b2..6734d16ce1 100644
  --- a/config.c
  +++ b/config.c
  @@ -2184,19 +2184,23 @@ static int do_git_config_sequence(const struct config_options *opts,
      repo_config = NULL;

    current_parsing_scope = CONFIG_SCOPE_SYSTEM;
  -	if (git_config_system() && system_config &&
  +	if (!opts->ignore_system && git_config_system() && system_config &&
        !access_or_die(system_config, R_OK,
          opts->system_gently ? ACCESS_EACCES_OK : 0))
      ret += git_config_from_file(fn, system_config, data);

    current_parsing_scope = CONFIG_SCOPE_GLOBAL;
  -	git_global_config(&user_config, &xdg_config);
  +	if (!opts->ignore_global) {
  +		git_global_config(&user_config, &xdg_config);

  -	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
  -		ret += git_config_from_file(fn, xdg_config, data);
  +		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
  +			ret += git_config_from_file(fn, xdg_config, data);

  -	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
  -		ret += git_config_from_file(fn, user_config, data);
  +		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
  +			ret += git_config_from_file(fn, user_config, data);
  +		free(xdg_config);
  +		free(user_config);
  +	}

    current_parsing_scope = CONFIG_SCOPE_LOCAL;
    if (!opts->ignore_repo && repo_config &&
  @@ -2217,8 +2221,6 @@ static int do_git_config_sequence(const struct config_options *opts,

    current_parsing_scope = prev_parsing_scope;
    free(system_config);
  -	free(xdg_config);
  -	free(user_config);
    free(repo_config);
    return ret;
  }
  diff --git a/config.h b/config.h
  index 8fb7a89875..be7b7ddd6c 100644
  --- a/config.h
  +++ b/config.h
  @@ -86,6 +86,8 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,

  struct config_options {
    unsigned int respect_includes : 1;
  +	unsigned int ignore_system : 1;
  +	unsigned int ignore_global : 1;
    unsigned int ignore_repo : 1;
    unsigned int ignore_worktree : 1;
    unsigned int ignore_cmdline : 1;

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

And then builtin/config.c can leave the "config_source" arg unset, and
pass those flags, e.g. here's an untested, dirty hack:

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

  diff --git a/builtin/config.c b/builtin/config.c
  index 060cf9f3e0..495d56274d 100644
  --- a/builtin/config.c
  +++ b/builtin/config.c
  @@ -312,6 +312,20 @@ static int collect_config(const char *key_, const char *value_, void *cb)
    return format_config(&values->items[values->nr++], key_, value_);
  }

  +static int read_scoped_config(config_fn_t cb, void *data)
  +{
  +	if (use_global_config) {
  +		config_options.ignore_repo = 1;
  +		config_options.ignore_cmdline = 1;
  +		config_options.ignore_worktree = 1;
  +		config_options.ignore_system = 1;
  +		return config_with_options(cb, data,
  +				NULL, &config_options);
  +
  +	}
  +	return config_with_options(cb, data, &given_config_source, &config_options);
  +}
  +
  static int get_value(const char *key_, const char *regex_, unsigned flags)
  {
    int ret = CONFIG_GENERIC_ERROR;
  @@ -366,8 +380,7 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
      }
    }

  -	config_with_options(collect_config, &values,
  -			    &given_config_source, &config_options);
  +	read_scoped_config(collect_config, &values);

    if (!values.nr && default_value) {
      struct strbuf *item;
  @@ -477,8 +490,7 @@ static void get_color(const char *var, const char *def_color)
    get_color_slot = var;
    get_color_found = 0;
    parsed_color[0] = '\0';
  -	config_with_options(git_get_color_config, NULL,
  -			    &given_config_source, &config_options);
  +	read_scoped_config(git_get_color_config, NULL);

    if (!get_color_found && def_color) {
      if (color_parse(def_color, parsed_color) < 0)
  @@ -509,8 +521,7 @@ static int get_colorbool(const char *var, int print)
    get_colorbool_found = -1;
    get_diff_color_found = -1;
    get_color_ui_found = -1;
  -	config_with_options(git_get_colorbool_config, NULL,
  -			    &given_config_source, &config_options);
  +	read_scoped_config(git_get_colorbool_config, NULL);

    if (get_colorbool_found < 0) {
      if (!strcmp(get_colorbool_slot, "color.diff"))
  @@ -598,8 +609,7 @@ static int get_urlmatch(const char *var, const char *url)
      show_keys = 1;
    }

  -	config_with_options(urlmatch_config_entry, &config,
  -			    &given_config_source, &config_options);
  +	read_scoped_config(urlmatch_config_entry, &config);

    ret = !values.nr;

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

I call it dirty because they're plastering over the real problem, which
is that "given_config_source" has stopped being a good mental model once
we added the second global file, so the better long term fix would be to
overhaul builtin/config.c to reflect that (probably distinguishing
between config sources for reading and writing).

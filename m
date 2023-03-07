Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08383C6FD1E
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 19:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCGTzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjCGTz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 14:55:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DFAABB1B
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 11:47:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id cp12so8816545pfb.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678218433;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/+JVJMWRwTmUrzUQnu7KlUXXoMMfquFyhqGJ2VXx7U=;
        b=NGhFnSSZLKV+TugzMR1xr+iNMp8DpQ4moHW2e80iEfliIafi1iZl++Ye4sq8aVrLdt
         lzINCa0NV+FL4Vo3/vdLg3WegG6Ycp2VlPko97CfGTrTAeOn+Ru6F5ZsVZWsc1Q8q9lX
         4M3vwtB1i1k28zqgW1W4tACRJiCETWXdyaxufvbnjn5IRZcg85LCYRtz/xGdlzP1HJJ0
         yHu0o9EeXiYHh8FJJfh86tU+DEbG/OAgCHLg9/jGPB94EN8E5JpsdWoxMdQWV36vZsEp
         k9HBw5zbk3z7U1TOhLrluao3VXPP8tjVtBjnlawqR/OsbtQZ9tzBayNSNIqkEHmxUDBT
         mPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678218433;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/+JVJMWRwTmUrzUQnu7KlUXXoMMfquFyhqGJ2VXx7U=;
        b=JNtBK6LXD2LAMxlhm7S7QoljyKMXwyMMgULIZaoJOeQkg2ncx7zeEefQqmcsC93r0U
         FrtMoXwA3J2ZZWdquAhpwQ2ccBvwewosPkjAnZjnK7jefqmWveEElXHb6M97Wfw2ktsX
         OkHW0vdk/waF9dAOmf5v3sCMiZQaYqz9I13LR/Jcmo6kzGhA+RkXnS55DgksgG6DYP5T
         4CLFK7QhBdX6W/2OO9ZaLJSS6ClnUIKreaGxwaE2qYY6+pV2/DkLpXVGmLiRuFUZF1eE
         +WOESuzkzGctlWoz9Xa5meFNH0CwDcqyaHHVniO3N6+/htT5bCGA/Husj5Rdk1Qb3PX/
         1cyw==
X-Gm-Message-State: AO0yUKWxX6v+kbZYtDAGdDgXFHreKqfrtHGeJM6NxQkhQxhIANzeuCPD
        pyNPgdRYUWd5KVYeH9MaxIA=
X-Google-Smtp-Source: AK7set+sty3XlyFQSxuScyDnYo+ov+5UXVBqS53oIanIDEpfISDJl6TmYFcBuGoYuC/G9tQwQmKsSQ==
X-Received: by 2002:aa7:94bc:0:b0:5a9:c4d6:bfa6 with SMTP id a28-20020aa794bc000000b005a9c4d6bfa6mr15054842pfl.6.1678218432869;
        Tue, 07 Mar 2023 11:47:12 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h7-20020a62b407000000b00580d25a2bb2sm8218611pfn.108.2023.03.07.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 11:47:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] sequencer.c: fix overflow & segfault in
 parse_strategy_opts()
References: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
Date:   Tue, 07 Mar 2023 11:47:12 -0800
In-Reply-To: <patch-1.1-f6a06e25cf3-20230307T182039Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 7 Mar
 2023 19:21:59 +0100")
Message-ID: <xmqq5ybcxs1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> There's a few things that use this for option parsing, but one way to
> trigger it is with a bad value to "-X <strategy-option>", e.g:
>
> 	git rebase -X"bad argument\""

Wow, that is nasty ;-).

> diff --git a/sequencer.c b/sequencer.c
> index 3e4a1972897..79c615193b6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2876,13 +2876,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>  {
>  	int i;
> +	int count;
>  	char *strategy_opts_string = raw_opts;
>  
>  	if (*strategy_opts_string == ' ')
>  		strategy_opts_string++;
>  
> -	opts->xopts_nr = split_cmdline(strategy_opts_string,
> -				       (const char ***)&opts->xopts);
> +	count = split_cmdline(strategy_opts_string,
> +			      (const char ***)&opts->xopts);
> +	if (count < 0)
> +		die(_("could not split '%s': '%s'"), strategy_opts_string,
> +			    split_cmdline_strerror(count));

This made me look at split_cmdline_strerror().  It is a table lookup
into split_cmdline_errors[] in alias.c which looks like this:

    static const char *split_cmdline_errors[] = {
            N_("cmdline ends with \\"),
            N_("unclosed quote"),
            N_("too many arguments"),
    };

So the result is properly localized, but I suspect that the string
after : should not be enclosed within a pair of single quotes.

	die(_("could not split '%s': %s", strategy_opts_string,
		split_cmdline_strerror(count)));

Other than that, nice find.

Thanks.

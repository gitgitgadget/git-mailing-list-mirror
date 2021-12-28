Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE7C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhL1QZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhL1QZv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:25:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11404C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:25:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e5so39303231wrc.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Smm4i1NNb10AkqKoQixcY2NogmnPY+vDrcBe5CzuVzY=;
        b=gVQyObqDSCwWO71U0nAX5zZQ+CZxDh8ccaWrmLSOnB4CKQ17VciAUKbhwI4XPWBVlb
         0HWqR8GWRI49+2Gzp+9l2KrL5BErmYQpqsl+bgBw1d/2hr9WLGb8/9ORehcGhLG85XjW
         3KaG2uexhFDCMLVNH8qe7EKaUVJg1G4y+DMQAqVCjUvrmbB63v7wC6BsC7K0BH0Dq16p
         JDkbkksbnforYM3z/ShP3l4SK4QHnWDUbot8orbDLVrl+8CDnJcCmg1YjuvMIB5GcnqK
         QZpbsmlk0nINPM91bpvRZx5Q3H+uxH7GfE6CZ1qxc0YwF+eM4VVRp4ncaQL/zG5llFnr
         MFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Smm4i1NNb10AkqKoQixcY2NogmnPY+vDrcBe5CzuVzY=;
        b=EafE54Zn14RM9FSKzIYjDcFmvJer4XZwF61HsWFWYQfCqv1qaXFvV6cDvN+pRCwI5v
         KXfJ3/wTHCfveV6XisSo4N8yxyGAn3GuU5bcUZ/Em4QE6PhTHcb8bwTIOHdfwEkEZ3Wq
         +wTyalcT0N/YaVbdH4TjJay8Mco2sJJpJgRVwLweTVol4UVhpj6OREiBY1MKV9rZNjTt
         DTLk+VvEM3cLNd+sqSCA7XFjNAc6UUmb0QxFkbR4ccDDW2lSvgwB+8uK+uG6wlhYUpl3
         GLdmGt6Z5FtCTuc6GkuoqAQswzHePsB5sP8HuBvRVO4KfoFJaDDKu/7+Lcwxte7x9T4M
         ZTGg==
X-Gm-Message-State: AOAM532zxX1RpRYJbq2ePecKB0UvHWijpPgI/8Js4pBM9bU6iix2jgig
        6prbb96kq+YHIJbMRuYuqJA=
X-Google-Smtp-Source: ABdhPJyT0pydyJVmhPca3v/7NCuBc3hV/pra3yto1qKBc2XF2Q2WlHTKM6bEB4tGEdRdc53NlOD53w==
X-Received: by 2002:a05:6000:cd:: with SMTP id q13mr16909550wrx.302.1640708749659;
        Tue, 28 Dec 2021 08:25:49 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id o9sm2622634wri.97.2021.12.28.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:25:49 -0800 (PST)
Date:   Tue, 28 Dec 2021 17:25:46 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v8 3/7] progress.c tests: make start/stop commands on
 stdin
Message-ID: <20211228162546.quzsbwgvot7o7z76@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-3.7-271f6d7ec3b-20211228T150728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v8-3.7-271f6d7ec3b-20211228T150728Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 04:18:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the usage of the "test-tool progress" introduced in
> 2bb74b53a49 (Test the progress display, 2019-09-16) to take command
> like "start" and "stop" on stdin, instead of running them implicitly.
> 
> This makes for tests that are easier to read, since the recipe will
> mirror the API usage, and allows for easily testing invalid usage that
> would yield (or should yield) a BUG(), e.g. providing two "start"
> calls in a row. A subsequent commit will add such tests.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/helper/test-progress.c    | 46 ++++++++++++++++++++++-------
>  t/t0500-progress-display.sh | 58 +++++++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 32 deletions(-)
> 
> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 50fd3be3dad..becc163375f 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -3,6 +3,9 @@
>   *
>   * Reads instructions from standard input, one instruction per line:
>   *
> + *   "start <total>[ <title>]" - Call start_progress(title, total),
> + *                               Uses the default title of "Working hard"
> + *                               if the " <title>" is omitted.
>   *   "progress <items>" - Call display_progress() with the given item count
>   *                        as parameter.
>   *   "throughput <bytes> <millis> - Call display_throughput() with the given
> @@ -10,6 +13,7 @@
>   *                                  specify the time elapsed since the
>   *                                  start_progress() call.
>   *   "update" - Set the 'progress_update' flag.
> + *   "stop" - Call stop_progress().
>   *
>   * See 't0500-progress-display.sh' for examples.
>   */
> @@ -19,34 +23,52 @@
>  #include "parse-options.h"
>  #include "progress.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  
>  int cmd__progress(int argc, const char **argv)
>  {
> -	int total = 0;
> -	const char *title;
> +	const char *const default_title = "Working hard";
> +	struct string_list titles = STRING_LIST_INIT_DUP;
>  	struct strbuf line = STRBUF_INIT;
> -	struct progress *progress;
> +	struct progress *progress = NULL;
>  
>  	const char *usage[] = {
> -		"test-tool progress [--total=<n>] <progress-title>",
> +		"test-tool progress <stdin",
>  		NULL
>  	};
>  	struct option options[] = {
> -		OPT_INTEGER(0, "total", &total, "total number of items"),
>  		OPT_END(),
>  	};
>  
>  	argc = parse_options(argc, argv, NULL, options, usage, 0);
> -	if (argc != 1)
> -		die("need a title for the progress output");
> -	title = argv[0];
> +	if (argc)
> +		usage_with_options(usage, options);
>  
>  	progress_testing = 1;
> -	progress = start_progress(title, total);
>  	while (strbuf_getline(&line, stdin) != EOF) {
>  		char *end;
>  
> -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
> +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
> +			uint64_t total = strtoull(end, &end, 10);
> +			const char *title;
> +			const char *str;
> +
> +			/*
> +			 * We can't use "end + 1" as an argument to
> +			 * start_progress(), it doesn't xstrdup() its
> +			 * "title" argument. We need to hold onto a
> +			 * valid "char *" for it until the end.
> +			 */
> +			if (!*end)
> +				title = default_title;
> +			else if (*end == ' ')
> +				title = string_list_insert(&titles, end + 1)->string;
> +			else
> +				die("invalid input: '%s'\n", line.buf);
> +
> +			str = title ? title : default_title;

I don't think title is ever NULL, so we should be able to elide this variable.
(Did you want to fall back to the default title when the input is "start "?)

> +			progress = start_progress(str, total);
> +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
>  			uint64_t item_count = strtoull(end, &end, 10);
>  			if (*end != '\0')
>  				die("invalid input: '%s'\n", line.buf);

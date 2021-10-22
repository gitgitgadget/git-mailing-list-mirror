Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78BC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B561390
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhJVDgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJVDg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:36:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78006C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:34:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so2039299pjb.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DxE5ro2eRJG7C5UjeCRClu3zJX3o/ud6vgrvT20421s=;
        b=fTDtMy7j3Hc8MjizCSw8X9ewraMsoplexeKq2pAEVqLHXLF54qF7AqtcU1hr1cHqEa
         52rU29rNVkqwPmof2gZqgUtOpu1y7lQTJxcal5VqbT1QmAJeh7L1TgMpBdukDaCp/mpe
         DeD8F+v8PqahP66Y/PZqyg43DGwMqmjmZL3ER2k+YdFIYW9rceW+ZNFMN9WvtslhtJv8
         yc1zMWijN7bJPXy/a2ahGhhaq00pinqBEThC3DLc5v0CnXdzUYjwUBxn0qxCk+WC1aLQ
         oRu+euDT4F8948Fk1bOzaV+9otjsk7xsFy6WkRLYMhyjRn86cLiFes9IBiqqYsoJoHOz
         xlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DxE5ro2eRJG7C5UjeCRClu3zJX3o/ud6vgrvT20421s=;
        b=bWvAsghVIGTpQRituVguMSiZ8YIpNPX7XiiqeAJfjAHBmi0Lb+oL9udvIdXovJ43gZ
         NAumBs8IZqe5jFkl6K8IQ2NVXr0kJEqFoed7cYTcLsB+Vy2qcJ2k+Izc06hKSDzxEqH/
         YmP/GiqAkTjv0pOL9B+77JX0zpRv1BMOcSJTW8EVQdXeFNtm+MefI/aE8tiVvuZZ7eT8
         6DUX0gwj6uK8s4LPL6OqGdcAazQo9j5V6eEBLqcqhT207U/28jSG3I5DFL+7MPSdy5lF
         4Y4HXhQfI0d835KkU8O1wVdx7wnymKxHqIlgH+PTtgA4IzKM97sp8hAzZIkMBxcb67bo
         l3rA==
X-Gm-Message-State: AOAM533MiIirtuRJcGViHehwVDXFO7UQms8i2t2ylXmMCmO6ZvtvkxAw
        c2zeLwzVQ6eNdIKi8otm/jgZtA==
X-Google-Smtp-Source: ABdhPJx0iihRUTkh8JDvNn8igh8OXn4ZhbC2UpI286n9SbmKj7DCSBkNFnoQFJP1IHIMY5T7zO3Oew==
X-Received: by 2002:a17:902:868c:b0:140:f6f:8a10 with SMTP id g12-20020a170902868c00b001400f6f8a10mr3445890plo.77.1634873648703;
        Thu, 21 Oct 2021 20:34:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id b6sm8936832pfv.171.2021.10.21.20.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:34:07 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:34:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 03/10] progress.c tests: make start/stop verbs on stdin
Message-ID: <YXIxLHJa6uzYAQZU@google.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-03.10-045d58d8201-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:19AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
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
>  t/helper/test-progress.c    | 37 ++++++++++++++++-------
>  t/t0500-progress-display.sh | 58 +++++++++++++++++++++++--------------
>  2 files changed, 63 insertions(+), 32 deletions(-)
> 
> diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
> index 50fd3be3dad..45ccbafa9da 100644
> --- a/t/helper/test-progress.c
> +++ b/t/helper/test-progress.c
> @@ -19,34 +23,43 @@
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
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	const struct string_list_item *item;

I suspect the string_list is there to enable multiple progress lines
later, no? I saw SZEDER ask about it in another reply... If it's for
later, is there a reason not to add the extra structure alongside the
series adding multiple progress lines?

> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index f37cf2eb9c9..27ab4218b01 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -18,6 +18,7 @@ test_expect_success 'simple progress display' '
>  	EOF
>  
>  	cat >in <<-\EOF &&
> +	start 0

Seems better to me, more explicit for the test reader. Thanks for the
change.

 - Emily

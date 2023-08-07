Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA42C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHGVUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHGVUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:20:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C998E5B
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:20:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d414540af6bso3590807276.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691443237; x=1692048037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+CWKyO/4VYZCTAiZ8eiVVXXM0zpwAh/P7t/sPPNuDA=;
        b=pNnPThJVxBQGfVaEMsWxtAi18Pvo8Bb+f9p13HjE1AIW4flLlN9Au/2ZpzdGUX8K4+
         2v8sza5oy1zJG8BkV+FP+yh3ubw8M5lCoyvz5l/gPhJHzwrUxUTdGjrbte/TE1s6psRj
         /Jxkw9eA+hZcAp/g8P3qXPss6pJaejsKYpp5L/6BKi6AZGIg42pDo38P53t8FG1UCXXm
         bxRwwMAODrWXykDKjfW/hhAk1aKgARY8W3GbjcNg9WxjktDnNNCZnTWOLxV0jXNO+5aD
         6xfK+bRA78jg/iEOzvCNzR6cSN2RKhCMMb1JuEBRVf6aCdjOrtK+5yaXNRND5f1sqYSv
         oqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443237; x=1692048037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+CWKyO/4VYZCTAiZ8eiVVXXM0zpwAh/P7t/sPPNuDA=;
        b=EN1RP53qtmUWQFRgzjVG8wVOJnQS7pH7g34BamN0eExWSTWGvMJ0+sxoszxxLLBtI5
         0npwzN/o1SnkyNMAy3+shMqLhdwTCwclXEjmnZ7hLj9kL+v2t2pziU1rIXWRySO1fstD
         mow36/T7Y7nj01dpjAKlz6Jp2O+k8aFklLmpbptvDO6S9eDJRTiCmzBLYvsXq22sVPD3
         lCv/nazFVDhMNFfFZJuQ7E57XHhHFOKdXl+larf5/fyBvza4kmc/eAYoz9eo9ZBQYqZL
         VrzaY6FFdMGBdgslUTCYh5JTh8YNF+XbZtAUqtsBakxWA9Kkx2V/PatdTa8osw0HAXii
         NVzQ==
X-Gm-Message-State: AOJu0YwMkjmAoQ8SjTnOLBj3hMQN6A9A2VZUC4RcWXuiSE361e4fDl0g
        HfrB7MCgH8QQF0W+RrJn2taGvw==
X-Google-Smtp-Source: AGHT+IFmUgBqPfFJO2tQTpAOG3xkb4NZH0EXjjbXTF4BJ81O+tUcXRthyc0PLsZPuIrS3IuwM0kKnw==
X-Received: by 2002:a5b:ac9:0:b0:d4b:f4e4:62f4 with SMTP id a9-20020a5b0ac9000000b00d4bf4e462f4mr4537369ybr.10.1691443237353;
        Mon, 07 Aug 2023 14:20:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v184-20020a252fc1000000b00d0aa0a97ee7sm2511446ybv.32.2023.08.07.14.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:20:36 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:20:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Message-ID: <ZNFgIyuhlNd8I9Y2@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 06:51:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index f3942188a61..66a972bc292 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1708,6 +1708,23 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
>  	return 1;
>  }
>
> +MAYBE_UNUSED
> +static int get_random_minute(void)
> +{
> +	static int random_initialized = 0;
> +
> +	/* Use a static value when under tests. */
> +	if (!getenv("GIT_TEST_MAINTENANCE_SCHEDULER"))
> +		return 13;
> +
> +	if (!random_initialized) {
> +		srand((unsigned int)getpid());
> +		random_initialized = 1;
> +	}

I was wondering where else we call srand() within Git, and it looks like
the only other spot is in `lock_file_timeout()`.

I doubt it, but is there a chance that that code depends on only calling
srand() once? I think the answer is "no", since we only use rand()
within that function to generate a random-ish backoff period, so I think
the repeatability of it doesn't matter all that much.

So I think this is kind of outside the scope of your series, but I
wonder if we should have a git_rand() that automatically initializes the
PRNG with the value of getpid()? Then multiple callers can grab random
values at will without reinitializing the PRNG.

Thanks,
Taylor

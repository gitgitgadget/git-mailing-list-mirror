Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB8ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiH3NsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiH3Nri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:47:38 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E695FE805
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:45:45 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f4e634072so2526202fac.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=btZLbxZJVxgMD0xCKzrE+gPwTP3nmseP46Qs7BhvOv4=;
        b=L2q1vXNKCiJ2XkchzkL+5cE7hBZvfM254F9F+b6ukyBF+HUGIn8svszM+aRWaJc76/
         Zc3KrFjITO6KxxUR1ukYVnv2LwFtyDBWzF6D+i7e7N+0fepl2tXWAh+EP4pfiRz68uJN
         /wSS5yR+s9O+ZIB5HdV6aeCHAHnd0Sfe1GRWrBGLO7b2NnrLoYXfuSBmvYNKCwbeePV0
         b2OtLepA/v7e5T6j1hIszo+QphS+PLHWU7gmx8tB/E9a4OFLQaJIkMQyYRdkRhcmQsQE
         k2dTwYa8wyG+ZL6XIYuIq8USxKzxqlAHm22YG47KJzpJExvL6KiWlpPEeRgcCxU2e1WR
         zTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=btZLbxZJVxgMD0xCKzrE+gPwTP3nmseP46Qs7BhvOv4=;
        b=L8xW4LydF04BlJcBV+Nh9phM+nhh4BuHxsRe9cyc1xlpQk+PSZIBRKRwT4xS4/jBK4
         WT9ydnYIhUBV37IDEVfjrhdvTOCGiSQBZifMb9ihDMZVU+4f1rzF7d2j9Gnud8RgVfVD
         7w+NBLBFcOVXD4tcdklnFx6QdiYrPZGlkoQ5UE1Le8I/orKU8bjgdwmiFAJ98TFnDG0a
         S2KoM9r1s8D74AL9i7xGQYk4m3VllpJfzNArC0PUYq833VA1yM9uzcvSClx/9SMdXYaS
         KW1CFblFYlUlXb0H7yCWQtEx0NlVKG3ADH0xNpX75hmPZ/K4PsAdLFkYpwnR+eSHJDKu
         f6rA==
X-Gm-Message-State: ACgBeo0GzaH8CBGVIpHTAtZ21rTJ8Kib09I3/wTCwnEpfDuNylJK3lSd
        abhJ3PQV0O7HDceY2vaHLoDX
X-Google-Smtp-Source: AA6agR73/nVSVf3uHtH4/UpXJ8lhhACsxNKOvBqO/+cA0V31GyIwnua57B9XsYtnrMrVdIJDlQBzBw==
X-Received: by 2002:a05:6870:831d:b0:10d:a96f:8bc with SMTP id p29-20020a056870831d00b0010da96f08bcmr9666418oae.143.1661867124869;
        Tue, 30 Aug 2022 06:45:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z4-20020a056830290400b00639749ef262sm6401759otu.9.2022.08.30.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:45:24 -0700 (PDT)
Message-ID: <38741e59-3da8-e707-d8d9-da45eb2ef08a@github.com>
Date:   Tue, 30 Aug 2022 09:45:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] builtin/grep.c: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220829232843.183711-1-shaoxuan.yuan02@gmail.com>
 <20220829232843.183711-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220829232843.183711-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2022 7:28 PM, Shaoxuan Yuan wrote:
> Turn on sparse index and remove ensure_full_index().
> 
> Change it to only expands the index when using --sparse.

s/expands/expand/

These two sentences should be combined, anyway.

  Enable the sparse index for 'git grep', and only call
  ensure_full_index() when the --sparse argument is provided.

> The p2000 tests demonstrate a ~99.4% execution time reduction for
> `git grep` using a sparse index.
> 
> Test                                  Before       After
> -----------------------------------------------------------------------------
> git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
> git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
> git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
> git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)

Last time I asked that you don't present this to look like a
performance test to make it clear that it is not the end-to-end
process time. You removed the test numbers, but it still looks
like end-to-end process time, then elaborate after the table.

Instead, you can prepare the reader before the table using
something like this:

  The p2000 tests do not demonstrate a significant improvement,
  because the index read is a small portion of the full process
  time, compared to the blob parsing. The times below reflect the
  time spent in the "do_read_index" trace region as shown using
  GIT_TRACE2_PERF=1. 
> -	/* TODO: audit for interaction with sparse-index. */
> -	ensure_full_index(repo->index);
> +	if (grep_sparse)
> +		ensure_full_index(repo->index);
> +

As we've discussed, there are ways to remove even this call, but
that shouldn't hold up this series which is already an improvement.

Thanks,
-Stolee

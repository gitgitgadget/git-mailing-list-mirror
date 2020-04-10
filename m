Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C99C2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A2F2082D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hswPgCoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDJM1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:27:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36963 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJM1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 08:27:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id u20so1264197oic.4
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CEtTNf7mAvJUKTdW8R+i/HnT6TC2kCVu29e14OdozwY=;
        b=hswPgCoBpNxFaT4wg0r7b6EGsM0Ukf21Y06wXXszBWxliViNDS77V0ng0K5LlVK1dE
         XBhkFYLoGidMXLJszmI0R9iZ4snf3NxFPmCU1xPz7Y/ZeRa9EodVXnFQB2ClbULQAYWm
         277cE58c3byuf6uRB4HUmm+a7z7W7Q9/JI+rKCQt4pASStfP0RxMU8UFqcylqMHGqkZH
         q2cLlQn7pqmik3EcHxALqGNPrV3yTjVLDdwyibYwONcvLJWKw906H6dSZ355t/F/hATS
         ASIYUqkAgZCQFeaQhJghB/91DD96qozbzDwfVfLV0vY+JzbR/0LPnL0yEiG6WLi4Hs4g
         0Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CEtTNf7mAvJUKTdW8R+i/HnT6TC2kCVu29e14OdozwY=;
        b=LWqBz7St7XhjuXe0uGAa88ExePGoYQeqIqhcYmpAkjt0FxPiq/sCzI2keW0CH2jU8V
         ahF761MuFZPmjnlMDWLosEzh7OESWaAPXT0tNDpjQKkxfx2Q+Po9K7VWpNwXWecAJ8IY
         8vyDbRLPA+Yfth2sthuYiPpG7yHUxEqy0/UImJAjzpUZpjT5JfqHYHrI+h/KDmBOpIQr
         m3enB9p/XxzCh8sbW292RIvISr320FJPcjNZ8oWPOCbpeOxBQe+hk5PKWOOSO1w06XGf
         FHXZSLcu+9UALsdPGJe3A/W1lZVgZQhsOLFQh+nxMQoM2b4H444yDwJBaGvI9Fu9+Oa6
         zN+Q==
X-Gm-Message-State: AGi0Pua3zy9Nkg9zGSDpF8zlmpYJymYaAJnvaOKWVi3trewae+Jt03RD
        ZxYJhCmI/UXW8CWBOv0lR05agIi+e3I=
X-Google-Smtp-Source: APiQypISJFjDSz2xxlRF7KEwIBBEBk1xE2aZVQMxoEHa5nN6ys514B6b9obsbWbudjKljX7B6T2HZg==
X-Received: by 2002:aca:d10:: with SMTP id 16mr3205675oin.142.1586521658338;
        Fri, 10 Apr 2020 05:27:38 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q187sm1129117oih.48.2020.04.10.05.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:27:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] Refactor code asking the user for input
 interactively
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
 <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
 <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cf6bdc4c-bacf-5de0-b0b3-255e66c7bc18@gmail.com>
Date:   Fri, 10 Apr 2020 08:27:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2020 7:27 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> There are quite a few code locations (e.g. `git clean --interactive`)
> where Git asks the user for an answer. In preparation for fixing a bug
> shared by all of them, and also to DRY up the code, let's refactor it.
> 
> Please note that most of these callers trimmed white-space both at the
> beginning and at the end of the answer, instead of trimming only the
> end (as the caller in `add-patch.c` does).

add-patch also only trims the newline! This is still a good change.

> THerefore, technically speaking, we change behavior in this patch. At

Strange capitalization here.

> the same time, it can be argued that this is actually a bug fix.
> 

> @@ -1158,9 +1159,8 @@ static int read_single_character(struct add_p_state *s)
>  		return res;
>  	}
>  
> -	if (strbuf_getline(&s->answer, stdin) == EOF)
> +	if (git_read_line_interactively(&s->answer) == EOF)
>  		return EOF;
> -	strbuf_trim_trailing_newline(&s->answer);

(Pointing out the trailing newline trim here.)

> +
> +int git_read_line_interactively(struct strbuf *line)
> +{
> +	int ret = strbuf_getline_lf(line, stdin);
> +
> +	if (ret != EOF)
> +		strbuf_trim_trailing_newline(line);
> +
> +	return ret;
> +}

This looks good. Do we need a trailing newline or something?
The way the diff ends abruptly after the "}" line made me
think so.

Thanks,
-Stolee

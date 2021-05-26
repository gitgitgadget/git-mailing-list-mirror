Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20515C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24D0613BD
	for <git@archiver.kernel.org>; Wed, 26 May 2021 11:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhEZLGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhEZLGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 07:06:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3CC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:04:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5so592562pjj.1
        for <git@vger.kernel.org>; Wed, 26 May 2021 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bmYa5yOddTfwlwBJRFmFJx37Me7eGfZQAxk7e+UpGxU=;
        b=nNTFtg+XxT8Fg/GUU1nk++0m0WhqeV5jMW04+2OYjIMyp5BV9XWs4Ei6AqnMJcqoWq
         GOcF1bE90XlahIdio5yQWhFmy6b8pC3bB6Z3bK0f4iTc+dGIposFpI2/p1CZfxIdHCdg
         mmS86RZB6eCgWHmbEWE07GkS9uX0xXQLyBqUQMihAQ2QQ5GkZag+79pnW1SwHyPIVQAB
         nboZ6G8E0Qjyhz4yu2VxlVFkA4udCHekicp1Eb8WFaV/t0fgHa67da1ab3SaC+J2Mahi
         ul30CdILImcmZyPa+KLE0vhMNPFjUAJMKoHf9cyzF6mPqYQjKueKxWVvIxRli1c5v3Xa
         YgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bmYa5yOddTfwlwBJRFmFJx37Me7eGfZQAxk7e+UpGxU=;
        b=PdRtyi5NPDIcPU5QCCtm82FG0qZWKrc11MagxT9njYFYj7BRs0rKcLAr2Vzq1Zwtif
         zNDHOe8WmJAmpoUVPVJ4tmy5VbAlGIDO/3ytrVadRCSZpdSaNQiaNmaUcnGiB9YcZvZu
         /mGdo7RbnYwnrT4TksYvQV6jVG8QOYwOnZl/oLUDXQ27EskS2ovWx50+xQ9E+Uobz0Wo
         sjcwNGqiSFHS9lmXz5nfFWVWq4FAY2/Ud39mx0c4NjBKXb4lCodztEQGV67ziyvP7cW3
         XARAG/fpS71hdAa/YWyZb2yS8mJSPB4a5z3iE/z2LkUVtwWpUbrZaolqeOBzIv4jqFcB
         vG8Q==
X-Gm-Message-State: AOAM531Bnfj+7adBXIJLnQ5pdma2v2rpzHB67jSFfjhk0aUTjUBYznaj
        Kb+QezbwXNncl0OpMITtA9z4pp8HX6fSLA==
X-Google-Smtp-Source: ABdhPJyOPdLU8T27D2PJFdEx4kwWcKtaw0duB3Mvb8q1yOwN+XCWBFPP+Z9/vA+tsvDOyQb2YHk6UA==
X-Received: by 2002:a17:90b:17c4:: with SMTP id me4mr3429886pjb.22.1622027069355;
        Wed, 26 May 2021 04:04:29 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id ei9sm4166827pjb.2.2021.05.26.04.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 04:04:28 -0700 (PDT)
Subject: Re: time needed to rebase shortend by using --onto?
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org
Cc:     entwicklung@pengutronix.de
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a37840c5-1103-6f38-555e-188878f50e36@gmail.com>
Date:   Wed, 26 May 2021 18:04:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Uwe,

On 26/05/21 17.09, Uwe Kleine-König wrote:
> Hello,
> 
> I have a kernel topic branch containing 4 patches on top of Linux v5.4.
> (I didn't speak to the affected customer, so I cannot easily share the
> patch stack. If need be I can probably anonymize it or ask if I can
> publish the patches.)
> 
> It rebases clean on v5.10:
> 
> 	$ time git rebase v5.10
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Successfully rebased and updated detached HEAD.
> 
> 	real	3m47.841s
> 	user	1m25.706s
> 	sys	0m11.181s
> 
> If I start with the same rev checked out and explicitly specify the
> merge base, the rebase process is considerably faster:
> 
> 	$ time git rebase --onto v5.10 v5.4
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Successfully rebased and updated detached HEAD.
> 
> 	real	1m20.588s
> 	user	1m12.645s
> 	sys	0m6.733s
> 
> Is there some relevant complexity in the first invocation I'm not seeing
> that explains it takes more than the double time? I would have expected
> that
> 
> 	git rebase v5.10
> 
> does the same as:
> 
> 	git rebase --onto v5.10 $(git merge-base HEAD v5.10)
> 
> . (FTR:
> 
> 	$ time git merge-base HEAD v5.10
> 	219d54332a09e8d8741c1e1982f5eae56099de85
> 
> 	real	0m0.158s
> 	user	0m0.105s
> 	sys	0m0.052s
> 
> , 219d5433 is v5.4 as expected.
> 
> 	$ git version
> 	git version 2.29.2
> 
> That's from the Debian package 1:2.29.2-1~bpo10+1 on a Debian 10 box.)
> 
> Best regards
> Uwe
> 

Can you reproduce your findings with latest version (v2.32.0-rc1) please?

-- 
An old man doll... just what I always wanted! - Clara

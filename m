Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FD4C2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4622078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQXIICbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJM3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:29:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32880 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJM3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 08:29:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so1722715otv.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8B//bhhzW0p/t7glc6XA1GqSQyVIqy3ekL1x3/B/aX8=;
        b=EQXIICbYGhRYNaIhDqPnF11diaNOAZAQCVELqSVrke5qKCrpy9VrFNEY+UqRFf8A9g
         13Nx3iFGTPktiEAjOOmvsvBO1njbcjS8J9LcepRTpwn8glmb2cIDm6stNtUHG3+BCvm+
         rlqHdnOVejbC3Ajwn0CEIs0QRmavT4ozHbYxebyh/nh+Xl/moSKyDtMq5ocs6NFG/dpv
         p5aYKeD2FoqADlMjhwJ3eH7O53J8fC2lhXxnf3T4Z+CBHHIVHuBP0QCFthvIicP/WkTn
         NXO4wvWrgRo2UDIagKNsM99G+j7UcrAGYzw+pbqhzYae95napo+ET6RJgmWjYaSN98QL
         CS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8B//bhhzW0p/t7glc6XA1GqSQyVIqy3ekL1x3/B/aX8=;
        b=Xmsd7ZxL/LAa6iYV0C3piuX1Cm4QO+qInoEsNuvzy5O1K1MoH1a+N20vTzKIWuvoyX
         0k7PyRBnRXSh8aVMO4uVv/p5Fzdi2wP82GIIt19E3AKUvQBiEylv7EE1Msd0x4YcbDi9
         Gbrtw6JbMYgogHbYkxl8PD9DTcMlDVmc9+YZ600mhm5LpYeef0PjTefUopwjc+vC1Ifc
         SZzNr7civOdrYXnhXCO2jyvBNdBIEDzbnOtRaDTsu2g5qMziA6I7KSmcmwEfZcY/eRO6
         JEG8yRWSAvJGD0Dx5PrWQ8d6Uw5xYx2N9KmRITWok33vq35Mfu3iT0AkxKfwqLNLGg5x
         W1hg==
X-Gm-Message-State: AGi0PuaZD0a67FOP1HCCljO1+vQ+7hJ6GaP09F+3F3PYdiDC2/5nOOZa
        TDrHthd4EIhv3U6UA9Auq1E=
X-Google-Smtp-Source: APiQypIPYSj/fIAHePsHvUe6mVhr2lo2BGMFP+6xTvYVUTHlKQv7NWz2ZO2Mvo9kSkuj4gdOJkQnoA==
X-Received: by 2002:a05:6830:10a:: with SMTP id i10mr4163489otp.190.1586521738987;
        Fri, 10 Apr 2020 05:28:58 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f15sm1149761oig.13.2020.04.10.05.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:28:58 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] Explicitly `fflush` stdout before expecting
 interactive input
To:     =?UTF-8?B?66eI64iE7JeYIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com>
 <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
 <d3949e42004f31e8741fad08352f782b4b8536eb.1586518072.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5350e8fd-2ca6-7c07-497b-1bb35bb07c84@gmail.com>
Date:   Fri, 10 Apr 2020 08:28:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <d3949e42004f31e8741fad08352f782b4b8536eb.1586518072.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2020 7:27 AM, 마누엘 via GitGitGadget wrote:
> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
> 
> At least one interactive command writes a prompt to `stdout` and then
> reads user input on `stdin`: `git clean --interactive`. If the prompt is
> left in the buffer, the user will not realize the program is waiting for
> their input.
> 
> So let's just flush `stdout` before reading the user's input.
> 
> Signed-off-by: 마누엘 <nalla@hamal.uberspace.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  prompt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/prompt.c b/prompt.c
> index 098dcfb7cf9..5ded21a017f 100644
> --- a/prompt.c
> +++ b/prompt.c
> @@ -77,8 +77,10 @@ char *git_prompt(const char *prompt, int flags)
>  
>  int git_read_line_interactively(struct strbuf *line)
>  {
> -	int ret = strbuf_getline_lf(line, stdin);
> +	int ret;
>  
> +	fflush(stdout);
> +	ret = strbuf_getline_lf(line, stdin);
>  	if (ret != EOF)
>  		strbuf_trim_trailing_newline(line);

Nice and "clean" ;)

LGTM
-Stolee


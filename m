Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B4C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FF5611BF
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbhEQQwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbhEQQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:52:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81338C061248
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:48:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so6431685qkv.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Xmf8EM3g9V1ZR5H06NshGj5vPs+PlE3N11XMsMYReVI=;
        b=i2zL3ELgSAu7vJwjr1EdrBKa8Us2jDcp/FoNFTLukz8kijk3zgbk5z/gy51eOkmWT+
         rbyTqBMJcUfTcPHG3GuQh3HudrbSHiO7UBgC2SQuWvb8hsqELKX3z7Ii/cyvdcly78mD
         BTWBX3B397zsi8iO66P4GykINlvmcvGHreYh8Dg5kJJnS8ZV6DFmPifoH41H5T2TIyBF
         /NcmxMsyDqdvzRxqppCUSic4L2en53ww2u+eaHfQ0eoqYuTotMuXiMpSiIGt7sWULVbk
         83BaV9X+rCXTSA9Eepk/99dHtkZNtnTPxNRUrIRTFRlIdXD8YrVL+PcsWgRt8pnxeM6e
         1SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xmf8EM3g9V1ZR5H06NshGj5vPs+PlE3N11XMsMYReVI=;
        b=qWS8XqGWWKunuH/2cxx8EfY5Z6p8Jn4Zt53GsZdNwDWxjjblJO1/VOkEOs22FONqZA
         cDDxQKMFI0JrlFOcW5HaTRAd48or2u7eS5I6WTAVCLXwWrfVvGXs0wdKD1cVUQrd5Odp
         L/47SnIwNpNlEsLvN6hWd794bg9LIJxlEKLsBPgNtpn9wlFpzKpDNs3dnkrn3OhzwBkJ
         uKGDnzgEV9IJRnoIg2jlAIeeU0Fps73dhdiPVs0zU4Pc2IdzUTs0FSTZTndoNHCoWKU7
         TavkeFskYbvOko5rPnGeRCZAEmfKrlTOebNwE0Dn2WtmFQXLpN+KdLZ9ea4LxIzAb3U6
         JJdA==
X-Gm-Message-State: AOAM530jXRmnsPBhM+pehTSprpnl2jE3W1QZV2Njmevd8uEYCgGEG914
        yxHNnKok97mzzlsj5/kFQ1w=
X-Google-Smtp-Source: ABdhPJyk77YJzEF/9TbIFl1HFZ3pQLjUKVxHgYT/buPcnYGRgERTzdGS23ktbR8ueaRmWrQMnEv4Nw==
X-Received: by 2002:a37:b945:: with SMTP id j66mr782625qkf.270.1621270114703;
        Mon, 17 May 2021 09:48:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:68e5:b0b1:d7d3:e820? ([2600:1700:e72:80a0:68e5:b0b1:d7d3:e820])
        by smtp.gmail.com with ESMTPSA id g140sm10932484qke.32.2021.05.17.09.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:48:34 -0700 (PDT)
Subject: Re: [PATCH] stash: don't translate literal commands
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        ungureanupaulsebastian@gmail.com, t.gummerer@gmail.com,
        gitster@pobox.com
References: <20210516215704.32440-1-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91d3d4e7-a04f-3fc4-a97b-90af02b20ed5@gmail.com>
Date:   Mon, 17 May 2021 12:48:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210516215704.32440-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2021 5:57 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/stash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index d68ed784d2..075bcf6ee5 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -26,7 +26,7 @@ static const char * const git_stash_usage[] = {
>  	N_("git stash drop [-q|--quiet] [<stash>]"),
>  	N_("git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash branch <branchname> [<stash>]"),
> -	N_("git stash clear"),
> +	"git stash clear",

I immediately saw the commands above and wondered why you are
not removing them from being translated. My guess is that the
"<stash>" strings are the bits that are interesting to
translate. Perhaps add some description in your commit message
as to why you are drawing the line here?

>  static const char * const git_stash_clear_usage[] = {
> -	N_("git stash clear"),
> +	"git stash clear",
>  	NULL
>  };

Are there other instances in builtin/*.c? If not, then it
would be nice to say so. Otherwise, it would be good to fix
them, while you are here.

Thanks,
-Stolee

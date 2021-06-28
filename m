Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F9C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 06:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36E561466
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 06:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhF1GHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 02:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhF1GHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 02:07:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F7DC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 23:05:25 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q192so13230333pfc.7
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 23:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lfFXpjFvXI233o5xqmHqe0L99ko3mrMywS531P3wjL0=;
        b=IXrmgoORtDar8BRX2wT5BFCn7cGh7pKqjabXDc11FSvP9ISvAwncrhNM88tPAn1rpW
         RZMRL/MVNo4rw7qs23HOHLGDGt3H7B/ISXZI9jBz6CBBKmVpRig7Krapi55S7xKw7IPl
         JZEapra/n1FZoNHvyzgXQJMBsIWtmmmpE6lYXVuKhWHAediMil12zAXnu/oudxZFAHdF
         wLnPxDND/PIeVK22W1vEtVSzHgFVedOE22ioRrglRuV6pyFLyeqb45qQsyo5mfvjgYaQ
         nW51lB+jimiV/ZTH0ThU14exYO86YGomz/j0XVy+u9qcdC035nOw0IDskuyg4GgKudEC
         w3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lfFXpjFvXI233o5xqmHqe0L99ko3mrMywS531P3wjL0=;
        b=oxVuq5R2xAMhHsSEEoqkci5M2EsZpM7DoB2tdHP0mpofC+ttcuoF2YAre6QA0zazjT
         DYXnniy7c4wgpeQ8o1zMqtWB6v80j1Q5d5W76KxWXMD4OnPZxjSIlXpo3mv8s0mibv3Q
         6xUXdKANInhH6kUkfEAFCbMQIFIHxbP2E69dUrMRTLFLj2g8/Qu6q+2iIZjC5dtNSHMp
         guBJgTEcbRACE0CZy/GZueQm1XEzxTDmlYk4KUsOt6lycAeSl9AAh5h8A9v9eXRd0XRx
         00bAVeoQ4PtVQA/uT06cg0YYCt6xudZpBcUUL0XiQk6THIZCV1cTwz3ClvE+5OQ4MNSS
         SM2Q==
X-Gm-Message-State: AOAM5301HYfWVuIN4qmtlqAymlymH9gV93wXwFcFPjLBy2IvpwYy3vi5
        46HgAYy+e5oKBVO8U8Aewz/mZVTEh8Q=
X-Google-Smtp-Source: ABdhPJwVQZfzfCJsECNrvqphpTCTM5oT8CmT9f18wsLUybsPxwz3hOhSWGuRqCRcdjmDDimaxlabrw==
X-Received: by 2002:a63:4815:: with SMTP id v21mr21429967pga.213.1624860324451;
        Sun, 27 Jun 2021 23:05:24 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-79.three.co.id. [180.214.232.79])
        by smtp.gmail.com with ESMTPSA id v69sm14141361pfc.18.2021.06.27.23.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 23:05:24 -0700 (PDT)
Subject: Re: [PATCH 1/1] Documentation: commit patch typo
To:     Beshr Kayali <me@beshr.com>, git@vger.kernel.org
References: <20210628052631.345601-1-me@beshr.com>
 <20210628052631.345601-2-me@beshr.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <afef1ee8-dd6e-2954-2c97-57ae14b27668@gmail.com>
Date:   Mon, 28 Jun 2021 13:05:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628052631.345601-2-me@beshr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beshr, welcome to Git mailing list!

On 28/06/21 12.26, Beshr Kayali wrote:
> ---
>   Documentation/git-commit.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Why isn't there commit message? But from cover letter of this 
single-patch series:

> Simple typo fix (chose -> choose) in the documentation of the patch option under the commit command.

Don't forget to write the commit message in next series.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 340c5fbb48..95fec5f069 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -72,7 +72,7 @@ OPTIONS
>   
>   -p::
>   --patch::
> -	Use the interactive patch selection interface to chose
> +	Use the interactive patch selection interface to choose
>   	which changes to commit. See linkgit:git-add[1] for
>   	details.

Fix looks OK.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633AC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 17:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjANRnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjANRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 12:43:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD6A5F0
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:43:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u19so59073598ejm.8
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZMCGpVbfIB9JkUGTcyRqLG+GmIZ+PK+cLyuXuV9OB8=;
        b=QgUFfFAfdrbcllyuUJNfmCGrGE9tNEQq4kQ62CrBAmgKwnRyvd66OhDltayPB1Zt78
         Cb+BGXlQYTi7mRNDNEtopP+NC3C/XAL1biaHOCLctShMPawvV7EjkFXIasf7biIFCKf5
         UrqpX77l0Nqm3g3eExv5hc0QLIGS8+WeQKzE3Hi98RAj6NPFL4fVzhd0LQ6yOM0npYH2
         048cVP8nZJ/qyB6Uxtx9IJmSCB2YMWIxnh0bFNRYVwL4kGcL6Qr5qtAIxTjmBys7EoKU
         RG5U+e0WLKQy1yHta+ISPBsIUpJCoSz1VZieMmUqGAuNiCAQUkVPnwI2nKk2f2nAjqoG
         +Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZMCGpVbfIB9JkUGTcyRqLG+GmIZ+PK+cLyuXuV9OB8=;
        b=io3Y6vkLaZtDfzPaPjHf9Z2Wsv2C/pEBHAlObiQGe9mvmHwgcvEYEBd35HtQ1aUNtX
         Tqt733c0rFydysxrm8yxxdlzjLF4ELZD4WuSZzrSCzaDNB/itkIKAJ3hnEF1cBrvU+5I
         3Y87HJvGJlacrMtAjoD+39sZf8Pv+YACkqfWAHojx1lwn5g/kYtMEDkuJ7kLGNYNR1eb
         BwOR6TBKwTfqQFD7YWdv1OAsErMrKCaz0bXtilTETpAzM54kAsJ28A9TKSsKVTkPpfX3
         gmvLeZPVQ0LCFmvxgMZeeBEO875/EbDFKKFbztCW27DWgx0jxUedbmsbORpEnFsJB5NX
         unWw==
X-Gm-Message-State: AFqh2kpnlEoHfcKI4FsvlUphjsXMM0/dqqJcP0gie6xpZ52tjjuvkCXl
        YylTrUNh1DzlXusmAoMSCZRiFHUEPZUMK7NZM8M=
X-Google-Smtp-Source: AMrXdXueAAFhYn4hFmslJdJLHwLXMzG5nIHiCiNkTaDd23Y6WH1oMsG4UP8L2bi+I3+9vEeJqYCXJA==
X-Received: by 2002:a17:907:8a24:b0:846:95f9:5b4d with SMTP id sc36-20020a1709078a2400b0084695f95b4dmr94887210ejc.42.1673718227473;
        Sat, 14 Jan 2023 09:43:47 -0800 (PST)
Received: from [10.27.18.107] ([212.102.57.215])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709063d3200b0084d4a60b3d6sm6998419ejf.117.2023.01.14.09.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 09:43:47 -0800 (PST)
Message-ID: <744c8abe-6065-872d-8c9f-a1b1ab682d52@gmail.com>
Date:   Sat, 14 Jan 2023 18:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] env-helper: move this built-in to to "test-tool
 env-helper"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
 <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Here's a drive-by nitpick:

On 12/01/2023 17:03, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/Makefile b/Makefile
> index db447d07383..f2f342683c1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -799,6 +799,7 @@ TEST_BUILTINS_OBJS += test-dump-fsmonitor.o
>   TEST_BUILTINS_OBJS += test-dump-split-index.o
>   TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
>   TEST_BUILTINS_OBJS += test-example-decorate.o
> +TEST_BUILTINS_OBJS += test-env-helper.o

The .o files are sorted alphabetically in TEST_BUILTINS_OBJS, so
test-env-helper.o should be above test-example-decorate.o

Compare it to changes in t/helper/test-tool.[ch]:

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 7eb1a26a305..abe8a785eb6 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -28,6 +28,7 @@ static struct test_cmd cmds[] = {
>   	{ "dump-fsmonitor", cmd__dump_fsmonitor },
>   	{ "dump-split-index", cmd__dump_split_index },
>   	{ "dump-untracked-cache", cmd__dump_untracked_cache },
> +	{ "env-helper", cmd__env_helper },
>   	{ "example-decorate", cmd__example_decorate },
>   	{ "fast-rebase", cmd__fast_rebase },
>   	{ "fsmonitor-client", cmd__fsmonitor_client },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 2e20a16eb82..ea2672436c9 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -22,6 +22,7 @@ int cmd__dump_fsmonitor(int argc, const char **argv);
>   int cmd__dump_split_index(int argc, const char **argv);
>   int cmd__dump_untracked_cache(int argc, const char **argv);
>   int cmd__dump_reftable(int argc, const char **argv);
> +int cmd__env_helper(int argc, const char **argv);
>   int cmd__example_decorate(int argc, const char **argv);
>   int cmd__fast_rebase(int argc, const char **argv);
>   int cmd__fsmonitor_client(int argc, const char **argv);

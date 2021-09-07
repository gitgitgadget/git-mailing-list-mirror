Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E49D60F14
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbhIGPcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhIGPcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 11:32:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 08:31:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z4so15066914wrr.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZWc5ndqMo5SNXGaQRBixDXE6rvg/vRzHUzKYQZv5EE=;
        b=KH1B9NFDlBaoDIt3e7tLnCO6aYCCHIpHSs3jAks+Q2xt1rhMNoortBZRl1Ieswj75d
         lfb70MP4u7F3Wm48N62A6PYTq0erVMc7TtAgjemaAp2kZ0QZ3CE88qzxwDuTCgdZHUde
         e7BkzylDPfVEx+OfFwuSdknfEcV8QuCHI5/B5pAHWch7qj8dU+QXeJm37hKwAnr4EnLw
         HxUGykyl8+2lE/wcKdiErtKcI3CQwwjmfiaBRwRgKS3XlXsZPIKd9Z2H1EHrvV33ckcR
         Oew0mp4OvI2jw7KG1U0I4mwPfGnqGKU5EHLNzg8Avkd/ud1/4HXiceD56qIdIBdgwU/t
         Fb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dZWc5ndqMo5SNXGaQRBixDXE6rvg/vRzHUzKYQZv5EE=;
        b=C6qB6r66RuJntmZazETfGiXfh7ZxfmBJsm+qh6S2cNEFSnI+aAieaLIkO3U/9+wYiN
         kGO41EERToPmGS0+UEtf3sHAEf9MvRcbAOEMG+rXNNQvd2uFpzZXYXE1nURG+O5SJ0oe
         O7gayOzjD0kEV4d8t+Jf3L5E/WHBvnto/rQaCIG0nEW38gKhd7w9k2u+Nhs4FoEE1LpT
         7KyBRPfcfao0ps6Ec+M5oi0Z5ichPI7mNylOpisVhEnrHT6FPLASnlc3/Ak0oc31nypN
         D9qUrSS98EhfIJl1w49AvWMdz+lo19Oi2E8Bzg3uxKGNQXDPQU2uDoNVczDSKHeO0Ctn
         1MvQ==
X-Gm-Message-State: AOAM530XaZfeys4Pc+OM1qLAWzb2sJ5tNwaokA9iMvNNtRg1XNAbXKiG
        KNfPiYqvfG8fWHh7QThAeEU=
X-Google-Smtp-Source: ABdhPJwdNf653mN0WUmqhMGOJVxJPBL7dZ8O8O6Ki6WimNlsHSWv5iZ4czMK5CtJP/7flq9NDk4bOg==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr19283047wru.232.1631028666638;
        Tue, 07 Sep 2021 08:31:06 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.254])
        by smtp.gmail.com with ESMTPSA id j4sm11051145wrt.23.2021.09.07.08.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 08:31:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <d93a750a-9faf-c91a-c9f7-e968c7ed40f5@gmail.com>
 <nycvar.QRO.7.76.6.2109071430320.55@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <86cbe5b9-1a9e-0616-2d66-3130fcb9afb9@gmail.com>
Date:   Tue, 7 Sep 2021 16:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2109071430320.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 07/09/2021 13:32, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 6 Sep 2021, Phillip Wood wrote:
> 
>> Hi dscho
>>
>> On 01/09/2021 12:57, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> This option was deprecated in favor of `--rebase-merges` some time ago,
>>> and now we retire it.
>>
>> This all looks good to me. I did see the comment below in builtin/rebase.c
>> that could be tweaked if you reroll, but it is a very minor issue.
>>
>> /* -i followed by -p is still explicitly interactive, but -p alone is not */
>> static int parse_opt_interactive(const struct option *opt, const char *arg,
>>                                   int unset)
> 
> Right, without `-p` this comment does not make sense anymore. But once I
> replace the `-p` by `-r`, it _does_ make sense: `git rebase -r` is not
> interactive, but `git rebase -ir` _is_.
> 
>> I do wonder if we need these option parsing functions now but that is a
>> question for another day.
> 
> As the function parses the `-i`/`--interactive` option, which is not going
> anywhere, we still need it.

Sure I was just wondering if we could simplify things by using something 
like OPT_BOOL rather than OPT_CALLBACK_F for "--am", "-i" and "-m". I 
haven't looked too closely though

Thanks again for this series
Best Wishes

Phillip

> Thanks,
> Dscho
> 

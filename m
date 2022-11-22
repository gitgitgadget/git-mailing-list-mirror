Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91FC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiKVSkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKVSkL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:40:11 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B567615A
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:40:09 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z6so9863327qtv.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPOezffbzUKVVDsx2DfmAFZ9cisZQs2nFFiVGs5klCI=;
        b=hNDfdt9wgSlI1HYOVwT4zFv+n9dNpx/afaUzvvmZw38Im6DJtAcvnYQOIYs3KeCv8E
         8oSJirBQUGSUN84Cz46Pwg3dNai/FizS43Skhh1XDh0RFyG27ysGXY9mOsXZpiBMesPE
         J91ykFWBXNGVpVxXT/+J06HEh5lkWFcoFeQPPQFaFIebw+AZZaT7ISCpR+XD7P2st6rQ
         MsoKEQqtI6cArKlRE/HJT1JRriASZvA5r0YOSYErCaB8MU/PZYFlNxU0ZJuTqnXLA5aD
         u3ncA9APqYXRGf8d1HQFPTa4w/x+ign9w3tqLos/VrAaG2Y4qQzA/CpT+xNF1vhoLwAc
         MdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPOezffbzUKVVDsx2DfmAFZ9cisZQs2nFFiVGs5klCI=;
        b=xXfVE+oCQ1oTNCjIP2dq/S61GuC37zhlUm0KYPbvi+8Gb/nsM4f1y8dtllEoUi9u31
         wUIQ2NE5itSW9RSw3Yk1hxLQfBg9xM7bhk+BCXyAjTD4PMDTTvBjP0da895j0FMnWcbA
         OLscezsS9Z706W4fHuQFIUkBPNowWgNXHOqk7PmYPd7ktnW18oYaLl9kahs6/vG7r2iQ
         gS0N0dea8PTXejiFLEEzqQPEpbfW74nVcntY+u9knFgJ5bRwcYaR3yPBi1/qF2NAFNds
         16ab2QAEm9RdUKMQniSuQzcPs2T7iltFg7Z84xFpHlb+5EfrkJAq37x6PkiB459R9jFZ
         hOvg==
X-Gm-Message-State: ANoB5pkLxfhaVewJWtWV7t2Tn+/0w/iqHf2R6xf8m6XPUTn5F5Bo5GcC
        58bJSLO7jiFv/yEQZnvhI5o=
X-Google-Smtp-Source: AA0mqf5z1bslLXKPA8tkNUPXp7XB+L+C95pg1y/gMB0kcTAY/mfzJx+ZkM2xva+ByOeNmTgIQ+DSkg==
X-Received: by 2002:a05:622a:1c1b:b0:39c:d5cd:848e with SMTP id bq27-20020a05622a1c1b00b0039cd5cd848emr10436890qtb.294.1669142409011;
        Tue, 22 Nov 2022 10:40:09 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id l14-20020a37f90e000000b006cfc7f9eea0sm10535144qkj.122.2022.11.22.10.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 10:40:08 -0800 (PST)
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <26daec59-2923-39f1-3699-c28c13234241@gmail.com>
Date:   Tue, 22 Nov 2022 13:40:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-11-21 à 14:19, Johannes Schindelin via GitGitGadget a écrit :
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It is relatively common for users to maintain identical `~/.gitconfig`
> files across all of their setups, using the `includeIf` construct
> liberally to adjust the settings to the respective setup as needed.
> 
> In case of Operating System-specific adjustments, 

Here, as well as in the commit title, the rest of the message, and the changes to 
the doc in the patch, I would downcase "operating system". 
It's a common word that I don't think should be capitalized (in contrast to
proper OS names like Windows and Linux).

Cheers,
Philippe.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F6C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 23:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359523AbiELXf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359511AbiELXf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 19:35:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA011834B
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:35:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m1so5947528qkn.10
        for <git@vger.kernel.org>; Thu, 12 May 2022 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c1Gzh1IsbnVP2i9hHiATH+xjhPp006ZwsNp3Hkzf2mg=;
        b=OdEk+RL5OAoVukyTbcofVssyj26PbgvvXJImWstwEt8nqA+iO/WpMBpmqbrC2p02f0
         AeHqt4TQtxhbgcHToXpInIgyVC5mHXnCL9nBjdAbKI5ATgpOVzDM6YVR971diWzMT8jo
         LK3J3EWV49WkzYOZLMRhx5YUilObDQHMm12S7dfp+kle+E7InAw6aaeMYF1AQnMoCmNr
         o1E8vr1PErNd5LD6jWbAOL+XxjyScF3b+mC09+tj4hE9cY2gDBxMZn3pOvrhDdOVcCrN
         OVBo4MxN3DDQ54ON/e/GSPkN7GyAroAAHHX/huzLq5ukgPfW8TGOWu5sJfXFLmkH4QRU
         U0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1Gzh1IsbnVP2i9hHiATH+xjhPp006ZwsNp3Hkzf2mg=;
        b=cr5kc2nGg9jw5jF6SIz35nqdK8AFk+vAr4K6UTh9olfN/rhMX4wT4b62x9rPWgCCcs
         GQm7JM5w0nf/cjtL2xromvT7X8EiuSTz/Sab5gKhT3Nw0MU6qkydXk2vtyTlEXq4vCGv
         MkMP6CoPnZFcBRF5UeDuaGFplmJzjpXX2LhK7CyFuf4LaOgd3gR6j5BzDpFuoxg1zttx
         /wxJH43Q3A4Se4jCb415Xdz7h7u04Qlb9JVHTr7dg1mQVZ+R8Dv8oIHdczSZYxaIsgA4
         DH8wMxGCNFXU8tMYbuT6ei8mRqy0N4a1yZDCmHKA3e3UhP82Gqjx1a3UO2/Yy5r7Q7xZ
         QXEw==
X-Gm-Message-State: AOAM5309mKP7g9LGHnJ8H5oLU5rnhORa7RFtQIoSMiUS1Yx+Kpa6xr0Y
        e2aefElMw/5jCzL5tXZdHwY=
X-Google-Smtp-Source: ABdhPJw5wqhjaTSBCQdBJ3UVd9g4aaiKkPCiUQBdr3e6r7KxXiy95qFfgiuez3fKYu0vt7bPngWHFw==
X-Received: by 2002:a37:670b:0:b0:69f:b5e2:5e2d with SMTP id b11-20020a37670b000000b0069fb5e25e2dmr1878048qkc.326.1652398555241;
        Thu, 12 May 2022 16:35:55 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bq31-20020a05620a469f00b0069fc13ce1fbsm463968qkb.44.2022.05.12.16.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:35:54 -0700 (PDT)
Subject: Re: [PATCH v3] pull: do not let submodule.recurse override
 fetch.recurseSubmodules
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
 <pull.1262.v3.git.git.1652312560207.gitgitgadget@gmail.com>
 <xmqqv8uaebav.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <14349c04-6879-6fd6-30f0-4272a627b93d@gmail.com>
Date:   Thu, 12 May 2022 19:35:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqv8uaebav.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen and Junio,

Le 2022-05-12 à 16:38, Junio C Hamano a écrit :
> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Glen Choo <chooglen@google.com>
> 
> Let's see if there are any more inputs and start merging down to
> 'next'.
> 

Well I just thought that since you just merged pb/submodule-recurse-mode-enum
into 'next', maybe Glen could make use of the new enum in his new code,
though that could also be a separate cleanup for later.

Philippe.

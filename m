Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7829FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB6A2250F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgLOOeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgLOOeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:34:44 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBFC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:34:03 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id b24so2011207otj.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=++ZlY0oxC/3tr9ov3LreW/AP1dCxTgFWGTjlm2gB2As=;
        b=OWf2HhQ/pVizAK6LiJGU5XpH72MJ/XiEaB+nUkEJoyIwTdGgniBboT1+kq3CleifVV
         y2mwChWLfUo8S4v47wJZNKn22QndrCQE9QzhrfFA4D+hN40GVrDzETdwr3GfveTKYHIE
         iQY7r/lYxtzgsOt2B/mdz9cKkAzy5isD9sR8gjmOM2GJOYbydAgBepetHdgmHe6NxrkQ
         kZeTHb0TBp/ytLeR2lUctxGjUYKBvhw7adWtjLjFSyqgoOLVO+WDsktDj+IVD5RtwYfm
         DcCkCLzMQQbOKYxtGL4muWg4FRqRUJkIGRYjC6RDG/Rw/ua9Z/LIu0VsVeZgQu0BEsBs
         RWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++ZlY0oxC/3tr9ov3LreW/AP1dCxTgFWGTjlm2gB2As=;
        b=Sn8m+bduMi8g2PjN8xkCaq2JOotW8gVyXgtUW5DRI6aPNyM3X4hdJIFtzGXLwIXaxF
         VCKMmYASDD/DTf+x2PfTX/qTfK9XnNeKdVfJeEqCBtZhoTCaL2M8z94BGHnlJWkWL4v5
         P8cuZnmBJ81WEshyZeSSQx65efOtoSP8k78O+JbHRxWMYkHKBucH3IoF00dNeVu7o9j9
         /a3gUeHiIq7syM6++dCm2Y1101b6rxFeILirGM4eBjTbNzMhs4y2Ne9btBgujk7+yaXp
         b5FoFN2NfB58NoS/QBHMHPuonPdbzx1gdOQPyqyk0ywxCZeEGjWCNQrG+gFSTe+vJL0u
         H28Q==
X-Gm-Message-State: AOAM532hARUS03oFWI2RGDmach1UzJypeAvEerS3aOUi2ofORfI2qSKq
        ItKlKUOXflcfgyvWAsq5coQ=
X-Google-Smtp-Source: ABdhPJzs67PkUaBnhFRIN0sDL2SwRBhkWvlK/D4MikczaHgEtlXHSScueXGx307H1PSxFC61Y1rc/g==
X-Received: by 2002:a9d:908:: with SMTP id 8mr23537630otp.248.1608042843138;
        Tue, 15 Dec 2020 06:34:03 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r25sm445992otp.23.2020.12.15.06.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:34:02 -0800 (PST)
Subject: Re: [PATCH v2 00/11] merge-ort: add basic rename detection
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6448806f-791b-610a-06de-7be5650334e6@gmail.com>
Date:   Tue, 15 Dec 2020 09:34:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> This series builds on en/merge-ort-2 and adds basic rename detection to
> merge-ort.

I have now finished a full pass through this series. I find it to be
well organized with a satisfying conclusion. My comments are mostly
about nits. I tried to recommend some better organization, but failed
to find a clear way to do so, which shows that the organization here
is sound.

My only complaint is that some of the patches break compilation, so
that should definitely be fixed to assist with bisects in the future
(likely for bisects unrelated to this feature).

Thanks,
-Stolee


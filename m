Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD9C433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EA061359
	for <git@archiver.kernel.org>; Sun,  2 May 2021 11:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhEBLHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhEBLHw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 07:07:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF46C06174A
        for <git@vger.kernel.org>; Sun,  2 May 2021 04:07:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so1716060pjb.4
        for <git@vger.kernel.org>; Sun, 02 May 2021 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=frL1qRGO+OJQNEceGk53AEBAn5iXd8GX/43j7HLLNmg=;
        b=ZXo1J2ok2M5jxK4zehLRn9Y6Puw8P8ic10/VhnhDAsi3f2Km2Zw9kzdRK22MaVxXRg
         su2hSJnqRsVo8c2j6iB52Gc4E+iShxtCCPKvBU8FMWD64BSY3mlm/3h80Lb2vki0hfMi
         evWWKwzULXtBz64k6FxMH5prEd+LpP5SqoE4OThEVf7gErL2at2Im3atZj+giIX+Foq3
         cea/eTeeJ92Loiu+otsFwTSkhSFXZnnbpl66dCu03ecjHF7ezgngT1jB+gwrfc6ULavB
         xlGy5ayxrabObydcpAlYBGCiuAD6hjzTgZ5hkFi0bw5U3yTavkS4Eb7smq/xJ0sW1qQK
         cs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=frL1qRGO+OJQNEceGk53AEBAn5iXd8GX/43j7HLLNmg=;
        b=Ap23LR2GcPimZoM674v7ydcyi3d5WPnmOr+M0zxsPkQpS7UyWy6qiyVenuJsB7g35q
         eEu2vKIC1a4LxsB0QPKeTlhTgRX13hq0KsCnVKSTcIqctpv9Vs86G0JuSLw1Hm/ViC2+
         kbGPfVRzVs6iLj5HcFXpUrTCRAyMTK55gVRIy2ydDoUfXaLlbcFytoH2gLuwHukU4uCv
         h0MDPxd1ViIxyHaf5joyM1WE30kdWunSEMYF2u77GpOAFq7GzB8NjJ/zRvCIvYjY/zUm
         N1/geEKRsRH8wUI+AjZ/OHTfANVeqgugKb6NvWTQ6Y04GSia5FASC9RDkOEkYuv7lodF
         DwMA==
X-Gm-Message-State: AOAM5307a/Ejc/aTHz+N05X3CyXkKcxzdUhAwmmHiQKCmryct+VgDwwU
        yamNmjbD1aH2lJo7GKOOd54c7ANMDWCuYg==
X-Google-Smtp-Source: ABdhPJxKW+cTyVpQ16W0fIf9irz5ORXVvIaTd5irJiz0L6eTOi04Ctc36nLN5htqTCEREBsT+RpXhg==
X-Received: by 2002:a17:902:fe94:b029:ee:ba90:a27a with SMTP id x20-20020a170902fe94b02900eeba90a27amr5915320plm.53.1619953619975;
        Sun, 02 May 2021 04:06:59 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-61.three.co.id. [116.206.28.61])
        by smtp.gmail.com with ESMTPSA id 39sm6368548pjo.25.2021.05.02.04.06.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 04:06:59 -0700 (PDT)
To:     Git Users <git@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: "Unpacking objects" question
Message-ID: <bdd50fcc-02c3-dc24-9d49-773db881b65d@gmail.com>
Date:   Sun, 2 May 2021 18:06:57 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Recently I stumbled upon git unpack-objects documentation, which says:

> Read a packed archive (.pack) from the standard input, expanding the objects contained within and writing them into the repository in "loose" (one object per file) format.

However, I have some questions:

1. When I do git fetch, what is the threshold/limit for "Unpacking objects",
    in other words what is the minimum number of objects for invoking
    "Resolving deltas" instead of "Unpacking objects"?
2. Can the threshold between unpacking objects and resolving deltas be
    configurable?
3. Why in some cases Git do unpacking objects where resolving deltas
    can be done?

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

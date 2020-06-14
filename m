Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6FC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB192078A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 00:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCs1pvFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFNAuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 20:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFNAuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 20:50:40 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A0BC03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:50:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j32so10004368qte.10
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AeEY5n/e/GfeZJ2f6Wg0LpVp+WikoUJVq305yy2OHSg=;
        b=fCs1pvFyFRGG3ft7o8qEGsNH1VdMCQFIBSzHe2W2wK7Jtr27SlMBTuzvyCGl9Dy3XD
         aqzD7K30dLp9aMC2OcvGdEEtsinNM866bVhlOb0kdXbzHQT1TkSOqQIrENhGlboJ5Owo
         wEe+8pNt47LWiVlm8PPPaBtS9HxL2EFK4VqtKJc4vo/U9sYSOTpbYEWLwgvc2662ZDsb
         3fQs+hqzK4iTVvul10H/Xx0RkXaZ17k8MwQ5wQmM/V9JQYV6CW0FLVneQHn5KMyCBiNI
         qI+ug2VL2sXSaCV1Z6fltVk3dI7gahUVMwl7STfkRgN6tHQ4x4G19YBIv15B8ju7th1a
         6KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AeEY5n/e/GfeZJ2f6Wg0LpVp+WikoUJVq305yy2OHSg=;
        b=TqdPMu8t4Wy9pucnLx+kk7etzyorZUFfMLpmF920k5GRYwI7qBhqDlUsjqp7rmYS7V
         tKKmBhiMWpZFk1ke3L8v3RXXzT3+9fKP+IvraTKHrYKfHAlEcNogF1fARtPDkxMQO2FB
         WO1xszH4T5FvmBUlKZpE1Zutlel/9uKoNtQHUoa++QoUAn/oxLDc+dIO47WafueYWF/b
         c1A1PhF1hAiw5gr1qbVQke+ikHVv/zk6C0h0CwBgVr22S3YoYMm+PDfEgue8hDeKP4Dd
         wubeHz68JCPgT6LltuzFYtclZBRbJ0ObsdKTJYxgtb6qhBkyDjTzlgxsHRESin4Xh4jK
         qKmw==
X-Gm-Message-State: AOAM532J29Cyk64tRPtGXS++Ytt/CrPXwpvaVJtfeO4J2ZFclgjUjRCf
        MIveQam6XJ9EpoRGtlgtyvM4OYX2RxM=
X-Google-Smtp-Source: ABdhPJw9KoeyEncxlOwIfTJfG1DhLSPv4BTSq7ibZgUqSMwODBsd+7hLDZ3txwEkkydB2cCml+k+Dw==
X-Received: by 2002:ac8:110:: with SMTP id e16mr9439948qtg.94.1592095837618;
        Sat, 13 Jun 2020 17:50:37 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id l69sm7955159qke.112.2020.06.13.17.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 17:50:37 -0700 (PDT)
To:     gitster@pobox.com
Cc:     don@goodman-wilson.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <0dd6b6c2-4ea4-498d-4481-7f65988db293@gmail.com>
Date:   Sat, 13 Jun 2020 21:50:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2oqxyp3.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Then why create all this disruption by changing the default from master 
to "main" if you will offer a feature to set the default on creation? 
Americans were discussing trump's tiny hands last week and will have 
moved on to any other meaningless subject the next one. You can 
literally never please the perpetually offended. Taking this kind of 
slacktivism and creating problems for other people is a disgusting level 
of entitlement that only americans display. You really care about 
others? Remember there's other countries in the world.


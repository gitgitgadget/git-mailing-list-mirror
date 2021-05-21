Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3845C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88726613D9
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhEUVWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 17:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEUVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 17:22:19 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFEC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:20:54 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so19281453otg.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lbyWGoQmOYrbgYHbLOu6kFYyRu0DLeL/X4SilzN1QGg=;
        b=udTI9GWL6Us1tCkvaSRIVx5P//hAPofO2urXQgLsCGUePAJmLDg65KvNbeL/wdWlXc
         b+yfuRt2tyOanpxIQ92WOon1jEPMuYiKKaiwMoBoH9lQ85+ND3sXrngN668JiE/fRs6M
         i3rnMvwhOn78WbVJmPaV301duJSt6OpmbbRGtoww2peAhRDTYhkbBnngPsJ/wuqBQQT1
         v7i0vNEyzmHjKBxofgh3gtWNLHeoORoOVrceYRSyo1b4NkW5h4s1BvLHpliXb7MoFKzA
         q7dUhcMe+LtVxKmT+wAjPAhZokO8VmcwMOUMooPum/bfO+NghqU6FckJMgAXAhFXEMVl
         NbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lbyWGoQmOYrbgYHbLOu6kFYyRu0DLeL/X4SilzN1QGg=;
        b=Wraf/2IpihrftfbYkolrQTeQJknzLUtiOFy//+i8a8eoafJnQI0gDql4UE6kQ8+r3H
         gP1YVFmehfQKgYXeCIBOHPtUSPrbDD6RYSmFNtjNn4VXRacUIeituT3BOGAcFAbwDFnc
         WTABCf7gttdZndTeu3uLn0EperLlzSKjdEKu6Rjr2pi9cH5rrRCLmWr0rmnowG3y/W2D
         6wWL4TMtLIojNuINZjhDHBeo+j1bR93Jhd6IrtfcooijHv2Pxh3vn0sb+dDtoblIan7y
         b8lltWhrVgqzdT9oWXRNPxWT0nYH9Sr4snctW9YxzbJzK6c1FepCCr0hNwBvQsLR7L1d
         bIJg==
X-Gm-Message-State: AOAM5333vS+tgxPSE5eZj6ihXNHIEQ8aAcyUbJSg5wH68c6ZWSJV5Dse
        i3+Ef3OqO28SZVaFWGUa/z5hwQFdQpKkrw==
X-Google-Smtp-Source: ABdhPJzXdteLOm4EvkT1256q2oT/jDQAD9xd3C0RF0r+OdrNsLZD2DDo5aFh1XpWjUnVO+OH7eKfJg==
X-Received: by 2002:a9d:4816:: with SMTP id c22mr10187729otf.283.1621632053177;
        Fri, 21 May 2021 14:20:53 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id q5sm1087239oia.31.2021.05.21.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:20:52 -0700 (PDT)
Date:   Fri, 21 May 2021 16:20:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
Message-ID: <60a8243323625_77e4f208f8@natae.notmuch>
In-Reply-To: <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net>
 <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic wrote:
> If I may, NO_COLOR approach seems to be rather straightforward to me, 
> as per description on their homepage[1] - make all software supporting 
> it behave as colors are an opt-in feature, thus disabled by default.

May I ask you how you interpret this?

  It is reasonable to configure certain software such as a text editor
  to use color ... sparingly

-- 
Felipe Contreras

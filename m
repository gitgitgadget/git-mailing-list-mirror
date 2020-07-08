Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E44C433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87BD206DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="RH2IfD/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgGHPr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 11:47:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB5C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 08:47:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o1so11771282plk.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=G8xjw1qPMKhhQjscfUyEzoJGLCRB+K6nxxfdteF78UY=;
        b=RH2IfD/TF/oFH/L9DhFQHWuRwUJaBW7t3wMQxHjVr3Kwdas0VR7x6jDdQ17bwJsOur
         AbuRQkmJvdpKMqB01rfyi0U3iudjyjS6EHQR62XqHWfbtHpwspOuXWPaNVNZDZUDPCub
         jDhXcqcuZko++H4JklgT5rlgGnGoTgrWTF/KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=G8xjw1qPMKhhQjscfUyEzoJGLCRB+K6nxxfdteF78UY=;
        b=ZKKJ+q5wDwSTBlDz9IWy/JI4gDHYIgE9AyjXqzMPd9u6JSuE/dn0tAcYfvKXFcRJCP
         acrASCX+pFbJKNcCMc65pP+BX9HXqVKoWxaO+NfzuRzrCRas2fSHN77umf8iM+rUIOB2
         CRLDmazGvdiP0F7DNoMFf+NPqrI6HAb8juZJYUFyQ6123V/j3qpbNN6i0GsaZrui4rY0
         68PEZ4neA+Whsssu1U4BR0fqdROJl0g1gG/zlhKx2+GwidhhuHa0ntaLikSIgu1inoIl
         avE7ssKsCBTwmIJf14+9nRD97Wd5A+YrVM7p9RMuirkI5cebPSPnzj3iCMa5xaihvrcS
         o04g==
X-Gm-Message-State: AOAM531BkSSaj7mwkwwq2Ndi5KpJPLBU6DYCZ1zOA0l+bHLKBE6ZIR+9
        F3IUo2Td9FNgDO1k+n8NBSyBLQ==
X-Google-Smtp-Source: ABdhPJwkxmRgKKxrIwcIy1K9m1nU5JdUBAlsaG4CsaGMkaOKzVknaxKVPF8aW7Zxorh0UDEt4uYl5w==
X-Received: by 2002:a17:90a:d912:: with SMTP id c18mr10089356pjv.184.1594223246343;
        Wed, 08 Jul 2020 08:47:26 -0700 (PDT)
Received: from ZoomDell ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id h194sm215838pfe.201.2020.07.08.08.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:47:25 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     =?utf-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com> <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com> <20200708154218.GB18432@danh.dev>
In-Reply-To: <20200708154218.GB18432@danh.dev>
Subject: RE: [PATCH v12] Support auto-merge for meld to follow the vim-diff behavior
Date:   Wed, 8 Jul 2020 23:47:20 +0800
Message-ID: <009301d6553f$138237d0$3a86a770$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHCWhx1ftaZsotRV+SB1Gp08SI0dwGL+c9rAqrYFFmpBBKxEA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

Thank you for your comment, it's actually my failed that loss the "*" =
after *"[OPTIONS...]".
I'll add back the missing '*' in next uploading.

Regards
Lin


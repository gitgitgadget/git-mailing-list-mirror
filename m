Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE180C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2296188B
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhELHbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhELHat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:30:49 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7477C061761
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:29:38 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso4751414oov.10
        for <git@vger.kernel.org>; Wed, 12 May 2021 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v855eotzs4EntAhpcp/ivcJtTgrmvfUb4BruQu65w8Y=;
        b=DA4fjruV7IszQcfgo0gtQyJvyrf5DN7fhlN/AAygyzIg9v5shSD4wJt5SB0vNhY314
         id2fgXC5aNna6yVunNnuGjdoRendv/3Qm/t1jOTi6Dbb/v3tCkEKxZoSU4RYSArb+bTG
         aRiq1nlZVq1IArWOvNPIbKl8lSZCVh5jDhjJBND50XqHJa/2cS/OTgAMpJ+oTqzH8Vl6
         /Zb0Oo3RNPKaU0DNJpGIrJft/f0lDR2Ruz3ieo966PJFeS+xQ0fA+ZSJ7D3k8jz1mVBJ
         XD3us+9jhENS8094OXpb+hbE2QGxPnDJrki42fYfiBTGhE3214YMnHJRTYrejcv83vbN
         ilLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v855eotzs4EntAhpcp/ivcJtTgrmvfUb4BruQu65w8Y=;
        b=AuKfaPOs7MNZXg7wbIUUkWFYVqZcgD7MtiVT2520cZy53TZ900ZopPNsqKfb11P4GA
         9D8jzbgp1+ezJuQndqOrXtwaYcux5R6y2BKJQBnNipnB2r1qioKJ+8ykZi7pUrkrQ2qO
         1E8eU5wJuU6xX2izhwGtxsKYaU/+ZSo+VmBYN9pgalVLuZk/LePs6TXqFR/6iOnFAomD
         sk/Q0bsXqJMx2WQjfEqgSbItqCf0M1DRlpUWsRX89K0tGc2hbpg5O8nBrs4hDmmPxoq5
         B3IZehVXtSpu9aTlJVKzcVuvo3RtCEpou3CKSdEq5RtAzHdEeoAhym3baFrU8y5Bv9rm
         Nd9g==
X-Gm-Message-State: AOAM531ESh1h5oINSebDO6n8EJ0YOpwRX/ZQFRhj3jE01lr29nh6iPyi
        tu4u0wfoqevI9nL7U23FW8bt+psaW2lsDg==
X-Google-Smtp-Source: ABdhPJzhJ1+2PxHSOr8aNT7/61qU0ODQhEAc3WAFHaLfJv52YbtZvbLqQao/wiNVt2b58NM4T6nJCw==
X-Received: by 2002:a4a:cb95:: with SMTP id y21mr12856047ooq.68.1620804578400;
        Wed, 12 May 2021 00:29:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q1sm4353696otm.26.2021.05.12.00.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:29:38 -0700 (PDT)
Date:   Wed, 12 May 2021 02:29:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>, git@vger.kernel.org
Cc:     christian.couder@gmail.com
Message-ID: <609b83ddd76a5_6e0fc208ec@natae.notmuch>
In-Reply-To: <20210512030156.GB1899@localhost>
References: <20210512030156.GB1899@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> gitster@pobox.com, stefanmoc@gmail.com
> Bcc: 
> Subject: Re: [PATCH v1] Writing down mail list etiquette.
> Reply-To: 
> In-Reply-To: <20210512025746.GA1899@localhost>
> 
> Aaaaand I also forgot to Cc: all of the relevant people in the previous
> thread. It's been a long day :)

Aaand for the record it's Felipe, not Filipe ;)

-- 
Felipe Contreras

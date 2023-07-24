Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C27EEB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 19:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGXTtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXTte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 15:49:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1AF19AD
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 12:49:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso3678137a12.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690228137; x=1690832937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgMO5fzL8YLIx/v2DWvv+tabNIiyorLcuCHTy68iZC0=;
        b=ngKR3HKim/O1vzCZLON86mPZ1xvFE+tCZhKMiVx4W3P5NwEzMGGbRiFLAeBv/aBFLP
         kkyLorrud5YCYt8B791uhqXfYN2lYPdWVGPAIJg8OgN4sGPpGBFvOkglOy8kELNpNXsL
         ol31/GYNjt2RXFV66WRt4klD2tWv1UCq3R8aoxurrw6xWm/0C12KXrZZfqtnZpmSOY91
         ow+Qwtnbtkh3eWPs/pNwFsftm0xOBXwo44DUfH3e//3AbTeQRjCJA0kRgJIg0OL4xtOp
         wB3eC4HCMp8F5G1oDh75XK0OsmsFx1cJ6iUVQvIENkoGZIJr1hP62Ya8dK0i49UYI0Xm
         KP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228137; x=1690832937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgMO5fzL8YLIx/v2DWvv+tabNIiyorLcuCHTy68iZC0=;
        b=Muu1oJFsiHZgWPJdBltEsJspvdAFQwrytTWXbw4SdRZ3+a9vT1tL3TeumEfVUQOrtE
         wc8yccojdc8xcGcKI88TOErSfX0bG227ic5y0lVmwmriIxlvMAIdhyFerB/dAfCPqne2
         iu6A96Ec/GwStr8qNq7LHt3ZD5YIYhEnsHmEpjzisD27jJpyY9MEx9z+wMHAvUKbjAIQ
         RvS8Mv3Tla7/xd+1nVNAP8UTv96J1Yml6XanIUFqTMaD3m5LAkfHzfoeMi3Zye/D2yeU
         L32sIxeoQtwSZCd9hEwu3kirKszTvktW0d+5Bqj6w4UvBkAB8TcvvpclQbe3pEG16CCA
         d+Jw==
X-Gm-Message-State: ABy/qLaZU3iF+hC89GuBFxMHaLRRHyVUsl83XZMPXQ89fIJVry8/s/3n
        WbYwG8+wNpxr1rlD1MZxEM1UPjlR1gw=
X-Google-Smtp-Source: APBJJlGUtsqygUlOR77cjVipKIdzPGHxNOYTT6ASD475Vm7z+0MNntgZ3FOv8oxotnUrvWwngTT52w==
X-Received: by 2002:aa7:da03:0:b0:51e:166a:ac7f with SMTP id r3-20020aa7da03000000b0051e166aac7fmr8971909eds.28.1690228136709;
        Mon, 24 Jul 2023 12:48:56 -0700 (PDT)
Received: from penguin.lxd ([95.145.162.49])
        by smtp.gmail.com with ESMTPSA id be26-20020a0564021a3a00b005215eb17bb7sm6568585edb.88.2023.07.24.12.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 12:48:56 -0700 (PDT)
From:   M Hickford <mirth.hickford@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Credential improvements need review
Date:   Mon, 24 Jul 2023 20:48:54 +0100
Message-ID: <20230724194854.3076-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.41.0.30.g817ef55270
In-Reply-To: <xmqqedl3a909.fsf@gitster.g>
References: <xmqqedl3a909.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * mh/credential-erase-improvements-more (2023-06-24) 2 commits
>  - credential/wincred: erase matching creds only
>  - credential/libsecret: erase matching creds only
> 
>  Needs review.
>  source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>

Hi. Is anyone able to help review these changes?

https://lore.kernel.org/git/pull.1529.git.git.1687596777147.gitgitgadget@gmail.com/
https://lore.kernel.org/git/pull.1527.git.git.1687591293705.gitgitgadget@gmail.com/

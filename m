Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B58C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825D2613C7
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhEFG2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFG2X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:28:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A6C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 23:27:23 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y2so2863862plr.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3EdwotuNd02+B9jED/U1/Y+Mcz98/DXdFmV9lOuXD0=;
        b=slESEh3JsWSp+s5eqdExBd6mgMFs5cyzS8HiVf4/YESpRpOyZ649y/KAm+ybHM7vgg
         fUlAiy2zCGxJsH7eKzhT/eh82zzTrtqYNoCAyeSEkGdQSH+5Itq/vr/OGtjLRome2jPB
         LcvqnFA4Yx5kIc3CSopuDm0M36JOYKIhbB8uFxXGvvJh1SeZRa3TZNLkHVnDXdGatqWk
         y4K0HHZ6i6X4KVFd8ozsjTc/p67iFIFsNzKl4cK2edQix/yFZAmKkasyg81k5rPVZH8S
         fOSIG8djCUtO9luitxmdFyE/8vYjmaxt+CGwEGeAOZx7tVHq0HNiFYI9FRxriKX4j0BX
         b6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3EdwotuNd02+B9jED/U1/Y+Mcz98/DXdFmV9lOuXD0=;
        b=HaltYhWO03l2mkuh6B0BcrdezVHkbiefnuuzZmELK0PX5rSNtxYX9gel8jkWlQ/4rv
         c16vTJ5GIX93l49yvGY4pOdiZMYny1PMJ6nSyN+EhQ9W8oavpkHnIm8EQ/b/iARPAcA5
         wj+/pWFXz77SpnlmsGJIDUpuKId7sCUb6owS7ur1JEbcmzktEgt399oaySc8+ErsBO9t
         PEWyJJ6ld1KZ6mg1eu1tha0PT6AU0J2F5kStHbE0eKJreSBLIJ6bCvGER2Ky87pLLBWn
         0BvAjQgcqGkVh1RMxi95zmQ0LMmV66odhk2F/RgCHoxb2pQ6ajapvSUXS5lBLTUjvNsf
         cVrQ==
X-Gm-Message-State: AOAM533vKswGV1NFx+Who8ZrrOBcJwfBjWJW8KtyMyPI1Yeh8nEzTTEP
        QSZjby/qdLypevzHoKNivyI=
X-Google-Smtp-Source: ABdhPJzyXG6v4dyJbtgEAsTWQGLKvaQmPDZfmM7Q9eGveKAjlz5MvVshXlQBHhMdul3fF/L76FLj6w==
X-Received: by 2002:a17:90b:33c4:: with SMTP id lk4mr16276046pjb.225.1620282443527;
        Wed, 05 May 2021 23:27:23 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id g15sm1038857pfv.127.2021.05.05.23.27.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 23:27:22 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Fix inconsistent signed-off-by abd author name
Date:   Thu,  6 May 2021 14:27:14 +0800
Message-Id: <20210506062714.23191-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <xmqqeegwjazs.fsf@gitster.c.googlers.com>
References: <xmqqeegwjazs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long (1):
  clone: document partial clone section

 Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

-- 
2.31.1

>Puzzlling.
>
>This seems to be identical to v3.  Some "rebase-i / push -f"
>accident, or something?

To Junio:

I confuse working and non-working user.name, fixed now in newest patch.
Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83EBC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DBB61059
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 12:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbhIBM1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIBM1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 08:27:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0110C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 05:26:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so1065799plp.7
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcwLNO+HdIfw5/XTVZW+KJI5zwZmIteL+s3tXzSUDn8=;
        b=pzgAWLDk7bpJjbi07PRfKYlcVXUhN7v01MlV3ldL6PDYVaCKHtV08ZwG0rMcAif82w
         TFyPlQq/+c53+wUgKJjrqFfLvDdtZl1Bh1+lLOPAJIKYs7qZ+g7hXHnAp77lr/MXldde
         GedVMXkWhQa+g93Kb3rDB+KSWRvoiizqJ+8Bu94em9+M/XMOVAQouorNUshJYSi8nbWI
         BPpx67U4CyP5Kls/xdoxRoDm66bfvx5AdMxds9iK4Tl8OHOSUF5w1iaXtrQAcYt3l1kN
         CpleGKmajh4dyF9b4WYrAii4zlyyfulGRWCZiAGI+9887ogeUVc64i1Hec/XLenP2G4h
         NcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcwLNO+HdIfw5/XTVZW+KJI5zwZmIteL+s3tXzSUDn8=;
        b=O3kaI8lvzQTF26yPHmkTCZxBF8SgMpeIHh8giVftEpi9Wp1Nz22Ra677iC/d8tmOrI
         DsdtFlA3v9OQxeib4KWBGg4U5MX6Hgd5mq7VpHA83kIbd+gtAVh/xJclRnUiBaYZ0SHo
         XGVpaSYwkpU9lrtSYNK9tdpxQIC8AZlwjr0lxUIpEpJIgGJI+OqfWiqcJB9PsbprmLgB
         RLwj6FAQS4jhRMHfra34tR2Pr+99Z0+ixNWM6MJpSM1a2Jm8Oj5ajrimjsX2ceI+4DrP
         EBTmxBVlFNcvD/5dxPQ3GLAseg21iNVw9Sdpur6l1Be5rkQAFlMRZc9tcUJpgnV1zEBh
         eoAw==
X-Gm-Message-State: AOAM533OdSW2OHLRLX1eV96famBTBatXQkS/UjDu5VxBx2Q2KxmEhqjF
        nhOTVfm0PzLs24a0D6UHl5Q=
X-Google-Smtp-Source: ABdhPJyDJKFXjWctUvNwc8ZpQuMygyRPXBJN7jRGGPhi9Phvb8W36AQwbwHTIiFYWnABOdwD4G6JbA==
X-Received: by 2002:a17:90a:4681:: with SMTP id z1mr3454146pjf.131.1630585610123;
        Thu, 02 Sep 2021 05:26:50 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id u123sm2285132pfb.123.2021.09.02.05.26.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:26:49 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 03/14] packfile-uri: support for excluding commit objects
Date:   Thu,  2 Sep 2021 20:26:38 +0800
Message-Id: <20210902122638.77513-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <875yvtccd8.fsf@evledraar.gmail.com>
References: <875yvtccd8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> I was under the impression that with uploadpack.blobpackfileuri we
> already supported excluding non-blobs, it was just unfortunately
> named. Perhaps I'm conflating that with the protocol payload for
> packfile-uri, which I know doesn't only support excluding blobs.
>
> What we didn't support at all was a way to have the server-side
> mechanism in git.git recursively exclude anything, which I think is what
> you're adding here...
>

Agree.

You are absolutely right(ಥ_ಥ ). The description of the commit is inaccurate, I will
fix this problem in the next patch.

Thank you.

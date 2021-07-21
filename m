Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E3C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3083F6120E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhGULfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhGULfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:35:14 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F7C061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:15:50 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id o2-20020a0568200402b0290258a7ff4058so502991oou.10
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7iMxBI/0/YfdaouD/Xa60/WKJ1e5J2F+3fHxIk3ovOY=;
        b=ZyQ9ZX921D9/BoYtjx60+JGgXNxJlHNUAIL2oVq5UQP60PJ9kWvtcC63zGqta/sd84
         iJ8fexMZizsq+jBStyDw5VRi/WK+ZLPR/vKV8wAWX2T2Fn6K6YlkIKszKFRPhbaqhdkE
         bAh++XPfvMGSOmSoMAztFO9y+HeXsswdV7iMdxgUrCZoshjrPK0NwBg0poJspu0brPeX
         5qiFlIiWlhEW9mgundRtq1aGrWrPmeccyG7zqqkd+DKt5VIkyJTIXrbkpg8wnc9WmTMS
         jk4tghCjxa5WlD678M3zx9LDusIxUahVRMdOP/lKSUHj2ZUI2sOipE/W7C60xOPK7A9C
         ut9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7iMxBI/0/YfdaouD/Xa60/WKJ1e5J2F+3fHxIk3ovOY=;
        b=bf8ix61bJwYSEli12QkJXs7dtdfZbKe6hl2/fgL4Q3U/6LOTFQPi2LDErF55NKa/L3
         F8XJYv9qcvv6GpO4e3/Vhp0VNG3hzL4ALDG+DW7ZxrDT0BoHo3WXpFtsBxJ+Wwfp7C7f
         6vdzsvF6av9nnUS6/2Po4WuywHRA9wZaKaT6+RK9rLB2olrLWOuutVcKlU9X8lzbqq9d
         u+lCCX7xKvfE8oJqfv+Z4erbQJOe6Jrjm+DMMqXy8widNC1DsnruyhAG82Frc/hmzH0Z
         oVOMtZL+XwdpCAW4CrtofG1MnNGFLjer46wSWamgKXXXlfVqYLbUkNCsZNdV3VFlUdH8
         a89A==
X-Gm-Message-State: AOAM5300v41qekccfsRHGFLME+Rzcm6UPuzmZd0+rZ0sEQV8aPGI1y09
        OaxctIqS0DgiWSjHuomRDL0=
X-Google-Smtp-Source: ABdhPJzHjrWppSdw1aG/cRXJOivSMsmE6p1UdiSNifI9FuZ/PyPspOP7W6wxzpThXMkf997F2yZ4Ag==
X-Received: by 2002:a4a:9b0f:: with SMTP id a15mr24241645ook.4.1626869749939;
        Wed, 21 Jul 2021 05:15:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id k13sm4608126otl.50.2021.07.21.05.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:15:49 -0700 (PDT)
Date:   Wed, 21 Jul 2021 07:15:42 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f80feeb4461_1305dc208b8@natae.notmuch>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 0/8] Handle pull option precedence
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a bit tedious to keep repeating all the ways this approach is
flawed, but here we go again.

Elijah Newren via GitGitGadget wrote:
> Based on a recent list of rules for flag/option precedence for git-pull[1]
> from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
> here's an attempt to implement and document it. Given multiple recent
> surprises from users about some of these behaviors[2][3]

It might have been a surprise for you, but Son Luong Ngoc's usage of the
options is correct.

>  * Patches 1-2: new testcases (see the commit messages for the rules)

These test cases check for backwards incompatible changes, not what the
code is doing (and is supposed to be doing) right now.

>  * Patch 3: Alex's recent patch (abort if --ff-only but can't do so)

This breaks backwards compatibility.

Users will complain.

>  * Patches 4-6: fix the precedence parts Alex didn't cover

Yet another backwards incompatible change.

>  * Patch 7: Alex's other patch, abort if rebase vs. merge not specified

More brekage without a single day of deprecation warning.

>  * Patch 8: Compatibility of git-pull with merge-options.txt (think
>    rebasing)

This doesn't update anything in Documentation/config, which is now
clearly broken.

-- 
Felipe Contreras

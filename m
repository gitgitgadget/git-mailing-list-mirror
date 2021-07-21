Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAAC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9DA6120F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbhGULqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhGULqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:46:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF219C061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:26:43 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t6so2720601oic.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=xSUOoGPpkbE9+WI4D1jFhwnJT3RvxfTc9j4y7pf5F0c=;
        b=OMUch/SMUgj2H40M8yMp3lAGA1LTE/+0nH7rleQs0C5ctW8pUs7CmaDRTZfXlldpfE
         HrjQMPg6OampzIe4BqKyavdQ6i9bKLNdohnIWs/lPQfmtcZ31Q4HYat1SXDVL9+Fm3uW
         tVuIAzJ8ozSSS6abtPVeAnhjbqU/Xq7dyVy/XsF6eVi6btthKI/Hgve+l6D/RJ/qGphf
         74dDSOh4/4hto7gZhn6LucEF2ffLpIlpocRF9ltcMo9lRKYGgx8/bDwOH7kQ3mOSa+l7
         CP08z/6Ahxw1ZBCcs0rUxYmdr75qmD2Rf0EhH7w5Ehz4Rwst7Vk2gGQ5xe7biutL3fml
         smiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=xSUOoGPpkbE9+WI4D1jFhwnJT3RvxfTc9j4y7pf5F0c=;
        b=gJ22dWWRaBLOT2dh9KxJ017IWsPbdbSylZOT+c+dqz7t+vr3TXqZENGMx28kkY20Ai
         ZRdPl1SdsarlDz3LDeLwBgBJyCkgzvMui+OkXhXJ0GpfLss/FlBC87l4xqs0AiVOrtaf
         pnCZYCX50/Bv8/cDnewHaho7kWAOA+Nv3Y0KTiz0rsepxgYSffIvMrHZyJtpiV+S4ivf
         3YzAEPl/nKWY5K6N/AZFnXoK2xUd9UrHNWw6Zt3UV3G57UfHk/20Kl1SQHsWbmoERyUi
         +HAfB3bVQnYZAagSwSmrA9aNJZUBoCvef3WT4vX+4EDt/7fsNp2f8lvZdA79hkcfZ3QN
         3oCg==
X-Gm-Message-State: AOAM532EVlRI2camYPMvw5JNIjK2xEnUT5OMYNamw1EjrUGQ/HHpko+n
        wrLUEJNyCd+TmmHODlRQEqU=
X-Google-Smtp-Source: ABdhPJxI11oX2w9Gb1wsUMzBoRPY7rlb92xMhQkey4JtlMFEwKwUunHGITnccopOvha3PgQYJAu8Xg==
X-Received: by 2002:a05:6808:2105:: with SMTP id r5mr2388497oiw.57.1626870403383;
        Wed, 21 Jul 2021 05:26:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v4sm4487435ooa.2.2021.07.21.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:26:42 -0700 (PDT)
Date:   Wed, 21 Jul 2021 07:26:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f812818d139_1305dc20895@natae.notmuch>
In-Reply-To: <9b116f3d284840052945292f73c47bacdb2f86d6.1626831744.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <9b116f3d284840052945292f73c47bacdb2f86d6.1626831744.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 5/8] pull: make --rebase and --no-rebase override
 pull.ff=only
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Fix the last few precedence tests failing in t7601 by now implementing
> the logic to have --[no-]rebase override a pull.ff=only config setting.

Once again, this breaks existing behavior.

-- 
Felipe Contreras

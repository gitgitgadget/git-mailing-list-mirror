Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C75C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840ED610D1
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbhIXQxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhIXQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:53:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C5C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so29404164wrg.5
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wywphniog9wudTti6pSUrzr74hoHrBQeXp0SyuVX4zM=;
        b=lf/X7cSbwBE49oVqxTMmz8iXXs/DnRggYrsHb57+vymwS6S6cc5IdKnDXjR+lZei8J
         VG974vrK2sAtcnIvz0S6ppwfdsUWdA4q3aa21GeXQQoX0v0t8sH7XXfucCbE+gMepJ77
         sSOjzZnZqy3NQqded3D1SDn0uJJikHlkic4ne3CdriqFEpz+LYPjcnvEYgS30axYRKH9
         x/T2e6GtFeP3tCvF01iHUPDnQw5bzStteHPhxqVET5toxMt+wTMWb0pQMt4WuvBEk5ZS
         16c/pu7Nyrnr2Rv8c67YHng14O4D0UWCniwPe7rpW2q6U7g3Ss+zdKOry83zvoYiLEOU
         93Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wywphniog9wudTti6pSUrzr74hoHrBQeXp0SyuVX4zM=;
        b=vV+K2J+rTEvVQtyV9xj0mTOxFqv57zidYautycv/ijdB8Q8GnBdIkEnaoXndg+U4r5
         K6+NXMvnA6l1TDM+zcd3oSdTJjGKyIpso0S+dB38VFVJUo5yYxiIEkqCpY5mSMYvUptN
         HlM2jlv0/FPsM5NK5zjDGF4l8xoX7ih8gQf2hVn/wnPyu0XSmvnp3oOqKNzI1M2tlcjz
         NsV3n3IIPzxWwhoQKqdCPbzgd2eHOTJ/vboNTs4ImbaiVUHZpfxTXiSL6DiWsbUgH+nW
         sNCQ6pcRayGe+ELK9HFCiFwMeE2VDuD7/r19qbBzug88YgwEtRNl0xO74XkI5do6Vqpn
         UqDw==
X-Gm-Message-State: AOAM5313ztFx6yR/bWt1CZhieDJo98toq46HBh43RvKvvF5uKe16Qxvz
        NztBy231F3RqP5cIz3VfdDH5ZhV7fwxStA==
X-Google-Smtp-Source: ABdhPJxycx+nouLIfnfZKA2GTab+keiZq5DvAmMvvxcBIGjlHCp7n6AN/9EyWdzHQ4m/62Lw/UijYA==
X-Received: by 2002:a05:600c:4991:: with SMTP id h17mr3219511wmp.74.1632502309129;
        Fri, 24 Sep 2021 09:51:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm8929623wrc.66.2021.09.24.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:51:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] show-ref, ls-remote, grep: fix -h handling
Date:   Fri, 24 Sep 2021 18:51:43 +0200
Message-Id: <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1285.g7aff81f6560
In-Reply-To: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the issues reported at
http://lore.kernel.org/git/20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net,
thanks to Ignacy Gawedzki for the report!

Ævar Arnfjörð Bjarmason (3):
  show-ref: remove unused custom handling of -h
  ls-remote: remove documentation for custom -h option
  grep: pass PARSE_OPT_NO_INTERNAL_HELP, fix odd -h handling

 Documentation/git-ls-remote.txt | 1 -
 builtin/grep.c                  | 3 ++-
 builtin/ls-remote.c             | 2 +-
 builtin/show-ref.c              | 2 --
 t/t0012-help.sh                 | 4 +++-
 t/t7810-grep.sh                 | 4 ++++
 6 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.33.0.1285.g7aff81f6560


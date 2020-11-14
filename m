Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2040AC5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A4320644
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxQSBx4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgKNMVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 07:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgKNMVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 07:21:44 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E7C0613D1
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:44 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so13258997wrw.10
        for <git@vger.kernel.org>; Sat, 14 Nov 2020 04:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5hK3+eJmZxy3D8rxsEkt/IdMqLQcZu4tLBQHCfuQks=;
        b=bxQSBx4WMZmbpEjez9+B8GQ4UoiElWssdPqheccEGoYEpFCv1pIWS9mqGdwvq8otXP
         gSw9Q3bQmPPeaMv1Qtd60lskMt8/49CObY35z66zcyO3S/CHraf0VYdtyWn1vOj+RO8N
         AjhJ9VS+JB1NJxVvwEyIULhU8STEb8u6SZyX6wVCvcyAMYjxZRjjC1Uc4FVRx1kKXGCi
         xd513ewzqXUz8omLriWOXAq0QY0T03mxM6g2yJcngpp3+AhhKwVtTr1r8Qw+ilkNyK+u
         yFtuTh9A71vU++KITAOGR66YbSXuM313muhViWZDiGIEiZ/MVP5d0TsrzHqJYtKKoNA/
         WqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5hK3+eJmZxy3D8rxsEkt/IdMqLQcZu4tLBQHCfuQks=;
        b=ZagJPfbZ+L8aNC+oR1klkXsedcRxLgdXawQtgIRvd0oPxLvdMPof3sIP3k+8t9aqQ9
         QJU3P++KOcK7goImMobrQmCd3t1aJsEs5wTFnFmt09oY+upYOrfRUfANgDlxtEGdWpLY
         bC7dvVrQzK74KpvHSzCy4hMtp7XzDEJySAtugEYdrVBMB0J4GmyHPMVZXh2FTTzPq2yB
         Z9qqShXA7CzVyFLOXHQkJl6KriyQVpUfyJi/eZmg/r7GNpF4G0c8qgmdlcr4rHr6YfVx
         hF79vYAr4itOLZFB94cMSlj19r1ESum7htyVemMq9TWSeIiGHG52Y4iW3EJb7rxmmvWG
         /M4g==
X-Gm-Message-State: AOAM5306JTfOSdfqfqyv/92YIowab+zUmAyuMXDhQsquvm3toEe120BX
        wdusWriTtK0y+w01eS5qo5oy4FTgXIug0w==
X-Google-Smtp-Source: ABdhPJy0ydEmbKJ5TinKaTtfguTqwugWKjurofcgAgOL21r1YolDbkf3gClmYlK0aKThqwXjOed71Q==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr9871991wre.229.1605356502628;
        Sat, 14 Nov 2020 04:21:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12845225wml.21.2020.11.14.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 04:21:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] submodule sh->C & retire parse-remote
Date:   Sat, 14 Nov 2020 13:21:29 +0100
Message-Id: <20201114122132.4344-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From my 5 commits to remove it in v1, to Junio's 2 commits in v2, to
just one in this series :)

The removal is now simplified by changing the submodule code to invoke
C helpers instead of this old shellscript code. As a result 3/3 is
just a plain removal without needing to move any code to
git-submodule.sh.

Ævar Arnfjörð Bjarmason (3):
  submodule: use "fetch" logic instead of custom remote discovery
  submodule: remove sh function in favor of helper
  parse-remote: remove this now-unused library

 .gitignore                         |   1 -
 Documentation/git-parse-remote.txt |  23 -------
 Makefile                           |   2 -
 command-list.txt                   |   1 -
 git-parse-remote.sh                | 101 -----------------------------
 git-submodule.sh                   |  19 +++---
 6 files changed, 10 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 delete mode 100644 git-parse-remote.sh

-- 
2.29.2.222.g5d2a92d10f8


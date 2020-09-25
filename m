Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519CC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A062076D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8m4yb4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIYWBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgIYWBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 18:01:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89437C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:01:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so712144wmj.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fp+v9hIYTJHP3R+g5gV21tgi7kohk6KcMEAo7BmnnGQ=;
        b=K8m4yb4inIzEBeL5CFJdJcv0fDPjOduSh+3xw5t59lONwyFutPIO423l/2BZEUUtTP
         tB4D/a0Gap7AVDH7BsttcjYj4yhriKDW/M1fzRu7ehA3JIfrCCX3IwTerUPZnGkh4RIq
         uhaFdvzIl1OX/XGIs5B+bgXmbyKf26BG1QH0x/ATdAihajrp0JFlGtCQrw2ZuqQmMSbQ
         TLcDrgkaqBrmmylgqfOyaGSoVrKkQoqctR29G8KYgbFw4zOTVFaH0AoIWBW/um+MCka1
         +DCC9txxl37HXNrDXtXIrUgM9wquFPXyor5/l5YkQEJbvMqqsZvLFlAQOuM3Ez1HZ9xe
         UR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fp+v9hIYTJHP3R+g5gV21tgi7kohk6KcMEAo7BmnnGQ=;
        b=Ri1Og6dOBfO1swh90vCbvaJ0Bn3JmbUjh3GfiTHrgvgEF/yTwUZDKDrgBTrWD4Uwud
         JkRQpiJceLPzrbB58xtA002PcDBeoA2x+m2dzuEsjsV0VmINxrycTgfOiDzq3Go8Pr3d
         3kKddzOlZ8rg1YlF/yeabsl9pnZGKWuExP1r/nTbIc+/pZjaj98Tfo0mLsMz31z1rZgp
         iMNdMkFxEhyo4SUB1hSZWis8lw2ASW7VgnNJFXEgcLJmo4G7ny3bhD90ao5bCa0nlIqJ
         OIoSaEadHaZ+pKQ/dqrBHPUnIZ63sD414Nm9yc5IqFdwlJ8CetF2ISuycK8HjN22w0Sb
         DuZg==
X-Gm-Message-State: AOAM532eNunitqSG6B9Fup58wE5zSD/uSB5YXyhKVzB8XpTJKtwMryIN
        djGoUtTwnlLI0uodmhxHILp2fJhPmQqJQJEX
X-Google-Smtp-Source: ABdhPJx2CYs+FxHfdrQgVW74ToA09n0szQRdadLQfaA6dDbXa9LVN/Ijauf3turU+UGtLRLI1nBcdA==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr582478wmk.69.1601071259972;
        Fri, 25 Sep 2020 15:00:59 -0700 (PDT)
Received: from localhost.localdomain (91EC7F95.dsl.pool.telekom.hu. [145.236.127.149])
        by smtp.gmail.com with ESMTPSA id w7sm354659wmc.43.2020.09.25.15.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:00:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=81kos=20Uzonyi?= <uzonyi.akos@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81kos=20Uzonyi?= <uzonyi.akos@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] completion: complete refs after 'git restore -s'
Date:   Fri, 25 Sep 2020 23:11:24 +0200
Message-Id: <20200925211124.1673337-2-uzonyi.akos@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
References: <20200925211124.1673337-1-uzonyi.akos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently only the long version (--source=) supports completion.

Add completion support to the short (-s) option too.

Signed-off-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
---
 contrib/completion/git-completion.bash | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d02bd4de7..0a96ad87e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2841,6 +2841,13 @@ _git_reset ()
 
 _git_restore ()
 {
+	case "$prev" in
+	-s)
+		__git_complete_refs
+		return
+		;;
+	esac
+
 	case "$cur" in
 	--conflict=*)
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
-- 
2.28.0


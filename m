Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B9C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D229E23110
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLETyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLETx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:53:58 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114C0C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:18 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q25so2410239oij.10
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6aTBf0SDpHve48rTJ5EpUCFxp9EXKC/Z1a9387wUXY=;
        b=byXvS+/77dGepIA8hKXnG0fUMGhGLpTcO1C7e+B3QTCl7D221zogxXlNzFRD/Oqo2B
         UBLzbgqw1uZR5JmHICi0ObeTJInjx9t3Lsb+d3mBKJrSus6rYDZ+y8hddODb9owzHj5Z
         /WwY0p8yl94i1Ua1wDz9tQVOx2F1UwTkq6txyP1c3YqMRDdGHs10Kq/eL/AjSH+7MtSe
         KTpfHJyYgpH6ddQGNJq+pg/9wn8kGMZwTeS4d5lS+TOUK6GGFXi6/7MVhkaxDmiK5Ap6
         VAkDvo91kRP0uDroY4aGMnafSk1CM52TwvOTUEocZm67EEzSpvjxWF3gYp1sgZCOrXX4
         h1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6aTBf0SDpHve48rTJ5EpUCFxp9EXKC/Z1a9387wUXY=;
        b=tU5JP6XwM13IetLOtCh9gKMkDzmMV0jVS7HH7jHkiONB0EUem/r3D667y91fbelywC
         6TC25Fh99Y2ymK09P3Rpe8ZdKoKMl9g4k5kL7INUOM0kWXGJbAnNoJ5KoZlX4rdFSSwb
         osdwvYTKMj7rv2xaKAQP1L9PY7waUHTbNLhG83XuiCj1pcj1EeMxQxjpowPJ+FfUd3gT
         GEV0f6jPXf6GywDwBYAHBRnFKjphSNqU947rhDHJ4vsr2MpvQDPzo2IM+6uc1V2ITyoE
         vlVbYghJs7JKoY2mLaHAR/YP7/ZBDKnZRM11ArPOxBDjxouYOAkg8JMbSsEMN5SdiBd2
         ujkw==
X-Gm-Message-State: AOAM533IxNHUMEgr82F3bEDAsyuJ3xg1jAr0l1Dki2zqKG1Ctbue5Q6Q
        aGb4Njgirw8ryLb+8+GdgM6lRw5rKisZeg==
X-Google-Smtp-Source: ABdhPJyfT7bpEHGnf5suggmRWyREmZfGSSiELJusztzZdvsxjIi1ZeIzLxg4NbrjFyIdIWH6C1bq2w==
X-Received: by 2002:a54:4704:: with SMTP id k4mr7307115oik.39.1607197997310;
        Sat, 05 Dec 2020 11:53:17 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r13sm1524125otq.42.2020.12.05.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:16 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
Date:   Sat,  5 Dec 2020 13:52:58 -0600
Message-Id: <20201205195313.1557473-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want users to know what is a fast-forward in order to understand the
default warning.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..dc812139f4 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -38,6 +38,20 @@ as set by linkgit:git-branch[1] `--track`.
 Assume the following history exists and the current branch is
 "`master`":
 
+------------
+	  A---B---C master on origin
+	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
 ------------
 	  A---B---C master on origin
 	 /
-- 
2.29.2


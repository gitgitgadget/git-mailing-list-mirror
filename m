Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF22EC636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBBJxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjBBJxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD376BE
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:52:59 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg26so949513wmb.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adgCct04pNckz7JaSPhGY6S1ptijQH5JMhfdAkwEWEQ=;
        b=VpCW1pyTzO3jXitiGg6Sb3CIYmvOOmevrilnICULit0I2QN42IS5WWX33vAxQsOYHx
         VE3Q3mqCi+iUQ21xNm6ZDjPOJRIgw06Rgwb4O3/Zk/R0eNKT2NBGiSCNfvUawXW4KsYW
         EE1U2Ydye9ZvoQWkenk1HB+qh0OxmaVF63rBiYNRsoIIXrPCRAVleedusQ+Ry2jFRub/
         tb4FR9cypzdRanTWLiJf3KvhII4cVAU9SV7vHdiVVy3wnBUUpV5DedDfZlp/fN0sag3L
         XNIAB10q14+qmDKqVcLu0itxtzladDz4NJbZ5J2nZarEtvZ6OWmpBm+mPFf7gsGQGqKA
         sEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adgCct04pNckz7JaSPhGY6S1ptijQH5JMhfdAkwEWEQ=;
        b=Cw58cj2edEbHQEVcWManXfDPSgTP1MVUgLm6ZSz7wz/8qeIBFfInJWQEnux1IH7AaU
         zheB9rC3fnj/39SgM+URcMbnzi3hDQXeodUoBrkR95JtJ/2Tub8wqB+8QjO6TuAlidoD
         rSjM36cNeEU0sUAYkNqZiVj2xTAizcgn31DZcfhRueTAFK7vqVovbPyKv/UbRajvGyM1
         nu0BdI2ETUivd3usoejlkKEIuFNn21mGxz1AsBN25lOcCq2zlyCU58NJCKkCsmmk/4mh
         Qu0fyC5qhZjbhny3BISWQCq2utvEN8MC2NaagjvMeFrr08YNyrgPXQFtQmur87yQYYpy
         AZJA==
X-Gm-Message-State: AO0yUKXxdZzvYonmb1N7GNrxQHn3lJNi2EBFTWpaDggPAwQwUBlHTK01
        IYXm2tXL5+/KLeAq2tyVPm8q27T3xDHXAv1H
X-Google-Smtp-Source: AK7set/0h1L/5luZPOi2QE860zmRWBJHuj6YzXd9+yhu0/p8SP0A7EJUbjKi4HiEtii6szyB0SjVUg==
X-Received: by 2002:a05:600c:4448:b0:3da:107e:a1e6 with SMTP id v8-20020a05600c444800b003da107ea1e6mr5186944wmn.17.1675331577482;
        Thu, 02 Feb 2023 01:52:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:52:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/19] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Thu,  2 Feb 2023 10:52:33 +0100
Message-Id: <patch-v6-02.19-f0f1a388350-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05). If we can't verify
the bundle, we didn't call child_process_clear() to clear the "args".

But rather than adding an additional child_process_clear() call, let's
verify the bundle before we start preparing the process we're going to
spawn. If we fail to verify, we don't need to push anything to the
child_process "args".

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.1.1392.g63e6d408230


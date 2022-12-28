Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33EC4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiL1SBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiL1SAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1762DC
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so15507309wrz.12
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=413D+CELXTZtussK+RVwQ2qyX4Y9wpLeV+m+KMRcll4=;
        b=jRWqGzAK2VjPAr7O0tO585AdjfxSjFY7RNSqbTF2rr6Wl4f/HHDmwLLhdvqZs9qf/M
         F4rLYYYZdp/PPczhzRvODLG/ZG0hzFw81d0C03NoXp+e3kOT75ms96xOPD2igVDMsL7i
         N2UZ2/iPku+CYyG84h5drI+t1tK7MHFw73TlT9jgQInxy57cB5NH43DEKq+v6nzDtvo3
         hpA7n2Y5D7YuvHF7ZUJudsYQ4SFbNRRuehOv3OVmCXKAlGpQ8txhZxVhXecRAgl4WZSy
         mZwmj2NcyneWnZpt6zOgeQKtn1a2E0EXBWnL2MiEdwWTHjR5pNuDAcWSsxf+Dy1aV23H
         ALkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=413D+CELXTZtussK+RVwQ2qyX4Y9wpLeV+m+KMRcll4=;
        b=iJAd701SsuCtwtJAU+udRm/WNkl0Yc/KRpWr2e5QeBB6hkzAkVR/KG6MXba+8re4vb
         TmaXaLTTznfXOR97leySWHv7r/DycYH44viHZFu1RUIxY5hWa2hE0S4EnkzNIHPZzEie
         TPC04TClqSL3+Pw+EmZZKbhmpYJ/ImID81uXJkqQuhO5kjDi3qAFzZE3nRL4GK4ceSNW
         +o1dxAG68NutzgN+cKHtOOvCc7RaAXZC+frrPUI6SWbZ5PHlnOKijHWOtgAGcnR4USBH
         bJCXrk8uFXMOAIJqkibhNfX4f2ogH78KuChY8qYuOYpJQmtf5SFWO6ChiTjDjMlqiUzh
         dckA==
X-Gm-Message-State: AFqh2kpBowTHmoh4dJtNzSyx92m//XlYFzSHTnRi1wZlNAxdCp3ZQJLK
        UKCGGBvQTEt+anaFerh74m8QrqjXq96Nbg==
X-Google-Smtp-Source: AMrXdXtjOgRkftq6XhV9IhaB3AaKHB4b3RlhhHI1J8OwrJ2AXOF8+LtAo+GDZgF9TDLt50wS1OZkfQ==
X-Received: by 2002:adf:e6d1:0:b0:27c:dcf5:ad52 with SMTP id y17-20020adfe6d1000000b0027cdcf5ad52mr8733391wrm.11.1672250442576;
        Wed, 28 Dec 2022 10:00:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/20] connected.c: free(new_pack) in check_connected()
Date:   Wed, 28 Dec 2022 19:00:17 +0100
Message-Id: <patch-17.20-ae2f4931315-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was introduced
in c6807a40dcd (clone: open a shortcut for connectivity check,
2013-05-26). We'd never free() the "new_pack" that we'd potentially
allocate. Since it's initialized to "NULL" it's safe to call free()
here unconditionally.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 connected.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/connected.c b/connected.c
index b90fd61790c..e4d404e10b2 100644
--- a/connected.c
+++ b/connected.c
@@ -38,7 +38,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (!oid) {
 		if (opt->err_fd)
 			close(opt->err_fd);
-		return err;
+		goto cleanup;
 	}
 
 	if (transport && transport->smart_options &&
@@ -85,8 +85,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
-		free(new_pack);
-		return 0;
+		goto cleanup;
 	}
 
 no_promisor_pack_found:
@@ -123,8 +122,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		rev_list.no_stderr = opt->quiet;
 
 	if (start_command(&rev_list)) {
-		free(new_pack);
-		return error(_("Could not run 'git rev-list'"));
+		err = error(_("Could not run 'git rev-list'"));
+		goto cleanup;
 	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
@@ -157,6 +156,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
+	err = finish_command(&rev_list) || err;
+cleanup:
 	free(new_pack);
-	return finish_command(&rev_list) || err;
+	return err;
 }
-- 
2.39.0.1153.gb0033028ca9


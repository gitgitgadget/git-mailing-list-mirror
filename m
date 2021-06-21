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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37DC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4443B61151
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 15:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFUPMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUPMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 11:12:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466B5C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j1so2867060wrn.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GSgGFHKLYpU4t8MujkZ/Rj8IXVKP659BqJ2KgcQ4TE=;
        b=Lh2g+LW4ZjhpdfyghPH/gpW39lKanQs691Ue0w29/K8oPOke4xZA4ZLssGGT2w6ES8
         MX4p7AQFt+rUlpy1ysFsLB0AlIha1QTpsrVXsywI7BkSXH+CGHffSHCLP8Vf71ktcscE
         nKUIW7uupd4WrtzWnh6rqmWJgry7lTLcrAAhkrpKAW/R0HysHq3S8lOnPZ83zTxi+0rl
         VA/Iq3x3VHuPtBWZZdp8AXNJYXLJx4Zpm6gMLrqE+FF4vhxOxl3/YWuJxocvUcdXHccd
         xbCtheQm5stSXZmDCVEmdGdFj96479v0AuKTScC/ay6i9iAVIotgXKyZ1Y/FJK8kJxcz
         mW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GSgGFHKLYpU4t8MujkZ/Rj8IXVKP659BqJ2KgcQ4TE=;
        b=InSCi99jfyIQxIFEIMgQ4JGDgjGDgj7zf2R+dEMOP9iRsD0XJRnAbOe12dHSaxhoPA
         DLbz1Ahaqkb6fH0qBDKh9iFWQEqDhrwu94rNeYDzF7VeVNW3NIvm5PPeodzCAEloV+jw
         LoOGGjWqVyI0ugpDw2uNM1+gR4gWw2Nx1RGfSsj5a2p0pxbONH1KaG54tYsrT3Nc9QGw
         nItB7watBdNHl+ROvxRiwH9ydgCvbZNkSxN0pO+cXtDXHNf+pxTabpu6bt4Rtyl7Q84n
         ZYp7uMx4sNI2C/Tvu6cC7AKmDYJ4WRRuJoS+PQ+BZs6Y0Kod4hDPwq13l8my1rvn+Vz+
         xJSw==
X-Gm-Message-State: AOAM5326mozxmIMN6Er5KeJKFseJV/YuIzUy7Ohg6iyYhQVqZZT+XDP7
        0VgYsx8/pyiF7yNVIUxS2hLWfaMpLjNiWw==
X-Google-Smtp-Source: ABdhPJxtMdqovzExpmbWWtcw5erI7fyMXNxDT82P5NToPPsrAWrSFNMt+gm93RLjyTFm7Y+HymkJfQ==
X-Received: by 2002:adf:e110:: with SMTP id t16mr29329185wrz.359.1624288220657;
        Mon, 21 Jun 2021 08:10:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t17sm16676383wmi.47.2021.06.21.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:10:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] upload-pack: run is_repository_shallow() before setup_revisions()
Date:   Mon, 21 Jun 2021 17:10:13 +0200
Message-Id: <patch-1.4-3840ac28e8d-20210621T150651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com> <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_repository_shallow() added in b790e0f67cd (upload-pack:
send shallow info over stdin to pack-objects, 2014-03-11) to above
setup_revisions().

Running is_repository_shallow() before setup_revisions() doesn't
matter now, but in subsequent commits we'll make the code that
followed setup_revisions() happen inside a callback in that
function. This isolated change documents that re-arranging this part
of the code is OK in isolation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65579e09fe0..a4e2ae059c0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3767,11 +3767,12 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	setup_revisions(ac, av, &revs, &s_r_opt);
+
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-- 
2.32.0.599.g3967b4fa4ac


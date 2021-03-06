Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E5C433E6
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE86501D
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCFLEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFLEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E34C061760
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so5264768wrz.0
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQFnUc6Ut+Vf3CWco0eioCxE6QH1QjZGyWB2P1kj1yY=;
        b=oxHKKNQoIgwMrF0Y5P11qNm0PhgA0ilyaXlZFh6eKw48IFpw/+MJYdJcA6i8ekG3/6
         cIdm5hNGFyyTgvvQ75hVyZ7UwhGiubydrrNFNOJP4GR4FAYnA17sQM12Wm8zFD/xQ4Cq
         Y0O1O4qDCi5HUib1dqjqkhuiGUeyaNxtHcf6ZGzrO9ujOddu59tkuQLnni7gd4zlyTkn
         xV+312pV2ClOoY4sINKhMA0yJS47iWtQo9ND/3eOoBJEEDW5GTS/8Zpn2cQUfJLXEFs+
         8ZprJ1ZHOIQssj4ixq9tjt9jZtUfYldlIfM5t0mmylMbzYeUZ+8CjdAR8+u/tt5qidaK
         sfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQFnUc6Ut+Vf3CWco0eioCxE6QH1QjZGyWB2P1kj1yY=;
        b=FxXtxI4Ny5InbKN7p1JKABiUU64R8TRCT+sCcbtaIetssEZOGmEqdSk6SndhiPb0AB
         zmCpgHiNPOuKrxw1XQAiTl1+9+orKqvZaqTFQiwzOYOClNvJO2a7XOn1gcdn/DKwuJGw
         DAW0weLAl4qu2d4cWXKHnoTA+YS0vwDZWYH7tqJwVzSGdJJt6umnjcrZDkHW8HQLhEwi
         Sat7GrHFX49okNdlBmYuE57uIrHRWuk+94+L4MkNCL8H9ZRPr0OPjPDrcmDiJNbWvh++
         1XHX/XJ4eOAEddXgMXI7OzzyuCBefAK2HF8lQfUSG3zeDB+rcS01VWrEaiQgnZ2D8v2P
         PcUw==
X-Gm-Message-State: AOAM530fs43/AlRJ9hFvPdauQt8GKHRyNCHBMIu5zG1lZVDKTBhjsT/p
        2tF0nLz3edaG3ifqubPoP7dPKiLZ/npESQ==
X-Google-Smtp-Source: ABdhPJzqa5FS2UBpF6XbLXcQFaAQ7owGvS7kp5kmPNclDqpM5tC9Y3i22i0r9C3xt9xK9ROwWjkmmw==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr13765474wri.77.1615028692505;
        Sat, 06 Mar 2021 03:04:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/22] fsck.h: update FSCK_OPTIONS_* for object_name
Date:   Sat,  6 Mar 2021 12:04:18 +0100
Message-Id: <20210306110439.27694-2-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the object_name member to the initialization macro. This was
omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
go, 2016-07-17) when the field was added.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index 733378f1260..2274843ba0c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,8 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.rc0.126.g04f22c5b82


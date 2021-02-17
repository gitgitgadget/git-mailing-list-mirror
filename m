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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8488C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC0F64DF0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhBQTpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbhBQTol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:44:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E9C0617AA
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n13so17743235ejx.12
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr+9aa6ekvvXtMNE6hVOS/3MZe+vZaUjTsGzbgo0Tgc=;
        b=FBHbfPejFeg0AkgW03tpm6YBfCm/z0brndaRSHp1D/wHgzZf4h8FHpj+pGg9HscnwE
         mtJ1UGsBCYnn7455nbLBCL+zOprQ1zuzxc7QEhSumSvow3smjuJLXfp2Srtbgz1oz07Y
         z4P+BJnLU0/RZ2RZnsTOHWaj6449hNkxMirgIEPMsl0YGIqrXF/0QETrphCzvasa8Y6w
         FQjo/QTNtXqkAgJf1nWKd5tZW9A09DkGQydXtDjL2kYMOzm02Q2arfvdy20Aq551iupx
         nD2Ri4elgc2zioblJ+WaQHynqkBPdb/zx6b/Uvi2UDkJzGVHXLtfOVmO+9DCmhD6DdwT
         rVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lr+9aa6ekvvXtMNE6hVOS/3MZe+vZaUjTsGzbgo0Tgc=;
        b=iUN9CG3up5VTNvYfOOR5KBx6GXTwvhb6EDo6lYaE3gm1uXW3jURjjZC7CVDkZDjOE7
         5MgAizAX4p9qdz2Z1gEZTF6JiiLc1OBae+yNI2asOiHKzBBj9wKXEvPxWoVbxrCZAlfQ
         ZjeLqjJnHXDTzVlV1coZarzzJ+tnc//3XI1bqNjh7NOM6O5lpSDwXm8HERh3HgDx0wN1
         zrzatWSznilRdepCQmNzaVHGx8s+StkN/1eAL9PSnve7JSJhLjCcequbQ+IT+avNK5gb
         yBXqcua+eS7yA2Wb5JjiSWSy+QnEAyTl8634VdxgiQFrloCdRqObF2sDsMWV117Ckqbz
         AkSg==
X-Gm-Message-State: AOAM532/qpVrQ1hkCVBvpqcBsJTndQND6VlXUkWccX7eTKrhfjoa3lVT
        JIm14t0SL0kjm1QzZ0nc3lG/x7OBC1qxbQ==
X-Google-Smtp-Source: ABdhPJzH8OpFY3RAi9HvieaIE1OKOoNnXJGynRiIZpPA6NdFzDd1V7+gylvIaZIGECr9ovx87IhBOg==
X-Received: by 2002:a17:906:271b:: with SMTP id z27mr497090ejc.313.1613590993538;
        Wed, 17 Feb 2021 11:43:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm1479706eju.89.2021.02.17.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:43:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/14] fsck.h: update FSCK_OPTIONS_* for object_name
Date:   Wed, 17 Feb 2021 20:42:45 +0100
Message-Id: <20210217194246.25342-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
References: <87blcja2ha.fsf@evledraar.gmail.com>
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
index af145bb4596..28137a77df0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -119,8 +119,8 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
+#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.30.0.284.gd98b1dd5eaa7


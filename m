Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90557C43217
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiKRLrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiKRLrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:47:05 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9B2182A
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f27so12477144eje.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUOskB7cUnbKwbJc7ZWKlpeX+jnnAEIE6O+6lNHuGzk=;
        b=cJifsZZPpF4Xai8s6HnGkZcq/ASvMv99TB7Crs64Tg2Ug89/DftP5DCdPX8Bja0ViP
         ztfeCePRwEu261VeGfSI5KUnORwnl/XvVokuEw/27QwSups7uawCbTltEnES68qO2VI4
         d3IcviYSPlmVFfZ6e9ADyUL8pjUiPDCG66Q89h1wc1dEYgwR+tEP6HchtBB9Oq5Wzvtv
         vYR3HSsDB+oZGGq8wnWNTkG7+0TR9jsPXHFAnkVX5yL+eP8hteuIWecwyuHuVCMTQDE9
         LsM1kBcHmKTgOUMxIQ747mNdqYc0GCe9yUH8Lb8d8XAswNldE0RtEpAOW8dtGmB0scbX
         hcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUOskB7cUnbKwbJc7ZWKlpeX+jnnAEIE6O+6lNHuGzk=;
        b=Evyiu0swEWCfA1sJBC+4BavpbCFqyDGebYEr4Py5qG3zRdfadrKknAaDMxK/VYMJDX
         P3YCyi9iaN5is0/1InL+8Z/qtDe7k+pnOPbkJ2rih+StsexqunX3dDNNKrx025Q7xavm
         41yMKYFdKurEMPI6YOG7NwZNQWC3UKjNoTOSHpylAEPti7RZu8CVliQe+UQYNQhuRvDT
         F35KKUMWPn7tk7bwGrRyBXrsNB3y3PTtCpsNsdw4fDLxhwJ7zpVALI40c6rElGsDJwbS
         7LmfSHbCGJdPx0SjKm4gmlajzPZngG0iaVYK5ehGk2LRcgJ/uZw1vycozi93TYQeQfIr
         /TLQ==
X-Gm-Message-State: ANoB5pkwKsb8uyu4G63uk0CeRs6RCd6aplp80dojaOV+EHtLOaO/LtaE
        9rvtJp7PUYc3mL/YcDrn98H+XpQS5mgEbA==
X-Google-Smtp-Source: AA0mqf7Vft/3FKQH/JyVZaUSZZMYt59vZZuQBJrwTI6Okv4K5+vDMtw3f2oPVO6kx4OBLjBixkgZpg==
X-Received: by 2002:a17:906:eb8e:b0:7b2:a2c3:2ff0 with SMTP id mh14-20020a170906eb8e00b007b2a2c32ff0mr5018511ejb.561.1668772022821;
        Fri, 18 Nov 2022 03:47:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7dd48000000b004615e1bbaf4sm1705349edw.87.2022.11.18.03.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:47:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] object-file.c: free the "t.tag" in check_tag()
Date:   Fri, 18 Nov 2022 12:46:56 +0100
Message-Id: <patch-1.4-2be8477cd78-20221118T113442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1512.g9e0c09a155f
In-Reply-To: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net> <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since c879daa2372 (Make
hash-object more robust against malformed objects, 2011-02-05). With
"HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
tags into a throwaway variable on the stack, but weren't freeing the
"item->tag" we might malloc() when doing so.

Mark the tests that now pass in their entirety as passing under
"SANITIZE=leak", which means we'll test them as part of the
"linux-leaks" CI job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c         | 1 +
 t/t3800-mktag.sh      | 1 +
 t/t5302-pack-index.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/object-file.c b/object-file.c
index 957790098fa..a13edba0753 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2338,6 +2338,7 @@ static void check_tag(const void *buf, size_t size)
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die(_("corrupt tag"));
+	free(t.tag);
 }
 
 static int index_mem(struct index_state *istate,
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e3cf0ffbe59..d3e428ff46e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,6 +4,7 @@
 
 test_description='git mktag: tag object verify test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b0095ab41d3..54b11f81c63 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='pack index with 64-bit offsets and object CRC'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.38.0.1511.gcdcff1f1dc2


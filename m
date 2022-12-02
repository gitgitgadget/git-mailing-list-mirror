Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D084C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiLBAHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiLBAH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9CC510B
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id td2so8030315ejc.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNfAvdQFXXe+9ThL11w33UlC+TtUkH7jNduzG2ZIdDI=;
        b=ia6hPyDb2dKK1SE7oO3R/nvW4akjrU6KBbL2Tey3tQnNhjtcajGIT86eOQe1V93g7R
         j6liOxgTMCLQSdv0OpXOZKqHCT6XeYgqOeBR7FHGViCbK/C6QQIjrW3tAgYsC5QylwWz
         dC/jxEU9euG8JFQ685Hcg9SZwEiJdBeK7dC2KJZVZl1zG2sAoyryz3PT2IpNiCSZJE7A
         noRcG0SlD95VBGB6JoboOrViDjNVS8YC9qpriSlnMGCKIl4DMSWpHXFu+rLISkgnohoE
         HVUN6OsXhUU7K4HbhEVNT6YQBbm+lcnYDxSmndpsQSVYA0I37t3rlqj/6npPfePt9v46
         2sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNfAvdQFXXe+9ThL11w33UlC+TtUkH7jNduzG2ZIdDI=;
        b=UgtedVRZnhS8zwCr8AsbsDUqEFs0gVyO5lfI4anvlOzIHwh/BNDge+o/SYtVEgR9iO
         BqdO6jrWNwAYQD8zaHvYpMrsbu8npSIBnEGX+bt45+GhcUuNwVWdpUfVs0mtc2PblOsy
         T4jhwxsd8cRQTqFAELDh+uUFujAD9m0YyduYXYH6c9i74IQfxGj1clFJ1wHkAudvlSSW
         DLFxdxT/Uzjnii0sC4q+Y9Ku4w+Ap+AG3mtDcx9ijh8OjKBrtLcRrSW9SOeyNfmufOdv
         EKZf67XYiSTupkU4zQJGAtV7VaftDEpLv+vT3ZMaiVYxHinFkUbmgHl7QUnPYGV//8QV
         8LHw==
X-Gm-Message-State: ANoB5pkFMF2BwWcv9COgGFy1yum6vVmuQClt6iQ/LHri25ZYXWnN/mov
        yt+ED5KDkARrOxrO+jb8WfyrW4RIIa3nSw==
X-Google-Smtp-Source: AA0mqf6Kd2KPQ5k+6ogwifEqtejv2XcI85OIO2+LXhyQJV9lT0BhAt8Pd/0IvSj9SlSGF4VPeMeb3g==
X-Received: by 2002:a17:907:8a23:b0:7bd:2864:d33d with SMTP id sc35-20020a1709078a2300b007bd2864d33dmr27808697ejc.330.1669939644163;
        Thu, 01 Dec 2022 16:07:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] merge tests: don't ignore "rev-parse" exit code in helper
Date:   Fri,  2 Dec 2022 01:06:32 +0100
Message-Id: <patch-v2-6.8-5715ff7f0f7-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the verify_mergeheads() helper the check the exit code of "git
rev-parse". The "$rest" variable added in 274a5c06d52 (merge: record
tag objects without peeling in MERGE_HEAD, 2011-11-07) wasn't being
used.

Such a thing is needed to support the .git/MERGE_HEAD format in
general, but in this case we have no such addition to the line. So
let's compare with "test_cmp" instead, we can always add back this
"$rest" parsing if it's needed in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7600-merge.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7c3f6ed9943..f5c4cbae9c8 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -102,12 +102,11 @@ verify_parents () {
 }
 
 verify_mergeheads () {
-	test_write_lines "$@" >mergehead.expected &&
-	while read sha1 rest
+	for rev in "$@"
 	do
-		git rev-parse $sha1
-	done <.git/MERGE_HEAD >mergehead.actual &&
-	test_cmp mergehead.expected mergehead.actual
+		git rev-parse $rev || return 1
+	done >mergehead.expected &&
+	test_cmp mergehead.expected .git/MERGE_HEAD
 }
 
 verify_no_mergehead () {
-- 
2.39.0.rc1.980.g92d3d4579ad


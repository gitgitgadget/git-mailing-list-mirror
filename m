Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ACAC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4090661247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhI1CUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhI1CUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D2C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x20so10536763wrg.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOD6bMoeab8G0bSyc1ooH1a9r327BrXjvT93FoAlkTM=;
        b=gzlzYu9bpVs7BMOXgx/xwd/lbCahm3jGDreOA4GwXKvXimn6TgBrbksna3dYjDR5dL
         q8vPSdgeaO6G2f9tqIA3BXvJD7cKdBvjLWSVlzO6GPX4uIJsE8/Xq//LkPiE1tbISfoL
         q060bq7nUKnx/EwCZMEJrUWdLJul+qkId3tJTGoQyBrfFgMP88rUXT4g6Gsc20RSSI2e
         GnQAkV1DXa1nwgcI6NhdZTFJG0/RwB5BaK5d4zqAMHaWaywQ5TLrGFE/4ie2R+7Sr+1s
         Tp7cxbpQtDi4gdH/RpEOzxH9EfpWd4hfdT7/p5Cu4wPziwujNk9O4yyXXL/EULV90Ir2
         lRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOD6bMoeab8G0bSyc1ooH1a9r327BrXjvT93FoAlkTM=;
        b=VwI8UEEQlEcQOsKhtTOBqXvU1Qlzo09OnPsOJdFSSsB8mxzAlja7MsXTiwERq4LxQx
         TDg11mApUJEG5l3wQspIljsJowVSb9zIyKkxEmV0lpb1yvzYv9vYzuMaY4i0UlHONy6T
         yWZnamZQesfDwRBJcvJgCXbztCAZDHzkbXhY/Sq1Rq3cHiyAXEmCLhWtW8+w3Lk6pqX0
         dmb1mS5NsIDssII6Qa57vEE0NYbB5FsHQXb0C1wNlaUq3/Q/qxEIG3pKiQCgQ02a3cKa
         /AImqvExUcsgqIog0mDuyQHFZnda38MFE+vkdtYNsCOScUAsDbOuKTW043A2ye+iY15h
         gSLg==
X-Gm-Message-State: AOAM5331JkGTVv/sfmjw/0tIWyYautICxBcT1fRW6uqw3TVNApaYgh+X
        iiWI1wZeOULR2IQAx8Fhf5XBhO6Oy2RUGA==
X-Google-Smtp-Source: ABdhPJyn/o1qNnHZ6t9ZMtR/pX2yB0YTIuK510dJzhyVtMlvdATrtodIV8g5kh41gc65Ezl04kCySA==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr3509476wrs.71.1632795543241;
        Mon, 27 Sep 2021 19:19:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 04/17] fsck tests: test for garbage appended to a loose object
Date:   Tue, 28 Sep 2021 04:18:45 +0200
Message-Id: <patch-v8-04.17-277188dd58d-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There wasn't any output tests for this scenario, let's ensure that we
don't regress on it in the changes that come after this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 175ed304637..bd696d21dba 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -93,6 +93,26 @@ test_expect_success 'object with hash and type mismatch' '
 	)
 '
 
+test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
+	git init --bare corrupt-loose-output &&
+	(
+		cd corrupt-loose-output &&
+		oid=$(git hash-object -w --stdin --literally </dev/null) &&
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo extra garbage >>$oidf &&
+
+		cat >expect.error <<-EOF &&
+		error: garbage at end of loose object '\''$oid'\''
+		error: unable to unpack contents of ./$oidf
+		error: $oid: object corrupt or missing: ./$oidf
+		EOF
+		test_must_fail git fsck 2>actual &&
+		grep ^error: actual >error &&
+		test_cmp expect.error error
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1327.g9926af6cb02


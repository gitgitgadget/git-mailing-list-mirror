Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B0DC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF60E619E9
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351563AbhI3NjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351501AbhI3NjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339BC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t16-20020a1c7710000000b003049690d882so8436605wmi.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPx0KT5jVhbA+IQtxng9p/dsLu1Psx4mXe9hAN36+5E=;
        b=CVyJzpeaqVfVn2WFPrj+2AIZHB4Nn5Qy3Hb4jRUqDxjE0cECYUMaf1DMg+mZYP+VXP
         9lP2CSXdGqlZmv4LpvUCRqA83xUNpj+R9XAxoUHhAVZmp+4OFKDk1/9oo80h9dfQdTPa
         LMAkIvmIcXrxrh9UpKFH7sKoZqVOm/WnigRh28+GcRU1UNZ2ouSs1979v5VMZAGsK5UN
         0F6pxPbmGxcHn0D+M8PykIvnebGSbSBPuUDa+jcndoEvBmuvzDd3w0ZYTdK8d9LqjWW2
         yCYJCmASQCQVHuGk3yZMP3MiDUSMgkMKnbiIzOb9cSKeZpsG/jLk8Th5uBqyzinyca8b
         Z/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPx0KT5jVhbA+IQtxng9p/dsLu1Psx4mXe9hAN36+5E=;
        b=roGIEf23ApGeUSN4Znj9cFQbCZ8qJMmXzxvyv+mGkvmCKwQ0LF/rFNdG8CdV/sI67k
         N0H4rUziSQs7oc2GV4daGH02eI2zxYA/PcA+kDyAP6BX8GlchhntXO58V9LJtczXe0h+
         5moWO1Id3pRwYPENdCAuIwdvR1Hd+1tvETA5K3LhfBQyxdTTUlial4WS5Qd4MK1urz2m
         sK9+OZRwqyQMGSY7y8To6fI1A+7VfOiw23Gvl0gB5MvCthCAmtRm7kxI6mDMJ84hDVcQ
         2umUDPszH0P1n9FAlLJVrJEMp9bnqLzoCOQ+OgJx2hw0Zf3wqHu6jJEYhNKUHTGicf+Y
         +zSA==
X-Gm-Message-State: AOAM533zIWUD2M2tt0voxA0Uv8c7f3NgnptTI3kdIjuGA0pUQvds9QTo
        LL9CfBfmR/YmcnOcu8R78SNyWLZQaPu/vqUy
X-Google-Smtp-Source: ABdhPJytCdiDsRf/k3bKTAmVgCJKrPfrnDbnLSWzfat+Khb3dHVpCDg3T/POa6iMXz8VMmF8Pn5DoQ==
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr5274943wmg.100.1633009047085;
        Thu, 30 Sep 2021 06:37:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 01/17] fsck tests: add test for fsck-ing an unknown type
Date:   Thu, 30 Sep 2021 15:37:06 +0200
Message-Id: <patch-v9-01.17-520732612f7-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..969bfbbdd8f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -865,4 +865,21 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	(
+		cd garbage-type &&
+
+		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
+		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
+
+		cat >err.expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck >out 2>err &&
+		test_cmp err.expect err &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.33.0.1374.g05459a61530


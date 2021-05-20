Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCDC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E16E611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhETM1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhETM0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BEC0438DA
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lz27so24632143ejb.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iithknjOnpC5bxEYiDsJLW3r9clveNKxwKwkHYWLDLc=;
        b=nH8UgIT26gnHplkKjVGcTfWkW5Xfdw074VXSel7gB9EhZ0EqtWQHJXt3hkFhSBPzZA
         auZxAeYnujQDiD3Fou1B3izj5tGvCgyZIBVtUBc3YdxXmFbOgoutyhxFBET1TKmWWnYW
         hLZR2H8c7XAAuS6MF13+Xagrs+fF6lpUjSyE2/aKveGDUJHMmJTGL1BCbKup/k1N1TUR
         4qos2C+A1j726048m8tjx+5GmDtt/mL4O9axB/hnoi13YOYVySHs5uEz/ajpLuR2LKk4
         Nxu96B/Yjep+OFyh9u/G1m9ZTTQsfltOt3z3j57ACUKruQ41xRpEeRLW/LjjvOo3XWY8
         ZIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iithknjOnpC5bxEYiDsJLW3r9clveNKxwKwkHYWLDLc=;
        b=N7MuN/z2Lm7n9DOLp/yMvyeTnwu0iuE2DJdOsuKDZpeNBFMqdR2lmWvLefiaArQNyb
         SIV9sat7B4rPoH5YyeA35sFU1B59vAMiJp9ESex53A7RoTMAd4djZgZ0hYOduF8KS94u
         5uwZ4nG4PNPGLP0FyRWYl6iaTxEoNnlx5CmiDjFN+u+wEmj5Nno6BH7UA53VZ6dK7L4U
         QoCZQ+wlZIBEUHwhhtrRARjgdcl9eMMpiKh/bW+ptwf3YT8u6VyI72Nq2dJ6q8A0GAyZ
         6xb7y1OJb8bR4bPh72H7xNQFFwqjhr64zz8thSYcp1UstKOo3C2JGj2TwBYND0nTciSm
         tcWg==
X-Gm-Message-State: AOAM531mAIAKAoYKd+G9A5Ln5nu0upnR7hx4MTZjkfMsTtCJmOpY9og1
        HQJabMX9nJa/2rnz9W885Vwrktd0c5VWfQ==
X-Google-Smtp-Source: ABdhPJyhqaTPVsUHmO5x2kkc9Q2/NEqoLw1suKqrGXQgBGqH1R4JA8KdOw7mRcXD/hy7P5GVLZjcrw==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr4231492ejb.175.1621509797517;
        Thu, 20 May 2021 04:23:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/17] cat-file tests: test for missing object with -t and -s
Date:   Thu, 20 May 2021 13:22:57 +0200
Message-Id: <patch-03.17-7c3c2fe25d-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test for what happens when the -t and -s flags are asked to operate on
a missing object, this extends tests added in 3e370f9faf0 (t1006: add
tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
-s flags are the only ones that can be combined with
--allow-unknown-type, so let's test with and without that flag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74..b71ef94329 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,6 +315,33 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+missing_oid=$(test_oid deadbeef)
+test_expect_success 'error on type of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -t $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -t --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
+test_expect_success 'error on size of missing object' '
+	cat >expect.err <<-\EOF &&
+	fatal: git cat-file: could not get object info
+	EOF
+	test_must_fail git cat-file -s $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err &&
+
+	test_must_fail git cat-file -s --allow-unknown-type $missing_oid >out 2>err &&
+	test_must_be_empty out &&
+	test_cmp expect.err err
+'
+
 bogus_type="bogus"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.32.0.rc0.406.g73369325f8d


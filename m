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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152CAC43461
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED5B6136A
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhDDJT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhDDJT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:19:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838EC06178C
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:19:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so1114739wmk.4
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OQmQcgqY0vDUDXZFlJKifPbGJlMIYt9Njd6euY1zxE=;
        b=smxE93RJ1XiGsGjXnm6HwIvQ3wQpTgPj/cmVfeZJAB0H8pK22K7+yvp8mXjVvkQqR5
         Na8xfaKBDKeCBgxe80byRocMqIaAkGSQisvmDmeG1BuiaSHfGvjvo78oWZDNypLEAnK3
         3DdtTtqI0hZBo0HjTnMJxRnQVxXK6EJ45nJXSrpibKCwkVb+I6gSF8S+tjuy106LXETK
         6pv9eAwZh+fWnRK+nGcsYbKbL9aC9BGTstiURJIt9+zolml5lkpabpBUlu7YffNZnPLV
         35M9OC9rPJ1vElfcr5Bks2BiEvIdfEjl9+XkQf54B+YLcTeDbW/WC3QTazI9XVEp54lw
         nQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OQmQcgqY0vDUDXZFlJKifPbGJlMIYt9Njd6euY1zxE=;
        b=HRilQCWLRNP2ZNfHG2LOAjbC6tL6lrk0tc49h+hzgcuJH7bYywipCvk8kWALaH4meq
         SQwQC+WBRnKD3NfUa/lNymRHUUz6otRDMguTwK2+oKl1GsJRuHjiMMtDyVSQPPrgKMXY
         oZMRxMalLfKNaEfJtw2O4SjdXMXSreOmkUnmDmMDxdGd+53g3ce+ybmCVM52LK7BYbS7
         /eVPh1UQwjG80cHzGS/cJhhUNkR1BabMNjnk5S289r1If+x/q8B8S2oMSOZb8dXbgaw8
         KYHt8lCB0BpWSeatisULabjM8nE76yd9fv4aNhACmh0258jLfCZigbISSCR/p+FISzDw
         nciQ==
X-Gm-Message-State: AOAM531CUfzLJzcADgC8WwQzdoJgIJ8eyeM+OQXHwhfm2ZayjcEDUTI/
        DWl95Li19tvoOtI6enMukP6uGo09z61NJQ==
X-Google-Smtp-Source: ABdhPJzFHNzREJE8U1XnRLaZN3qeeCbDKhJneXfEi8Ismywp/SEEGA5QIpj95VXNidXZkigsicYwLg==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr20128409wmj.38.1617527992769;
        Sun, 04 Apr 2021 02:19:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z25sm22480540wmi.23.2021.04.04.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 02:19:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/4] git-send-email: test full --validate output
Date:   Sun,  4 Apr 2021 11:19:45 +0200
Message-Id: <patch-3.5-15b59c226d4-20210404T091649Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.482.g6691c1be520
In-Reply-To: <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210402T112946Z-avarab@gmail.com> <cover-0.5-00000000000-20210404T091649Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests that grep substrings out of the output to use a full
test_cmp, in preparation for improving the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9001-send-email.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1a1caf8f2ed..74225e3dc7a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -422,8 +422,12 @@ test_expect_success $PREREQ 'reject long lines' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--transfer-encoding=8bit \
 		$patches longline.patch \
-		2>errors &&
-	grep longline.patch errors
+		2>actual &&
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: 35: patch contains a line longer than 998 characters
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success $PREREQ 'no patch was sent' '
@@ -527,9 +531,13 @@ test_expect_success $PREREQ "--validate respects relative core.hooksPath path" '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--validate \
-		longline.patch 2>err &&
+		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	grep "rejected by sendemail-validate" err
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
@@ -540,9 +548,13 @@ test_expect_success $PREREQ "--validate respects absolute core.hooksPath path" '
 		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		--validate \
-		longline.patch 2>err &&
+		longline.patch 2>actual &&
 	test_path_is_file my-hooks.ran &&
-	grep "rejected by sendemail-validate" err
+	cat >expect <<-\EOF &&
+	fatal: longline.patch: rejected by sendemail-validate hook
+	warning: no patches were sent
+	EOF
+	test_cmp expect actual
 '
 
 for enc in 7bit 8bit quoted-printable base64
-- 
2.31.1.482.g6691c1be520


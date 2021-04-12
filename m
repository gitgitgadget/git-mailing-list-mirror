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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE018C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5D860249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhDLLd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbhDLLd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37792C06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so7828308wmq.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbWLlr/dhk6uRy6crKErzHdd95VgyD1LOUiKg7AYft8=;
        b=BqI1s2VlF8b0liumO/sxF6wK+ZrSakLtH/KVdbLM2uV4jc0eEuwFn0Ut21aY1XYgoe
         Dxq6A2F4x0dMb4Hxs+oZHbd1U+gT2fl2SyZTJ3tVvX3noXStVQDerK6ELV3vS8aQpRhJ
         1bh6MDMUHzoTNE6T4oNQ+N7mswviR9g5IzI5WXkM0oropRQwyIgDlKyn0hLBPZyDsJ4A
         zDfRusl7gQsgN/ZVN03JAl5XGY/AtJXv86lmTCiw7jFxM1YddkDAnOvN8JVZc0PpN0S7
         d0+IMB4Ly8ColZxbHW8HzBNmta/kaNTMgF+FGfsRpl52kMKncnHgLgQrwyEHOaROrfLI
         rXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbWLlr/dhk6uRy6crKErzHdd95VgyD1LOUiKg7AYft8=;
        b=arEe5GItBaxfbsG8GahiHxwwM2vID6DUpne2G+FdUEu42dblxMhx6mRw+8ONtck4cQ
         xf6HLdwe6kKUzw0fKlqObhdtqRNgv5rMGpTUZbD5Qj41DAPrUH5mKCTlbgMXB2HJPwNo
         O9FI2nN8R/3W2Y7losuMMHEK37w1QG1O1VvyguWNY2/u5ZHYXxA5poUYM2myUPLpD0yO
         nRjAAECaZ850o1c2Y0rErj0V/8GtnQz9W6i7UX3zn6U8KSiywpHrmWxDnJDl59hF06ng
         tIrKbJXU6+b3FUQShbGvmNsAXR1/FCjgmReGerX12GjCkLJ74xBRO9z5nJGZuER9tQm7
         sx/g==
X-Gm-Message-State: AOAM531GPjYLZYXh2VzT+xt18TdE2rwo9mz+He3yqiK0uvaae3nIEsq2
        yYf7tYDDALI1XncPDYIJNSF1r6YiWQDNdA==
X-Google-Smtp-Source: ABdhPJzyxLzMAms5Isk1hschbdyV07nrxS2mPP1hrm0+J/smUpMjkf3AL7rVpChaRcxCng1mfKznuA==
X-Received: by 2002:a05:600c:4013:: with SMTP id i19mr20405456wmm.144.1618227217721;
        Mon, 12 Apr 2021 04:33:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm17210139wrr.42.2021.04.12.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:33:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] svn tests: refactor away a "set -e" in test body
Date:   Mon, 12 Apr 2021 13:33:26 +0200
Message-Id: <patch-2.2-8dd13c24994-20210412T113247Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 83c9433e67 (git-svn: support for git-svn
propset, 2014-12-07) to avoid using "set -e" in the test body. Let's
move this into a setup test using "test_expect_success" instead.

While I'm at it refactor:

 * Repeated "mkdir" to "mkdir -p"
 * Uses of "touch" to creating the files with ">" instead
 * The "rm -rf" at the end to happen in a "test_when_finished"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9148-git-svn-propset.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index 102639090c1..aebb28995e5 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -7,19 +7,22 @@ test_description='git svn propset tests'
 
 . ./lib-git-svn.sh
 
-foo_subdir2="subdir/subdir2/foo_subdir2"
+test_expect_success 'setup propset via import' '
+	test_when_finished "rm -rf import" &&
 
-set -e
-mkdir import &&
-(set -e ; cd import
-	mkdir subdir
-	mkdir subdir/subdir2
-	touch foo 		# for 'add props top level'
-	touch subdir/foo_subdir # for 'add props relative'
-	touch "$foo_subdir2"	# for 'add props subdir'
-	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
-)
-rm -rf import
+	foo_subdir2="subdir/subdir2/foo_subdir2" &&
+	mkdir -p import/subdir/subdir2 &&
+	(
+		cd import &&
+		# for "add props top level"
+		>foo &&
+		# for "add props relative"
+		>subdir/foo_subdir &&
+		# for "add props subdir"
+		>"$foo_subdir2" &&
+		svn_cmd import -m "import for git svn" . "$svnrepo"
+	)
+'
 
 test_expect_success 'initialize git svn' '
 	git svn init "$svnrepo"
-- 
2.31.1.634.gb41287a30b0


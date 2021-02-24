Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43130C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0107164EDD
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhBXTxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhBXTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A0CC061794
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o16so2907297wmh.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMD3EnHs+oRiCx+TJvrhvnoiXbDXhjgwygZfIRyT3xk=;
        b=XOh1v/O2rTgJQ9l7VjFhKUWS2kJ3UgSBb8j8qXN6bhIoJ/frKxYUSJhhCLr32uCdEE
         SzthB4M3ETKadZRJI+x9qwPy59XPYWTVJfyLPU4fShI0Eb9NOhXk713XBUnYzdAnz4k4
         VS8S9bZD0KJWnpwfvVtEBduY8qXMJWsQphVaQ8N2XTm8JgNAgVjNWxMpBRcF67dGj1ol
         fjDbr2oEmDzWCxoIRSNE0ny4XJvaYI6WA4jDW/YjsXOLXRQn0LASixqAN4Hb0wDqW8po
         GPGvAM3xpUw29604oBmevRhU8cmu50ttsA/SaCVqvpeQcHzWK/J+hhOaFSXmhg2d6J79
         Cquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMD3EnHs+oRiCx+TJvrhvnoiXbDXhjgwygZfIRyT3xk=;
        b=La7dcgFSE/+qaTMEURJ1JYB2r7OZbp1aUnYKlztEliNuKXY+OwMYF+iUTHl6PUf7GC
         ljsQvLza26ZBb0sAk4RJ1cSUDtXpjaEZuUupFYXxdwBCYwsOgso2qD7LIG5JsBiHgBUI
         9egqmDBVVDQHXJTkh7MV+lKt59cHThzpNKN21lFbQZXuzjXAvM6Zxq1t/X4vVFxBDsCl
         ezi4fqP5a88r4J+lneuqrAAcD41CtpTTObI0P2YLk2/CW/+pwu5Uz0OKIt9+nMfnWqbD
         vsW78GP7JUEhbDCZSQHIn5VAF74pNsHHn3A7Nz8jfoFZkNp8a728Xks+ch94XovYvvJ0
         aFzA==
X-Gm-Message-State: AOAM531l1TRGWRCgViX6xK3y9EcgAErHpcxPx7mzmWyavD0aujnAu+uw
        5gbf74AjWjtVdkfVdrB3t7Yq1VLXaNdQHw==
X-Google-Smtp-Source: ABdhPJzxkN+SNOluiDU3qtENvq4HBxLOUqJ2DuY2XCXMWhzB6JuVEZUzEDz6rwN8OTKMoX5tBL4bgQ==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr5207964wmc.95.1614196319327;
        Wed, 24 Feb 2021 11:51:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:51:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/35] userdiff: remove support for "broken" tests
Date:   Wed, 24 Feb 2021 20:51:02 +0100
Message-Id: <20210224195129.4004-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
Fortran xfuncname regex, 2020-08-12). Let's remove the test support
for them, this is in preparation for a more general refactoring of the
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 +-------
 t/t4018/README           | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5bd82e09ab3..9aec9f8e6de 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -86,13 +86,7 @@ test_expect_success 'setup hunk header tests' '
 # check each individual file
 for i in $(git ls-files)
 do
-	if grep broken "$i" >/dev/null 2>&1
-	then
-		result=failure
-	else
-		result=success
-	fi
-	test_expect_$result "hunk header: $i" "
+	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >actual &&
 		grep '@@ .* @@.*RIGHT' actual
 	"
diff --git a/t/t4018/README b/t/t4018/README
index 283e01cca1a..2d25b2b4fc9 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -7,9 +7,6 @@ at least two lines from the line that must appear in the hunk header.
 The text that must appear in the hunk header must contain the word
 "right", but in all upper-case, like in the title above.
 
-To mark a test case that highlights a malfunction, insert the word
-BROKEN in all lower-case somewhere in the file.
-
 This text is a bit twisted and out of order, but it is itself a
 test case for the default hunk header pattern. Know what you are doing
 if you change it.
-- 
2.30.0.284.gd98b1dd5eaa7


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19902C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D203461103
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhDHPE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhDHPEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB997C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r9so3626026ejj.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAPteERdEhAr6OGxgQx6OOB8R3UU43fTi2ZVYcOHEjE=;
        b=oJoFQ7JqiN0qYkBBO88nCtQx7zhyUBjdEM4/IS7QBsMH2yiN1V98fC5dXz0I4h1Jh0
         G2TnMdoqunxEuo04jH6SdRSPI00bZe/sk358jofLHzHXqFonAZ4gaCIH0iIVk3okCsjh
         VkX/5mwbso5NVKrJ8s8GOQ7Y6IaHQs+rQMfKrOU5dt8ylaUGdnklyOYXJqBBQdO+VTBH
         PredaGzimqRTDNu2/DQWzaIWKcvIrnv67yPRHwbDubNbY66gM9PIIZ7btOx2AB/O1/3C
         ABLrJ7NVJ5dxlMuapXSLd0D4JzL7i+RbOY/En+evgx0E+PvpYFyiEvTOl9Ysaj0KaEcO
         Mkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAPteERdEhAr6OGxgQx6OOB8R3UU43fTi2ZVYcOHEjE=;
        b=DihWVod1galcXWyBXbAbScIRAkOy90WB5z5WGm3myfWrgc5WpUSuVkGMH0TA4n9HMR
         EFnslCo0dBYcoNTAPHz8jk/NEeCKUj5qwNmUKIHG3BW0yrbY2xFbMFpEXQtRRX2QZ/m1
         6/h3TJjSbTo6xdRhDaPZTjyWkeXPllOyHk6gAxhuqkLh1tC6lhuFJK7jUChtdMjDrCJy
         cAgtqw5xK7yYn7JRVfGbfDvcJbSNzCeJ+HO2tW7Sv5b3hkjtXU2blyLo+AUDKoxkbEfD
         AjBUSGDYD3hmxuwKFtVtUCheNIB93FvjJ/nsCXySA2KheetkELrTCZDLfCiM21f6NEC/
         94AQ==
X-Gm-Message-State: AOAM531rmtOvke1Bi649rYqtHvaWmL+lXnGQKH8Lrce+TsCt7sWfWAOl
        s1e0AHVj/Eob6bZInJ0cNL6qzG6fupASjQ==
X-Google-Smtp-Source: ABdhPJxY0ej3Rkx84O/nFUhPXN55lIsR9znSMRNCRDWeB88DfR0hk51xdgy7d+pmd0+2P5mMAUVZLA==
X-Received: by 2002:a17:906:7947:: with SMTP id l7mr3315593ejo.380.1617894278380;
        Thu, 08 Apr 2021 08:04:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:37 -0700 (PDT)
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
Subject: [PATCH v5 7/9] userdiff: remove support for "broken" tests
Date:   Thu,  8 Apr 2021 17:04:22 +0200
Message-Id: <patch-07.10-04bce275ab-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
Fortran xfuncname regex, 2020-08-12). Let's remove the test support
for them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 +-------
 t/t4018/README           | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 409372f3a4..740696c8f7 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -94,13 +94,7 @@ test_expect_success 'setup hunk header tests' '
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
index 283e01cca1..2d25b2b4fc 100644
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
2.31.1.527.g9b8f7de2547


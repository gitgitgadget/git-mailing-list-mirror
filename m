Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F3C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiDHJ5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiDHJ5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 05:57:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B21B74C3
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 02:55:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so12065140wra.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJvkaSbF80+HAD4GSJ62j+cLn6RM+znmqzLUo+dSZS4=;
        b=Xz8KPRTCEGnirAjF3eB9i6SF5MgnVqTORiNAxIOMBSj0KuGZkmJWO/cRinciokHoIP
         JdPcJePh/LP5jeLFydUgUqia1j319nw3tgIe+kybp+Wq1pubmxyin3F559Oczt87GFJe
         JAHefaRMXVB1oHaN6W0AZ3uxt00j1SHZMR8nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJvkaSbF80+HAD4GSJ62j+cLn6RM+znmqzLUo+dSZS4=;
        b=nAwPbLdTfRrJmhTosAKUhmXq/1lCsyR1I0pxG7tORXEJ7subkHy8OfWzynYl7my9fF
         pM3iHq7eutThHEorU5757zkf1OGz+6Hv4bZ8CtsLfN7iiIBKgNRKsqBE5p1jD5L79i4R
         1dmNt68YSCLgvyTnII3aU7CzkUcwuIb/i0mD5siff3fMihhq4n+I5Xr3ElNOvulrLvPR
         GnFTeWs0Cd/lYWeo1XBl0fO0jXjy9GuQ0E42n1+FpbpuMZLATRJnJQH7zpTXnGXMquJs
         55UQO2hPz7cp9HOT+3PRIIeVUVqdWOlByO9I6XfD8GOWFbxEpTdPOrwwJblbnH2JfQLf
         SuIg==
X-Gm-Message-State: AOAM530Xa/Dssl312vzWgzXev0JPGYH+eri3Xw2W9DkRX2hyF10n/H/c
        egDp5kZFkWnZ2oow1lLBm4gLGxroc31Zo2Lg
X-Google-Smtp-Source: ABdhPJzHAuY63zgPu/Uw7UwY2/ExGC25Y0figD02i8/Er+TczplBZku/ysUfRFcKXRMzSwxjtuH+Mw==
X-Received: by 2002:a5d:6d8d:0:b0:207:9391:67d with SMTP id l13-20020a5d6d8d000000b002079391067dmr2115187wrs.523.1649411712516;
        Fri, 08 Apr 2022 02:55:12 -0700 (PDT)
Received: from localhost.localdomain (7.9.b.1.3.9.d.9.1.c.1.f.3.e.8.1.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:de15:20ad:18e3:f1c1:9d93:1b97])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm11195745wmq.23.2022.04.08.02.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 02:55:12 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH] t9902: split test to run on appropriate systems
Date:   Fri,  8 Apr 2022 10:53:53 +0100
Message-Id: <20220408095353.11183-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "FUNNYNAMES" test prerequisite passes on Cygwin, as the Cygwin
file system interface has a workaround for the underlying operating
system's lack of support for tabs, newlines or quotes.  However, it does
not add support for backslash, which is treated as a directory
separator, meaning one of the tests added by 48803821b1 ("completion:
handle unusual characters for sparse-checkout", 2022-02-07) will fail on
Cygwin.

To avoid this failure while still getting maximal test coverage, split
that test into two: test handling of paths that include tabs on anything
that has the FUNNYNAMES prerequisite, but skip testing handling of paths
that include backslashes unless both FUNNYNAMES is set and the system is
not Cygwin.

It might be nice to have more granularity than "FUNNYNAMES" and its
sibling "FUNNIERNAMES" provide, so that tests could be run based on
specific individual characters supported by the file system being
tested, but that seems like it would make the prerequisite checks in
this area much more verbose for very little gain.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 t/t9902-completion.sh | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 24117cb901..31526e6b64 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1529,28 +1529,45 @@ test_expect_success 'cone mode sparse-checkout completes directory names with sp
 	)
 '
 
-# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes or tabs in paths
-test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with backslashes and tabs' '
+# use FUNNYNAMES to avoid running on Windows, which doesn't permit tabs in paths
+test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with tabs' '
 	# reset sparse-checkout
 	git -C sparse-checkout sparse-checkout disable &&
 	(
 		cd sparse-checkout &&
-		mkdir "directory\with\backslashes" &&
 		mkdir "$(printf "directory\twith\ttabs")" &&
-		>"directory\with\backslashes/randomfile" &&
 		>"$(printf "directory\twith\ttabs")/randomfile" &&
 		git add . &&
-		git commit -m "Add directory with backslashes and directory with tabs" &&
-		git sparse-checkout set --cone "directory\with\backslashes" \
+		git commit -m "Add directory with tabs" &&
+		git sparse-checkout set --cone \
 			"$(printf "directory\twith\ttabs")" &&
 		test_completion "git sparse-checkout add dir" <<-\EOF &&
-		directory\with\backslashes/
 		directory	with	tabs/
 		EOF
-		rm -rf "directory\with\backslashes" &&
 		rm -rf "$(printf "directory\twith\ttabs")" &&
 		git add . &&
-		git commit -m "Remove directory with backslashes and directory with tabs"
+		git commit -m "Remove directory with tabs"
+	)
+'
+
+# use FUNNYNAMES to avoid running on Windows, and !CYGWIN for Cygwin, as neither permit backslashes in paths
+test_expect_success FUNNYNAMES,!CYGWIN 'cone mode sparse-checkout completes directory names with backslashes' '
+	# reset sparse-checkout
+	git -C sparse-checkout sparse-checkout disable &&
+	(
+		cd sparse-checkout &&
+		mkdir "directory\with\backslashes" &&
+		>"directory\with\backslashes/randomfile" &&
+		git add . &&
+		git commit -m "Add directory with backslashes" &&
+		git sparse-checkout set --cone \
+			"directory\with\backslashes" &&
+		test_completion "git sparse-checkout add dir" <<-\EOF &&
+		directory\with\backslashes/
+		EOF
+		rm -rf "directory\with\backslashes" &&
+		git add . &&
+		git commit -m "Remove directory with backslashes"
 	)
 '
 
-- 
2.35.1


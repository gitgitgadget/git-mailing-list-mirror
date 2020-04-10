Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC41C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125642078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7PwSXyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDJLDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:03:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39987 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgDJLDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:03:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id w26so2007034edu.7
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ypSA69Lx8M4HSDO0ZAllG+LhSI4npIFBspTfBBKbb7c=;
        b=m7PwSXygr7jyBA9SLXCq6bvSNCCJ9X735EdKxR9faO4e5r065Dps5tsKb01BGm51x8
         ekvNiInp+nclw5yFJLU05Gtdk/eNtQmWiHzJqVfZOe0sW7Ay+Zwlbjz+vBLzQ6Mi7CAv
         PjEfwDAaRA2HM0H9VEH4whFL12dH+K40EeMjnvsYG6caDhUkHOWf+xNxyOngbw/j0e/f
         wHdoOm9ZcC04OGQEQGZZLFDhOTNf2XvtVVnNyTviqzfN2PgFcoY5SQ4X5QbxfxRfeRMB
         V/oDq38RUrjuaMpfWjyYJSsz+gOoQ21YSNUlzlfAw83LernO3tgkgQaHLKFp6QWrR9+/
         rayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ypSA69Lx8M4HSDO0ZAllG+LhSI4npIFBspTfBBKbb7c=;
        b=ojMbOGhZQ58KYAoZCBAN/1djR+RMfdzb9H70cZ2bKLBmp5BOR8LsKahs/V+KU7ZqeI
         i++AFqWBcKLP0TCb6SqL2nTJqSx9rDp5NfAmjZITPGCmcn7XLfnYpjWWPdN2piXqsYO/
         QELMCLV6XeJkwzAIv23KLIsTq4q5w3sEQmjQhh6F4qjXKF0NzxCC4Qb2/LKwwvJZ5Lno
         lEuLH/WJglen/EiOv2l9NoFlcDD1qIkskVs6+WKbbbPtsFrqQsrkuSmzncUiPmnsjpDW
         L4DPk6aTpJmvVuPTxDbLoOUdii9MKkWiQKvgTGTQlbobVsLSqzkhkB2XOBTjAaRuCiQf
         Yp3g==
X-Gm-Message-State: AGi0PuYL/52alukeEv0G9KKdpit7719odNAXAxkkbO/O3BgNjg+C6DaJ
        h152iT2MGpw/OXdLs9F6y0TSJRcC
X-Google-Smtp-Source: APiQypKN2eGuFfakVkLiUNLDvaHYZNMK9zMJoqgSXUo4cDeaPczc755VdWIDTupGmSlaO3PVKkngig==
X-Received: by 2002:a17:906:2418:: with SMTP id z24mr3327874eja.42.1586516586010;
        Fri, 10 Apr 2020 04:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm84059edy.57.2020.04.10.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:03:05 -0700 (PDT)
Message-Id: <dd81ea68d6b74c3031565a472d622d8db1f896bd.1586516583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
        <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:03:01 +0000
Subject: [PATCH v2 1/3] t: consolidate the `is_hidden` functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `is_hidden` function can be used (only on Windows) to determine
whether a directory or file have their `hidden` flag set.

This function is duplicated between two test scripts. It is better to
move it into `test-lib-functions.sh` so that it is reused.

To make it safer to use, we specifically test for the `MINGW` prereq
now, so that it is not used on a non-Windows platform by mistake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh         |  9 +--------
 t/t5611-clone-config.sh | 13 +++----------
 t/test-lib-functions.sh | 10 ++++++++++
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 26f82063267..1edd5aeb8f0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -392,13 +392,6 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
-# Tests for the hidden file attribute on windows
-is_hidden () {
-	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
-	return 1
-}
-
 test_expect_success MINGW '.git hidden' '
 	rm -rf newdir &&
 	(
@@ -406,7 +399,7 @@ test_expect_success MINGW '.git hidden' '
 		mkdir newdir &&
 		cd newdir &&
 		git init &&
-		is_hidden .git
+		test_path_is_hidden .git
 	) &&
 	check_config newdir/.git false unset
 '
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 60c1ba951b7..8e0fd398236 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -92,24 +92,17 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
-# Tests for the hidden file attribute on windows
-is_hidden () {
-	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
-	return 1
-}
-
 test_expect_success MINGW 'clone -c core.hideDotFiles' '
 	test_commit attributes .gitattributes "" &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=false . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=dotGitOnly . child &&
-	! is_hidden child/.gitattributes &&
+	! test_path_is_hidden child/.gitattributes &&
 	rm -rf child &&
 	git clone -c core.hideDotFiles=true . child &&
-	is_hidden child/.gitattributes
+	test_path_is_hidden child/.gitattributes
 '
 
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52e..09a2479fd38 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1543,3 +1543,13 @@ test_bitmap_traversal () {
 	test_cmp "$1.normalized" "$2.normalized" &&
 	rm -f "$1.normalized" "$2.normalized"
 }
+
+# Tests for the hidden file attribute on windows
+test_path_is_hidden () {
+	test_have_prereq MINGW ||
+	BUG "test_path_is_hidden can only be used on Windows"
+
+	# Use the output of `attrib`, ignore the absolute path
+	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
-- 
gitgitgadget


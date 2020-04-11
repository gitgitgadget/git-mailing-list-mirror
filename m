Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A17C2BBC7
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F722083E
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 13:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA1mtFS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDKNk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:40:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32796 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgDKNk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 09:40:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so5829563ede.0
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vGTl8Uu6le92T0yvmU2UDxdiwPPQugzUOJYsGMihQJo=;
        b=NA1mtFS2x5wzeQC6zzYlRQf/NIlbEaVXW2zRrasPMo1CWVhzDZBQQmO5QRH7XYKi1o
         j34oRRvjb2nALHFXbvsDPyYLymZRrh8WgUb5UW7w3c3yxSh6yjmQN4xm4Gnp/M04wphu
         LjsnRY73JClFCmTMKARU2u73FJzW1QC37uBPQ5zQhhJVFl3cGI5F+gpJS2edCxQGiv8u
         r1vtglqO+FORUwsAawKtismWQ7LRhX2p+tRgSPQ9luhMCb55NLDgema5euFLw2/AZzhk
         xlIpY6oaLpvkQ8Q3pBEZqpO97cIuF9QU4nL0OitUCC70vY+NJp93uTgTwTfQY4KTZKd2
         lJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vGTl8Uu6le92T0yvmU2UDxdiwPPQugzUOJYsGMihQJo=;
        b=oTsyqTQUMYIOCBUdNlCCdefLkhmwe7Lhl2DHWdn+JWlzuIgxLIz+V7C0j9ouUZC2Yc
         eXGqSnblV3JJm/U0W5gO+ZI/gQpWf4scgwV5804eOOxYTE1AgvziVkfTlWmJX1nIB+IE
         Px3iy7Qe83jmgyjVOL6wle2dTkuRmTCAUdRske2ymfr8HACBckgoE8Gi/JFFq5u8WfJN
         rVdmnkaQRrR6m+eVaUVVx+TpE59W4Xy0K7sRbaXx3kgFygH8Mgg5FS4b5IUf/G0uD6BA
         zxkBBm6cSeOiESILGpSnJmpsBL6lQ6u8YWxRrB14gaH1zIBFEJsKJg/U/4PUkI8QE3Rh
         xwPw==
X-Gm-Message-State: AGi0PuZoIzgnFIq5E/DYQO3O6A9NImTdN5m0SyGdiwxw0pN70azquJJQ
        DuZzmmahleIMyRv1t71iDm886sVn
X-Google-Smtp-Source: APiQypLqVVgJCW0JIWwgUJMTAp3vjv/Ab1WvbMpRPXcl1uqr7agrVkmgllqjwSPfbsqqPQwcw6YS9Q==
X-Received: by 2002:a17:906:43c6:: with SMTP id j6mr7813732ejn.39.1586612425660;
        Sat, 11 Apr 2020 06:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm541317edw.42.2020.04.11.06.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 06:40:25 -0700 (PDT)
Message-Id: <f13f9f78cda9d883be7c59417b1da662e02045d6.1586612423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
References: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
        <pull.603.v3.git.1586612422.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 11 Apr 2020 13:40:20 +0000
Subject: [PATCH v3 1/3] t: consolidate the `is_hidden` functions
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

This patch is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh         | 7 -------
 t/t5611-clone-config.sh | 7 -------
 t/test-lib-functions.sh | 7 +++++++
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 26f82063267..9cc919d8d1a 100755
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
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 60c1ba951b7..c861e12ea44 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -92,13 +92,6 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
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
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52e..7a7e7a38312 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1543,3 +1543,10 @@ test_bitmap_traversal () {
 	test_cmp "$1.normalized" "$2.normalized" &&
 	rm -f "$1.normalized" "$2.normalized"
 }
+
+# Tests for the hidden file attribute on windows
+is_hidden () {
+	# Use the output of `attrib`, ignore the absolute path
+	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
-- 
gitgitgadget


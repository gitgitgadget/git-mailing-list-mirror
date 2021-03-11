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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051E7C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE10464FE0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 12:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhCKMmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhCKMmV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 07:42:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA3C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:42:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h98so1682340wrh.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6CsoGWXi6nOCBmpTt70mWSXw/brnHS/AU6RkcNYTtY=;
        b=LLoOwl7c9uaXjbl2r/NxGk0vJpo3YRZDceaBeq9QnDnIW/J0pdtLnUrhPAp7B4JmOB
         WvcmnLkCNK85aZ5qRv+qwh4ijEpK+P/3U2HdleZCm2d/6W+Rnsn/rygZQGYfV69ZTd5f
         3n50co3phiBcuxU0izdG0hIXljjqVhk+QGEFfQ8XoLFEgGZcp6kFrqN9Naeum/tRTu1s
         2S285fyPZHvkNfwHaMmJOm0KSR1xg0K9EqSWjWFH78z/Q3SOwtbUVZLHVVcB380wHWoN
         wNWvJVeWa3TRTGvwaBjspeTnvevxSWr+lWm8K5aujOX+t24+DrfuZQAuwvcCEkIK2xdp
         rWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6CsoGWXi6nOCBmpTt70mWSXw/brnHS/AU6RkcNYTtY=;
        b=p/pvLFAmi9X7YQaRjf+en+0uE8qTli0Wlyfo/in3BVTs+MY9/r2aAZfjQrP6LXiwcn
         MbihGiY4MhFIdzMYTKKjiej/LjVBwcCoz+S0+8fzZMd3Bu8UcnZPfsrxPbDKULtyQup5
         NPmcjyfrOlZZB0+3HDDbqMgaYzrufbVY/Rm2OLDi9X3j8px8QZr5ZHPvVZ13f845rHEh
         SN/QBJfJ6XdJ1RG3Sp9DfiQ0+4lZqRYoidbKDlHIvXqvk5rhD10wNDVfFIZmSJcxyJ5E
         RDLqP7P6oq4kgeT6ldg4lkdx1RfZyMeOOrYWz6eBIaUBhickadCzO357O+5h7Yc4IAHR
         qvZQ==
X-Gm-Message-State: AOAM531fAVt8a9KTjXs5Qwl5KqQqqnUnGFdYcymH0O13xJymrl5AXDFK
        vYCgkMlq/HXTjszmn5TWO0waQPAlxIOz9g==
X-Google-Smtp-Source: ABdhPJxezusSpXBiPa6sASsDFCWqIwbgWWoxDNRJ3Hy+LUskpdG9uijJB1z2kPTkZLzhLnkalh+kxA==
X-Received: by 2002:a5d:558b:: with SMTP id i11mr8377358wrv.176.1615466539738;
        Thu, 11 Mar 2021 04:42:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm4263909wrm.0.2021.03.11.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:42:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test-lib: guard against being run as 'prove t*.sh'
Date:   Thu, 11 Mar 2021 13:42:16 +0100
Message-Id: <20210311124216.25036-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have t/Makefile targets to properly run the tests with prove,
however it's also just as valid to run them as e.g.:

    prove t[0-9]*.sh

But if they're run as:

    prove t*.sh

The prove tool will optimistically try to parse and execute
test-lib.sh and test-lib-functions.sh as Perl code, currently there
are no bad results of doing this other than a wall of error messages,
but let's be helpful and bail out early in this case.

Note that the shebang being added here doesn't mean anything to a
POSIX OS because the files aren't executable, it's picked up by Perl's
TAP tools. If the shebang wasn't here this would still be considered a
Perl file for the purposes of those heuristics.

I could also use the "Bail out!" keyword here, see
614fe01521 (test-lib: bail out when "-v" used under "prove",
2016-10-22) for prior art. I think it's more gentle to just print a
SKIP notice.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 9 +++++++++
 t/test-lib.sh           | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..7ba04fe399 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+#
 # Library of functions shared by all tests scripts, included by
 # test-lib.sh.
 #
@@ -16,6 +18,13 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+# Early bailing out on 'prove t*.sh'
+if test -n "$HARNESS_ACTIVE" -a "$0" = "test-lib-functions.sh"
+then
+	echo "1..0 # SKIP accidentally invoked 'prove t*.sh'?"
+	exit 0
+fi
+
 # The semantics of the editor variables are that of invoking
 # sh -c "$EDITOR \"$@\"" files ...
 #
diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a65..7ceae9a38d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+#
 # Test framework for git.  See t/README for usage.
 #
 # Copyright (c) 2005 Junio C Hamano
@@ -15,6 +17,13 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+# Early bailing out on 'prove t*.sh'
+if test -n "$HARNESS_ACTIVE" -a "$0" = "test-lib.sh"
+then
+	echo "1..0 # SKIP accidentally invoked 'prove t*.sh'?"
+	exit 0
+fi
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
-- 
2.31.0.rc2.211.g1d0b8788b3


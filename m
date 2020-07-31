Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147FEC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FF7208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFN8dwTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgGaP15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgGaP1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4AC06179F
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so28345478wrh.10
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gofoi52lXMs7Gb7AiJ79+NVm+CWnwQfcAdKgR9UxH9k=;
        b=uFN8dwTr13KOpIMjAVAwESY49Oh/Rl+yC2LHzSBzo6ndOi5i8q4b7EzZ2AaPPy6KCI
         vVMC0BG3qN1CmgP7rDXn3PsHydgBVwkhZN4SMwHX+jlAQJzAAOJhOzvnF/yJWB3t5Avg
         ZwcfQwaiehmEFU8ifCg0sz3vkC87NmAzaa84y33DTgQjjmM1QZDION7RrByOwBemqxNr
         /qhDah3MVfg+Ey14NIvgy2gYZS6gMOqaRGCOjTpeivgMZqz0xEIQi3RT5z5vsXc2rVx7
         FeyfEbTIiXtV4ZYbkikwJh8Pd1Zw72dAznme9Fpm4SgKPmpldLQuWKIeL84aTSvsRva+
         M1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gofoi52lXMs7Gb7AiJ79+NVm+CWnwQfcAdKgR9UxH9k=;
        b=sqGzeEayEgiSuoQ+4cxTp9aSkWep/1KucsS4sCEqdyVPeGsbig6955tbuSI6Dye7/z
         cbYK+EkcRX0Zo/TZKdrsODAMbNycMnokIspYOVroxSDh79d2kh6dtnz6wQ5QFTOGOsRU
         xer12g8cu9EqjVhEt6ewap+INDHG165MSGvJLtE2G9JC8KosKmQTTcbG1hTIs8GXN5vu
         uWRGA+9Juv5x8I79zxwx1WXt/rVyx4iyB9X+SnOCj0HI4M0LT9puY9xV7OJhVM23rgfL
         NmluUg0KVpc6m3mLBVj8WQ83eNb1ynSG79pKqXvmxPA04KwiUYaJAstFYhLqGst6IEEP
         i/YA==
X-Gm-Message-State: AOAM533G/UvoJVlit1V5eH5ZA7dIPvK6ztunzV5pEACWIaAYw5gNZabv
        MJbZnpz8X4t2cPgzrSWrpJO6AZjd
X-Google-Smtp-Source: ABdhPJwWcOKoH6wkzMyzEI/Nb5vJ6VhX566pSXdbofJ0frupsPbhh0D6L/VyWfx21iuL2jt+tYoelg==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr3864609wrn.74.1596209262115;
        Fri, 31 Jul 2020 08:27:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n24sm6147712wmi.36.2020.07.31.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
Message-Id: <a2e5b3082e8aad2f11fb73cd3c31209c17096f15.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:16 +0000
Subject: [PATCH v20 20/21] Add reftable testing infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* Add GIT_TEST_REFTABLE environment var to control default ref storage

* Add test_prerequisite REFTABLE.

* Skip some tests that are incompatible:

  * t3210-pack-refs.sh - does not apply
  * t1450-fsck.sh - manipulates .git/ directly to create invalid state

Major test failures:

 * t1400-update-ref.sh - Reads from .git/{refs,logs} directly
 * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
 * t1405 - inspecs .git/ directly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t1450-fsck.sh               | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 t/test-lib.sh                 | 5 +++++
 4 files changed, 23 insertions(+)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb6350..c6f7832556 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -4,6 +4,12 @@ test_description='avoid rewriting packed-refs unnecessarily'
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 344a2aad82..0966920324 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -8,6 +8,12 @@ test_description='git fsck random collection of tests
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success setup '
 	test_oid_init &&
 	git config gc.auto 0 &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f41b2afb99..edaef2c175 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -11,6 +11,12 @@ semantic is still the same.
 '
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ba224c86f5..7a341c7bc5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1508,6 +1508,11 @@ parisc* | hppa*)
 	;;
 esac
 
+if test -n "$GIT_TEST_REFTABLE"
+then
+  test_set_prereq REFTABLE
+fi
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget


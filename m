Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D26C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C902D2073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFoS/KCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFVVzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFVVzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0995C061796
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l17so1084243wmj.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rHvq88m2ks24BuD1UNEQKNf+2ECknErS9c1B3DOVvpk=;
        b=sFoS/KCXh7aekVV+SgOrGRlUi9ckJ3+BkP1GfdbuKd5OBt5z1vStfDSQaMRCiQpmO5
         s/zlVdY3etwlFNtqZ1xpDHU1x4UYzs4dcek02bfeTs/iBkxBzqtIC3Gh1ILCSu7VaLZR
         2HefeLcX3vDpMMlN7+c5/uCoJAEStDczcU6AzO1kQRrslD3XBuv6BvVLW7lrlQvnUNAp
         1o1Sy+vlw1fpf8TrQFOOO6wrvkY6t2ys6cEijGoFTAvRBZ5U9prQTOSN00wzBz0SPS+A
         0Sydm53T5Bqo7jwmWPWywLBWodM6YnxZGVd2/ouhHvtxyyP7rplILf4i9zJWYcxmzSIh
         lmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rHvq88m2ks24BuD1UNEQKNf+2ECknErS9c1B3DOVvpk=;
        b=K7ITYWIsFZlFB+/FTqatOB54ZR2WCHWgmlQc3xnhxtUw2Wx8Y33eiDHGvGfu7e+rHE
         tLDSgD+A6CEnnuhIDjTKr4eQaVyhrUrTd/l7YkhcRALV+fSFYTQu1hrg294T5qunpKgh
         u2KiP4D1R5VlmGe5m2Tyb7bluHz+AcG46hH45Lc+dmcgSDzH7xxubf7d/BF46RCqgATn
         15OaC5Uv5vVr0YpOpvi7VakjsFXWPSpt8eGoP8MG/8Ei6VU7v+n4ZdWf05zI1y5lbjwP
         2fM9Wk74MwB4FmfaeDEOnerh97vOWNWSN7xdxMWEXRhoT3RsELojeDIYWUgvvTC5Z450
         KV8A==
X-Gm-Message-State: AOAM530Xnskty5yFENmVT0bFDc+MBKCBabjMpZMb+gB4JVpkWdwNk5+O
        phVIOPq44G41hKLpmuQ+OYlTe2eH
X-Google-Smtp-Source: ABdhPJx0taAeom7H3T8AK9W8M20AROdDd9MYLgaMSgUcdlUY3aQcDnLMKNfMRjjbdV8m9kZERW55xg==
X-Received: by 2002:a1c:5987:: with SMTP id n129mr20184511wmb.60.1592862940130;
        Mon, 22 Jun 2020 14:55:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm19852973wrp.45.2020.06.22.14.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:39 -0700 (PDT)
Message-Id: <ece1fa1f62512997137dbec4b46e5bea082aeae6.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:19 +0000
Subject: [PATCH v18 18/19] Add reftable testing infrastructure
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
index be12fb63506..c6f78325563 100755
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
index 344a2aad82f..09669203249 100755
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
index f41b2afb996..edaef2c175a 100755
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
index dbc027ff267..3ce9b957b1b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1504,6 +1504,11 @@ parisc* | hppa*)
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


Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F54C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF252067D
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXVvvMbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgF2S52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgF2S5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9422C031C46
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so17128147wmf.5
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vgHP7fZ62VCVTz2sqy3qAAzsXNKys58ncFMumIlY/Ik=;
        b=WXVvvMbXCXQhv9L8vC927zjwIhrNyVrD2TPFN9o8hkBl4P2F2lYdOTA+6loqKIc2/T
         osoae1LbjuvrTOBMxgUHmtfd3v1RPnyymTcNvyc2wDx2gKROfJ0xCkdlDmsSwfQefD23
         xT2SlyV2F0f9a6FRib/XOQQzXkIGQ25QTeauwnWIkif1zM/wE29Fs3hANqytK95m+e4D
         qC7FhPmsxsP+FtagFycsZFEQmdhk81sCOBeqlIQv1HvxQ01xbdxhpauoYCEsEIwiU9+4
         MUJzpYnSAyLlLtsqkba5eqgEyTQb/etGylVlPO+LG9cP/X49WyXPRa6+ebKQUKhlkNsw
         SHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vgHP7fZ62VCVTz2sqy3qAAzsXNKys58ncFMumIlY/Ik=;
        b=oFDpUz1ew8UcyEKdU4117rKS3yOiXl0s+jjLJfjs3DCDbs2c1Ylh4rhmlK+ZRbTQmJ
         aab1MY8zbeVHoxIhcSTEEAz3hmPsXGrYyCIVkJ8lOQkJ4/U5B58n3MzGHJl0FwWA+NTu
         cwnb2tcqhnTjx4oFcIka6dJA41nF3OKG1CeMTKqnNdTZQFoKXis4H0Zuc9LW/mrukELN
         pZjQjSlzE4dlOuaMHUM5U+L0/MFgfMlD2KTlBFyqmJjKnTBgKB/MVQ7CklG69cOIW/SW
         wbtzq8mpe4vfoZAKV3C/xMPbk8gBdP/9305RnqiMAqrCNoR/PMcndKJS9J/TAUZtxDlk
         V2oQ==
X-Gm-Message-State: AOAM5338SKSAzG/XJ+uu6hCi8C0t+j+tyKywBqHjT1PUYZAh8zZBcsZ8
        UlI+N2gIA/Hb6rtIsZEzmKxjN9U5I/w=
X-Google-Smtp-Source: ABdhPJzeyCmvrvq3kXTgtJz7YkHopNHwC9XGXG02XdEWnOjPZSjc59ZNCStbF6ETM8m7a5qQSR+tpQ==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr16903866wmy.29.1593457037297;
        Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r67sm834408wmr.9.2020.06.29.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:16 -0700 (PDT)
Message-Id: <5a85abf9c429f96eefbdfb8367df6be74ee3fb5f.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:57 +0000
Subject: [PATCH v19 19/20] Add reftable testing infrastructure
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
index 618a7c8d5b..9b22c7def3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1505,6 +1505,11 @@ parisc* | hppa*)
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


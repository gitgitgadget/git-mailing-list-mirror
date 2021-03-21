Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55FDC433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A998361481
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCUWhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCUWgi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 18:36:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B17C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x16so14739508wrn.4
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S9sprta5EV3QXKCrO9t4DSzTHrbB2u3Qer20NVe9LA=;
        b=pAmqjpftOAhWMlGa6AGF1at1sc0hF4koIpVJ+8fCfyLIf74+y5UZW+1J6NetgzF6Wm
         VgN/faAwSU7lbmdlFreFcQycTbXS2/VRe86Aj6UANeAnG3Jx2mF3WwZ0LUxjxD1SGKBv
         N8klQJGAv2CqffDHADC5GhTZ0119IIKAEiPuYFGGSXvnIBctYYqkg0zXX/RU45jF0Xsb
         Ogm76iRK8lRwd69jyCEZamSOdFferN/aTgNiW9KBK8jWhkYXpvcsWt44evo0lNfbgPv6
         3LBaBT4N0eSy1BSovc5eT8bL94UiRffwhPuEdgT05Vo19c1lqTxAS4b6ftcDwCINvGiR
         8j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S9sprta5EV3QXKCrO9t4DSzTHrbB2u3Qer20NVe9LA=;
        b=LAzvsbRJzJIw3MlSUsN/qB+B4hqKPKZnwtHg57eMzrx++2TRM3bMXe170XLX2U0qi0
         WgTfDNDOZDMLruhplaIvPTy9g5jhCHACZXCa2UbymZpZzPsz1piVDegRdmebSwmCZt0B
         gU3iDjn8uhu6v4K9d7ALNs8CAwVsHH92P8hdLm6W5iLd/5h9l7yclkvNZ+DTcB050ZhQ
         TQyjD532oSjZLoDrdSnwSqoLE0schX5dBAUOfM5Mp6NU/Vk0C0NcAYhzsglPeq6QKNiQ
         n9j3sMh1+wIR9tPdE3H25Hg2OgIVyL+tcdMhY04KN9UhoWmQfK9QQp2JcvP/7bmkhGJP
         lS+w==
X-Gm-Message-State: AOAM530A6KR9Xi6d1eBwvC+v/7BIFitwYj1sBXoa+PjBA559m9GL926Q
        oAPgNfd4bojjGQ8V6v3H+OORSsUDSPaulw==
X-Google-Smtp-Source: ABdhPJyfgwz9v5id5blN5rdv+y00U6rkR5leeJEuo60Cr81r2oMGf0Wa4VBD1lKXa/op72Baf8iMTQ==
X-Received: by 2002:adf:f843:: with SMTP id d3mr15032703wrq.55.1616366196379;
        Sun, 21 Mar 2021 15:36:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm14922156wma.37.2021.03.21.15.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:36:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] diff --no-index: fix test blind spots
Date:   Sun, 21 Mar 2021 23:36:18 +0100
Message-Id: <cover.1616366036.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616330120.git.avarab@gmail.com>
References: <cover.1616330120.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a stupid s/Test/test/ typo in v1. Thanks Ramsey. I also noticed
a failure on one of the Windows CI's (curiously, not all?), so
POSIXPERM for these tests is another thing I forgot.

I've also added a symlink diff test for good measure. I'm testing the
full output, but using the the approprite variables, so it passes
under both GIT_TEST_DEFAULT_HASH=sha1 & sha256.

Ævar Arnfjörð Bjarmason (2):
  diff --no-index tests: add test for --exit-code
  diff --no-index tests: test mode normalization

 t/t4053-diff-no-index.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

Range-diff:
1:  a6e4ed6c3f1 ! 1:  2dbc6c253e2 diff --no-index tests: add test for --exit-code
    @@ t/t4053-diff-no-index.sh: test_expect_success 'setup' '
      	echo 1 >non/git/b
      '
      
    --test_expect_success 'git diff --no-index directories' '
     +test_expect_success 'git diff --no-index --exit-code' '
     +	git diff --no-index --exit-code a/1 non/git/a &&
     +	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
     +'
     +
    -+Test_expect_success 'git diff --no-index directories' '
    + test_expect_success 'git diff --no-index directories' '
      	test_expect_code 1 git diff --no-index a b >cnt &&
      	test_line_count = 14 cnt
    - '
2:  2dcc8bccf97 ! 2:  a1ab6a323f2 diff --no-index tests: test mode normalization
    @@ t/t4053-diff-no-index.sh: test_expect_success 'diff --no-index allows external d
     +	test_must_be_empty out
     +'
     +
    -+test_expect_success 'diff --no-index normalizes mode: chmod +x' '
    ++test_expect_success POSIXPERM 'diff --no-index normalizes mode: chmod +x' '
     +	chmod +x y &&
     +	cat >expected <<-\EOF &&
     +	diff --git a/x b/y
    @@ t/t4053-diff-no-index.sh: test_expect_success 'diff --no-index allows external d
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'diff --no-index normalizes: mode not like git mode' '
    ++test_expect_success POSIXPERM 'diff --no-index normalizes: mode not like git mode' '
     +	chmod 666 x &&
     +	chmod 777 y &&
     +	cat >expected <<-\EOF &&
    @@ t/t4053-diff-no-index.sh: test_expect_success 'diff --no-index allows external d
     +	test_expect_code 1 git diff --no-index x y >actual &&
     +	test_cmp expected actual
     +'
    ++
    ++test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not like git mode (symlink)' '
    ++	ln -s y z &&
    ++	X_OID=$(git hash-object --stdin <x) &&
    ++	Z_OID=$(echo -n y | git hash-object --stdin) &&
    ++	cat >expected <<-EOF &&
    ++	diff --git a/x b/x
    ++	deleted file mode 100644
    ++	index $X_OID..$ZERO_OID
    ++	--- a/x
    ++	+++ /dev/null
    ++	@@ -1 +0,0 @@
    ++	-foo
    ++	diff --git a/z b/z
    ++	new file mode 120000
    ++	index $ZERO_OID..$Z_OID
    ++	--- /dev/null
    ++	+++ b/z
    ++	@@ -0,0 +1 @@
    ++	+y
    ++	\ No newline at end of file
    ++	EOF
    ++	test_expect_code 1 git -c core.abbrev=no diff --no-index x z >actual &&
    ++	test_cmp expected actual
    ++'
     +
      test_done
-- 
2.31.0.285.gb40d23e604f


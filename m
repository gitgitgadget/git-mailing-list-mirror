Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E45BC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjECV4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjECV4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:56:15 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8977EDA
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:56:06 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3310e9368eeso23989385ab.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683150965; x=1685742965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31Mk8o7Fapiv2Y8UyZffT7mbwD8tPTS+/Gka/QE7LWk=;
        b=i4i6jaRY3doLH2JppMRxguqzVDd+bpOY6jY2anP3EqrE3oG828KQwb8XShbva4j1Df
         M8rNy3YGUPwWM4WXZotXhcKTkIwMgUzo8JnsOIhdWg28uET5lr0kJiG7LI+YWM/ZKW7o
         dLJ8jOSP/7+TuRNzQMXTVq0xl6OZxPcuAvJ/gWhFM5khaD0it04f7GeVGL+p4IEW4eQ0
         3IimYqYETJ6xRQsG1JUqGz0RKK2tjZ5yFJ1g0gVBVSlFFttb/7czSTF2Fxgq0froh4nS
         0JstJtDLNQgwEAyaW7XeDjSRYzV7bwu2CiekbvvhwE5AHCYZPfmeffljaMBwQWUtL48b
         QH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150965; x=1685742965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31Mk8o7Fapiv2Y8UyZffT7mbwD8tPTS+/Gka/QE7LWk=;
        b=KEHkSTV/B58yRSWwXYIzLTnXzPFcfldSqoRhPBW9bb//x4BUg7VCo5VBwnUbyyGzSU
         EJFGAZ8qsMz2V+8qHYjebBiMpQ+79bTjp/ynqoLSjcLGR9PkoJJpoAFQZxFeHKGF0RhY
         JXCyqaDlabLI0psZkh/lHbBIr5TZd32QJ10sPga71JuZ0yc2UVpN3s3sHA4SPJKHRENK
         MFkQttCRmIEV0qXh/SUfU6pYm9r1cEUpUi8D6z1/upiWYmjgEvCqQM59yL/xefIqDPsq
         aDho3VOFI5wlQ3XB9SgEB9nKNpuAYozxT0tQ9t1RTfDDLd1nwtyulR4m/B4mo3OTmY2g
         6EMA==
X-Gm-Message-State: AC+VfDzRGOo78z3G5ndwLNF2om6Ibll8T1TGkbHueqZB2O6WCF2Ijmul
        Bagi9MpVpV9s+bmUVVaVGhN+QhHyuLMngA==
X-Google-Smtp-Source: ACHHUZ7tGHWPiqrO39nAFqFxuhUP0+Zuv/FH0uh5RU6s/viWQQPlY/cb/shpIpGqaNNUpAkvpNFVSQ==
X-Received: by 2002:a05:6e02:4c5:b0:331:3fe4:f2ec with SMTP id f5-20020a056e0204c500b003313fe4f2ecmr4311572ils.26.1683150964857;
        Wed, 03 May 2023 14:56:04 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id p13-20020a02290d000000b00411af6e8091sm210419jap.66.2023.05.03.14.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:56:04 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v10 0/2] diff-files: integrate with sparse index
Date:   Wed,  3 May 2023 17:55:47 -0400
Message-Id: <20230503215549.511999-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230502172335.478312-1-cheskaqiqi@gmail.com>
References: <20230502172335.478312-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v9:

* Replace the unhelpful test with a double-dash case to prevent
regressions. 

* Remove the unmodified test because its empty output could pass
even with an index expansion issue.

* Update the relevant commit message.

* Did not add " -- " in modified test as suggested sine 
"folder1/a" exists in the working tree


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 66 +++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

Range-diff against v9:
1:  d78513af83 ! 1:  3b284bdf3b t1092: add tests for `git diff-files`
    @@ Commit message
         make a directory called 'folder1' and copy `a` into 'folder1/a'.
         'folder1/a' is identical to `a` in the base commit. These make
         'folder1/a' in the index, while leaving it outside of the
    -    sparse-checkout definition. Test 'folder1/a'being present on-disk
    -    without modifications, then change content inside 'folder1/a' in order
    +    sparse-checkout definition. Change content inside 'folder1/a' in order
         to test 'folder1/a' being present on-disk with modifications.
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +test_expect_success 'diff-files with pathspec outside sparse definition' '
     +	init_repos &&
     +
    -+	test_sparse_match test_must_fail git diff-files folder2/a &&
    ++	test_sparse_match git diff-files -- folder2/a &&
     +
     +	write_script edit-contents <<-\EOF &&
     +	echo text >>"$1"
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +	run_on_all mkdir -p folder1 &&
     +	run_on_all cp a folder1/a &&
     +
    -+	# file present on-disk without modifications
    -+	# use `--stat` to ignore file creation time differences in
    -+	# unrefreshed index
    -+	test_all_match git diff-files --stat &&
    -+	test_all_match git diff-files --stat folder1/a &&
    -+	test_all_match git diff-files --stat "folder*/a" &&
    -+
     +	# file present on-disk with modifications
     +	run_on_all ../edit-contents folder1/a &&
     +	test_all_match git diff-files &&
2:  a2454befa0 = 2:  15472db302 diff-files: integrate with sparse index
-- 
2.39.0


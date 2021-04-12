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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F1C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0796124C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhDLLd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C78C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id 12so12567012wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MI9lORs+ca/RCUXXVuG4k2g9Ns/yaNPxOL1fR4++5qM=;
        b=PUfQhiwYwHUxauYAnAwLHN5DpXKkhkykpG6p26kNF8dl56y0KSnwDrnciQzoIC9Hqp
         W2PiOc8LXXQjzZ8BU28bjqbe6MWGkPqorxfBofo72Un+ADzFhhsjTTyq2qf2XHT6Xph5
         HVMRqOAu2aPGj7dW/TlWHg87SKzaXVDusfTTp6gGtOP4a2yYAOChkiRbBjYLPMdSlo/k
         XU+GB6yp8GuRNvL4pIjP7x6CX3pSlOS65DT8WXHTGbNnsBAwMJ7N+QwzwrfB0tIJMwpL
         mGNoSdEyvvhkaRleklXUH6l/t/A29+4L8qHa0cVYto7ExhXajyYqhPZqVuaiDc70/YeS
         VoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MI9lORs+ca/RCUXXVuG4k2g9Ns/yaNPxOL1fR4++5qM=;
        b=iuHcdLNJobnmtpNOT2PBCbhm7lF1OAlqk6SO6nyqltAuj438DfcltIDcuWAYgzP/g/
         c0SPNPw6Wv3SACdIJ8FAK3QeF805iDoyeApejSQR/tbK8sffzVh79vW0GaQfpD54xRb2
         HwXuwZhgYMJlHJH0WA5QV2fyTUuPfvK9nr6RFauXt8D/C1ARf4TbObmNgh/Cj4WXD4QL
         /xJfaIKpNQzCRVA2R9B/WFd5GzA/YAunh5inf+AsQynLmAd340lRENxeJ7DwqCuiQDcB
         TIj+6aHQ8FjYEOn8Vi20QP3YOjkNTrMBv8Zhe8uxU6b0uA+Jcmu1OflnCATyGfsZG/AP
         p8yQ==
X-Gm-Message-State: AOAM5320DxLtVSDlL8cY3Ea3cf7TOka8zgCTiognySseyPND/PaT/ncl
        5KdAmAZ/EjH2dw6IF72o2L9t4ml7earbpA==
X-Google-Smtp-Source: ABdhPJztjt7v7sQP8t3tVWZis9OjAdo4Z6WMItD64TW1xkd6TiGLAp52zD+1gf+fj55kqywFvfUlqQ==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr31336922wrp.38.1618227216147;
        Mon, 12 Apr 2021 04:33:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u8sm17210139wrr.42.2021.04.12.04.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:33:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] svn tests: trivial "set -e" in main body of test fixes
Date:   Mon, 12 Apr 2021 13:33:24 +0200
Message-Id: <cover-0.2-00000000000-20210412T113247Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <20210228195414.21372-1-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 1. this set of trivial fixes has been split off from my
"describe tests fixes. The two patches were needed for a now-ejected
"make test_expect_{success,failure} return 1" (to catch such "set -e"
issues).

Even with that gone for now and thus the immediate incentive for these
fixes being gone, it makes sense to fix these tests to use a more
modern style.

The only other change since v1 is using ">" instead of "touch" per
Eric Wong's suggestion, and rewording the commit message(s) to not
promise a follow-up change to test_expect_{success,failure}.

Ævar Arnfjörð Bjarmason (2):
  svn tests: remove legacy re-setup from init-clone test
  svn tests: refactor away a "set -e" in test body

 t/t9117-git-svn-init-clone.sh |  6 ------
 t/t9148-git-svn-propset.sh    | 27 +++++++++++++++------------
 2 files changed, 15 insertions(+), 18 deletions(-)

Range-diff against v1:
1:  be5ed59dc61 = 1:  d08e098ea8d svn tests: remove legacy re-setup from init-clone test
2:  0b4238d012a ! 2:  8dd13c24994 svn tests: refactor away a "set -e" in test body
    @@ Commit message
         svn tests: refactor away a "set -e" in test body
     
         Refactor a test added in 83c9433e67 (git-svn: support for git-svn
    -    propset, 2014-12-07) to avoid using "set -e" in the test body. This
    -    would have broken in combination with a subsequent change to make
    -    "test_expect_success" return 1 to catch such cases.
    +    propset, 2014-12-07) to avoid using "set -e" in the test body. Let's
    +    move this into a setup test using "test_expect_success" instead.
     
    -    While I'm at it rewrite the test to conform to a modern style in our
    -    tests, using the "test_when_finished" function for the "rm -rf", and
    -    avoiding repeated "mkdir" in favor of "mkdir -p".
    +    While I'm at it refactor:
    +
    +     * Repeated "mkdir" to "mkdir -p"
    +     * Uses of "touch" to creating the files with ">" instead
    +     * The "rm -rf" at the end to happen in a "test_when_finished"
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t9148-git-svn-propset.sh: test_description='git svn propset tests'
     +	(
     +		cd import &&
     +		# for "add props top level"
    -+		touch foo &&
    ++		>foo &&
     +		# for "add props relative"
    -+		touch subdir/foo_subdir &&
    ++		>subdir/foo_subdir &&
     +		# for "add props subdir"
    -+		touch "$foo_subdir2" &&
    ++		>"$foo_subdir2" &&
     +		svn_cmd import -m "import for git svn" . "$svnrepo"
     +	)
     +'
3:  4f2c4f1fdd5 < -:  ----------- test-lib: return 1 from test_expect_{success,failure}
-- 
2.31.1.634.gb41287a30b0


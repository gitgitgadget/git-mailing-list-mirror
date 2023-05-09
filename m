Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD52C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjEITnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEITnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:43:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A94C23
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:42:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3eef63eff7eso32859251cf.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683661373; x=1686253373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RBLgwaudAYEhpX44gj0MVp0FFIZgDzdjSsrwz6vtXI=;
        b=Jh4qRyZ1vqUoem4cGan8m/m81oHyHx+P0qT33+c76FpqWPL4D3e09pppAPAzhpKQxT
         ivFb7cTn1waO56CAI9LK7NBn4gZScatz41UePV0MGu+rfCYqInOqA2p4oMKEkBmVWPfW
         P0jODVlJmf9B1wq9rTqgH213xtGzZC27ItgGxTQ4wAiH1b6QnNyN4lNbVeC9+Rps5gWH
         iwruiag39UdeN1OZRiWqGEm23dj38W3umlfiW9meEKc+gQtKgIPVA+di8zgqUYDOre0h
         j94Yv1cxfA22KNGSj3G3av42cKoElOIpRB2yq89e2nbyIElmV8AvEE/IFDxd3HX7rE/L
         L/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661373; x=1686253373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RBLgwaudAYEhpX44gj0MVp0FFIZgDzdjSsrwz6vtXI=;
        b=TT9X6SMpSu7zIZeST77Evru4Rnkuidxs0Dosi/d9M7AjLZvRTV8dg1DjaEJavD+Flw
         z1b60lzIVew5VRVk0alr2IDkYXaKhXlyLunUL8fclRcf+LHxU2Tg9LPF9L3t55+RUisq
         QhnaGjY/6lAHAXbxA/s+06AtB3+dO6BO23JGWLVtbq22ZZ/PLw5qW5e6JYnQzzBbDWB9
         f9sw9t0IAAKT0QjONgafhZWD2XQcXJTtzSpZgFFJ5BiZNmrylX60PcWyzcgfPcdJ+gPk
         4c2mN+dlTBMGKbOXBU8jQNBCeD8hHH6eWQ7pN/rco0+aEQJRBcciUfydYPGA7kLoICr4
         oDXw==
X-Gm-Message-State: AC+VfDyh26a1Ekm++/TJZu/fcU2Op67b4Ree3eMWFb/0gfopQa/P65lL
        9v9VLJ14qSp2cWAMeIDWVcw+ZnRrdvQmHQ==
X-Google-Smtp-Source: ACHHUZ47N2YauximvWOKyAq5BEsipFm2D5F/JX/R1FGBDWS98ly3pRIYrdTWV2d3TFrHhyOvcjh8vg==
X-Received: by 2002:ac8:57d2:0:b0:3dc:7fcc:31c7 with SMTP id w18-20020ac857d2000000b003dc7fcc31c7mr22777505qta.2.1683661373673;
        Tue, 09 May 2023 12:42:53 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id j11-20020ac8550b000000b003f1f26bbb50sm756038qtq.35.2023.05.09.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:42:52 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v12 0/2] diff-files: integrate with sparse index
Date:   Tue,  9 May 2023 15:42:39 -0400
Message-Id: <20230509194241.469477-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230508184652.4283-1-cheskaqiqi@gmail.com>
References: <20230508184652.4283-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Add the '--' in all test to remain consistent.

* Change 'may not' to 'will not'.


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 66 +++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

Range-diff against v11:
1:  3e96a0c136 ! 1:  eb74730813 t1092: add tests for `git diff-files`
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +
     +	test_all_match git diff-files &&
     +
    -+	test_all_match git diff-files deep/a &&
    ++	test_all_match git diff-files -- deep/a &&
     +
     +	# test wildcard
    -+	test_all_match git diff-files "deep/*"
    ++	test_all_match git diff-files -- "deep/*"
     +'
     +
     +test_expect_success 'diff-files with pathspec outside sparse definition' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +	EOF
     +
     +	# The directory "folder1" is outside the cone of interest
    -+	# and may not exist in the sparse checkout repositories.
    ++	# and will not exist in the sparse checkout repositories.
     +	# Create it as needed, add file "folder1/a" there with
     +	# contents that is different from the staged version.
     +	run_on_all mkdir -p folder1 &&
2:  2c53fedf08 ! 2:  11affce5b7 diff-files: integrate with sparse index
    @@ Commit message
         diff-files' and a ~97% execution time reduction for 'git diff-files'
         for a file using a sparse index:
     
    -    Test                                           before  after
    -    -----------------------------------------------------------------
    -    2000.78: git diff-files (full-v3)              0.09    0.08 -11.1%
    -    2000.79: git diff-files (full-v4)              0.09    0.09 +0.0%
    -    2000.80: git diff-files (sparse-v3)            0.52    0.02 -96.2%
    -    2000.81: git diff-files (sparse-v4)            0.51    0.02 -96.1%
    -    2000.82: git diff-files f2/f4/a (full-v3)      0.06    0.07 +16.7%
    -    2000.83: git diff-files f2/f4/a (full-v4)      0.08    0.08 +0.0%
    -    2000.84: git diff-files f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
    -    2000.85: git diff-files f2/f4/a (sparse-v4)    0.51    0.02 -96.1%
    +    Test                                               before  after
    +    -----------------------------------------------------------------------
    +    2000.94: git diff-files (full-v3)                  0.09    0.08 -11.1%
    +    2000.95: git diff-files (full-v4)                  0.09    0.09 +0.0%
    +    2000.96: git diff-files (sparse-v3)                0.52    0.02 -96.2%
    +    2000.97: git diff-files (sparse-v4)                0.51    0.02 -96.1%
    +    2000.98: git diff-files -- f2/f4/a (full-v3)       0.06    0.07 +16.7%
    +    2000.99: git diff-files -- f2/f4/a (full-v4)       0.08    0.08 +0.0%
    +    2000.100: git diff-files -- f2/f4/a (sparse-v3)    0.46    0.01 -97.8%
    +    2000.101: git diff-files -- f2/f4/a (sparse-v4)    0.51    0.02 -96.1%
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git grep --cached bogus -- "
      test_perf_on_all git describe --dirty
      test_perf_on_all 'echo >>new && git describe --dirty'
     +test_perf_on_all git diff-files
    -+test_perf_on_all git diff-files $SPARSE_CONE/a
    ++test_perf_on_all git diff-files -- $SPARSE_CONE/a
      
      test_done
     
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with p
     +	run_on_all ../edit-contents deep/a &&
     +
     +	ensure_not_expanded diff-files &&
    -+	ensure_not_expanded diff-files deep/a &&
    -+	ensure_not_expanded diff-files "deep/*"
    ++	ensure_not_expanded diff-files -- deep/a &&
    ++	ensure_not_expanded diff-files -- "deep/*"
     +'
     +
      test_done
-- 
2.39.0


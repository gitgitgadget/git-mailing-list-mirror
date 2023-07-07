Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99F8EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjGGPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 11:18:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50987AF
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 08:18:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403713e7344so16290051cf.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743135; x=1691335135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE9DBF31iGnuSwG9v2S/wnJ24ic9OEdCFIIAgTg+w1U=;
        b=oiwTFwLs2KtrxoqQHkOhbkEQDwidaXOXhYIWdlL3Rx6uIkSF5i6CFwSAU1O8mv3r21
         WtcA9mP6YIWwe9YsKzHblzxpxK+BEDpWUT79hvcOdbR1veuOwKa3VtFBVRgtRiDazhB0
         hAGv5h3z1hiiLfJz7UmLo+u5WSGUVCdfmJgVS3UCOrSgylFgT9RMPHODkKWC9NSsZ70T
         T169eCaJ55HDViO/bOuTzwaA1fbgYYGYaDQgVCd+ThhLbAF3lJJ1wM3Qp4MpOjGOvj9x
         eNzBBxEerGnnRzBTQVC0UUUp/mv8bmdXpKt1ARHRTfD5pdHTwVsbE9WsyKCFWcacMkbW
         YSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743135; x=1691335135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE9DBF31iGnuSwG9v2S/wnJ24ic9OEdCFIIAgTg+w1U=;
        b=VrLaC0EL0I+UTMsSJeNYXmMNeYtqZtY5ulB7v1FDELOmWDka+7qNLVlW0Z9mXEKhxY
         OO891gPfyo6UAtXzFxaMh7y+Ww7W1HFrcXIOi9OGZPrRpaVGzce3gmJGzjQRLIlaJPXa
         ZNQy5V3bB+Xlyd6Nt3zK/rXgOrOwJnEGl16OB1Qihrs3oNHi86rlSC0XqJ9j1ImDebiL
         zNydn3doWBQHu1QLK0131ProigKC3Nj4g5EAAZa0DnreGn0SvjAMvMfDvzyS1VDxStjm
         jfyumT1KuLQ9pdJLMWp4tOzdg7ETuc73O6X7NZ/XrANMiWO4BbiY/ErlZXUrgi3Qph1i
         VHJw==
X-Gm-Message-State: ABy/qLZ9uK9wHApxhkyccTer2vn8FRWjauswf5dHfFn4qBQFhKJK47Bo
        H4wc7ggvCKMNhSzrr6t9sT7GljWgAzc=
X-Google-Smtp-Source: APBJJlGpQnwmr0Or9ie8TuCpnXuSyYMyzWW6hRBTyiQXlxY55EEZC0xSK87BqWPchm3+bii1C5vH1A==
X-Received: by 2002:ac8:5846:0:b0:400:8f36:ec19 with SMTP id h6-20020ac85846000000b004008f36ec19mr7425289qth.36.1688743135012;
        Fri, 07 Jul 2023 08:18:55 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id a14-20020aed278e000000b004039e9199cesm338698qtd.60.2023.07.07.08.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 08:18:54 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v2 0/3] check-attr: integrate with sparse-index
Date:   Fri,  7 Jul 2023 11:18:36 -0400
Message-Id: <20230707151839.504494-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230701064843.147496-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


change against v1:

* update a new commit message with more details

* update read_attr_from_index function

* add smudge/clean filters in test 'merge with conflict outside cone'

* add the missing perf test

* only verifying behavior in 'sparse-index' in test 'sparse-index is
not expanded: check-attr'

* show that the index is also not expanded files outside of
the sparse-checkout cone

Shuqi Liang (3):
  Enable gitattributes read from sparse directories
  t1092: add tests for `git check-attr`
  check-attr: integrate with sparse-index

 attr.c                                   | 42 +++++++++---------
 builtin/check-attr.c                     |  3 ++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 21 deletions(-)

Range-diff against v1:
1:  afa27ebe2d < -:  ---------- attr.c: read attributes in a sparse directory
-:  ---------- > 1:  0ff2ab9430 Enable gitattributes read from sparse directories
2:  5bb40b0327 ! 2:  835e1176b0 t1092: add tests for `git check-attr`
    @@ Metadata
      ## Commit message ##
         t1092: add tests for `git check-attr`
     
    +    Add smudge/clean filters in .gitattributes files inside the affected
    +    sparse directories in test 'merge with conflict outside cone', make sure
    +    it behaves as expected when path is outside of sparse-checkout.
    +
         Add tests for `git check-attr`, make sure it behaves as expected when
         path is both inside or outside of sparse-checkout definition.
     
    @@ Commit message
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with conflict outside cone' '
    + 
    + 	test_all_match git checkout -b merge-tip merge-left &&
    + 	test_all_match git status --porcelain=v2 &&
    ++
    ++	echo "a filter=rot13" >>.gitattributes &&
    ++	run_on_sparse mkdir folder1 &&
    ++	run_on_all cp ../.gitattributes ./folder1 &&
    ++	git -C full-checkout add folder1/.gitattributes &&
    ++	run_on_sparse git add --sparse folder1/.gitattributes &&
    ++	run_on_all git commit -m "add .gitattributes" &&
    ++	test_sparse_match git sparse-checkout reapply &&
    ++	git config filter.rot13.clean "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
    ++	git config filter.rot13.smudge "tr 'A-Za-z' 'N-ZA-Mn-za-m'" &&
    ++
    + 	test_all_match test_must_fail git merge -m merge merge-right &&
    + 	test_all_match git status --porcelain=v2 &&
    + 
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not expanded' '
      	ensure_not_expanded worktree remove .worktrees/hotfix
      '
3:  abd14ddda7 < -:  ---------- check-attr: integrate with sparse-index
-:  ---------- > 3:  672d692e51 check-attr: integrate with sparse-index
-- 
2.39.0


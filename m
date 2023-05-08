Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DAC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjEHSrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjEHSrH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:47:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E359F7
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:47:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7577ef2fa31so417570085a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683571624; x=1686163624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaYc+Wfkl2UALglpc3tGtQ3NLeq/kDmyIY0dA6P48sQ=;
        b=GPa632jsWR+a8jCaooTIHusIWNOLQDLwr2dkfvyH8v96qpGyaZZtX4XNIs1U/aKhBa
         koDXJlVMaJerri6fTfL1mit7Wm4NxOkgAprBQkYSOXK1ifShNF7LcsW/MzzNrxAwiVe6
         rZNZoBOAzTwg/Cpcwkk32LKXkW2ujNAv4KTvlL7Jd+8P9SSSEc9ynWO4EyFt/sKmx3vx
         XMnDdpr+ggdK9REl57f72uUeUt1nr3D01iRc0W0zVXrkXE2fyP/XlFuTCEJRPaKaonLb
         Gp4f37sbY9w/WkpbaFZwtzKQ1jo/ulH6QzXW1P5uhCYz6IVYETZbNdpzkYbvLlgZvbCR
         GE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683571624; x=1686163624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaYc+Wfkl2UALglpc3tGtQ3NLeq/kDmyIY0dA6P48sQ=;
        b=UZcI1NYPqye8+Xhh8b8jbxUz0sQMNb/kLS0JT3I4i7PP3Z264KvsO37usDn4qdUJTW
         /OqRdep0cCWC67N4aarvi8QDfaE8Da/puRIQTv0O0pQLx6nW8PA9ZInwV8VXfxtXO539
         FMYrvFlT0X8BWx9hrdOo0GVgyd2TSQl/eiXjLO27nvR/ABOocAuTFynUNB4tr17bzZWY
         IwCMLFvExJa4QlY7XoigSlbLIJpjC/dXe+q7ZJK9jyxtBAAukgUAfbe6Mze3aYuZsZYb
         gfGwZuXk5gjzE1wcE6wNzaxmYLfN0WgQ/mHw/8VCNb/R5QHsJ1dqui8xeuFTTXOvgclU
         TAmQ==
X-Gm-Message-State: AC+VfDyi1MwmbpdsaKEcn0l9J35wOejU43tRN7z5H+kQmGKEdrhxv6y/
        j+3WIxA2azaU+fereWrvD2CfvARH6DSArg==
X-Google-Smtp-Source: ACHHUZ7ibNVx2kMFrQbcLyhvl/B2BUZtjVM8PwAo8EmckXUNR3tIWdAiJp2uo3iwE1AJdutKv2P5ng==
X-Received: by 2002:a05:622a:302:b0:3ef:379c:71b9 with SMTP id q2-20020a05622a030200b003ef379c71b9mr27469304qtw.30.1683571624666;
        Mon, 08 May 2023 11:47:04 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id q29-20020ac8411d000000b003f1f26bbb50sm1900982qtl.35.2023.05.08.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 11:47:04 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v11 0/2] diff-files: integrate with sparse index
Date:   Mon,  8 May 2023 14:46:50 -0400
Message-Id: <20230508184652.4283-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230503215549.511999-1-cheskaqiqi@gmail.com>
References: <20230503215549.511999-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v10:

* Rewrite the comment before the "mkdir -p"

* Add " -- " in modified test to prevent regressions.


Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 66 +++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

Range-diff against v10:
1:  3b284bdf3b ! 1:  3e96a0c136 t1092: add tests for `git diff-files`
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +	echo text >>"$1"
     +	EOF
     +
    -+	# Add file to the index but outside of cone for sparse-checkout cases.
    -+	# Add file to the index without sparse-checkout cases to ensure all have
    -+	# same output.
    ++	# The directory "folder1" is outside the cone of interest
    ++	# and may not exist in the sparse checkout repositories.
    ++	# Create it as needed, add file "folder1/a" there with
    ++	# contents that is different from the staged version.
     +	run_on_all mkdir -p folder1 &&
     +	run_on_all cp a folder1/a &&
     +
    -+	# file present on-disk with modifications
     +	run_on_all ../edit-contents folder1/a &&
     +	test_all_match git diff-files &&
    -+	test_all_match git diff-files folder1/a &&
    -+	test_all_match git diff-files "folder*/a"
    ++	test_all_match git diff-files -- folder1/a &&
    ++	test_all_match git diff-files -- "folder*/a"
     +'
     +
      test_done
2:  15472db302 ! 2:  2c53fedf08 diff-files: integrate with sparse index
    @@ t/t1092-sparse-checkout-compatibility.sh: ensure_not_expanded () {
      }
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with pathspec outside sparse definition' '
    - 	test_all_match git diff-files "folder*/a"
    + 	test_all_match git diff-files -- "folder*/a"
      '
      
     +test_expect_success 'sparse index is not expanded: diff-files' '
-- 
2.39.0


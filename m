Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4408CC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226F16103D
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhIJKca (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhIJKc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:32:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC0C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so1916782wrn.5
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oQZjrIgGrBbfzxRuC0XBWuxwnz94QeZkcSI6fNNp1no=;
        b=NdYAaCz5/Vrd+S75a3i5I7IPmv8wWgQKOxxbdv2aRQqqi4N81F+iJ/oUAmP+E41t7/
         BKi9er/wtiRKBit9vJ87viycsFUHQa6PunyxzyNoUSJ038jzlMd10Q8CS+VGnpMBekp+
         yMUfq/ULBVQHtqspJBQSHUMSzMdAg2MluRqgXhsoe5Ki65YIyVrssOoe8rdNAv8tpNVt
         Tiz3QrsiabUOpRXv2OHj6KWvyL60b9HbXSyq6zuuyp3eOzQRmDVUNhhuTCnA2xqtcvub
         OR6mO21N+xVnPzbc2GYyW+J48STVumiNSR0RmmI5DyZ4zofRr4l1r74LQ+IpumtbaKDb
         JQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oQZjrIgGrBbfzxRuC0XBWuxwnz94QeZkcSI6fNNp1no=;
        b=QsVQbzlCnrKsWcrmHLNaDTPFrpP3y45ypn3Ilsr7edjXapixkKSTIS0joTm5i4pFvO
         TmLMQeHes73g84+NChTTLNVaJ1UEOBAYHu8pFujA8ksImXA4D2y2dy4k8+Kwf+UTQFxD
         Qr2Fbf0voHvZdf0OfXYFEMLEiW2YbZ0OquKu/HSTEBcskkkYdr0LTqZVwctRGX2DuD0G
         M8qm7d4eWMDt7U1aS3l7KrIBsqLFIINvqemOVkAUhV5tK8xVhpLgymiG0ANRtbTNXr2N
         g2DOp9X+fGaZoT8I6Sv6dr4Ld0BjFTV4icWT6hQW1aA/g7zRJcPbVFEu1BBVejd+XzVk
         CQDg==
X-Gm-Message-State: AOAM531MZNpaDUL2cq/cucS8yj24Ahp/UljHXdaUj2Je6DEvNmizAKRW
        7gPnTjj7J1dkx/dvuTVORbe1mwppFCc=
X-Google-Smtp-Source: ABdhPJzVDl/OIh4GMmGaoEc+cUXuPXKdNqYUxiXfXQiNKrGeKQmt/z02KphNgKZbKOz/55xFHd8dyA==
X-Received: by 2002:adf:d231:: with SMTP id k17mr8888821wrh.389.1631269877354;
        Fri, 10 Sep 2021 03:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm3954869wmi.1.2021.09.10.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:31:17 -0700 (PDT)
Message-Id: <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:31:13 +0000
Subject: [PATCH v2 0/3] A pair of git am --abort issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series documents a few issues with git am --abort in the form of new
testcases, and fixes one of them. However, while I was surprised the abort
left the working directory dirty, I couldn't find any documentation to
confirm it should or shouldn't be, and reading the code led me to question
if perhaps it was intentional. Anyway, if it's intended, let me know and
I'll drop that testcase.

For frame of reference, these were some issues I found while working on
unintentional removal of untracked files/directories and the current working
directory, and I'm just submitting them separately.

Changes since v1:

 * Added a patch to tweak the documentation to clarify that partial cleaning
   of worktree is expected with --abort
 * Tweaked the second test to be a test that unrelated dirty files are kept,
   as suggested by Junio

Elijah Newren (3):
  git-am.txt: clarify --abort behavior
  t4151: add a few am --abort tests
  am: fix incorrect exit status on am fail to abort

 Documentation/git-am.txt |  2 ++
 builtin/am.c             |  3 ++-
 t/t4151-am-abort.sh      | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1087%2Fnewren%2Fam-issues-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1087/newren/am-issues-v2
Pull-Request: https://github.com/git/git/pull/1087

Range-diff vs v1:

 -:  ----------- > 1:  e199df0f3bc git-am.txt: clarify --abort behavior
 1:  b8a418bc63a ! 2:  38a7063b959 t4151: document a pair of am --abort bugs
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    t4151: document a pair of am --abort bugs
     +    t4151: add a few am --abort tests
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ t/t4151-am-abort.sh: test_expect_success setup '
       	git format-patch --no-numbered initial &&
      +	git checkout -b conflicting initial &&
      +	echo different >>file-1 &&
     -+	git commit -a -m different &&
     ++	echo whatever >new-file &&
     ++	git add file-1 new-file &&
     ++	git commit -m different &&
       	git checkout -b side initial &&
       	echo local change >file-2-expect
       '
     @@ t/t4151-am-abort.sh: test_expect_success 'am --abort leaves index stat info alon
       '
       
      +test_expect_failure 'git am --abort return failed exit status when it fails' '
     -+	test_when_finished "rm -rf file-2/ && git reset --hard" &&
     ++	test_when_finished "rm -rf file-2/ && git reset --hard && git am --abort" &&
      +	git checkout changes &&
      +	git format-patch -1 --stdout conflicting >changes.mbox &&
      +	test_must_fail git am --3way changes.mbox &&
     @@ t/t4151-am-abort.sh: test_expect_success 'am --abort leaves index stat info alon
      +	test_path_is_dir file-2/
      +'
      +
     -+test_expect_failure 'git am --abort returns us to a clean state' '
     ++test_expect_success 'git am --abort cleans relevant files' '
      +	git checkout changes &&
      +	git format-patch -1 --stdout conflicting >changes.mbox &&
      +	test_must_fail git am --3way changes.mbox &&
      +
     -+	# Make a change related to the rest of the am work
     -+	echo related change >>file-2 &&
     ++	test_path_is_file new-file &&
     ++	echo further changes >>file-1 &&
     ++	echo change other file >>file-2 &&
      +
     -+	# Abort, and expect the related change to go away too
     ++	# Abort, and expect the files touched by am to be reverted
      +	git am --abort &&
     -+	git status --porcelain -uno >actual &&
     -+	test_must_be_empty actual
     ++
     ++	test_path_is_missing new-file &&
     ++
     ++	# Files not involved in am operation are left modified
     ++	git diff --name-only changes >actual &&
     ++	test_write_lines file-2 >expect &&
     ++	test_cmp expect actual
      +'
      +
       test_done
 2:  5fa7daf264b ! 3:  a46f5c79fbf am: fix incorrect exit status on am fail to abort
     @@ t/t4151-am-abort.sh: test_expect_success 'am --abort leaves index stat info alon
       
      -test_expect_failure 'git am --abort return failed exit status when it fails' '
      +test_expect_success 'git am --abort return failed exit status when it fails' '
     - 	test_when_finished "rm -rf file-2/ && git reset --hard" &&
     + 	test_when_finished "rm -rf file-2/ && git reset --hard && git am --abort" &&
       	git checkout changes &&
       	git format-patch -1 --stdout conflicting >changes.mbox &&

-- 
gitgitgadget

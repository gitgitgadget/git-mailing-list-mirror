Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672EC433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355000AbiDEVok (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454960AbiDEP70 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 11:59:26 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91781DA8E7
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:07:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x5so151127qvk.4
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fag1SafkPu++O99b/gO8ESEYqZ5vgwJFAssHblO3oQY=;
        b=owRCeHW06nsFQpxe7mQNvAvYvd6A1v/DMURL5GhgJiKcHW/xgVhSdekGL9z9B2YzJ+
         j05nZgLPyXXiZwNi0USOoCPaua2ekDvllHZXU0plWwngz/mLqTdi60HRUYgTe2AxzyoJ
         l/eAsj6mLX1HoSgXk163cyexGp9FxmE3i4+cOcoHBVYUL8G4a9e/i4ujMwhpWD32DmMV
         Kqo7KHR20SZ1IBXQvVtmcFLDOOwDDJr/C4MfXeEenYmbsOQ+Tn/iomYR23OkH5pI2R4M
         Nv7yQdJqkZVAZzX6Fz0kVa/1vx6AEvybqBt3Bp5o1g4NBF/YI/jw0rW8LScXKr2M3m00
         3rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fag1SafkPu++O99b/gO8ESEYqZ5vgwJFAssHblO3oQY=;
        b=YZZCWVImj6bSulMoZyFjz3SInYA7F+pJa/BpMfNZ0XXNKY6GqO09MfUtvyKuSZsAVu
         2kNNBIXzpwb+bH9b/HPn3SqbIAL1HeL5bMhejkd36GQ2/0/0wWJUnQKqkuCx689YrDV8
         0sLSXZMssEhVSPxX9CHr9RKpfVN49A28a0ue1Hcqs288MKVoxRJbHE0CQwU2/FerVjuX
         pIGyq321h91sV3+c2nDXXp1rbOkjdsQthQExKGLcbNcp19RopZR7wUhf4wD3zpWxFdxr
         qd3/Bwm42cFDO7NM8BwBhelQv+DNGH5B+85JJXNeDLj+Wn064T+FIwhjVwUaaF26NXpL
         CZUA==
X-Gm-Message-State: AOAM530SLZ4YQcm6cOp7RjOlCu0LJGVb+phrnVynwHihw7SZrG0/9yxH
        JxyWsX5fODTsf82aVUmdFNs=
X-Google-Smtp-Source: ABdhPJzYitZrKCod0LprINlunGUCK5VjOg0DQ0DAjW4mUR0pMxPKm/bq3hulZqwMMNBVHMAvFyGm8Q==
X-Received: by 2002:ad4:5ca3:0:b0:440:f131:a7a4 with SMTP id q3-20020ad45ca3000000b00440f131a7a4mr3117214qvh.16.1649171232009;
        Tue, 05 Apr 2022 08:07:12 -0700 (PDT)
Received: from e4a2938d721e.us-east4-c.c.codatalab-user-runtimes.internal (42.11.86.34.bc.googleusercontent.com. [34.86.11.42])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm9465508qkp.110.2022.04.05.08.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:07:11 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     khalid.masum.92@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
        gitster@pobox.com, khalidmasum@iut-dhaka.edu
Subject: [PATCH v4 0/1][GSoC] t3501: remove test -f and stop ignoring git <cmd> exit code
Date:   Tue,  5 Apr 2022 15:06:56 +0000
Message-Id: <20220405150657.19801-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402192415.19023-1-khalid.masum.92@gmail.com>
References: <20220402192415.19023-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending this email because the previous email did not seem to reach 
gitgitgadget's PR and the mailing list.

T3501 contains two test cases where we used to check if a file exists using
test -f which is not necessary because we already have helper function for
it. In fact in one test case test -f is redundant because we grep right
after it. Also the use of git rev-parse can cause segfault.

This patch tries to resolve these two issues in T3501.

Khalid Masum (1):
  t3501: remove test -f and stop ignoring git <cmd> exit code

 t/t3501-revert-cherry-pick.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Range-diff against v3:
1:  aeb28e3249 ! 1:  1090429b86 t3501: remove redundant file check and stop ignoring git <cmd> exit code
    @@
      ## Metadata ##
    -Author: Labnann <khalid.masum.92@gmail.com>
    +Author: Khalid Masum <khalid.masum.92@gmail.com>
     
      ## Commit message ##
    -    t3501: remove redundant file check and stop ignoring git <cmd> exit code
    +    t3501: remove test -f and stop ignoring git <cmd> exit code
     
         In the test 'cherry-pick after renaming branch', stop checking for
         the presence of a file (opos) because we are going to "grep" in it in
    @@ Commit message
     
         In the test 'revert after renaming branch', instead of allowing any
         random contents as long as a known phrase is not there in it, we can
    -    expect the exact outcome---after the successful revert of
    -    "added", the contents of file "spoo" should become identical to
    -    what was in file "oops" in the "initial" commit.
    +    expect the exact outcome---after the successful revert of "added", the
    +    contents of file "spoo" should become identical to what was in file
    +    "oops" in the "initial" commit. This test also contains 'test -f' that
    +    verifies presence of a file, but we have a helper function to do the same
    +    thing. Replace it with appropriate helper function 'test_path_is_file'
    +    for better readability and better error messages.
     
    -    In both tests, we would not notice when "git rev-parse" starts
    -    segfaulting without emitting any output.  The 'test' command would
    -    end up being just "test =", which yields success. Therefore we could
    -    use test_cmp_rev
    +    In both tests, we will not notice when "git rev-parse" starts segfaulting
    +    without emitting any output.  The 'test' command will end up being just
    +    "test =", which yields success. Use the 'test_cmp_rev' helper to make
    +    sure we will notice such a breakage.
     
    -    Signed-off-by: Labnann <khalid.masum.92@gmail.com>
    +    Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
     
      ## t/t3501-revert-cherry-pick.sh ##
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick after renaming branch' '
    @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'revert after renaming branch
     -	test -f spoo &&
     -	! grep "Add extra line at the end" spoo &&
     +	test_cmp_rev rename1 HEAD^ &&
    ++	test_path_is_file spoo &&
     +	test_cmp_rev initial:oops HEAD:spoo &&
      	git reflog -1 | grep revert
      
-- 
2.35.1.windows.2


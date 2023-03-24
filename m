Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87454C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCXUym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCXUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4E5FF9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id er18so1445136edb.9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSA6KYrWFKgHYNQX6EFGe0twO/V5FDcJgYwqDkLjWf8=;
        b=fCbIdC2er8+gH7YBMOsC9gDtiElcfyajTGogCLZ3IBNXN4Lpw2pbc88jYwYNIbUCSa
         DSZsBti9iKG0+WdBu/AaR3L1+RGkSce7SrsyMxtjNCfVaubNl2unOD/lG2SaTj2Zt2py
         /E676n4IC6jCRbnvqQ/DqDNAMbs/gH2e8qYXAqmFjHnGhxGcjMvP7Sck5XhvOs34Tn4+
         Y9F0tb0ftB4d9wLgVft3u6wP3OeRYXYaKV8GLgQIJVpdk0Wv997Wj7hcqHCmkgjlkmzt
         O7wgUNZKDOaKPWyYTQG4Ewk0jOr/iSYBUnPRkuyp3Qwsy/YsBcIifWOykfbUXEsESWGW
         bB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSA6KYrWFKgHYNQX6EFGe0twO/V5FDcJgYwqDkLjWf8=;
        b=Uq4zj+p1az9NuYvx9SELQbuG9rdKHlCq56NbXI4a/eE7SQU2gOJywKZ7srFfZqY0HH
         0rZQEECN6F7kqDcHyouCGsCuVXnHFMrvHh0u8My22mYUfHDy96dMZtB67CjPXDxYbnG6
         giIXuAUmdH46zHU3aShjN68+CA+Uj5WME+4YuVzr27WnINzpZ3YRrygPK9JVJcCvNnTu
         GZO1wWq4EVEt33ZCyRo/AZ8vIazE4SFSsV6PReKzAXh0BXlbhX8d4UZ/7fH/URXM66af
         drFv5Hztu/pPux6yw344i3SkRtZhdx866gguFa+wDSBsko3CB+kZlUGAi6AG/F8hK7WB
         5DFA==
X-Gm-Message-State: AAQBX9dKCwn3U34YByMwbsQ1IA9i4aO3HE9N8gnbx02YDOFtX/LvQMs8
        Ue3VsNvyEZQ20ooxAKkpVAxZqTq2+NWTOg==
X-Google-Smtp-Source: AKy350a2jlXEQ4oOkBAVZ58VaPVBEUKDKk5aQ3fZxAgNmbBkjTjVYzZ+CdtYWsnrZcSQtU8kYbnD/g==
X-Received: by 2002:aa7:db59:0:b0:4fa:7fd8:8f6a with SMTP id n25-20020aa7db59000000b004fa7fd88f6amr3765959edt.38.1679691276982;
        Fri, 24 Mar 2023 13:54:36 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:36 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 0/7] t: fix unused files, part 1
Date:   Fri, 24 Mar 2023 21:54:27 +0100
Message-Id: <20230324205434.93754-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I messed up when sending v2 (incorrectly used format-patch with --in-reply-to),
and v2 didn't get any response.  So here's v3 which is just a resend of v2.

Original cover letter is at
  https://lore.kernel.org/git/20230312201520.370234-1-rybak.a.v@gmail.com/T/#m63071efd1e2f876fdcbd0c384130b0ec7859f885

Changes since v1 address Junio's review:

  - just don't redirect output of mktree in patch 3/7
    Cf. https://lore.kernel.org/git/20230312201520.370234-1-rybak.a.v@gmail.com/T/#m0c7b88dcf0af59f65262c00f30dee353170c3b2e
  - rewritten commit message of patch 6/7, where I'd completely misunderstood
    the code of the tests.
    Cf. https://lore.kernel.org/git/20230312201520.370234-1-rybak.a.v@gmail.com/T/#m65f0666a8e94a1d44434dab58ee7002491b13df0

Range diff:

1:  017f1d8173 = 1:  59a868c0b8 t1005: assert output of ls-files
2:  7a75864e00 = 2:  a3514687ad t1006: assert error output of cat-file
3:  e23a16e560 ! 3:  4cb07fa965 t1010: assert empty output of mktree
    @@ Metadata
     Author: Andrei Rybak <rybak.a.v@gmail.com>

      ## Commit message ##
    -    t1010: assert empty output of mktree
    +    t1010: don't create unused files

         Builtin "git mktree" writes the the object name of the tree object built
         to the standard output.  Tests 'mktree refuses to read ls-tree -r output
    @@ Commit message
         "t1010-mktree.sh" redirect output of "git mktree" to a file, but don't
         use its contents in assertions.

    -    Assert that the output of "git mktree" is empty when it refuses to build
    -    a tree object.
    +    Don't redirect output of "git mktree" to file "actual" in tests that
    +    assert that an invocation of "git mktree" must fail.
    +
    +    Output of "git mktree" is empty when it refuses to build a tree object.
    +    So, alternatively, the test could assert that the output is empty.
    +    However, there isn't a good reason for the user to expect the command to
    +    be silent in such cases, so we shouldn't enforce it.  The user shouldn't
    +    use the output of a failing command anyway.

         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

    @@ t/t1010-mktree.sh: test_expect_success 'allow missing object with --missing' '

      test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
     -  test_must_fail git mktree <all >actual
    -+  test_must_fail git mktree <all >actual &&
    -+  test_must_be_empty actual
    ++  test_must_fail git mktree <all
      '

      test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
     -  test_must_fail git mktree <all.withsub >actual
    -+  test_must_fail git mktree <all.withsub >actual &&
    -+  test_must_be_empty actual
    ++  test_must_fail git mktree <all.withsub
      '

      test_done
4:  462cfa7025 = 4:  1ed6030a4f t1302: don't create unused file
5:  9fa04e479c = 5:  002942d81c t1400: assert output of update-ref
6:  e79566cc32 ! 6:  2e3446fc2f t1404: don't create unused file
    @@ Commit message

         Some tests in file t1404-update-ref-errors.sh create file "unchanged" as
         the expected side for a test_cmp assertion at the end of the test for
    -    output of "git for-each-ref".  The filename conveys the expectation that
    -    the output won't change between two invocations of "git for-each-ref".
    +    output of "git for-each-ref".  Test 'no bogus intermediate values during
    +    delete' also creates a file named "unchanged" using "git for-each-ref".
    +    However, the file isn't used for any assertions in the test.  Instead,
    +    "git rev-parse" is used to compare the reference with variable $D.

    -    Test 'no bogus intermediate values during delete' also creates a file
    -    named "unchanged".  However, in this test the reference is being
    -    deleted, i.e. it _does change_.  The file itself isn't used for any
    -    assertions in the test.
    -
    -    Don't create the unused and slightly misleading file "unchanged".
    +    Don't create unused file "unchanged" in test 'no bogus intermediate
    +    values during delete' of t1404-update-ref-errors.sh.

         Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>

7:  5a7df840a8 = 7:  e11a7d8e02 t1507: assert output of rev-parse

Andrei Rybak (7):
  t1005: assert output of ls-files
  t1006: assert error output of cat-file
  t1010: don't create unused files
  t1302: don't create unused file
  t1400: assert output of update-ref
  t1404: don't create unused file
  t1507: assert output of rev-parse

 t/t1005-read-tree-reset.sh    | 15 ++++++++++-----
 t/t1006-cat-file.sh           |  3 ++-
 t/t1010-mktree.sh             |  4 ++--
 t/t1302-repo-version.sh       |  2 +-
 t/t1400-update-ref.sh         |  3 +++
 t/t1404-update-ref-errors.sh  |  1 -
 t/t1507-rev-parse-upstream.sh |  6 ++++--
 7 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.40.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A14C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 03:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbiBHDZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiBHDZR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 22:25:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BBC043188
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 19:25:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y7so7464111plp.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 19:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRSJMFb8FsaKMsEIVFssvIkoJJHginq4opmmCUNv+7k=;
        b=FeOk++vCraF8WB+YFHI+iTnfGU4eytf/weN0TmQAqDhholI21syLrEOxm/KJoIGIyw
         8WtcwTALIlf5Y7QFp/j1n9VfFNvt4EzdyMgL7OX6Clp0xru6Oe6QSk63pzDcMBGw8KUh
         1TBIWi4eriCzwmyViOihFK4bnu1lyflCeq3DvbjXn7rz8rYHtbhUGcEXmdsSpXfKYVhF
         LwUZVxnfJE+kFHfJ0tSmfQCvrsifcnfE+T6NNfWGpKvf5FAUAhBJ8qs7L5mFw0vWh7Ny
         gU9KLj4kvY2yS8lAOT8WXw59ljznoH2i+GUoUpkVSXCMTcnUon5iGMPDhWKI9t4BCMGz
         OfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRSJMFb8FsaKMsEIVFssvIkoJJHginq4opmmCUNv+7k=;
        b=dC4YdgIKtM9yyplC+Ma+wbXrULbbJZ8ug9CGSVNotJY6e9mutoQ6TwMccTYdXOPuGr
         oW4wXtlyM96OVoSfofuVi73NPfwD47jk297fZafwce2IzXxKRl3yC54+Ti+NCfdbb8Wy
         mHrjtbP1nMzgAlr4oLDI1G1tvI4O2puCmSo2eS62qqO+OeLOrkcoLOWOvmlurHp7WFlm
         bbZCUbDneIRjFt8I/IEyvIoqsaNx6sRkDxtebzZuM0Ohx51cyG2pmq3qauUML4+KvpG4
         SO7gpjst7BFpNAIgnttyGatH7+va4N6OEGym3lII5Nlfest8F8Xk1KIqO8pSEKLMqVKk
         0osQ==
X-Gm-Message-State: AOAM532CHTtIO0gDupQsQzCtuqY04nYUQXnjy2WlP9ODINnvbS7QcUE+
        Sr9Wz/2kFyfQLU6ea6aEptg=
X-Google-Smtp-Source: ABdhPJzCK5sVTlTlYEIim1ADHkrALtnagscufQcidnxEyu0u9uTHcoprUqAulPxjB1qWEFuas87MTQ==
X-Received: by 2002:a17:90b:4d92:: with SMTP id oj18mr2197799pjb.236.1644290715247;
        Mon, 07 Feb 2022 19:25:15 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.108])
        by smtp.gmail.com with ESMTPSA id o21sm9571707pgl.19.2022.02.07.19.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:25:14 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 0/2] t/lib-read-tree-m-3way: modernize a test script
Date:   Tue,  8 Feb 2022 11:24:48 +0800
Message-Id: <20220208032450.46604-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Basic Summary ==

Modernize the test script t/lib-read-tree-m-3way.

Shaoxuan Yuan (2):
  t/lib-read-tree-m-3way: modernize style
  t/lib-read-tree-m-3way: indent with tabs

 t/lib-read-tree-m-3way.sh | 168 +++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

Range-diff against v3:
1:  72323a7a57 ! 1:  6cbca771e5 t/lib-read-tree-m-3way: modernize style
    @@ Metadata
      ## Commit message ##
         t/lib-read-tree-m-3way: modernize style
     
    -    Many invocations of the test_expect_success command in this
    +    Many invocations of the test commands (e.g. test_expect_success
    +    or test_expect_failure) in this
         file are written in old style where the command, an optional
    -    prerequisite, and the test title are written on separate
    -    lines, and the executable script string begins on its own
    -    line, and these lines are pasted together with backslashes
    -    as necessary.
    +    prerequisite, the test title, and the executable script string
    +    are written on separate lines, with the executable script string
    +    begins on its own line, and these lines are pasted together
    +    with backslashes as necessary.
     
    -    An invocation of the test_expect_success command in modern
    +    An invocation of the test command in modern
         test scripts however writes the prerequisite and the title
    -    on the same line as the test_expect_success command itself,
    +    on the same line as the test command itself,
         and ends the line with a single quote that begins the
         executable script string.
     
    +    It is worth notice that albeit all executable script strings
    +    are changed to use single quotes (for modern style uniformity),
    +    some of the test titles are kept untouched, e.g.
    +
    +    -       test_expect_success \
    +    -           "adding test file $p and Z/$p" \
    +    -           'git update-index --add $p &&
    +    -           git update-index --add Z/$p'
    +    +       test_expect_success "adding test file $p and Z/$p" '
    +    +           git update-index --add $p &&
    +    +           git update-index --add Z/$p
    +    +    '
    +
    +    see the "adding test file $p and Z/$p" part.
    +
    +    This is because the test title is simply echo'd/print'd, and
    +    double quotes are necessary for "$p" interpolation; however,
    +    the test body (executable script string) gets eval'd, and
    +    single quotes are acceptable in this case.
    +
         Update the style for uniformity.
     
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
2:  477b71497f ! 2:  e5d89ca1de t/lib-read-tree-m-3way: indent with tabs
    @@ Commit message
         t/lib-read-tree-m-3way: indent with tabs
     
         As Documentation/CodingGuidelines says, our shell scripts
    -    (including tests) are to use HT for indentation, but this script
    -    uses 4-column indent with SP. Fix this.
    +    (including tests) are to use tabs for indentation, but this script
    +    uses 4-column indent with space. Fix this.
     
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
-- 
2.35.1


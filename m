Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997D5C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8436135E
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 05:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhKKFWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 00:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhKKFWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 00:22:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155DC061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so7781746wrb.3
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 21:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ms+h3MFroDfdUZZx2p3idIa1svJuR65vPMBjCwCYbDs=;
        b=VVT4WBPc9Tzlf/szDdWbCZQnn0GUyU99c2J/jlGLzoX2V/mSpLZplWDepduH2HM0k7
         ddCV/UofBDacKq8OxFb9lcAODa/FWdzSmvsjoshwdfOZ51j2FGdo4Fzwlw+XinEgbMTm
         HvmhTfDTvvhZyzaGIcXwja/jkFuJ463usBd+oiKELm8VQLDirIaqsgmBd1K/+NH9MXCO
         QJoVx7n7gFr+xttU6wIvcUcyzwuCd7xiA3dz2CB8n7MUfK+C4fsLn0QFd4nbtzKqSrKi
         jRxAkAIa0JSUswZPg+vOE13DvBYdxlV+i/sfv8MRbYrJ4uMqtEeU2k4qiUA4gH7rGcD9
         26Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ms+h3MFroDfdUZZx2p3idIa1svJuR65vPMBjCwCYbDs=;
        b=tpMwfmCwEwFZsixpJzGF+Fwj6mnnvrKCbbxQ4ozD2Ci45udiCgQJrBG719CRooRwJi
         qzI+m9dw6ZKmQRJHwPmMyr7VlFL1gqfkhYBlQF7zOhb+iQiS1uhuThst6wilOlwPou0t
         v6b01yKtZE7/kcCmO5zmjCUkHhDGsx4NKWup9ucgoGQQsJl6nA8pXKsLPV0eeq7XkfS6
         y/gnYR8m7MfXpxtJ7KfjKJpo1BvSLDmAyUqAgSdV9b1yGAv1yjXxNthWlrNWuynwZPkl
         3CIyZGgfsaIRWlf5MYtwNhr9LFj1lTbY/a5NBmSuiRRDrFlEuS7AGap4lFvxqrnqNoVm
         yDbw==
X-Gm-Message-State: AOAM532YfwYk0vNgv30v+24Q6EkKRYv5u7S8NXS7tCZ3GoE/wfkgNQ7j
        Dfl5QDj2GYNzPdFk0TQ/FrMijZSzvIbe0IFy
X-Google-Smtp-Source: ABdhPJwVuApGQ46wno1riz3kyLRmPY7pI+jZYutWWlBoz7nit2eVkXxpLLMoXVgkujdSHWSKRyecxQ==
X-Received: by 2002:a5d:64c3:: with SMTP id f3mr5475311wri.321.1636607973130;
        Wed, 10 Nov 2021 21:19:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1845391wrg.1.2021.11.10.21.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 21:19:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] object-file: fix SEGV on free() regression in v2.34.0-rc2
Date:   Thu, 11 Nov 2021 06:18:55 +0100
Message-Id: <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com> <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression introduced in my 96e41f58fe1 (fsck: report invalid
object type-path combinations, 2021-10-01). When fsck-ing blobs larger
than core.bigFileThreshold we'd free() a pointer to uninitialized
memory.

This issue would have been caught by SANITIZE=address, but since it
involves core.bigFileThreshold none of the existing tests in our test
suite covered it.

Running them with the "big_file_threshold" in "environment.c" changed
to say "6" would have shown this failure, but let's add a dedicated
test for this scenario based on Han Xin's report[1].

It would be a good follow-up change to add a GIT_TEST_* mode to run
all the tests with a low core.bigFileThreshold threshold.

Currently a lot of them fail (but none due to SANITIZE=address)
because they make implicit assumptions about the current hardcoded
setting of core.bigFileThreshold.

Around half the failures are due to us assuming that files larger than
that are binary, see 6bf3b813486 (diff --stat: mark any file larger
than core.bigfilethreshold binary, 2014-08-16) and the comment added
in 12426e114b2 (diff: do not short-cut CHECK_SIZE_ONLY check in
diff_populate_filespec(), 2017-03-01). The rest seem to all be
pack/loose-related, i.e. they're assuming that something ends up as a
loose object or in a pack.

The bug was introduced between v9 and v10[2] of the fsck series merged
in 061a21d36d8 (Merge branch 'ab/fsck-unexpected-type', 2021-10-25).

1. https://lore.kernel.org/git/20211111030302.75694-1-hanxin.hx@alibaba-inc.com/
2. https://lore.kernel.org/git/cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com/

Reported-by: Han Xin <chiyutianyi@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c    | 2 ++
 t/t1050-large.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/object-file.c b/object-file.c
index 02b79702748..ac476653a06 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2528,6 +2528,8 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
+	*contents = NULL;
+
 	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 4bab6a513c5..6bc1d76fb10 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -17,6 +17,14 @@ test_expect_success setup '
 	export GIT_ALLOC_LIMIT
 '
 
+test_expect_success 'enter "large" codepath, with small core.bigFileThreshold' '
+	test_when_finished "rm -rf repo" &&
+
+	git init --bare repo &&
+	echo large | git -C repo hash-object -w --stdin &&
+	git -C repo -c core.bigfilethreshold=4 fsck
+'
+
 # add a large file with different settings
 while read expect config
 do
-- 
2.34.0.rc2.795.g926201d1cc8


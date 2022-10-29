Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7E6FA3743
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 10:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJ2KZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2KZM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 06:25:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EEA39120
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h2so6869610pgp.4
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vnw+yu47pUpRkNybVenApXxwcACinShRJ8uY/mgaIU=;
        b=irU69g5Yq6nR93Vjgs1pkp+xqPfLEo3rlkG8L6K9nVSeW60MqqpA7Pk7gn18v+mUA5
         hK96Hq/+wO+xydLUpIBfyislD0fmWTINK7lulLaqQrDbFuv+x17sSTwmZbKj9w9qCYxI
         2dgoEaliJrkzZvMN89Z9GH/X7ugiiLOijBUwMkZjv/PnMSPHyK2OjJF4pJYB0AmwqwrJ
         G9XzijSlkqyblCWWI2NTIa23Zkh9BDzKZIW6cZC4/P2m9ZYSwwRiB7BwCXMLix9qGBNu
         LJe1MFT1KDElHqAUOL21AmytyvXuy95IKBxmzeLbZHf6WH1F0W9wOxFLl4GfG6P6oPoS
         kw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vnw+yu47pUpRkNybVenApXxwcACinShRJ8uY/mgaIU=;
        b=wvgu8w0jZC3Z/XDwmB8VnV+3XvkRI8F9H/2NkP+nn+q10y1GQDzJmKmDjtoU7R+oZ8
         a2aQTx+9LxhEX+30nH2y91ptP48IbWRoV0CZ8Q51jc2DIpNXrEVqE72DiMsQAT4X+XP7
         MLc2zyIrShpqD5Rc8ZBO+m+e/ykUdpYGQptZFYsIPez11iB9Y58p3OoAKXlFa7pztc3S
         8VRGyHok+GnCUlgxOgp2SUMRkRJ05s6865GY/qadMH6mLGphRDtcgQuqtK4FJjGBDwL8
         hkWA6WJdHwbvLhXs9aRenncAhbecZaT7jS10qRkeXjBXi6AmY+ubcQhZj7/N34Cat59K
         eoPw==
X-Gm-Message-State: ACrzQf0Iwd8oj6NL06B2FBI1rMDk+SKOnteA9hcKJo0lGJu5C3InG3bT
        XvtbgsFADAaRbM4OfYIEqpYcG3lEIXXx8JOp
X-Google-Smtp-Source: AMsMyM4aAWsYB+pD22Gb1tW2pWUzFFmgXtyTNNaSgWPKRq4aQtYSPtnqpokMkoOqTOZQ+wJXvLgnDQ==
X-Received: by 2002:a63:c104:0:b0:459:c6a1:15c0 with SMTP id w4-20020a63c104000000b00459c6a115c0mr3384335pgf.588.1667039109271;
        Sat, 29 Oct 2022 03:25:09 -0700 (PDT)
Received: from HB2.. ([223.190.251.111])
        by smtp.gmail.com with ESMTPSA id e10-20020aa798ca000000b0056286c552ecsm902449pfm.184.2022.10.29.03.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 03:25:08 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/2] Add mailmap mechanism in cat-file options
Date:   Sat, 29 Oct 2022 15:54:57 +0530
Message-Id: <20221029102459.82428-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.282.g2e87897fbb
In-Reply-To: <20220916205946.178925-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot Avar for the review :) I have made the suggested changes.

= Description

At present, `git-cat-file` command with `--batch-check` and `-s` options
does not complain when `--use-mailmap` option is given. The latter
option is just ignored. Instead, for commit/tag objects, the command
should compute the size of the object after replacing the idents and
report it. So, this patch series makes `-s` and `--batch-check` options
of `git-cat-file` honor mailmap when used with `--use-mailmap` option.

In this patch series we didn't want to change that '%(objectsize)'
always shows the size of the original object even when `--use-mailmap`
is set because first we have the long term plan to unify how the formats
for `git cat-file` and other commands works. And second existing formats
like the "pretty formats" used bt `git log` have different options for
fields respecting mailmap or not respecting it (%an is for author name
while %aN for author name respecting mailmap).

I would like to thank my mentors, Christian Couder and John Cai, for all
of their help!
Looking forward to the reviews!

= Patch Organization

- The first patch makes `-s` option to return updated size of the
  <commit/tag> object, when combined with `--use-mailmap` option, after
  replacing the idents using the mailmap mechanism.
- The second patch makes `--batch-check` option to return updated size of
  the <commit/tag> object, when combined with `--use-mailmap` option,
  after replacing the idents using the mailmap mechanism.

= Changes in v2:

- The commit messages of both the patches have been improved.
- In the second patch, we were populating the `contentp` field of the
  `object_info` structure when `--batch-check` was combined with
  `--use-mailmap`. Which made us read the contents of tree and blob
  object types as well, which affected the performance. We should only
  be reading the contents for commit or tag object types. The second
  patch has been updated to do just that.

= Changes in v3:

- Make the tests a bit more self documenting by running commands in test
  without using mailmap flag.
- In the first patch added the test for tag objects as well.

Siddharth Asthana (2):
  cat-file: add mailmap support to -s option
  cat-file: add mailmap support to --batch-check option

 Documentation/git-cat-file.txt |  6 +++-
 builtin/cat-file.c             | 27 ++++++++++++++++
 t/t4203-mailmap.sh             | 59 ++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

Range-diff against v2:
-:  ---------- > 1:  4b0231504b cat-file: add mailmap support to -s option
1:  0e142beb2b ! 2:  2e87897fbb cat-file: add mailmap support to --batch-check option
    @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
      	strbuf_reset(scratch);
     
      ## t/t4203-mailmap.sh ##
    -@@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
    +@@ t/t4203-mailmap.sh: test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
      	test_cmp expect actual
      '
      
     +test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
     +	test_when_finished "rm .mailmap" &&
    -+	cat >.mailmap <<-EOF &&
    ++	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
    ++	cat >expect <<-\EOF &&
    ++	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
    ++	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
    ++	EOF
     +	echo "HEAD" >in &&
    -+	git cat-file --use-mailmap --batch-check <in >actual &&
    ++	git cat-file --batch-check <in >actual &&
    ++	git cat-file --use-mailmap --batch-check <in >>actual &&
     +	test_cmp expect actual
     +'
     +
     +test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
     +	test_when_finished "rm .mailmap" &&
    -+	cat >.mailmap <<-EOF &&
    ++	cat >.mailmap <<-\EOF &&
     +	C O Mitter <committer@example.com> Orig <orig@example.com>
     +	EOF
    -+	echo "92d99959b011b1cd69fe7be5315d6732fe302575 commit 220" >expect &&
    ++	cat >expect <<-\EOF &&
    ++	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
    ++	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
    ++	EOF
     +	echo "info HEAD" >in &&
    -+	git cat-file --use-mailmap --batch-command <in >actual &&
    ++	git cat-file --batch-command <in >actual &&
    ++	git cat-file --use-mailmap --batch-command <in >>actual &&
     +	test_cmp expect actual
     +'
     +
2:  e95cbd7932 < -:  ---------- Add Test
-- 
2.38.1.282.g2e87897fbb


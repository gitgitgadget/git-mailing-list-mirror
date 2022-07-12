Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA8C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiGLQHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiGLQGw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:06:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925CCAF23
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:06:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso11933752pjc.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4smoM5IS9sKj85Y/s/3hX7g+RPVXasmSklS4E1Bgg0k=;
        b=B/wUui39WwCkmXx1GCa9MSJGhQ7N3ZRT9M0wniUt2CVuqyyMXinz9KSPF2sxHxY58E
         TgTkqUmAfI7rrhjQF2A28llWA/EBzDJy1bUsEm8SFp7vXnom+tCSInZOGHrzRUBYubIT
         1nwjCb+jOK0mNGGlm96fJ8mf91MZ01g6toTuzYgoSDU3FZNZJhyp6cpMeImpMyPt0vyj
         eG15VeqRm0IFksLAU9TYJP1TlXN8v1Lx8LyWGPUGrq5ONSkhhOHse0Zdd8HjPZ8YYwop
         EzboXM/Tpaeg7fJw0uT2V8fRk3CEBDK9g9pI94Flhsn6LIF93YwoGtqbzYhDwF1ayot6
         LArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4smoM5IS9sKj85Y/s/3hX7g+RPVXasmSklS4E1Bgg0k=;
        b=Gy6GES9YQ+eixwr1Vw7DWazEAAJkUAvjvELnSUjaMZKFeaTPLuaD5euY3M6ogbxnBT
         yBxS6k5AVfBs9xyc359GEOL0HDrUDuE7lrbXAFJEsYaTpXja1RSzowcghPPzFzKL+3L+
         mtfu+zrIV6NJe148vcWEP24EOnN8G4aCju4tNqKSWDNLE1AoohlckyGd7ZZ+atukyRsl
         WUDf2fJEsW8MbybWSgHEdbaYroB7JnleI4uQEyA3czmJyHPv1eC7R1SJv5x19TYi3Ans
         r/3duoWDb7AlGOHO/r04UZBYIxly4J9w0be0F6zAMXReJpjz6Qvv9XGY2XmR3fX1+0T0
         PPmg==
X-Gm-Message-State: AJIora/P/SjPNj7DsR324AxljyYZErqIXIjTJr6wkLOgR3qspsReLpmO
        DX7wZIPUW8YOHPmTi5q8UwvCm0oO/hPjYX5G
X-Google-Smtp-Source: AGRyM1sLgwbIdbK7yVJD5lu7amiUHlpeGxvHGnTMipaUCg+At84fwEDpluYPw8HOul+8e/oaZ2uhSQ==
X-Received: by 2002:a17:90a:9f01:b0:1ef:76bd:e46c with SMTP id n1-20020a17090a9f0100b001ef76bde46cmr5118373pjp.197.1657642004715;
        Tue, 12 Jul 2022 09:06:44 -0700 (PDT)
Received: from HB2.. ([223.230.62.254])
        by smtp.gmail.com with ESMTPSA id u188-20020a6260c5000000b0050dc7628183sm7232376pfb.93.2022.07.12.09.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:06:43 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, congdanhqx@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, johncai86@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 0/4] Add support for mailmap in cat-file
Date:   Tue, 12 Jul 2022 21:36:30 +0530
Message-Id: <20220712160634.213956-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.37.0.6.g69b7ad898b
In-Reply-To: <20220709154149.165524-1-siddharthasthana31@gmail.com>
References: <20220709154149.165524-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for helping me fix the broken test Johannes and Junio! :D

= Description

This patch series adds mailmap support to the git-cat-file command. It
adds the mailmap support only for the commit and tag objects by
replacing the idents for "author", "committer" and "tagger" headers. The
mailmap only takes effect when --[no-]-use-mailmap or --[no-]-mailmap
option is passed to the git cat-file command. The changes will work with
the batch mode as well.

So, if one wants to enable mailmap they can use either of the following
commands:
$ git cat-file --use-mailmap -p <object>
$ git cat-file --use-mailmap <type> <object>

To use it in the batch mode, one can use the following command:
$ git cat-file --use-mailmap --batch

= Patch Organization

- The first patch improves the commit_rewrite_person() by restricting it 
  to traverse only through the header part of the commit object buffer.
  It also adds an argument called headers which the callers can pass. 
  The function will replace idents only on these  passed headers. 
  Thus, the caller won't have to make repeated calls to the function.
- The second patch moves commit_rewrite_person() to ident.c to expose it
  as a public function so that it can be used to replace idents in the
  headers of desired objects.
- The third patch renames commit_rewrite_person() to a name which
  describes its functionality clearly. It is renamed to
  apply_mailmap_to_header().
- The last patch adds mailmap support to the git cat-file command. It
  adds the required documentation and tests as well.

Changes in v4:
- This patch series introduces new test cases for testing the mailmap
  mechanism in git-cat-file command. These tests rely on the side
  effects of the earlier test case `set up symlink tests`. However, that
  test case is guarded behind the `SYMLINKS` prereq, therefore it is not
  run e.g. on Windows. This caused the --use-mailmap tests to fail on 
  Windows. So, that has been fixed by removing the prereq from `set up`
  test case.
- The `set up symlink tests` has also been renamed to `prepare for
  symlink/--use-mailmap tests` to reflect its broadened responsibility.

Siddharth Asthana (4):
  revision: improve commit_rewrite_person()
  ident: move commit_rewrite_person() to ident.c
  ident: rename commit_rewrite_person() to apply_mailmap_to_header()
  cat-file: add mailmap support

 Documentation/git-cat-file.txt |  6 +++
 builtin/cat-file.c             | 43 +++++++++++++++++++-
 cache.h                        |  6 +++
 ident.c                        | 72 ++++++++++++++++++++++++++++++++++
 revision.c                     | 50 ++---------------------
 t/t4203-mailmap.sh             | 56 +++++++++++++++++++++++++-
 6 files changed, 184 insertions(+), 49 deletions(-)

Range-diff against v3:
1:  9e95326c58 = 1:  9e95326c58 revision: improve commit_rewrite_person()
2:  d9395cb8b2 = 2:  d9395cb8b2 ident: move commit_rewrite_person() to ident.c
3:  355bbda25e = 3:  355bbda25e ident: rename commit_rewrite_person() to apply_mailmap_to_header()
4:  69b7ad898b ! 4:  ac532965b4 cat-file: add mailmap support
    @@ Commit message
         cat-file command. It also adds --[no-]mailmap option as an alias to
         --[no-]use-mailmap.
     
    +    This patch also introduces new test cases to test the mailmap mechanism in
    +    git cat-file command.
    +
    +    The tests added in this patch series rely on the side effects of the earlier
    +    test case `set up symlink tests`. However, that test case is guarded behind the
    +    `SYMLINKS` prereq, therefore it is not run e.g. on Windows which can cause the
    +    added tests to fail on Windows. So, fix that by removing the prereq from the
    +    `set up` test case, and adjusting its title to reflect its broadened responsibility.
    +
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: John Cai <johncai86@gmail.com>
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
      		batch.all_objects = 1;
     
      ## t/t4203-mailmap.sh ##
    +@@ t/t4203-mailmap.sh: test_expect_success 'find top-level mailmap from subdir' '
    + 	test_cmp expect actual
    + '
    + 
    +-test_expect_success SYMLINKS 'set up symlink tests' '
    ++test_expect_success 'prepare for symlink/--use-mailmap tests' '
    + 	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
    + 	echo "New <new@example.com> <orig@example.com>" >map &&
    + 	rm -f .mailmap
     @@ t/t4203-mailmap.sh: test_expect_success SYMLINKS 'symlinks not respected in-tree' '
      	test_cmp expect actual
      '
-- 
2.37.0.6.g69b7ad898b


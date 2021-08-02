Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB54C4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118F2610FF
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhHBTBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHBTBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:01:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA5C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 12:01:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c18so17639085qke.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4dkkpNqDtgjBLZjR1SDlzyH3ulqDiYMu0XwHbwZLn0=;
        b=Rc7vtIgKmr4fbCAFbVbCDW07QBbX3mDFohvuXQSzJ7sTPVjW3aGwnoRGmfqrRovr4G
         ji9MFkwojE2aPvFCF9ZTBeCnNIHWIz0YX3GwgoyNuUKF9NApjWNT+x/CAela/xisssQR
         CsJVvPX6LBr/SUTLuYezLc6a7PkZtt3jYAgMrVsR5p3On78fPPxoiTmaeqB5cTN/T1US
         zUvT76QtHRoJZlKWE5NyOPRVO19OArnjVQJwy85YEU+a3VMZ3d8RzVCXRkzh7ppy1Fjx
         oumRFalO5nSrXfKPLw5JhAmDBsSGdYovfMNlfKVr4ZQFRgdTk1Wm6xkXOFoicSpByaw1
         9a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/4dkkpNqDtgjBLZjR1SDlzyH3ulqDiYMu0XwHbwZLn0=;
        b=WQv8dmPWgtqk5IeuhkuBj0AZcU1FpfcHJx+xvIlLc7NaCheNo0xECB8boh/1J5C9+O
         67KGxG8JkNajkFafA6TEKQOlPaMTTuvbEuYK9zHluSpABjplXocDut0lmL8zZShZA7cj
         jO9Ybs+gxSqKfo7LRTmCCjPr00MKnx7nCSZJSqU9tbQ0uWCmfkXq/z6yetki5fk8bdKT
         lMC7BoAA0kpoeYU8Zg6ixGOQfKn5ueURc/F24K1M7cdC/V8EkSrATYmkJ0dI19ijnmuo
         tZQVrxPwhIiFbvoJbzWEm2Pezf4HDZ+QQ2dBqi7gduwTgqm8r92SVcW4PKNSwg50tqwL
         ZwFg==
X-Gm-Message-State: AOAM532yN9fwmNxKwzVCMf+zBaIA2h4aKAMVTEV3rAspiqacni9lz3Nd
        mGaU64RbCzAeC1FVDd3ffZCvmF1TqxU=
X-Google-Smtp-Source: ABdhPJxBUu2b+wwyEc6xbDCzyEC8JVmgREgMxbhHVCq4DKf30RioQDh4Bjw5oSd8gCjEYjfiHgvxKw==
X-Received: by 2002:a05:620a:913:: with SMTP id v19mr16895770qkv.429.1627930891759;
        Mon, 02 Aug 2021 12:01:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b21sm4949885qtb.58.2021.08.02.12.01.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 12:01:31 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] hn/reftable "fixes" for OpenBSD
Date:   Mon,  2 Aug 2021 12:00:51 -0700
Message-Id: <20210802190054.58282-1-carenas@gmail.com>
X-Mailer: git-send-email 2.32.0.826.g286871f41a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While building "seen" in OpenBSD, noticed the following issues as part
of reftable support.

the first patch also affected Linux and was indeed one of the two reasons
for the failed CI runs of that branch, hence why it might be worth
squashing into the corresponding commit as the subject implies.

the second patch might be worth squashing as well, but neither address
the segfault in t0031.14 which manifests as :

  2d732e1 refs/heads/primary@{9}: commit (initial): number 1
  ++ grep 'commit: number 10' output
  357ed45 refs/heads/primary@{0}: commit: number 10
  ++ git gc
  error: reflog died of signal 11
  fatal: failed to run reflog
  error: last command exited with $?=128
  not ok 14 - reflog, repack

and that correspond to a call of `git reflog expire --all` with the
following backtrace :

  #0  hashmap_entry_init (hash=<optimized out>, e=0xbfba1384) at hashmap.h:317
  #1  hashmap_get_from_hash (keydata=0x0, hash=<optimized out>, map=0xa027208)
      at hashmap.h:378
  #2  oidmap_get (map=0xa027208, key=0x0) at oidmap.c:38
  #3  0x08202dae in do_lookup_replace_object (r=0x83fc180 <the_repo>, oid=0x0)
      at replace-object.c:76
  #4  0x081b59d3 in lookup_replace_object (oid=0x0, r=0x83fc180 <the_repo>)
      at replace-object.h:40
  #5  parse_object (r=0x83fc180 <the_repo>, oid=0x0) at object.c:271
  #6  0x08134e87 in lookup_commit_reference_gently (r=0x83fc180 <the_repo>,
      oid=0x0, quiet=1) at commit.c:35
  #7  0x080d6e39 in reflog_expiry_prepare (
      refname=0xa026fb4 "refs/heads/primary", oid=0x0, cb_data=0xbfba161c)
      at builtin/reflog.c:363
  #8  0x081f9325 in git_reftable_reflog_expire (ref_store=0xa026c40,
      refname=0xa026fb4 "refs/heads/primary", oid=0x0, flags=0,
      prepare_fn=0x80d6c80 <reflog_expiry_prepare>,
      should_prune_fn=0x80d72b0 <should_expire_reflog_ent>,
      cleanup_fn=0x80d6990 <reflog_expiry_cleanup>, policy_cb_data=0xbfba161c)
      at refs/reftable-backend.c:1511
  #9  0x081ef820 in refs_reflog_expire (policy_cb_data=0xbfba161c,
      cleanup_fn=0x80d6990 <reflog_expiry_cleanup>,
      should_prune_fn=0x80d72b0 <should_expire_reflog_ent>,
      prepare_fn=0x80d6c80 <reflog_expiry_prepare>, flags=0, oid=0x0,
      refname=0xa026fb4 "refs/heads/primary", refs=<optimized out>)
      at refs.c:2408
  #10 reflog_expire (refname=0xa026fb4 "refs/heads/primary", oid=0x0, flags=0,
      prepare_fn=0x80d6c80 <reflog_expiry_prepare>,
      should_prune_fn=0x80d72b0 <should_expire_reflog_ent>,
      cleanup_fn=0x80d6990 <reflog_expiry_cleanup>, policy_cb_data=0xbfba161c)
      at refs.c:2420
  #11 0x080d786f in cmd_reflog_expire (argc=<optimized out>,
      argv=<optimized out>, prefix=<optimized out>) at builtin/reflog.c:634
  #12 0x0804e9fb in run_builtin (argv=<optimized out>, argc=<optimized out>,
      p=<optimized out>) at git.c:461
  #13 handle_builtin (argc=3, argv=argv@entry=0xbfba2208) at git.c:716
  #14 0x0804edcb in run_argv (argv=0xbfba1ffc, argcp=0xbfba20a0) at git.c:783
  #15 cmd_main (argc=3, argv=0xbfba2204) at git.c:914
  #16 0x0804d8dc in main (argc=4, argv=0xbfba2204) at common-main.c:52

Carlo Marcelo Arenas Belón (3):
  fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
  reftable: clarify zlib version dependency
  openbsd: allow reftable building with zlib 1.2.3

 Makefile         | 2 +-
 config.mak.uname | 1 +
 reftable/block.c | 4 +++-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.32.0.826.g286871f41a

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2DC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3B161266
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbhI1CUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbhI1CUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A15C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so3317109wrd.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bc+RugTa16YET+TZMKlZlEdRILwkJhUHqoeCVi+i+Ds=;
        b=puADbY7cyxu9h5WMSLAOz4q8JFwG3v9F2t7UnL5SFjdeUtB1mGTBzzh8K1JnQuVqO1
         J2uSzpXkdgkmRMdImb6dXrmiEgb/4j4mNsaagr60jv9FbowvTyewlRmnLq5uNttYEcdr
         cIlUe0b7Cu0GMZtUPRPXNpJBPTi6mjJo7ATxcSGJZVgo1pn53QezrAgKtfMr1yF8eq53
         WvtsdgQr1bk0G+fQsyVqAebIyt3IRV4EYJcCJ1p/ne94BHBoCYL2CTPKbARFtSeb2DHa
         wbsgQsfpboLSEcuUd7LLrekIeMf/XCp9GyamtH0uf1yQhZ0k80P4N9Z30RulMfzVSHZI
         PvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bc+RugTa16YET+TZMKlZlEdRILwkJhUHqoeCVi+i+Ds=;
        b=VewuDYFGMlCfTgM3ktbOiL2qRYp6EsyLaObVAYn2DWsS/eZ8yCOQwboMLiuieGkDHT
         wz5mOpvFicFpoyW1gOyC7wS1003xYoYgoY1jcCPz5ULuN953cFtj2s2KPBivClocKToF
         VIT9A83FQfDGzLmMuNjysZs7Xk503/P57siPWbTO2xl125F7DzbMxHNDoB8pw6VwuUB6
         6ADOo2guFJNMaG7z5ciJF3th5rdajzO2iQ5vkmoUINr+p6CIwEIrlu34E5vy07DDDmJS
         109ue7WwXPzFvcpvjLQvmynlYPT9RGl7XHbNM4e1NJLmz9sVJvcn5i1i9t8Mvr0xGj0Y
         pquQ==
X-Gm-Message-State: AOAM530TD8VBMdfufQ/QEWM8UD/1rRrUgImUfbkCg7aIxhVGi5M6xLwA
        tK/u8zwAi+t4hWDdxx8QWIXVO5LvEZ79zQ==
X-Google-Smtp-Source: ABdhPJwuRDRljbEY9w1j9S4L0izgbe5SnEX9JAymUFbiJyhvWKXaS+H5gKq6RtBMW2Yfbuo1mad8Zw==
X-Received: by 2002:a05:6000:1192:: with SMTP id g18mr3538208wrx.63.1632795540105;
        Mon, 27 Sep 2021 19:19:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:18:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 00/17] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Tue, 28 Sep 2021 04:18:41 +0200
Message-Id: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 16/17 and 17/17. To get there I've lib-ified more things
in object-file.c and the general object APIs, i.e. now we'll return
error codes instead of calling die() in these cases.

v6 of this got a very detailed review from Taylor Blau (thanks a
lot!), for the v6 see:
https://lore.kernel.org/git/cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com/

The v7 had a couple of trivial shellscripting issues, a typo'd
test_oid variable, and a warning on a "test" comparison. For v7 see
https://lore.kernel.org/git/cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (17):
  fsck tests: add test for fsck-ing an unknown type
  fsck tests: refactor one test to use a sub-repo
  fsck tests: test current hash/type mismatch behavior
  fsck tests: test for garbage appended to a loose object
  cat-file tests: move bogus_* variable declarations earlier
  cat-file tests: test for missing/bogus object with -t, -s and -p
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: make parse_loose_header_extended() public
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: use "enum" return type for unpack_loose_header()
  object-file.c: return ULHR_TOO_LONG on "header too long"
  object-file.c: stop dying in parse_loose_header()
  fsck: don't hard die on invalid object types
  fsck: report invalid object type-path combinations

 builtin/fast-export.c |   2 +-
 builtin/fsck.c        |  28 +++++-
 builtin/index-pack.c  |   2 +-
 builtin/mktag.c       |   3 +-
 cache.h               |  45 ++++++++-
 object-file.c         | 176 +++++++++++++++------------------
 object-store.h        |   7 +-
 object.c              |   4 +-
 pack-check.c          |   3 +-
 streaming.c           |  27 +++--
 t/oid-info/oid        |   2 +
 t/t1006-cat-file.sh   | 223 +++++++++++++++++++++++++++++++++++++++---
 t/t1450-fsck.sh       |  99 +++++++++++++++----
 13 files changed, 463 insertions(+), 158 deletions(-)

Range-diff against v7:
 1:  752cef556c2 =  1:  b999ab695d9 fsck tests: add test for fsck-ing an unknown type
 2:  612003bdd2c =  2:  e01c21378a4 fsck tests: refactor one test to use a sub-repo
 3:  1e40a4235e9 =  3:  93197a7bcee fsck tests: test current hash/type mismatch behavior
 4:  854991c1543 =  4:  277188dd58d fsck tests: test for garbage appended to a loose object
 5:  fc93c2c2530 =  5:  ab2ea1beaaf cat-file tests: move bogus_* variable declarations earlier
 6:  051088aa114 !  6:  91229b94fac cat-file tests: test for missing/bogus object with -t, -s and -p
    @@ t/oid-info/oid: numeric		sha1:0123456789012345678901234567890123456789
      deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
      deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
     +deadbeef_short	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbee
    -+deadbee_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee
    ++deadbeef_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee
     
      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: test_expect_success 'setup bogus data' '
    @@ t/t1006-cat-file.sh: test_expect_success 'setup bogus data' '
     +do
     +	for arg2 in -s -t -p
     +	do
    -+		if test $arg1 = "--allow-unknown-type" && test "$arg2" = "-p"
    ++		if test "$arg1" = "--allow-unknown-type" && test "$arg2" = "-p"
     +		then
     +			continue
     +		fi
 7:  20bd81c1af0 =  7:  9e95e134d30 cat-file tests: add corrupt loose object test
 8:  cd1d52b8a07 =  8:  215f98ad369 cat-file tests: test for current --allow-unknown-type behavior
 9:  d9f5adfc74b =  9:  3e1df3594df object-file.c: don't set "typep" when returning non-zero
10:  51d14bc9274 = 10:  b96828f3d5b object-file.c: return -1, not "status" from unpack_loose_header()
11:  f43cfd8a5ed = 11:  273acb45517 object-file.c: make parse_loose_header_extended() public
12:  50d938f7f3c = 12:  314d34357dd object-file.c: simplify unpack_loose_short_header()
13:  755fde00b46 = 13:  07481bcb55c object-file.c: use "enum" return type for unpack_loose_header()
14:  522d71eb19d = 14:  42b8d135c8c object-file.c: return ULHR_TOO_LONG on "header too long"
15:  1ca875395c1 = 15:  106b7461ce9 object-file.c: stop dying in parse_loose_header()
16:  d38067feab3 = 16:  d01223ae322 fsck: don't hard die on invalid object types
17:  b07e892fc19 = 17:  7f394a991a6 fsck: report invalid object type-path combinations
-- 
2.33.0.1327.g9926af6cb02


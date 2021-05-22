Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2690DC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 07:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D1F600D4
	for <git@archiver.kernel.org>; Sat, 22 May 2021 07:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhEVHLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhEVHLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 03:11:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C8CC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 00:10:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 10so16600196pfl.1
        for <git@vger.kernel.org>; Sat, 22 May 2021 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4Qj3h4Pp7J+Ym0BYi7xIuMRjmSo6laRqOg5dJtpYT8=;
        b=imDLtiWR5Vo1B8Ecfk0R04JlUCIqx0jl3MMP8WRwP+5D75G4x0Cd3YzdVhJ5v3p1aR
         GElMlljoqMBWSSeGVzieiwIyu+lsE2Ax9RFKWiHjquEuVhhiqvAj/AjvhTF5qQQ2ngU4
         8c9BPetY6JYOUQW6PkAayuWAXuovqImSWPkVL0WGygw+pNAqbMI+6OtNYcpzwxJ8ZXDN
         m39UB+tJdbzkG4JE2/Zxpa7QIWSk7XRrKjpApBwm9rk65spbbuZWdfRVp79Yk8nweqvk
         PeJrxX4xe97LKrjB4l9VPTEInr6QVpkgSy5tyS+Wf69EPioEFM9mfVl5nRRSHDnhb4fI
         W3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4Qj3h4Pp7J+Ym0BYi7xIuMRjmSo6laRqOg5dJtpYT8=;
        b=lAVA+d18xGLREwijevQ5Hi479g80Y+JgN7Hjo0R+npkWJk1lyahwVGmq334OA6s7xE
         kxzj4+q1gabABhZ/t6K5hW4cQNUelRQYmaiNxHgNDsRxvuveScibhPo9EXM6pToGgWKl
         2fLDyMFMPaDRzT6non3K2+oF+AtwQ+VhWRDtgU3LcXR4aqS4u1pZsuwcG07OcDtevcya
         R19ySrz1LaMep4UnYmc47S7IZ+tOT3zjmoN3Qg8D4lvdEn0b9MFeTMbooF1uXzlfO5GH
         eCmP/vOERC2VtwSY/RZjld5uDOtc9Ov5+vNUlziiryZ/DccUKL8XPq1DqPepOgQUO52s
         9Ayw==
X-Gm-Message-State: AOAM531H7MtFw68TAawm/tsyXqvhdig2NFag2vl5xZ9v5l6Ir4EL9Dp8
        cQGkQ6puGyi4cTa29WczF5UPntvqKXhn6A==
X-Google-Smtp-Source: ABdhPJy3QCRT6hg5kMyuRhUr16WJj+G1RAErKvl//lQvqWAw82egrkibJV6LoQM8Brs6x2t/g6r7Jw==
X-Received: by 2002:a63:f245:: with SMTP id d5mr2755248pgk.416.1621667421349;
        Sat, 22 May 2021 00:10:21 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id b23sm5679298pjo.26.2021.05.22.00.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 00:10:21 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t: use configured TAR instead of tar
Date:   Sat, 22 May 2021 14:10:08 +0700
Message-Id: <20210522071008.26790-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.32.g107691cb07
In-Reply-To: <20210522062815.17083-1-congdanhqx@gmail.com>
References: <20210522062815.17083-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite that tar is available everywhere, it's not required by POSIX.

In our build system, users are allowed to specify which tar to be used
in Makefile knobs. Furthermore, GNU tar (gtar) is prefered when autotools
is being used.

In our testsuite, 7 out of 9 tar-required-tests use "$TAR", the other
two use "tar".

Let's change the remaining two tests to "$TAR".

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

>> knobs, and we prefer GNU tar in autotools script.
>
> The last part I didn't know about---it is sad if autotools require
> use of gtar (but since use of autoconf and autotools is not required
> to build Git, I do not deeply care ;-)).

I do not care, either. Just want to add more data points for this change.

I've made a grammar error with v1, and I think two "and" in a sentence is not
good enough. Let's take this version instead.

Range-diff against v1:
1:  3a8ba467fc ! 1:  724a1a7a77 t: use configured TAR instead of tar
    @@ Commit message
         t: use configured TAR instead of tar
     
         Despite that tar is available everywhere, it's not required by POSIX.
    -    And, we're allow users to specify which tar they want to use in Makefile
    -    knobs, and we prefer GNU tar in autotools script.
    +
    +    In our build system, users are allowed to specify which tar to be used
    +    in Makefile knobs. Furthermore, GNU tar (gtar) is prefered when autotools
    +    is being used.
     
         In our testsuite, 7 out of 9 tar-required-tests use "$TAR", the other
         two use "tar".

 t/t3513-revert-submodule.sh | 4 ++--
 t/t6041-bisect-submodule.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 74cd96e582..8bfe3ed246 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -14,7 +14,7 @@ test_description='revert can handle submodules'
 git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
+	"$TAR" cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	may_only_be_test_must_fail "$2" &&
 	$2 git checkout "$1" &&
 	if test -n "$2"
@@ -23,7 +23,7 @@ git_revert () {
 	fi &&
 	git revert HEAD &&
 	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+	"$TAR" xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index df1eff0fb8..82013fc903 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
 git_bisect () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
+	"$TAR" cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
 	may_only_be_test_must_fail "$2" &&
 	$2 git checkout "$1" &&
@@ -25,7 +25,7 @@ git_bisect () {
 	git bisect start &&
 	git bisect good $GOOD &&
 	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+	"$TAR" xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-- 
2.32.0.rc0.32.g107691cb07


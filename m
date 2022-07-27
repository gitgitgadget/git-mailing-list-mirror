Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6EC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiG0XOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiG0XOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266214D4DF
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso1660854wma.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=r5jnN7/O+TAVw3sF6mVenDS/A42VH7+SHRQ5vcEMHRo=;
        b=T5Eh2xpiM8U125UZTcs1BNK3+FBNk2H9HBZlLb1oqbxnKtVpEtCYLa1aotqYE9L5pw
         y0uAIj6I/kleeWnblb4hf3V6p74ItQqwr6rJvPHEqwTjknf9numYslt0tJ5dibksDB3y
         yt8CdadQxRqBZEhGQWaxYzhMKSjfjfMUKHJUgw6iUCrQzNXH0g+nD+OPkQ+1gQcjVqwm
         CJQoFLlfKT+veHx3QUdjnrxZi1TtXFvg/6Qagv77Is8SxMdjV/1XoO6XdVhBjkInGbT9
         +iA7bNnvyrgT0jqqP+IjQK0kse44gvoUTk7qSmeSQF+Rg25lFEZ6R5xwC+Kdi1tiygxd
         ZXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r5jnN7/O+TAVw3sF6mVenDS/A42VH7+SHRQ5vcEMHRo=;
        b=sbaTXxG7NymqtzrnVXPcIKH1+QZ8rNn1rbOwpSC7+c9nHeU+Lb2qTztV16m3+u81Om
         yyTqucizTgx+ziwXl8ADbZrOjc4vzrUmIsQLpzIwz80/nKD/AgOQxNZAfhguavNaukII
         nEAd6zQSOQpG8f/2DJpZddB8txaVNEvxBHt86zG3XqDrf5TTagHztnXWI5hxSVYGlOb0
         aqR/cvO3d0OnBrAprn3MvRhqb/7oPBc3vFDozGOKoBFxdrjo1wjeDstPBiA5Vz6MUzqk
         FR9VIg2dwTS6e5+Pp+N+a33Kojt8ohcBbKJBMO3XOd42BsJx0NFwYjxrRoJCMKG+BENW
         Eekg==
X-Gm-Message-State: AJIora97mjM123tYa8+su7lskwGDXszCkWLyxPmu7StPOZlfirWtHYAv
        pkNqi7da24J01FLW9UQCSOpNWpp8cMoM2g==
X-Google-Smtp-Source: AGRyM1sNT1Wm/nobNGxkzmYOqZxKd7fV4eNwFhZE5LzqpOmLp3MCb9PIhgESpGYcrrvWjxkT4jtuYQ==
X-Received: by 2002:a05:600c:6006:b0:3a3:7245:7be4 with SMTP id az6-20020a05600c600600b003a372457be4mr4603638wmb.112.1658963637184;
        Wed, 27 Jul 2022 16:13:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:13:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/15] t/Makefile: don't remove test-results in "clean-except-prove-cache"
Date:   Thu, 28 Jul 2022 01:13:35 +0200
Message-Id: <patch-v3-07.15-c7ea6dc013b-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "make test" is run with the default of "DEFAULT_TEST_TARGET=test"
we'll leave the "test-results" directory in-place, but don't do so for
the "prove" target.

The reason for this is that when 28d836c8158 (test: allow running the
tests under "prove", 2010-10-14) allowed for running the tests under
"prove" there was no point in leaving the "test-results" in place.

The "prove" target provides its own summary, so we don't need to run
"aggregate-results", which is the reason we have "test-results" in the
first place. See 2d84e9fb6d2 (Modify test-lib.sh to output stats to
t/test-results/*, 2008-06-08).

But in a subsequent commit test-lib.sh will start emitting reports of
memory leaks in test-results/*, and it will be useful to analyze these
after the fact.

This wouldn't be a problem as failing tests will halt the removal of
the files (we'll never reach "clean-except-prove-cache" from the
"prove" target), but will be subsequently as we'll want to report a
successful run, but might still have e.g. logs of known memory leaks
in test-results/*.

So let's stop removing this, it's sufficient that "make clean" removes
it, and that "pre-clean" (which both "test" and "prove" depend on)
will remove it, i.e. we'll never have a stale "test-results" because
of this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/scalar/t/Makefile  | 2 +-
 contrib/subtree/t/Makefile | 2 +-
 t/Makefile                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
index 01e82e56d15..1ed174a8cf3 100644
--- a/contrib/scalar/t/Makefile
+++ b/contrib/scalar/t/Makefile
@@ -42,7 +42,7 @@ $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 276898eb6bd..3d278bb0edb 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -47,7 +47,7 @@ pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
diff --git a/t/Makefile b/t/Makefile
index 7f56e52f767..1c80c0c79a0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -62,7 +62,7 @@ pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 clean-except-prove-cache: clean-chainlint
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
-- 
2.37.1.1127.g4ecf1c08f67


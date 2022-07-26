Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A4C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 11:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiGZLJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbiGZLJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 07:09:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91B2F01B
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 04:09:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so19638640wrw.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1e/zql+Q+d1SLwo8Yz3Kjw8fkqYc6+u39wtNZhHsgYY=;
        b=BVLkVvMuPcnqtLiTgYg/teoFdGD68OOQT0Okf4eqsNDIwYdbkTSV5vFyemx3mIMDFF
         DDrIhD3Z2UnnvuX3e5eXEUMj1wKWR+hdFuuB3sZ8b570oMggyIWe0KkErgUyl6NmLyx7
         C1LKkMHoK6eGbb2vVrXQUrPdL+Ho+zcdD+riPL+3OUw0hMpJ2+DXIdydswlDHbKlfAyc
         Z4YlxlU/zY1phRTYl3CWdLAPq0GnQvPk+/6vBJ9+9TcetH7x3ZmOv3YtpssXz/n6tSmu
         HQ/fHNIJud+uJGb27CZtZG7Yw1+bFCNAAVnWG03b3GRM9sGZ1iBw7O12KYOJfZO3RXUg
         zZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1e/zql+Q+d1SLwo8Yz3Kjw8fkqYc6+u39wtNZhHsgYY=;
        b=0PekBk98OFUjPo3qC6biTcv5xZAvdQ732lMq6RSMIUNCvd8Ue/glPGwNmXDh5bAbmu
         y45cQL8qAX0S4tpLcmqyG7HZepFR1WeN6m0jZdsjTdTqeLxsJY56vQX53PmWr1FxBPf0
         ZoImUj5kH3mAF6FO0oGT4JWxS1KukdUZdyISGwMR3DtaxWXwI8/BrACEWDPGaEWsxGg2
         lqWazngTrImsl89se1dZYTx4jDyfl2Jub6TdWFPo3+FpqocqHSZqaFQi8iWuSFOkOEhx
         4P1M5pMlsjOvNVLnyf2xuGQoKQ1j+DLHxtcPcnuEJlbsWlk+pK4wZtUzZdt9aNP8Hp8K
         Huhg==
X-Gm-Message-State: AJIora9AiPhJOViAravo15fNdjGLBKMMEY4tLb83ScunkbNAYLD56Fs8
        1QbNXgA1tgUcJMavsjZCWIhmbncRWULZJg==
X-Google-Smtp-Source: AGRyM1ugoVvnS/37cnhxnxKAWJ0T2YSYLPbvK8c7KVsxxqi0AB3TVQtllA+r1vX9gMfeo/GD8leq8A==
X-Received: by 2002:adf:f807:0:b0:21e:5094:aeb9 with SMTP id s7-20020adff807000000b0021e5094aeb9mr10774060wrp.497.1658833756204;
        Tue, 26 Jul 2022 04:09:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b003a3199c243bsm29049648wmq.0.2022.07.26.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:09:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Date:   Tue, 26 Jul 2022 13:09:13 +0200
Message-Id: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1107.g76fe5d1ed7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add CI targets for SANITIZE=address and SANITIZE=undefined. The former
would have caught a regression in 18bbc795fc5 (Merge branch
'gc/bare-repo-discovery', 2022-07-22) which made its way to
"master"[1].

Per [2] the GitHub fork of git.git runs with these in CI, so it's
already useful to some forks of this repository.

Also per [2] we could use SANITIZE=address with some ASAN_OPTIONS
instead of our SANITIZE=leak job added in 956d2e4639b (tests: add a
test mode for SANITIZE=leak, run it in CI, 2021-09-23), but unifying
those two with these new jobs would be a lot harder, so let's leave
that for now.

On my system a "make test" takes around 12m of user time,
SANITIZE=address around 44m, and SANITIZE=undefined around 18m.

In practice this doesn't seem to slow down the wallclock time of the
the GitHub CI by much This runs in about 50m, but getting through some
of the "win build" and associated tests can take around 40m, and the
"OSX" tests are on the order of 40m (all of this may vary with the
available workers etc.).

The "address" job will fail due to the issue reported in [1]. the
"undefined" one succeeds, but note that "t4058-diff-duplicates.sh"
triggers its assertions, they're just hidden by
"test_expect_failure" (see [3] for why).

1. https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/YPClS0fj2HOJE5nH@coredump.intra.peff.net/
3. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This CI wil catch the memory corruption that made it to "master", see:
https://lore.kernel.org/git/220725.861qu9oxl4.gmgdl@evledraar.gmail.com/

 .github/workflows/main.yml | 6 ++++++
 ci/lib.sh                  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cd1f52692a5..4f59a7aa44c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -251,6 +251,12 @@ jobs:
           - jobname: linux-leaks
             cc: gcc
             pool: ubuntu-latest
+          - jobname: SANITIZE=address
+            cc: gcc
+            pool: ubuntu-latest
+          - jobname: SANITIZE=undefined
+            cc: gcc
+            pool: ubuntu-latest
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
diff --git a/ci/lib.sh b/ci/lib.sh
index f095519f8db..5ad60af2e7c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -277,6 +277,12 @@ linux-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
 	;;
+SANITIZE=address)
+	export SANITIZE=address
+	;;
+SANITIZE=undefined)
+	export SANITIZE=undefined
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.37.1.1107.g76fe5d1ed7c


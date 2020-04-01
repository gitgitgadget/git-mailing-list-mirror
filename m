Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CEC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CCD20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 21:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIy4reQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgDAVWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:22:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43328 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732357AbgDAVWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 17:22:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id m11so1767049wrx.10
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z512z0pCSgo6dn/v86xT98cN7VeOO0uCc1Yrlx0rIbs=;
        b=vIy4reQDcuQSvpnGLbGnX6ofRm6R6wQooyL5JGKoMtdZc4pvCdfiT+3lN4x+tdpfSv
         PZYCygG3aZLrFqujHzHZ4cvzUvgInQ9zCOp2vA0KPAJbKfQif8hYN9mYn/LhzKzHpZ/1
         VgmeUIDLEmmjeRA6anylLYrrf0V/aHakKYgyL3NNf5IUmwiE6yYveNYGUTROQ8eU/MZm
         RQ97vUjkkIl2LO8kYY4KtL9NfLpWqVwSBPvQ2V8QJvX9BNEiadqnLS3VOeAFBTRcZxwl
         gZk+RYgRv/z/TT42mHbT91oxXS224dSN4d5SUJdok7G/LrTShlJTLn0S9m6QE683Jncl
         Ye0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z512z0pCSgo6dn/v86xT98cN7VeOO0uCc1Yrlx0rIbs=;
        b=tskUHdCmfEZjp1M7YhJF4Cf4rMda6vKbmvxlreIVHZd0D9GBqDi/rQw5V4M38o9CnN
         625OIhkpO+Eo25Y/iI7w1vARL8BV60m3CoBOD/5IfGfySJmExVoOl1g5B9KdIGOYQoV4
         2cpABXPPWnTpGPO2tt3r2Zj6x63b2+OX8m/V8wvKogzvuGasDN5rcezor+DtQL+lhT3N
         antLhbWJCu2tw5aI/WNfQDRZVHJ65QGyVbOMNREqg3l8cll04XlL041YM+BYPW7ML79Z
         y7sdkAQq1BoHd0Gd3VQnTN93uS2ic9nMGmCT8z0dzE/vLntLjgCBc/YEtbS0181a2jCn
         8LBA==
X-Gm-Message-State: ANhLgQ391jqZtGijscvDyG2xbG6J7G4oNtZb1Ss73Jgr3SSeNOn3D6jU
        5VDJ7uF52XiPUQGReKxPd2jPuiaD
X-Google-Smtp-Source: ADFU+vuzQtDjEgaEsUf+B2u/wEL5T7B06Vy5bqgMqSRxDUEChEW3ukClT1EBn+hMZMMQaoeDcb7xcw==
X-Received: by 2002:adf:9465:: with SMTP id 92mr27841480wrq.122.1585776124912;
        Wed, 01 Apr 2020 14:22:04 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-192.pool.digikabel.hu. [78.131.17.192])
        by smtp.gmail.com with ESMTPSA id p10sm4484911wrm.6.2020.04.01.14.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Apr 2020 14:22:04 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci: make MAKEFLAGS available inside the Docker container in the Linux32 job
Date:   Wed,  1 Apr 2020 23:21:51 +0200
Message-Id: <20200401212151.15164-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.26.0.483.g160d1dcc28
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time we ran 'make --jobs=2 ...' to build Git, its
documentation, or to apply Coccinelle semantic patches.  Then commit
eaa62291ff (ci: inherit --jobs via MAKEFLAGS in run-build-and-tests,
2019-01-27) came along, and started using the MAKEFLAGS environment
variable to centralize setting the number of parallel jobs in
'ci/libs.sh'.  Alas, it forgot to update 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container running the 32
bit Linux job, and, consequently, since then that job builds Git
sequentially, and it ignores any Makefile knobs that we might set in
MAKEFLAGS (though we don't set any for the 32 bit Linux job at the
moment).

So update the 'docker run' invocation in 'ci/run-linux32-docker.sh' to
make MAKEFLAGS available inside the Docker container as well.  Set
CC=gcc for the 32 bit Linux job, because that's the compiler installed
in the 32 bit Linux Docker image that we use (Travis CI nowadays sets
CC=clang by default, but clang is not installed in this image).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

The 'dd/musl-libc-travis-ci' topic needs some more updates, and those
will depend on this fix.

 ci/lib.sh                | 3 +++
 ci/run-linux32-docker.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index c3a8cd2104..d637825222 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -198,6 +198,9 @@ osx-clang|osx-gcc)
 GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=true
 	;;
+Linux32)
+	CC=gcc
+	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 751acfcf8a..ebb18fa747 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -20,6 +20,7 @@ docker run \
 	--env GIT_PROVE_OPTS \
 	--env GIT_TEST_OPTS \
 	--env GIT_TEST_CLONE_2GB \
+	--env MAKEFLAGS \
 	--env cache_dir="$container_cache_dir" \
 	--volume "${PWD}:/usr/src/git" \
 	--volume "$cache_dir:$container_cache_dir" \
-- 
2.26.0.483.g160d1dcc28


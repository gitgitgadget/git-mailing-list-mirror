Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E21BC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E86206E0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ40RlpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK0QYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:24:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45251 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0QYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:24:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so1546808wrj.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHWWE80gomhYssX7Bstys7Pq2Ndv6eHrn+TMj0uFCjo=;
        b=AQ40RlpKrknnaC1v38foOKMWaDzUA6GCmChTco/03Q8OCtoK2M77UrC0e2BNV646Cp
         efVjYdiJ63jgoMxpDVPQSmbzVrwTBVz8DmacG0urDulxTaKMXQ7pCO6dgXsm3IyMKb5y
         rL7t7TYXg8d5w78MD5DbJs0t5XZcXu0BKLsrRcul0N1sxMbKeaJGfAYj1L7nF57BV7ab
         LwsocJTzI7e1KjgMz5dybFK0mFl7FHR1cEldEWCf+835hq8erZghJ3dAswSHcSrI0xVC
         U8RD+a4+I2evSoNpNM8i5zI0Iv05POnMkMleTA41oK98i4ojdfDyoTuJNDP7Djvg4656
         a9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHWWE80gomhYssX7Bstys7Pq2Ndv6eHrn+TMj0uFCjo=;
        b=C/z2kDbATHJefgZDwvpe7U6FtWsyjRsJksxLa4u07bUD5zAuNM86aiSbWoSu0Eih+h
         bNQ49kqfOzQ+fZhgTgFG46x0HLksl2aMdoZEsvnSvODEyhphwLVNn30n/+fS2D1zgqWI
         tvmzr54zD99EPB6lWyvD7cq8X4bfuXsTwPbNjLwM2nktCTkk1+b6DHx2jcXLmvy/OTum
         VaI96hwjZS9Lj//TACvOOXlj8LBYS018GsKHVSLp8f4soJJjuSvBOob5LJBEH60OurKF
         vF6TKUMunPzrkqUbRYxpXS1NQcqFRkWUSXE3YfXzeOkdJTNAH+KBvPu1aYm/iFBKg5ez
         da2w==
X-Gm-Message-State: APjAAAUQ78bO5alFDC2t2ViSibIqyh6PtEeZipGz8p99COg8Joj+Q2AT
        MrvNeNIKk8uH/kV2V44JvB0=
X-Google-Smtp-Source: APXvYqzHVvaRDPtRXrEIE/y/oH/gYSTDBYLZzda1DFZ/2jAcfvLNdD18FN03EyY3A7aA32XOBJZWig==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr9412542wrq.91.1574871860088;
        Wed, 27 Nov 2019 08:24:20 -0800 (PST)
Received: from localhost.localdomain (x4db309d4.dyn.telefonica.de. [77.179.9.212])
        by smtp.gmail.com with ESMTPSA id 205sm9966463wmb.3.2019.11.27.08.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Nov 2019 08:24:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci: build Git with GCC 9 in the 'osx-gcc' build job
Date:   Wed, 27 Nov 2019 17:24:16 +0100
Message-Id: <20191127162416.19391-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.643.gac013444ca
In-Reply-To: <20191126011536.GA30006@generichostname>
References: <20191126011536.GA30006@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our 'osx-gcc' build job on Travis CI relied on GCC 8 being installed
(but not linked) in the image we use [1].  Alas, since the last update
of this image a few days ago this is not the case anymore, and now it
contains GCC 9 (installed and linked) instead of GCC 8.  The results
are failed 'osx-gcc' jobs, because they can't find the 'gcc-8' command
[2].

Let's move on to use GCC 9, with hopefully better error reporting and
improved -Wfoo flags and what not.  On Travis CI this has the benefit
that we can spare a few seconds while installing dependencies, because
it already comes pre-installed, at least for now.  The Azure Pipelines
OSX image doesn't include GCC, so we have to install it ourselves
anyway, and then we might as well install the newer version.

In a vain attempt I tried to future-proof this a bit:

  - Install 'gcc@9' specifically, so we'll still get what we want even
    after GCC 10 comes out, and the "plain" 'gcc' package starts to
    refer to 'gcc@10'.

  - Run both 'brew install gcc@9' and 'brew link gcc@9'.  If 'gcc@9'
    is already installed and linked, then both commands are noop and
    exit with success.  But as we saw in the past, sometimes the image
    contains the expected GCC package installed but not linked, so
    maybe it will happen again in the future as well.  In that case
    'brew install' is still a noop, and instructs the user to run
    'brew link' instead, so that's what we'll do.  And if 'gcc@9' is
    not installed, then 'brew install' will install it, and the
    subsequent 'brew link' becomes a noop.

An additional benefit of this patch is that from now on we won't
unnecessarily install GCC and its dependencies in the 'osx-clang' jobs
on Azure Pipelines.

[1] 7d4733c501 (ci: fix GCC install in the Travis CI GCC OSX job,
    2019-10-24)
[2] https://travis-ci.org/git/git/jobs/615442297#L333

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

On Mon, Nov 25, 2019 at 05:15:36PM -0800, Denton Liu wrote:
> It seems like gcc-8 doesn't exist anymore in our gcc OS X Travis job. As
> a result, that job has been failing consistently recently[1].
> 
> An old similar thread here[2]. Not sure if the failure is related.

> [2]: https://lore.kernel.org/git/9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com/

It's funny how merely two days after we talked about how/when Travis
CI images are updated, we got yet another update, which broke our
builds again... Oh, well.


 ci/install-dependencies.sh | 6 ++++--
 ci/lib.sh                  | 3 +--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4e64a19112..93e3bba434 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -48,8 +48,10 @@ osx-clang|osx-gcc)
 	brew install caskroom/cask/perforce
 	case "$jobname" in
 	osx-gcc)
-		brew link gcc ||
-		brew link gcc@8
+		brew install gcc@9
+		# Just in case the image is updated to contain gcc@9
+		# pre-installed but not linked.
+		brew link gcc@9
 		;;
 	esac
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index c8c2c38155..10b97c05ad 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,7 +131,6 @@ then
 		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
 	}
 
-	BREW_INSTALL_PACKAGES=gcc@8
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
@@ -182,7 +181,7 @@ linux-clang|linux-gcc)
 osx-clang|osx-gcc)
 	if [ "$jobname" = osx-gcc ]
 	then
-		export CC=gcc-8
+		export CC=gcc-9
 	fi
 
 	# t9810 occasionally fails on Travis CI OS X
-- 
2.24.0.643.gac013444ca


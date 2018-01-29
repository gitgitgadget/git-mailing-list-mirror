Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029DC1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeA2RRZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:25 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55879 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2RRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:24 -0500
Received: by mail-wm0-f51.google.com with SMTP id 143so15759820wma.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEJt4KYz3a58nXgFAT5lyJ9HZxkwIIUP9oxxYCv1IR4=;
        b=Jq09W7/a6sSZFlVHmfsxiwSK7ctf2q6I57y7blXDWfdHT2r73kEd/LHgXLqNNzDh2G
         e1vp9Q1ll3rrhr5ZSRCVd1kPjzH/6P+YjCJHPT1+7puv/4hiQ+fe0xz5TQFPkyOn6Fvc
         8JcB/qLYy9bCnyimIW6czGbCZeW0OpYqzurl+nxYGNwKRoUMxZaT/715g6qKXWvN1EW7
         /h5xoQutz4Ik9iiTyuHn5eJ0UEkfwr10lqVvxigZqTNgSEO/yKEBZT7Pul33Uao8SOhC
         KuVTmSrKr/RlBzZBR8Ox5NqvIdMjBHXCSOza2Lhz3BxJw97zIcD9YDhOMtJDYYTPa6+j
         844A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BEJt4KYz3a58nXgFAT5lyJ9HZxkwIIUP9oxxYCv1IR4=;
        b=ErINcP0go0ZSQb/ZXvTteE8JZi6L4+L25Mgr3dHty2Fca/2JEbpuVKmfYKWoM1Ploz
         uSycqTmhO7JInsaSzrutowEY0e+d28eR8DB+1j5net3W/7A+O5oaCO5yTzy8J29VE677
         uqQMibkst+s1TEy8torNhAbx82R47NrtrgHC6G/uJu6DIsuFJaSGSDLBvI9cn+UZvlOp
         gcvs/R0HgHptupSbWWfi0QTJ1YH0fjPtsa32QIUAWTH3zou85mz1KpQBIoqOa3QLBogn
         IjxdoXibwl6QD19hQWD/yG5dA7hkfrPEbYEMYm0wh/Xjc0CViRvcad0AgmleO5/54720
         EjcQ==
X-Gm-Message-State: AKwxytcuC9yPZpJYUY8gKBWTNXcuic/A1Ovg2/mUu++f9mJbnx/58+vq
        OvCYMEqYdKN9Hot5Q7WXJpw=
X-Google-Smtp-Source: AH8x224bOYupeakI5W28Qjx5UNsk2SVIIiSLY6945mefV9DSiSOXwA0bTt7S8exusKC7Mlf+etrvDg==
X-Received: by 10.28.5.145 with SMTP id 139mr16964353wmf.89.1517246243278;
        Mon, 29 Jan 2018 09:17:23 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 0/5] Travis CI: don't run the test suite as root in the 32 bit Linux build
Date:   Mon, 29 Jan 2018 18:17:08 +0100
Message-Id: <20180129171713.17471-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version addresses Peff comments:

  - Updated the commit message to discuss the broken && chain and its
    consequences in patch 2.
  - Fixed quoting of the 'su' command snippet and updated the commit
    message in patch 3.
  - Squelch error from 'test "$(id -u $CI_USER)"' and add debug
    message in patch 5.

Additionally, it's rebased onto current master (I branched off v1 from
'sg/travis-build-during-script-phase' to avoid a conflict, but Junio
applied it on top of current master).

Interdiff against 'sg/travis-linux32-sanity' at the end.

SZEDER Gábor (5):
  travis-ci: use 'set -x' for the commands under 'su' in the 32 bit
    Linux build
  travis-ci: use 'set -e' in the 32 bit Linux build job
  travis-ci: don't repeat the path of the cache directory
  travis-ci: don't run the test suite as root in the 32 bit Linux build
  travis-ci: don't fail if user already exists on 32 bit Linux build job

 ci/lib-travisci.sh       |  7 ++++---
 ci/run-linux32-build.sh  | 51 ++++++++++++++++++++++++++++++++++++------------
 ci/run-linux32-docker.sh |  7 +++++--
 ci/run-tests.sh          |  3 ++-
 4 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.16.1.158.ge6451079d

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 13047adde..2c60d2e70 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -33,9 +33,9 @@ then
 	CI_USER=root
 else
 	CI_USER=ci
-	if test "$(id -u $CI_USER)" = $HOST_UID
+	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
 	then
-		: # user already exists with the right ID
+		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
 	else
 		useradd -u $HOST_UID $CI_USER
 	fi
@@ -51,10 +51,10 @@ else
 fi
 
 # Build and test
-linux32 --32bit i386 su -m -l $CI_USER -c "
+linux32 --32bit i386 su -m -l $CI_USER -c '
 	set -ex
 	cd /usr/src/git
-	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
+	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
 	make --jobs=2
 	make --quiet test
-"
+'

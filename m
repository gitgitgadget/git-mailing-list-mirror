Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EEC4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 10:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKYKAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 05:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiKYKAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 05:00:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E6BBB5
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l7so1247885pfl.7
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfKzvlKYCUNwOIBvcyb6oTduhxdEBZdWxPs5rTwCmns=;
        b=HB10aEekftyjolRFbVN2toubJrTbilNsB24BIpowvQKrgTvADMa8iOpWSRN93soHFt
         srztcnAV78WKMCCbFmummkPtMa0Vhk40H42sO5B48DhCUk8qsd4zqawqXZnUkTn/3wtI
         6wcXk3XKayuZcuGQVPiTTyXAMn6y5PkTB/xbUpMiHMKoYIgvPvMC4Un+bvvBbnICt5vD
         paS8Hm7dITXLnBbK97WKlN6fQv3hJF3blKWGTs1DIANtGxVtH0oGcpgrvuDG4WFfkV4F
         etmtDgsidhrCppK3ORSuQoC9+rm0oQzPMBidwfkHQ9VNMEWJbY2gWx27HsyHIcynIuMU
         FOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfKzvlKYCUNwOIBvcyb6oTduhxdEBZdWxPs5rTwCmns=;
        b=au9sOKRkdJi6Zt7UC+QR4TKVwXcuoh8FmNaRsdfbfZRl4J1eigD03NE2XQ7R5WrFTI
         CBlkzy1IqfVF3f9OucLhGtp3Y0Gy7CKEWytKN0ezY6YOYagO55APzFcFN3UyoaM4drha
         qNovTmGfliNd3ofV+JCgVS0sxrVgIUFC1KQXBKnqH0siqWabWu1y8BTIPrgL3xjj5pah
         1c0qz+SXU1jubrCEJSY29IA31+DS+MAFajWTjJzSaQVlK4ZqURwoR/JEh+ipIrc7rvjV
         UXxyY+f7264+4Ux+juxy7INnTff8KLoH3vgm6EYaUODbTAIP4LoPbYABDmoqNJOmVggX
         pDzA==
X-Gm-Message-State: ANoB5pmXVdo7m80/2RHVVtLQeyjG23KiDjzH4K0g7+ErJ5cBe74th2jv
        JstucZXlvwiVV13SCYavwreWrGWG4Q8=
X-Google-Smtp-Source: AA0mqf4UREoNBcUHSubFCBZcMakRvfs7mH1uXYKvGcpjCk+vJgEIqRH0FZfswjAKXWMtTF/VQ43Nzg==
X-Received: by 2002:aa7:8d5a:0:b0:562:7f16:7407 with SMTP id s26-20020aa78d5a000000b005627f167407mr40020622pfe.15.1669370400452;
        Fri, 25 Nov 2022 02:00:00 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b00186b0ac12c5sm2904514plb.172.2022.11.25.01.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 01:59:59 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 3/4] ci: p4 on Linux has the same version as on macOS
Date:   Fri, 25 Nov 2022 17:59:53 +0800
Message-Id: <20221125095954.4826-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124153934.12470-1-worldhello.net@gmail.com>
References: <20221124153934.12470-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

There would be a segmentation fault when running p4 v16.2 on ubuntu
22.04 which is the latest version of ubuntu runner image for github
actions.

By checking each version from [1], p4d version 21.1 and above can work
properly on ubuntu 22.04. But version 22.x will break some p4 test
cases. So p4 version 21.x is exactly the version we can use.

With this update, the versions of p4 for Linux and macOS happen to be
the same. So we can add the version number directly into the "P4WHENCE"
variable, and reuse it in p4 installation for macOS.

By removing the "LINUX_P4_VERSION" variable from "ci/lib.sh", the
comment left above has nothing to do with p4, but still applies to
git-lfs. Since we have a fixed version of git-lfs installed on Linux,
we may have a different version on macOS.

[1]: https://cdist2.perforce.com/perforce/

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 4 ++--
 ci/lib.sh                  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 97a1a1f574..b569893b38 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=https://cdist2.perforce.com/perforce/r21.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
@@ -40,7 +40,7 @@ macos-latest)
 	mkdir -p $HOME/bin
 	(
 		cd $HOME/bin
-		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
+		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
 		tar -xf helix-core-server.tgz &&
 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
 	)
diff --git a/ci/lib.sh b/ci/lib.sh
index eb203662c5..927b4529b0 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -246,7 +246,6 @@ ubuntu-*)
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
 	P4_PATH="$HOME/custom/p4"
-- 
2.39.0.rc0


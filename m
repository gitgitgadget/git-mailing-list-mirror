Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D844C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 15:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKXPjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKXPjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C030562
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d20so1738686plr.10
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOecyeyTetxTaFOgnmxEvvHNBhzKBuwDfSjKxQpFkO8=;
        b=DPYnx5fdXyElrdNVMMfVw62fdYAS9dFRcHwVkmpXKnJ76SbRZU5ZCVafpgyNfENFoO
         GTHTUcT6hukam1qa7490KhH9q1tNDCKjYoWYKvyRWAF1H2EmkSACBpWkruKoKngDJnOo
         9VLvA2wd3mqRxFxd7ZpfXofr0RRxAybuRZb8R4tWSRcTOixoRX0vuKKuior27jOWvQ7R
         veu8Hi2Mx4cUwGoXF+qcxO84/2KDDFXAC7HiTqsXZp7/QEla5woJw2Lf7cvVWIfv8Mv9
         Xxv0nYOBwGa5iCI1OQCJXdKLs4s8uphx09eebxFph89+vftz7V7b1sHKIRxQqs7jXJR+
         RLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOecyeyTetxTaFOgnmxEvvHNBhzKBuwDfSjKxQpFkO8=;
        b=odRrHRhySRZCVTL4HghIXEorYYlZrGzsOjvDbt51ECbmPz1OFIFZiMOK7wj7aYofb5
         lIepPBeRrKDFE9G/RHrtwXFhuViq05E3Dfpiw0IuQ/OWMA1wumHdjMdZNJHhgq0lOBZO
         CLo3HSS2490MbTA8nEGQ+Gi9g9t8lc4I/6lIRgwC6qi/+XWlCWt1TJHzsKlJAaI+Ubdo
         JfYW4URgxnEQSNxY5m1aAloVv9EW+xXUnwm6fX3hCS6E+IQ3G3T5Y22T4T98enxkeJZN
         n7acnNlUUBt0fYqUI6nuob0FrsQxBwt4oQKmm30YWVuJyAqokMTCE+7OWMAbv+2FoycN
         oOdg==
X-Gm-Message-State: ANoB5pm/yqlJ80O3i5ILjrJg+yBHs49qqQaqQaSw25PdxEoAwGypnUh1
        LDBohUdfPACuNb0IHNH0OnC19TMABxU=
X-Google-Smtp-Source: AA0mqf7UMNUmJtvFaif4hdUFaMhgsqpIQHtx+TdXD9ndekDP2iQn4a8oULghstX6dk/sL3CA03mScw==
X-Received: by 2002:a17:902:e807:b0:186:fb90:5774 with SMTP id u7-20020a170902e80700b00186fb905774mr14829037plg.137.1669304381209;
        Thu, 24 Nov 2022 07:39:41 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm1413089pln.292.2022.11.24.07.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:39:40 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 3/4] ci: p4 on Linux has the same version as on macOS
Date:   Thu, 24 Nov 2022 23:39:33 +0800
Message-Id: <20221124153934.12470-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
References: <20221124090545.4790-1-worldhello.net@gmail.com>
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
index 291e49bdde..f860c35c75 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=https://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=https://cdist2.perforce.com/perforce/r21.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
@@ -40,7 +40,7 @@ macos)
 	mkdir -p $HOME/bin
 	(
 		cd $HOME/bin
-		wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.macosx1015x86_64/helix-core-server.tgz" &&
+		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
 		tar -xf helix-core-server.tgz &&
 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
 	)
diff --git a/ci/lib.sh b/ci/lib.sh
index 0c0767d354..991ea4f8a6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -246,7 +246,6 @@ ubuntu)
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
 	P4_PATH="$HOME/custom/p4"
-- 
2.39.0.rc0


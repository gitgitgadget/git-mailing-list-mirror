Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16487C2BA1B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD29620747
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXcySWX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDHEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:08 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33408 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDHEGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:07 -0400
Received: by mail-pj1-f66.google.com with SMTP id cp9so1772524pjb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3kKYxLCRN8HSBleLvkfmJ7KcIiCd1iKqb+rPAhGVRs=;
        b=AXcySWX4lWo4AY4dTQwRLKjACSPMMIC+ehU1dbJnTIp3iGUaMSQjuwqi3Ug6a8SNBC
         NSp8vdF17uDfYj3Mou9WeFK0lN/w40ZU9LtYHOlwQExrI5JZP0QYMn5CCur1fIKJIV0+
         pLb7+qkQJRGChCI6HtkTqzwzECTcRA5J++CStWX0grw3iC2gPyz27Z9xXaP0zKyHKT7J
         uFNtIRQSGw8idetFcbLY71fi/LI166SZTuq9+92oyES+KIiawvdInLc4fGYi1HKv/ugg
         s+0nyVLV0xTfkswD0ki7p6/ZcQc/vjbnv+TDXJ674qxCYVn8IKZ0Q8y7i8/Eux1jmuoW
         RYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3kKYxLCRN8HSBleLvkfmJ7KcIiCd1iKqb+rPAhGVRs=;
        b=Y+0eGVPEgswolExBy5V9g8tkQ8wfY0+afhZ/p6Kcqn7G7voxveK8AjbHKIim3jyWBJ
         2AVWzbwnLBY/0CVdfEyeImyDa0GL42IJL8Tsn1OvobuSrE0/21WvjU98GD2AEmx21adV
         V02rI9dqulAf0y4H0VX16CYSFrWtaDiUrKhMp88eClyLzJ1SUGb0Zz5m8YczYkjAsA4V
         j+deOwptWqkOz/5lpmzN8+rLziSOhWp2364aQbRUXW9+IbxShNLSnm0u6NnuW+VmFKk1
         pi3s69xr7GnWwE53q/3PBgN1AF8N3NY+50cl+qqSuOMni92IgQ9J8Ahu88351glCp7Y6
         vxxA==
X-Gm-Message-State: AGi0Pub3BOrfVWydkexjF5HEC1L0bOMZYC0vtBS1yGTCZIhUToY9XLyh
        aT8r7f1NyUDcO5JAomvMdTiPY7Si0wI=
X-Google-Smtp-Source: APiQypJSk5V+58oq3+diYJoU40ePxMAXsj2KpDfmGqtVj20KDEZP30rTvPgkw8jseO18nDNgvGZK3w==
X-Received: by 2002:a17:90a:362a:: with SMTP id s39mr3094085pjb.28.1586318766307;
        Tue, 07 Apr 2020 21:06:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 05/12] ci: explicit install all required packages
Date:   Wed,  8 Apr 2020 11:05:36 +0700
Message-Id: <4f80724641e17bf0d1937dbad77f987fbf86cd64.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, we will support GitHub Action.

Explicitly install all of our build dependencies.
Since GitHub Action VM hasn't install our build dependencies, yet.
And there're no harm to reinstall them (in Travis)

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 497fd32ca8..371902bb75 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -7,12 +7,17 @@
 
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
+ perl-modules liberror-perl tcl tk gettext zlib1g-dev apache2
+ libauthen-sasl-perl libemail-valid-perl libio-socket-ssl-perl
+ libnet-smtp-ssl-perl"
 
 case "$jobname" in
 linux-clang|linux-gcc)
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
+	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
+		$UBUNTU_COMMON_PKGS
 	case "$jobname" in
 	linux-gcc)
 		sudo apt-get -q -y install gcc-8
@@ -63,11 +68,16 @@ StaticAnalysis)
 	;;
 Documentation)
 	sudo apt-get -q update
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns \
+		libcurl4-openssl-dev
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	gem install --version 1.5.8 asciidoctor
 	;;
+GETTEXT_POISON)
+	sudo apt-get -q update
+	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
+	;;
 esac
 
 if type p4d >/dev/null && type p4 >/dev/null
-- 
2.26.0.334.g6536db25bb


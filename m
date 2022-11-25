Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D3C4167B
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 10:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKYKAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 05:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKYKAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 05:00:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B0E2409C
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p12so3567531plq.4
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 02:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce6lq8CxQ7rDwg/drADC+l/NTTqEbiitMt4k7KpRdXQ=;
        b=hHIvwkDCErxBPsPBVK44XnFkGu49y0VNqbbn6nvKhM3lj4tonjYGM+VVOnUiqcHxvL
         +p/0LIxfJOfS1suC3fXWRBd5adrRMLMOzD5RGNjsHeHtSB2wWzBSjLnGsfXMCrc68Af/
         kpLHYqvVb7dFKdn4/kohg+cHmSAzjsDEns6rh8GyBkQMRnzkmyQ77UuQk3xLXvh8bTCs
         N32X1dn5VCcS68s7sEWBINaEAQD+LdxK8hEo0ez4TVHhTwXYQQ+gUClUzLD14BUGFkcq
         VP9aPF87QOctIh3JY7ws3e6QhAkoMRN8zERtVxLSeRE1reBbyvLJ0yljpt70FMMsQbGZ
         W0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ce6lq8CxQ7rDwg/drADC+l/NTTqEbiitMt4k7KpRdXQ=;
        b=7wHzQDhV+Tv2wwdOM9E26OYN3bhtLrmEsjtRb+TIl0Qigietm13BBPdA9LgI0aitcW
         cDAVsfYnLTA47zb/14YdLxsPgv71RRybH/nZncoDCbQJPDu/PDho4qANIpMj0iZAYR6C
         gFi0nC99XzSd1V23vLoqkdN0pQFy8Tg+mDzMLJUMlp5S4f8buBgaU34sLk4ht6kLFtOJ
         j55172VNaldMCozzrYv58H5U3THZflRK3Nm75pjMtvtXatBMSh4jKEjj3/Qr194awtfQ
         0f86pO9pfurMlucSOyxQxChPNPnZrQI/mxTG+xN868D3c3fcrTnDWh6TlycmNeSOrXFe
         mkzQ==
X-Gm-Message-State: ANoB5pkjLHagtKpgldIF99xnfW9jfZOyL9KdnD9T2rcg7dGkS8dlbFxO
        4TOzFlavvHglM9qgG04p52L3bfkn84Y=
X-Google-Smtp-Source: AA0mqf6+6dj/DmZL3EHVET7scTKgmW9p9Nur1k7KEMEab0B6B2zv6CEp6v/EcdKgsT7fbwkpqh3dYw==
X-Received: by 2002:a17:902:ce90:b0:186:ab02:664c with SMTP id f16-20020a170902ce9000b00186ab02664cmr20125199plg.49.1669370401374;
        Fri, 25 Nov 2022 02:00:01 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b00186b0ac12c5sm2904514plb.172.2022.11.25.02.00.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2022 02:00:01 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 4/4] ci: install python on ubuntu
Date:   Fri, 25 Nov 2022 17:59:54 +0800
Message-Id: <20221125095954.4826-5-worldhello.net@gmail.com>
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

Python is missing from the default ubuntu-22.04 runner image, which
prevent git-p4 from working. To install python on ubuntu, we need to
provide correct package name:

 * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
   "python" package, and "/usr/bin/python3" is provided by the "python3"
   package.

 * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
   the "python2" package which has a different name from bionic, and
   "/usr/bin/python3" is provided by "python3".

Since the "ubuntu-latest" runner image has a higher version, so its safe
to use "python2" or "python3" package name.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index b569893b38..d8fafc8ed2 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -15,7 +15,7 @@ case "$runs_on_pool" in
 ubuntu-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS $CC_PACKAGE
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
diff --git a/ci/lib.sh b/ci/lib.sh
index 927b4529b0..cb30699f34 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -232,12 +232,12 @@ ubuntu-*)
 		break
 	fi
 
-	if [ "$jobname" = linux-gcc ]
+	PYTHON_PACKAGE=python2
+	if test "$jobname" = linux-gcc
 	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
+		PYTHON_PACKAGE=python3
 	fi
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
 	export GIT_TEST_HTTPD=true
 
-- 
2.39.0.rc0


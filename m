Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86303C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiKXJGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiKXJFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:05:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86F10EA35
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:52 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1073212pjl.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK6JS5gZIRIzK9mx6215aVpMZkDUvJ9gEAPGe0vB2uk=;
        b=A1BJoBEd+kjdrsZp8fhGbwdvrb+Je42amhjcouwuTc1Ajxk2r9HAhaxylWFPPZL53J
         sKoBzMiC7YVFIDBP7wfxZVsMiKbflxHluOBjIQC1bPZL5VDknQkk7pyjHLr9EClp+5Ws
         UW6PKaFMpO/JBLmHHfIodnawtAxzoWzMMRNZ9jQCzy9ZW/YANvC5m+EtVGHEyPm2BeQZ
         H0tO2sfoUEheTGYPye5dZveGmTysU7IdZ67fkERo952jCoEwPa9LoIEv0Dsj4LQzhL+A
         45+RnqYqIQdIan1hIbsYzmTymiACrpiLC9oVsJ8YjA0Ja3sOcm94RbKNEIQDr2JOjNAc
         tdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK6JS5gZIRIzK9mx6215aVpMZkDUvJ9gEAPGe0vB2uk=;
        b=cV8JVjWuPOWlmZZErySomaoTQ5qIShDJ4SUw3dE1m+UnLGgLgY/1lU8/gh0H7l31I0
         mL4aZ4kGRTpHcaGORbbVodVNiRwsNdQQ4o9YH+3Ygm0FnPgx7rxMItV+UnTwPcQY+wt7
         YLmDCaXNPiX0nlnqlT8//9CTT9BfQDUlwr9AyDIvuzhO6DUpDJe7nZWZa7zRFOu3P1dl
         MkxTZHuSpW2tpfRMG37H2mL0Q6Vq/eVjHZ+QM7WKXew1iDBiPIbBA4Jj0b5/okk+z1+m
         ZxFzxmSsRGe2/ubNkNtknbTBy/HOs3h6boF1TEEUfvAQiezPNwmrqCE17CFgZ5n8gpqZ
         tipw==
X-Gm-Message-State: ANoB5pknzH6Vz4pYf61ZhslJW993qUNVCJwpe9PqeY8QiuPZmSa32TkU
        oiqR/IPcUT2EECzz9Kc4/WwVgY5N58E=
X-Google-Smtp-Source: AA0mqf4E46O0Y68FwZGevUOijTN5KTWuDZYkhWZgOIrJfe2g8V4UuknDMio7BKd5l7xu0h+C/TS+wQ==
X-Received: by 2002:a17:90a:ba97:b0:218:f5df:5cf1 with SMTP id t23-20020a17090aba9700b00218f5df5cf1mr4462199pjr.79.1669280751849;
        Thu, 24 Nov 2022 01:05:51 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001893dbd8963sm689356plg.239.2022.11.24.01.05.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:05:51 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/3] ci: upgrade version of p4 to 21.2
Date:   Thu, 24 Nov 2022 17:05:44 +0800
Message-Id: <20221124090545.4790-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
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

In addition to upgrade p4 from version 16.2 to 21.2, also add some
instructions to show errors of command "p4 -V", so we can see why the
command output doesn't match.

[1]: https://cdist2.perforce.com/perforce/

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 4 ++--
 ci/lib.sh                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f639263a62..291e49bdde 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -83,9 +83,9 @@ esac
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V | grep Rev.
+	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V | grep Rev.
+	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
diff --git a/ci/lib.sh b/ci/lib.sh
index 0c0767d354..a618d66b81 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -246,7 +246,7 @@ ubuntu)
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
+	export LINUX_P4_VERSION="21.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
 	P4_PATH="$HOME/custom/p4"
-- 
2.39.0.rc0


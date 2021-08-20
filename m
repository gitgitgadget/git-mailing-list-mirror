Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F247C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D8260C3E
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHTKyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhHTKyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A866C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 03:54:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y190so8259393pfg.7
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jS/trhsdEWXtTR1PgcZ5/mPfmQLxcWwsmLTJ/Jra6M=;
        b=kbUFoOYj8UGaXKh/qmlUfH+vhMGqTVqTJQWLdPR4ecHyXl6pMKwYebK4SVN5YaTpqB
         VfmJZaXFLNgxSas1fheTjUwNYFGBsS3MCkj8gcvaKmD8UuWvSXt1SYbPxxWIAwmN2iq4
         N0vYHoK2GXEx310bfcaR4BHkY/+Q9z0r4MoEVOvew9R0LphmjrSiaL+TR0e1c+XG7oFw
         4axQBTJQCVzHSDAQpqO4cyCsxIHXXYLL1mz6XTTFHBSKycdleF3gDK+aNCJsgU8IrMFK
         DqX2oiv+ersadj+u4+Vp5jMBA1U/rOveAmpSWFZamNUSHHelO/9OqnViV92kccoMa3q0
         fECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1jS/trhsdEWXtTR1PgcZ5/mPfmQLxcWwsmLTJ/Jra6M=;
        b=txNj5XIw+ZqXwx6/7sB8wj4PZgLICNE9h/IVD5vOjL4tDFM+MKi14UEGijSkw21ZYg
         BQ/d70Vgvrq+MC9hokejFMdqqxHR1ea7P32SAAkxCuQMNvIlrDglIQaeU75ZfadQ2AFr
         2rOOVFAj9wCV1H7oUtrAJ68vwGJvwPK4VkA9ofkoacy0Uo4WL/s4w75Jm4XuJb84VpiI
         YSwPq2zsXOgGzctprpJGWC+etUtjpUoSvY2Clz0Ry0hvM82MpkKL1/Il7esfbPYzMfbu
         zNCsQO1vPVa5G2BTOvzCYEPkkHLLw8cssObx5NC4tCzk6czVqLp3stVFBoNiqgoaQydQ
         35Lg==
X-Gm-Message-State: AOAM530fjSOJ621u8dIete/sdlgrGwyN5WyfyniVCMO7Sp3qX2EMDTmw
        WfqPSFLMNTsDDttK+UiyBx+Wq+/HT+g=
X-Google-Smtp-Source: ABdhPJx/LQax5W3kDH8lMstJojHLloozJKVfPorU9DEGvRn0ENg2ZrGRgyMnh9mFUIH/rqFl3h0WRg==
X-Received: by 2002:a62:fb13:0:b029:309:8d89:46b2 with SMTP id x19-20020a62fb130000b02903098d8946b2mr18954018pfm.67.1629456846594;
        Fri, 20 Aug 2021 03:54:06 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-63.three.co.id. [116.206.12.63])
        by smtp.gmail.com with ESMTPSA id y19sm5631848pfr.137.2021.08.20.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:06 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] make: add INSTALL_STRIP variable
Date:   Fri, 20 Aug 2021 17:50:53 +0700
Message-Id: <20210820105052.30631-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some environments (most notably embedded systems and small production
servers), it is often desirable to have stripped Git binaries due to
tight disk space constraint.

Until now stripped Git can be built wih `make strip install`. Add
INSTALL_STRIP make variable so that they can install stripped Git
binaries with `make INSTALL_STRIP=yes install`.

Also document stripping and using INSTALL_STRIP in INSTALL.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Junio suggested me to have INSTALL_STRIP make variable [1] when
 reviewing the install-strip target patch.

 [1]:
https://lore.kernel.org/git/xmqq1r6p1ark.fsf@gitster.g/T/#mc3b8017448bdafedf9250ba407f5de767c20ad67

 INSTALL  | 8 ++++++++
 Makefile | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/INSTALL b/INSTALL
index 66389ce059..98e541ee4d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -58,6 +58,14 @@ suite has to be run using only a single CPU.  In addition, the profile
 feedback build stage currently generates a lot of additional compiler
 warnings.
 
+You can also strip debug info from built binaries by:
+
+	$ make strip
+
+or for stripping and installing together:
+
+	$ make INSTALL_STRIP=yes install
+
 Issues of note:
 
  - Ancient versions of GNU Interactive Tools (pre-4.9.2) installed a
diff --git a/Makefile b/Makefile
index 9573190f1d..e486f3ab75 100644
--- a/Makefile
+++ b/Makefile
@@ -8,6 +8,8 @@ all::
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
 # to PATH if your tools in /usr/bin are broken.
 #
+# Define INSTALL_STRIP if you want to install with stripped binaries.
+#
 # Define SOCKLEN_T to a suitable type (such as 'size_t') if your
 # system headers do not define a socklen_t type.
 #
@@ -3005,6 +3007,9 @@ profile-fast-install: profile-fast
 	$(MAKE) install
 
 install: all
+ifdef INSTALL_STRIP
+	$(MAKE) strip
+endif
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'

base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
-- 
2.25.1


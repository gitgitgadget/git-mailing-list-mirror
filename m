Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E2C77B72
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDAV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDAV3F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B493FB
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o32so14908634wms.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=A1jbdTKQB9fbrB5X3B4Jj5sVyZAQNPOj9c7w5NGhmqSKoZFIWlwILcWVrpMBPcsbP2
         yf7fSwI6wAnmWJUdW9xYUIn/SLp1PHz+AjXodKxf6fT0UyOr0/TJkOSGTr5m7ek2cbnw
         R+e4nNo5bY8DhvDGW7l+i1pk54L2rfC7qyexX2h0zGijSZfX5m0X72yUpgWPjxzJ+K66
         0e2PnS95E+Vcw3gzU+iLRxUX0SOlngoaRWvt966Y6DBL3m8zJUwD2tvz47JZfQketxTo
         /C5G5KS9RHqPSMRujy7CWqgUDbWV5kdfZZRJQpu1Mru86Q6u5biSJ1/tYs+AcbyM28CD
         yYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRu4JBrQ9k+aFnaTKf0xWSTGf6TU8UWVGqC92cgpg48=;
        b=ouoD/Yy1c7yAAKWXXU2Mukp4lJ1qlATof/j2jttRwq+qrdEYkdzEyqXGRtt5NPzKRs
         VGnY5n3jMIFjK7OlYA1AhlzeycPHFIBhSp9zcgh+qdoSpUpkJQCOtroEtrG165BW2kO2
         zfXnHjLg7V33RTO59h8z9WQ0B+4yVd8rwUTYcuBrjZKoyuM/SjQ8RQ4kTmZ7AW7Kzu6U
         7Nmhz2T2g+rWloq1b1tWZy27708VaZAyNcxCrZco5jpZavrviXFodAszd+GpZSthbmyY
         f6Gwxa4UytpapC0TNxTV9gjYAmM3jMIzxsH1H1SnvDOYXTB2tJEgMNS7mDJli+JvZwMk
         15ew==
X-Gm-Message-State: AO0yUKX+6SpzhPQUiZuXZG0XK/YeqPLHvePmhhJXtczs8nykBDoJqfun
        DSgRPP4LNs1O6kbHn+6FgX/pyfiU5egneq2+
X-Google-Smtp-Source: AK7set8e0V5dL9m0h5AlRz0uVKCRucWLLdeHLfUPiXqxU+abDzrRF8flq6J3jnVVFgkERouGViFhDg==
X-Received: by 2002:a1c:770b:0:b0:3ed:4b0f:5378 with SMTP id t11-20020a1c770b000000b003ed4b0f5378mr23351175wmi.27.1680384542275;
        Sat, 01 Apr 2023 14:29:02 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:01 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 2/6] t1300: fix config file syntax error descriptions
Date:   Sat,  1 Apr 2023 23:28:54 +0200
Message-Id: <20230401212858.266508-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in t1300-config.sh check that "git config --get" barfs when
the config file contains various syntax errors: key=value pair without
equals sign, broken section line, and broken value string.  The sample
config files include a comment describing the kind of broken syntax.
This description seems to have been copy-pasted from the "broken section
line" sample to the other two samples.

Fix descriptions of broken config file syntax in samples used in
t1300-config.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2575279ab8..d566729d74 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1571,7 +1571,7 @@ test_expect_success 'git config --edit respects core.editor' '
 # malformed configuration files
 test_expect_success 'barf on syntax error' '
 	cat >.git/config <<-\EOF &&
-	# broken section line
+	# broken key=value
 	[section]
 	key garbage
 	EOF
@@ -1591,7 +1591,7 @@ test_expect_success 'barf on incomplete section header' '
 
 test_expect_success 'barf on incomplete string' '
 	cat >.git/config <<-\EOF &&
-	# broken section line
+	# broken value string
 	[section]
 	key = "value string
 	EOF
-- 
2.40.0


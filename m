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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7024FC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50849613F6
	for <git@archiver.kernel.org>; Fri, 14 May 2021 06:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhENG4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 02:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhENG4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 02:56:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D8C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 23:55:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m9so29049805wrx.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMvgfcOsCZtLK7Vs0Q6XuFT7/RsHKWMP0uATtYr0u+U=;
        b=FT/LZX+q+Uw+W5NdM/aefm6slAKsDEOqQCM3J64J6+Pvoz2XV5LT0yYgrsk3SHsKj0
         2IeBnKriDe7WfmC8QiRHnbYeRcmg68XqKQmwKkZ6HPbCRJ0f6HzlsK3Olvvg98saYu0G
         B89R/CWnMhFnG7rhWrv5bEy2lbBjrZStPj9EWztVrcVVrJWTZ7uSUb41R58FkBBkjFhv
         hTVM/uwfJFUyUFDvIhRxitZR7fMy38wD1o4Gyu9Vmyoy/LmoNIdvmacBCfyU3+qV+2mp
         BZMjp83owcUAQCnig+hwzx/drBfSsLHcQzYH3ixoih8FyJZm2hzpfCuST74k0bpNUsdb
         SOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMvgfcOsCZtLK7Vs0Q6XuFT7/RsHKWMP0uATtYr0u+U=;
        b=G4QqH0q8uOSEWe818Itk68/wPQNtpF/E/Q6KKSXILMFaLZ0XOP9wmOUvY1rgyDbk41
         28BGs4ONO5bYmqN52o/wtdwNacwyLSB3QcF2kn/WCYO3QwIJ6iAywEj1kh/fNf50guSI
         sMBOM9EcnWUW9QBEUvh16EejClJG1nwMo+LVu9mBfmrdg56lMX6tXKV8DjhsLuwhtB66
         BaljWPJikXUU7LDQGE9mOPrET5ikvpw+9GvJx8IgWx8+J+Pz+9kD4pFAHOt8H55ENZvA
         5k/5akzTZS7xpfXKDQt7c4ZckIdxAzZMZbq/yalrOfAhfXFGTzsCECBxxDX3RMQEhl3o
         VxHw==
X-Gm-Message-State: AOAM53036SYcPY/a/OGIhp7HuJjnC1Ae2IwAmXqvPlim+BYfX69vKu5G
        h49rhGPwwFD/HEZj5+BhYts=
X-Google-Smtp-Source: ABdhPJx/PgEFs4frVNKEeACsGZj0Yk3INNaomZ7cTQ2hdksMKOfW1jkGVI1JK8rkEpcs+qyigQzcwg==
X-Received: by 2002:a5d:64c7:: with SMTP id f7mr55570049wri.257.1620975323225;
        Thu, 13 May 2021 23:55:23 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001c07d070726df7f9.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1c07:d070:726d:f7f9])
        by smtp.gmail.com with ESMTPSA id n2sm5401361wmb.32.2021.05.13.23.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 23:55:22 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t/README: document test_config
Date:   Fri, 14 May 2021 08:55:07 +0200
Message-Id: <20210514065508.247044-1-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_config is used over one thousand times in the test suite, yet not
documented. Give it a place in the "Test harness library" section.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 t/README | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/README b/t/README
index 8eb9e46b1d..f69aa05c61 100644
--- a/t/README
+++ b/t/README
@@ -1046,6 +1046,21 @@ library for your script to use.
    Abort the test script if either the value of the variable or the
    default are not valid bool values.
 
+ - test_config <config-option> [<value>]
+
+   Set the configuration option <config-option> to <value>, and unset it at the
+   end of the current test. For a similar purpose, test_config_global for
+   global configuration is also available. Note, however, that test_config_*
+   should not be used under a subshell.
+  
+   Example:
+
+	test_config format.coverLetter auto
+
+   Is a concise way to write:
+	test_when_finished "git config --unset format.coverLetter" &&
+	git config format.coverLetter auto
+
 
 Prerequisites
 -------------
-- 
2.31.1.443.g67a420f573


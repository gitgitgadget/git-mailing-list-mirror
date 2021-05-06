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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79839C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55225613C2
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhEFQxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBEC061761
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so3404050wmb.3
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC0BC5oYnVj1FKJXiYqZE7eHen0OEzX70j/8Mne4u+4=;
        b=LA1BBcxbBHnjcDNWc/bDkEBzrfexuKFwjuAvNxWyFJnKW+F857LLVRhS96pkaURFli
         sOwINYFhGdCTZWDlk72wI8c1AnIWNMylsOCVj7wDOjuUdDkLptn46AQECzxp9+f9ZgF8
         s/4v/UY68MAYGLPh+P2Xl7Xw+1tHlFiZX2ShgyhQMxSXjMq9kuuCK5w4KMzPyddvV0gR
         DSzG1RuXGLEdXgqUb+DL9J8E/1w7JRsch9Ijn6t1HlMMTKEj6eihuK5ohv2MG27MlLuz
         k7n90D8ubVYvlGeesHIIiU2wWnnrWnP3Lwmn5OIqdAm9w6zpU4Myup37sMFf11nOSYB4
         ibcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC0BC5oYnVj1FKJXiYqZE7eHen0OEzX70j/8Mne4u+4=;
        b=DK04IC67dvvXAfAvtJ9BB8f1iQCRPQxndUGKGXmgkFUQ33jApu6wAwGweeZYd71P/o
         YcB4vt1Ad+JDYRSj1m3PCj+Ag7sDPqpDEeLHMIeeb1GAu2fM4xP2MeBrx1829f049Mnf
         tNrL90hCMAfFn7UcWZIvQZEnDcCVFBE7IKtlbac0IhTm9aCC60/aQEUB2DCnKlMttyYR
         y5Hg1ltFiC5ZW0XysVuLDzPzgn6no9blUc6cF6T9hnazn7insTkLmTc+5WXpQqQZUulL
         2JeCvMtYZZALiKER+U0q6ifBH9zVlZ6F3AWin3L001FF08XCdIs0K5qFchpv1qOKXDho
         YqHA==
X-Gm-Message-State: AOAM532R6Uu9dblIY+wK522VSoPRnZ+QX6b6JMm6IrXicXEn/ZUco53P
        LvTNS0hdOku4gR6k4NefR2w=
X-Google-Smtp-Source: ABdhPJy4Q5IdPtXzPAR70Lzxh7SEN1lRaBMCt71xNXgxX7oTL16cJ/T22Nre9uUD3NHkOkjLuaTrlQ==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr16561302wme.84.1620319964444;
        Thu, 06 May 2021 09:52:44 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 5/8] t4014: test patches overwrite confirmation
Date:   Thu,  6 May 2021 18:50:59 +0200
Message-Id: <20210506165102.123739-6-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 t/t4014-format-patch.sh | 123 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 712d4b5ddf..cf7e48f4de 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2256,6 +2256,129 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 	test_cmp expect actual
 '
 
+# $1 = git format-patch extra arguments
+confirm_overwrite_setup () {
+	test_when_finished "rm -rf confirm-overwrite" &&
+	git format-patch $1 -o confirm-overwrite main..side &&
+	for patch in confirm-overwrite/*; do echo 'APPENDUM' >>$patch; done
+}
+
+# $1 = format.confirmOverwrite value
+# $2 = git format-patch extra arguments
+# $3 = git format-patch with prompt (Y/N) or without it
+confirm_overwrite_test_body () {
+	if test ! -z $1; 
+	then
+		test_config format.confirmOverwrite $1
+	fi &&
+	case "$3" in
+	Y)
+		echo Y | git format-patch $2 -o confirm-overwrite main..side 
+		;;
+	N)
+		echo N | test_must_fail git format-patch $2 -o confirm-overwrite main..side
+		;;
+	*)
+		git format-patch $2 -o confirm-overwrite main..side 
+		;;
+	esac
+}
+
+# true if all patches are overwritten, false otherwise
+confirm_overwrite_all_overwritten () {
+	for patch in confirm-overwrite/*; do test_i18ngrep ! "^APPENDUM$" $patch; done 
+}
+
+test_expect_success 'format-patch overwrite unconditionally patch series without cover letter' '
+	confirm_overwrite_setup &&
+	confirm_overwrite_test_body &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch overwrites present cover letter (prompt/Y)' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "" "--cover-letter" "Y" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch does not overwrite present cover letter (prompt/N)' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "" "--cover-letter" "N" &&
+	! confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --numbered-files overwrites existing cover letter (prompt/Y)' '
+	confirm_overwrite_setup "--cover-letter --numbered-files" &&
+	confirm_overwrite_test_body "" "--cover-letter --numbered-files" "Y" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --numbered-files does not overwrite existing cover letter (prompt/N)' '
+	confirm_overwrite_setup "--cover-letter --numbered-files" &&
+	confirm_overwrite_test_body "" "--cover-letter --numbered-files" "N" &&
+	! confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch overwrites existing cover letter (format.confirmOverwrite = never)' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "never" "--cover-letter" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch: the user disagrees to overwrite existing cover letter (format.confirmOverwrite = always)' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "always" "--cover-letter" "N" &&
+	! confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch: the user agrees to overwrite existing cover letter (format.confirmOverwrite = always)' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "always" "--cover-letter" "Y" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite has higher priority than format.confirmOverwrite' '
+	confirm_overwrite_setup &&
+	confirm_overwrite_test_body "always" "--confirm-overwrite never" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite cover: the user agrees to overwrite existing cover letter' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "never" "--cover-letter --confirm-overwrite cover" "Y" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite cover: the user disagrees to overwrite existing cover letter' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "never" "--cover-letter --confirm-overwrite cover" "N" &&
+	! confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite always: the user agrees to overwrite existing patches' '
+	confirm_overwrite_setup &&
+	confirm_overwrite_test_body "never" "--confirm-overwrite always" "Y" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite always: the user disagrees to overwrite existing patches' '
+	confirm_overwrite_setup &&
+	confirm_overwrite_test_body "never" "--confirm-overwrite always" "N" &&
+	! confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite never: overwrite cover letter unconditionally' '
+	confirm_overwrite_setup "--cover-letter" &&
+	confirm_overwrite_test_body "always" "--cover-letter --confirm-overwrite never" &&
+	confirm_overwrite_all_overwritten
+'
+
+test_expect_success 'format-patch --confirm-overwrite never: overwrite patches unconditionally' '
+	confirm_overwrite_setup &&
+	confirm_overwrite_test_body "always" "--confirm-overwrite never" &&
+	confirm_overwrite_all_overwritten
+'
+
 test_expect_success 'interdiff: setup' '
 	git checkout -b boop main &&
 	test_commit fnorp blorp &&
-- 
2.31.1.449.g4a44fa8106


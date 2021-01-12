Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D96C43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E4D22E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405697AbhALItK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405681AbhALItI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:49:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B086C0617A4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y17so1534853wrr.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4DhR/G2xA842bEu7wGUO3+7cLp9usxdVGpDGIUia6kI=;
        b=WGvmoGyFsBvR6NpQuIYJeOvO0zCRC0LcRNKxk7/3RxBI8bqp9XtEPeKVjGdPYAVpIv
         lIzhHhxvoYGa7aNqaPbpDTxwc1z79UKXCIy21FWS2RyRmAx68tpLmTrh3XqNSK8Nq1YD
         dHFZArmXpvPuA6c5mM9OQunk6LJ+yC2QUmDcyABVzatovgO9tU+TYwtdtYIBzt1Ujr4Z
         6kXgp34bwMBLAlz20x2u1Pd4O1ES/nxSkcG680NBuPvoN4kPbH7Z7UBqrNqg0zwkASmt
         La/KwUFW/28HpaekDWarvTm8DPrdYoe385PLoQ9KW9OxKN1qYOgHAdReY+C14k5lwFQx
         WsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4DhR/G2xA842bEu7wGUO3+7cLp9usxdVGpDGIUia6kI=;
        b=dlg6bcdgAo0WKQxqlNVSvJD7q+JoV6Rkx0TAO665u3PgESIvPGlBizDlLj1gyIjFJn
         QTVksBQ/dSFXVZLk3+6Ic1CXkArHPnqeeVOOeQPjTpDvtA0AJP20IKVW+Fl6MhPFrYJd
         JQjt8WLDsVaAA4QEyD9sWczQVugVYctbUkbSUOgQkjCdXIZm2VEJazGPdHco4kQXUJow
         wuF+0PmAmszprtsJ1sCbu07g1jNQ3JdvyUUGI//lHulRu8xRnEBQpHlnLf5cd3OptJoJ
         ruIemKh2rXT8tPtzjQsAg6Nq0540wIcE5BPEiiTpElYx6G5Typ2zGwYkaeAPycPQrCgR
         N4ew==
X-Gm-Message-State: AOAM533mdU7GGyNIlcQgneVQKMX3zK5W5Jp35IGIvp928hzi28aZaj02
        tnIPrkcACkeXeo+hOdEn21scWBwTCsA=
X-Google-Smtp-Source: ABdhPJzFtXebooGoiIdSnwJrp2ZJ8YR7TYlWX1lqoPKDYYtL4sfWcXHqw4G+Zu8s8wYQjm170HRkrg==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr3041607wru.213.1610441270911;
        Tue, 12 Jan 2021 00:47:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm3975899wro.60.2021.01.12.00.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:50 -0800 (PST)
Message-Id: <5aa21ffc7f94262a5c31fca80d998115d3a5522f.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:38 +0000
Subject: [PATCH 07/11] t0027: mark a function as requiring the C locale
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `check_warning` function uses regular expressions matching English
text, it therefore won't work reliably with anything but the C locale.

In particular, we won't be able to match the needle 'in' under
GETTEXT_POISON=rot13.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0027-auto-crlf.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 9fcd56fab37..baa5c6f435b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -76,6 +76,9 @@ create_NNO_MIX_files () {
 }
 
 check_warning () {
+	# The `grep` and `sed` below expect the locale to be "C"
+	test_have_prereq C_LOCALE_OUTPUT || return 0
+
 	case "$1" in
 	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
 	CRLF_LF) echo "warning: CRLF will be replaced by LF" >"$2".expect ;;
-- 
gitgitgadget


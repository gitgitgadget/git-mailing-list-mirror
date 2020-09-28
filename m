Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27F5C4727F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 701D4221EC
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToEiTFll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgI1Lk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Lk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:40:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF313C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so966420wrm.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jssRumMUVvXD9Pg+O3yXWXwH1WAJlm10VQhXSQq2J3c=;
        b=ToEiTFllguFW74vPBZKttHK7eUcNwXXOhtWiROnUliaTltOapfrtv38+LfxsZ0Z32t
         MQoYLFBdFhVQCcHGFQDbxjh3yIrvI9Yzf9MA5lfr08nUa2hKSi/Cj7FMapRY20eMm1Gu
         htz/Exwv584zMQgjZU68NdZjOIWuu39CZntJ5xTSx8DNLgSIKgy1q4PgWyUnVxBG97AZ
         R5ofdAAJrPgD34BksENqxcyRSZ/MlruUd8bty6/KlvguZdmo42D5gsqv+ZTCWt5s3hvL
         JigKx9R7Z4KumnbwQz6gXTbr3441UrVdMfIPtN3EwDuJXU0irYh4FSXY2P4V7zcvsLoG
         bjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jssRumMUVvXD9Pg+O3yXWXwH1WAJlm10VQhXSQq2J3c=;
        b=NTBKlXcRTa6liBVka9MqVWwDOx1psmn42eF5Cb4dMASWT8uVQi6ePkWAF22VG9CQrz
         dd1iAfcCUcTfp5ClRh/0+gyTcFTOukdqu6k+vh531LMcbxs0TamgIkDtJFbWySm6FCVA
         BbEH01Z0opnMObPLvl+6a8ugQExieVU9i3ki40Tj4ighEK0Nz3q54Eug41uq8ajS4Mi+
         HKaMaWqfzyJihnOurGiXlXRFRf4SkkCnSEMjsS9dMy0qUROwBOKevZZKh7cPhYLLfTAK
         BypZchtseDspuCpv7ilpfooJuHh0V0rtdK+CH1NotpTFr/yLG7d7oBglvCafmD4B2kaF
         u2pQ==
X-Gm-Message-State: AOAM533fZ+P5bU1tP4pA5epTQ0e8mWQvNGiJhcdZW7KuQohHyym2V/QN
        TDweoQaHfgy+LL28akQLQ+xBiip/+ME=
X-Google-Smtp-Source: ABdhPJytHVgPnoX3feBSpOAoag88i47ru2ZMyAz8GEWN/Af8TCFfVKNQethy844eejA9G1rz2Khxxg==
X-Received: by 2002:adf:f24d:: with SMTP id b13mr1240841wrp.316.1601293226473;
        Mon, 28 Sep 2020 04:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u126sm1225736wmu.9.2020.09.28.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:40:25 -0700 (PDT)
Message-Id: <27f6400a21412d762b290a34a78ebe7296d36bf3.1601293224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
From:   "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 11:40:22 +0000
Subject: [PATCH v2 1/3] credential.c: fix credential reading with regards to
 CR/LF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nikita Leonov <nykyta.leonov@gmail.com>

This fix makes using Git credentials more friendly to Windows users. In
previous version it was unable to finish input correctly without
configuration changes (tested in PowerShell, CMD, Cygwin).

We know credential filling should be finished by empty input, but the
current implementation does not take into account CR/LF ending, and
hence instead of the empty string we get '\r', which is interpreted as
an incorrect string.

So this commit changes default reading function to a more Windows
compatible reading function.

Signed-off-by: Nikita Leonov <nykyta.leonov@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index efc29dc5e1..e5202fbef2 100644
--- a/credential.c
+++ b/credential.c
@@ -202,7 +202,7 @@ int credential_read(struct credential *c, FILE *fp)
 {
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&line, fp) != EOF) {
+	while (strbuf_getline(&line, fp) != EOF) {
 		char *key = line.buf;
 		char *value = strchr(key, '=');
 
-- 
gitgitgadget


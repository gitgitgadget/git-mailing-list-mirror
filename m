Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E183C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7E060F6B
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhGZX1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhGZX1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:27:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67342C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:07:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so1165937wrv.11
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NM0cHwZCtcVhVVCDlP0u1lyxB4+5RmjCct2rQmMZ44=;
        b=TuIkfokkFbhIKFzP9wAgdlj5cLvohRNuDPtvuFCH3uBqxuAlT8n63DJReWGUEhvCct
         yAvF3sXuH1KW4OVu2jZIzCkX8vYOPfzxpvFMGP/9Ra9027BpCHdq8tpryLNtMGwFA+Eg
         /Avnh864YV2IJUvGsaEbVz+p04akcdK5XVQ0IkQYXSn0IyN4oizjH/hAIpJp8ZjZsD7F
         FAFF5GutcLO7gueRNEqgoixLYQ/J7pcpUj4IQ3ARojjO7B2K5nNbzTWbtHfK5E4hUl+2
         rwyBnNKTyB+GTa4vWBXrpwM3DTnt9G9QF9SjGr7OEuior9D013JembB6X5M0zXLS05Va
         3fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NM0cHwZCtcVhVVCDlP0u1lyxB4+5RmjCct2rQmMZ44=;
        b=kRid0mmButkS2shfMks+Z2cIcPcqMJkB5AcXsDj0DWkwoEJbjiPT5oA7E58qHsuV91
         u0G1CDm/kgzPzqeSU2OPvzBSl6Qak9HH10vGf/D3Z6cF+MGtCxDON4eqHlhI/Y9VnnXR
         BOarj867L2sNbkfaId+xBnWGMcwTetJ3DN066pcTm+bcLNqoAMXyINAFB6AD/5vwOcfp
         mHslPJdkVVuYbylYJ4zm/go3nBfUn3zhJv/adgYzzEIRgnvMz9JlpVTDd3GmMdAkt6lH
         rdp1P30p2j0sBNgK1Z2H8k4jZrMHPqF4WaRbBjHbLVflx+yIOUBaUkO4oh5JPoLfyreY
         1+hw==
X-Gm-Message-State: AOAM533gze2CxOfEL/IUjlhSYqBRaZ1Yw5VXS7bLG9iiqWo8BcTqT8lp
        U41KoWNtM/OZszUfOQSaJOV3tCCKx4QL8Q==
X-Google-Smtp-Source: ABdhPJwStDjPcfnmiPO6y2Izeiurwv25kblMF1/ZGEkCCoPOk2q1Vj2sLdbrt4Ae8ttKt2EOJ2fAVA==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr22905746wrt.244.1627344455827;
        Mon, 26 Jul 2021 17:07:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm1310619wru.40.2021.07.26.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:07:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] http.c: use error_errno(), not error() after fopen() failure
Date:   Tue, 27 Jul 2021 02:07:33 +0200
Message-Id: <patch-1.1-ad71faa6da-20210727T000657Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error reporting added in e929cd20bb3 (http.c: new
functions for the http API, 2009-06-06) to emit strerror(), as fopen()
is a failing system call we'll have a meaningful errno to report.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 8119247149..f7940f1b5e 100644
--- a/http.c
+++ b/http.c
@@ -2341,8 +2341,8 @@ struct http_pack_request *new_direct_http_pack_request(
 	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(packed_git_hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
-		error("Unable to open local file %s for pack",
-		      preq->tmpfile.buf);
+		error_errno("Unable to open local file %s for pack",
+			    preq->tmpfile.buf);
 		goto abort;
 	}
 
-- 
2.32.0.988.g1a6a4b2c5f


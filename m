Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A15C1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 02:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfJACaI (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 22:30:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41782 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfJACaH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 22:30:07 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so15350387ioj.8
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f527cBm5hHiU3TB11TmtQ2zXDSWB9HMJsiTHUHhZwpY=;
        b=oAdZxpVHJ0O3yYZhYq/N5HN4dCfozyO90gwVJL33B9gXhc+Gp19xdC0RWcUF89bTTr
         /Vv3ArvKOpR/o7wfZDY25WRGCRpQr7fmz/EvnkeYDEqnpeAZwCzLeLTEADXhcJ3ltpT/
         kjlcXhIXBIOXZGgxrsOXWDUNEYlwxhKHqECRkqfDlP1zJnUWtjKsAllHN5DbtoDL7ouF
         LcEzsHNaE2O2h8pZia/lpWxm1HadKExEM2ZWbEJOAFVYzksuhfJh7sMkTATTdkcsdXsN
         /OULOWmUr3wY05qATienluFUTDKWlZ0fEXTlBG/7NNiury8yDfcOzeLHQ5KSZZrrgNfw
         /oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f527cBm5hHiU3TB11TmtQ2zXDSWB9HMJsiTHUHhZwpY=;
        b=koSkmS98qV2Nx92dJ9eo4CnTNvrD2AE+dUU2gAK+TpEjv+wxatBWVGBMgOSKtZFaYx
         8QqNPFMuvMtZNGla361ywKaRNwxwoN6163mPlTUYOkYpYE03rZzBNfgNj34gOnhRXL9V
         nO3bHFmVeFY7frfZRay2oxopHi/QUkzEtE0eF1Q90TXn/D6iXR8CwB0Pyc/TD2eC1PQH
         7re1sMAbPNm3uDyu307bbwnIGzZxJGfn0AfqyqVwbPxrhBnMUkYZodd/JDtG+9SzB93i
         LExvJ79H5IGO0V2FhZDyoEgjt6DOzSkubHRTZM5PR4L3lgB3aLx9niZgyUhVFrNkYvu8
         bOBQ==
X-Gm-Message-State: APjAAAWDg9TqcKIYsoytjkG+PSCXM2jb4RY46S9ISpr1xJGS1WJRHwEA
        7Flk7Z3qEEpRI+XjlZlohRCOFiBmiDs=
X-Google-Smtp-Source: APXvYqxl2uNq/0luRnRg78Q4KVCCowawIDzAtiWkEtap0OM4A9EG+6Xx4GbGzhfJcIMSzdI1BYt2OA==
X-Received: by 2002:a92:910e:: with SMTP id t14mr23853661ild.40.1569897006715;
        Mon, 30 Sep 2019 19:30:06 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id c19sm6415765ila.19.2019.09.30.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 19:30:06 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        cb@hashpling.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v5] wrapper: use a loop instead of repetitive statements
Date:   Mon, 30 Sep 2019 20:29:36 -0600
Message-Id: <20191001022936.1757141-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001022936.1757141-1-alexhenrie24@gmail.com>
References: <20191001022936.1757141-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A check into the history of this code revealed no particular reason for
the code to be written in this way. All popular compilers are capable of
unrolling loops if it benefits performance, and once this code is
replaced with a loop, the magic number 6 used in multiple places in this
function can be replaced with a named constant.

Reviewed-by: Derrick Stolee <stolee@gmail.com>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 wrapper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index c55d7722d7..c23ac6adcd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	filename_template = &pattern[len - 6 - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
+		int i;
 		/* Fill in the random bits. */
-		filename_template[0] = letters[v % num_letters]; v /= num_letters;
-		filename_template[1] = letters[v % num_letters]; v /= num_letters;
-		filename_template[2] = letters[v % num_letters]; v /= num_letters;
-		filename_template[3] = letters[v % num_letters]; v /= num_letters;
-		filename_template[4] = letters[v % num_letters]; v /= num_letters;
-		filename_template[5] = letters[v % num_letters]; v /= num_letters;
+		for (i = 0; i < 6; i++) {
+			filename_template[i] = letters[v % num_letters];
+			v /= num_letters;
+		}
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
-- 
2.23.0


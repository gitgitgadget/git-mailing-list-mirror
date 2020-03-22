Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070DC4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B178B20754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl9ASiqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgCVA4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:17 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33316 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgCVA4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:14 -0400
Received: by mail-pj1-f68.google.com with SMTP id dw20so4608313pjb.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xD4IRpQsYEKlskeJAyETTTopx15+pbpH5BEzlyPlcTM=;
        b=gl9ASiqqcjY5/YBaZGqHiTQ26i9io/N4PCnMsOJm4OcwFfyWDaIKSnCOVVZbPKPVnr
         sxDd4+u+dB5VA9bmLDtfDekFqEcqnKNPSr532q80kxHy9KeLWke1TuL5UIIJFZ4Pd2BH
         3Scwvjp68B0wdYvsAIiN7ItDYcanBFqZ5XUUo7Yo57WszJych6ODoCKlhNsoDIPQLPX1
         HDX55HmLLOr4nJWMisIhsFUXqR84Dcd7R4uWs7muk7TAgYYZFkaX+12hRm2hMoE64HUp
         1sguQBUA4/QO4N+d5DH4Aqb9f3IdnCFR70NsnlXqvGbCibDfvuohm6/nU75OjvnWQGyS
         j8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xD4IRpQsYEKlskeJAyETTTopx15+pbpH5BEzlyPlcTM=;
        b=kiOdz3YujNY7iS6xgErc8MKzIiyEBusTYiGa7r7QGN6Hv0nG1xXeeUaDfHBRPV3TYo
         yXi3NK/imk72qusHCICqynCrwSJuUu7nmIJpzoZbw13W6h/L3fZgtG5HnTwHQ3b/3tKX
         /Z8q1Xba5tSfZYGxGp/RiRBzAiAd1o2I/PZfoCq5T+UftLXzmvDLqdVVkHx1yDd3kkm0
         UNDYV0BAdRXl9LB4biT27NLKcPE7V4a5ffLtwDUciKO47qqBD7hM2f37msn6jeONJU9s
         NjMNp2t5kHf1q2VD647P/X2N7uXFrObK8QvrXA6EUUD6oCnHnN2cR1B1GFI7yc5uydr5
         SAaw==
X-Gm-Message-State: ANhLgQ0Z9G9JPKA04Ula7ymI8ozDC10sO9AEO2UkKavf17fX7m4IkaZZ
        nWVlrSEGwK5aRUspRc0vsvdi0ntP
X-Google-Smtp-Source: ADFU+vtG/Nm3t0nziURxpo63iXe26EVHK0aGus4PRW3ijglIKUWeCXGiP/cZuWRfamJfeC5NP+zZUg==
X-Received: by 2002:a17:90a:272d:: with SMTP id o42mr15196582pje.194.1584838571696;
        Sat, 21 Mar 2020 17:56:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:11 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 5/8] t5616: use rev-parse instead to get HEAD's object_id
Date:   Sun, 22 Mar 2020 07:55:17 +0700
Message-Id: <ee7ef352a768db39a281df2579841789e4e2a184.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only HEAD's object_id is necessary, rev-list is an overkill.

Despite POSIX requires grep(1) treat single pattern with <newline>
as multiple patterns.
busybox's grep(1) (as of v1.31.1) haven't implemented it yet.

Use rev-parse to simplify the test and avoid busybox unimplemented
features.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t5616-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 77bb91e976..09e640cae4 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -49,7 +49,7 @@ test_expect_success 'do partial clone 1' '
 test_expect_success 'verify that .promisor file contains refs fetched' '
 	ls pc1/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	git -C srv.bare rev-list HEAD >headhash &&
+	git -C srv.bare rev-parse --verify HEAD >headhash &&
 	grep "$(cat headhash) HEAD" $(cat promisorlist) &&
 	grep "$(cat headhash) refs/heads/master" $(cat promisorlist)
 '
-- 
2.26.0.rc2.310.g2932bb562d


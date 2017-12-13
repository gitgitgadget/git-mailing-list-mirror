Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFDB61F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdLMPN6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:13:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35600 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdLMPNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:13:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id f9so5857348wmh.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwRj7IuavhqesGbFO+pvtGk4kqJPi4ZVqH6eTcTa//g=;
        b=YfbpV9XLWTirOtCkBRVPBT2yEg+uUfpOGf1AZHpvq0y3iNn6deX2ArdF4Ukg/8URZC
         vXSJlo7rRkv3UXyMeCP0ytNQSickhX/EpFI9YVKbq6ox9EApkuFDHd6UrIzAEV06Up+N
         nGTvop0HfXK0AVgiq9figsElCframNe+2x2NpwRJkNsfZ5oY7fm4ckpTjoOfdw/O4knW
         HZ4R80QNRI2kmwH8RjYiJ7UF9OqSI8fCRyjKSigsMGwL+b6YrMTOa+jk6kSB+InGW2Ai
         AQ6TVLj+5Ff7eNNRV246g3CbSBbf/1iB+lkUuhTlp83giBM9474uKsN/SGGBITjVYeRT
         7xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwRj7IuavhqesGbFO+pvtGk4kqJPi4ZVqH6eTcTa//g=;
        b=Vn+GoBAtot+08sluxH7OztNsexhGOxFrSuois8XBa/2OQjpTzMkbJVPRFg5j6NUDwF
         qJraXNMnpZULAEonPeWphssSe9VtBVV+abNqcJTaKgnpeyej4+9pLXE3vjAb+DQbLfNp
         Zpl586MHqfb8cSf+FmuIe8fdITu99fZpRd5XYfrl1Ypd2lUxUC7rWoN4US2KNLfLKtGa
         BMskJu/R6RFEO05A+Da4mduX+wp5pdtHiCdiKnN6S7NG/sOpj7Sr/XGIjiWjlI2jdlyy
         4efEHDPENgBGrP0ztKWvxsVHgs1a8FisdBDKF7T4K20ECEKHVu/cRaDTCs2peWCIQfI9
         oT6w==
X-Gm-Message-State: AKGB3mK1oZA+z60GTM/oD65ZFu7xexJF/R7BQ0fA7iEZeAXxv7gOHrCK
        P0H1g3Bt+iVYycSsZbqO5ocmfWkM
X-Google-Smtp-Source: ACJfBosMeuZI/8106GX+U1bOxuY/1ZJaV62NDfuImy84FXyPvrQX1Zq36asw0pyW4TYofLKC2c0Hig==
X-Received: by 10.80.215.29 with SMTP id t29mr8205924edi.45.1513178033983;
        Wed, 13 Dec 2017 07:13:53 -0800 (PST)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id z56sm1552690edb.72.2017.12.13.07.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 07:13:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/8] perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
Date:   Wed, 13 Dec 2017 16:13:37 +0100
Message-Id: <20171213151344.2138-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171213151344.2138-1-chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index e401208488..769d418708 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -70,7 +70,7 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
-if ($ENV{GIT_PERF_SUBSECTION} ne "") {
+if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
 	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
 }
 
-- 
2.15.1.361.g8b07d831d0


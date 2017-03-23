Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4869320958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935317AbdCWPuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:50:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34317 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935231AbdCWPuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:50:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so17370079wmg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9NRx4H8TJl72dK2T/yBdVBkOT6Oul8bHeAKfanJ5pw=;
        b=AV6K6raXAvE61Ie8w7Vr/o6kf/YjT0P7ZgMgiWsa2Flv/2jG3Dyav3pTBQdWnW4cAR
         DfmaKtm25rMcbwjKWs4gWdaix3/DRL8XO705hbnUTyeViN7B1nRkvShZZmfNGntvg5AU
         oKjblafxMffA7NLBH/5n65SofVeJjEMukllVVBdF62/78QosMwWjvKo0M62xLtviaYMV
         eW4C3+r1DQbt+hMaO+Mx0RoETXuOQRgQVT4T/EckO0SeyPW2/IdvZ/B97XjRLIELABu5
         ZMwJxdQ9GesDOzK0Mb0z/V9bxG9P02qpDpcWfkEzimeFJr2+nRYgJ6Lit7FlSOEtF/8O
         vrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9NRx4H8TJl72dK2T/yBdVBkOT6Oul8bHeAKfanJ5pw=;
        b=dbhEUc0b+2KDkIFI7pmNCUby/zatop9K1DD/Nm4pO32qNrjGb3/v5YYVwyxloMCWg5
         BSgapKNTCG7ol+xW3Qv9oOf48HrLHXXASwibCiWm6zoxOQTLeSYcjLhFu7j7yDPNHrSJ
         h7iwL05iCqyHeZATPd1qKXvVqnFUbjBNBoykcoE+dCW85jn6EMOVE44cdzrDF+aps02m
         LBfYNG+w3glvNV2V7c1Ug/aKQk3CMB+Ks0O7KXeLS5QAWmh/Ys0JxkHRgBgGgArwcw9/
         U/hAFgF9tdeKhxhWZNfM4dnhIOjHOIWrQRJH/jxgYHJTlxXfFsNxxRbIHTUBmQEAlQPR
         8muA==
X-Gm-Message-State: AFeK/H3rGT23PDAqjyHZKLnC7fioY8t5zqvoe+nnDKvQJtF+MCgPEihlkBWbXOmg2dvuBQ==
X-Received: by 10.28.128.209 with SMTP id b200mr3743580wmd.140.1490284217197;
        Thu, 23 Mar 2017 08:50:17 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id l90sm4855401wmi.25.2017.03.23.08.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:50:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] refs.c: use skip_prefix() in prettify_refname()
Date:   Thu, 23 Mar 2017 16:50:12 +0100
Message-Id: <20170323155012.6148-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This eliminates three magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 refs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e7606716d..0272e332c 100644
--- a/refs.c
+++ b/refs.c
@@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 const char *prettify_refname(const char *name)
 {
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
+	if (skip_prefix(name, "refs/heads/", &name) ||
+	    skip_prefix(name, "refs/tags/", &name) ||
+	    skip_prefix(name, "refs/remotes/", &name))
+		; /* nothing */
+	return name;
 }
 
 static const char *ref_rev_parse_rules[] = {
-- 
2.12.1.485.g1616aa492


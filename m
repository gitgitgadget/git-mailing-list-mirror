Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427871F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404905AbfISVrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35342 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404755AbfISVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so65766wmi.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atmT5bA0hJwpSd/Lb1emUqBp1XHkmCMK4qZsNbjQ42k=;
        b=AGhY3kxIUr20UhyboYHo31O5L45X2KUm2GK5w/BC0uC1y6BRONVvYZDwM1QxDlxc1S
         Agrfn5QIoZWzRPpzJOMqPxvsUw7p6pMSv5ZbsseYR1snauNILGmgBCk5kTkceM5s5eag
         bN6MfjCwXkmdEN6KeAaRA/Uqd0flakc4mqar64FIlFCDU4c2P+TGVXjmGaONSVbmbzVf
         Ygm8B2p1QtQf6lbTlAGX4AZ4SpIwsgqI1QfkCuZ9MUN8k4tOxZiK2dKkU4hcb4k2RSQI
         LsAGREDhv538VKb0TFYklL/URZ9PLFrNEKpOUgeOcFONpl+bKRrjmy1bFf7hX3AEGn0o
         04wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atmT5bA0hJwpSd/Lb1emUqBp1XHkmCMK4qZsNbjQ42k=;
        b=WP+dm0Q5QOyO3YUHJsTyVkiOTGtglYKPOmOp6s6uRBripjoxoHYGuC0JgECMVgrfOp
         woNv9wm1EIwNbhLVF61401w+Fhhaz9XGPbLtylxJNfV9A0Q2WftkVZrWPRklfUMPQT9K
         jNTjqIQ/0xDGOrY8KL1MbTBIQmru3IQIGTu7H/FGCkqrmN7uB7wnJDw4U2rSW/m/SrcV
         b75smdEVSqb8ERr4dFdcjaJmTKfECFZHR6iwPRtHPenlyseWPojuZy1c5+VD7QhTEDBx
         1yf9POOOiFnqj0//KMNW91prBN1RZJQP7INtr9QMD3zU8Zd/KgvOMqzCaj0qhAH5j8Z0
         FDlQ==
X-Gm-Message-State: APjAAAVhK6reBx/jfQ1Pl5fnSB+wHnwkgNF94l1kuu+fXMkeVGbbpiis
        0aoxaslMh/jddXiRV8gbgko=
X-Google-Smtp-Source: APXvYqxsBYXRrw5RjEIsauN9iwFxVLC+irmoQ2bJZ5/rF1FnYSh31jj+wydyFVnAc/iGXKtGLl3qYQ==
X-Received: by 2002:a05:600c:295b:: with SMTP id n27mr36628wmd.128.1568929643519;
        Thu, 19 Sep 2019 14:47:23 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/15] name-rev: avoid unnecessary cast in name_ref()
Date:   Thu, 19 Sep 2019 23:46:59 +0200
Message-Id: <20190919214712.7348-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casting a 'struct object' to 'struct commit' is unnecessary there,
because it's already available in the local 'commit' variable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index d345456656..e406ff8e17 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -268,7 +268,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		int from_tag = starts_with(path, "refs/tags/");
 
 		if (taggerdate == TIME_MAX)
-			taggerdate = ((struct commit *)o)->date;
+			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
 			 from_tag, deref);
-- 
2.23.0.331.g4e51dcdf11


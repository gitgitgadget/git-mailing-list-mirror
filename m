Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F3C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C151222464
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP9TjTEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATOie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33197 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so29871433wrq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1w/Hc4cOkaibn8kvCOgrzsn1RxBbiqlk6Mv4m5lJ4c=;
        b=lP9TjTEqjpmJMf7Ydfp7c4k1zHuDGG4M58rxboREdfLoNixWuNhpfioE2NUkGv/sIi
         3tW51o/KT3ChNOb/2FrK59zmRBAl7S+0PW2Cv3o48lnhw2S83RiIoAjYUSGz0XNRqEB0
         0cXcdEn2h+fMKpnvaAFJR5eI7Ba9190IhRdcZ+ScEFIG+2B91VBLFaR5PNq36FGW+A/Q
         AFTkTEPl+Ety/2HDRTZTvgRjTGuvbAJYfPqVzrShgFZHEfxhAGI+DXfFrA1jnIczZCfH
         HIAhPMox8S9T8o4+mBly2r99sgd/D4qsDQv8B7XqamwBxoH6g6HHDfXj/aFksN/QMqnB
         klPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1w/Hc4cOkaibn8kvCOgrzsn1RxBbiqlk6Mv4m5lJ4c=;
        b=gAXUUi3v0ggq6gZa2wuaJRTxPoaHp0A5eWkTuKEEE9nRXShT+Ewh5RBhYGO+3YK9KU
         5te5JPIsRI2ttxh/LCAw7AZFFENe4xO6+jcLPnysUlrbPq0+OvwYi0CZ27X+q+qxjjgN
         vkQua5gVvT5LfdkI+vyi25DCltUZggtrY4GFF9xiswuX5/kHYRHk+sIhRCXT6p5Tra7W
         DscO0Fh+NTNIyjHh2wasokn/csIczzJzVHM2Yc4m091ChWp0PruBaLt9h/oMeX4Sgc7z
         4MN2Xs2dHKRoX6rCQdhTibA5fg96MtGrRrQgKhVYJT4BVot1bfgRmXASOwUjWRypZOWs
         lOtQ==
X-Gm-Message-State: APjAAAWPKbFYHkb1lImoU2d1jpGbc04JJg2Mb/YfSK40EzHpgLT8r2wW
        nvOMMUk/8+SYEAnu6D4L2vL+/nT1
X-Google-Smtp-Source: APXvYqwQPnTpSvXCpdDzE4duFoBUn4ygwPJUa+RXvPAVDYDnQQkbK27Ty1MKY5Lf5Fhou+4OOVQjOg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr19244200wri.16.1579531110024;
        Mon, 20 Jan 2020 06:38:30 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/29] bisect--helper: convert `vocab_*` char pointers to char arrays
Date:   Mon, 20 Jan 2020 15:37:32 +0100
Message-Id: <20200120143800.900-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a pointer that points at a constant string,
just give name directly to the constant string; this way, we
do not have to allocate a pointer variable in addition to
the string we want to use.

Let's convert `vocab_bad` and `vocab_good` char pointers to char arrays.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1718df7f09..36c09b7238 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -52,8 +52,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 	terms->term_bad = xstrdup(bad);
 }
 
-static const char *vocab_bad = "bad|new";
-static const char *vocab_good = "good|old";
+static const char vocab_bad[] = "bad|new";
+static const char vocab_good[] = "good|old";
 
 /*
  * Check whether the string `term` belongs to the set of strings
-- 
2.21.1 (Apple Git-122.3)


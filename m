Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD84C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6978F2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa+5Kqe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfLILxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLILxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so15885447wru.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4eaUWryvIegZRPbqmP4igzBURxzCXYI3SXQluzufq4=;
        b=Pa+5Kqe6IRZsvCddkg3eyaWfb4zVEddGVN1FEcCndoEvxfkeNAYvkfdOGX6XCo9wIv
         a5uThRSAqustbWmyGVSL6gbp8LZJ3HGDbFoJ4zqe/8KvUXTpItKpaPzCOeOBAQDJgf45
         FyoO+jvjZ5nUSHMUw8hk9LsYbMz8YjGSynJaGOzUdVW0MTxxDbqg2HjbEWIadABwgSPg
         4at5rRQsG2UL3mjM9+oVn+MzNmRque43LfpJG8Qwn1VBkijtIwe1ZtgzLCI+KpcaaCBY
         OfBjvLVTtuTffk4azsXf6tzOWoJl8bHW8CqgmFzhMjV86vHf54KoI2b25469HYrXCbL+
         P2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4eaUWryvIegZRPbqmP4igzBURxzCXYI3SXQluzufq4=;
        b=UlmQbuNa2lztwupWiUtefLDUnQoVQnONkfJKd0aF4yHgrBulxzQgcASYiXX6KhLxhs
         KTWzJnnFeuVNSf5H3h5vvkiNcJkbzZFS1MWYW1HA/t80actSFq2uCG1gGAXRqKVOSZ7A
         +Sn1dc9On1vKNICJassB8z/YVsWaD2gcWpdv0mIPoHsu9v9wQg4Ta13wIYJDiJZtBD3c
         W97ec71EHF9SmxUsmiYrhJWmdDqW9RU4fH+HtpblLE/te16QalidlRWnhcxSKxV90VDs
         4SCFrleRStAiK7bm8vpj2ezTwWdiA7o4WDWa+RMBDR/s3+KvZhAX7s7mx70tZZjg4+6r
         eN3w==
X-Gm-Message-State: APjAAAWpRU4qadEDx5gdB/90OlwAsoMzYZnBg0Qj9nHrA6IM3KSiu5eZ
        3oWyEO+c1KaYWwO6VgiCvbA=
X-Google-Smtp-Source: APXvYqyEsQqddWlyzX1tQv9NO2DsOJKOy6httJ89cOmOI+X8LMBuASNOFStsvlUo2hIMH20YFcus3Q==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr1730344wrq.129.1575892386575;
        Mon, 09 Dec 2019 03:53:06 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:05 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 03/14] name-rev: use strbuf_strip_suffix() in get_rev_name()
Date:   Mon,  9 Dec 2019 12:52:47 +0100
Message-Id: <20191209115258.9281-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

get_name_rev() basically open-codes strip_suffix() before adding a
string to a strbuf.

Let's use the strbuf right from the beginning, i.e. add the whole
string to the strbuf and then use strbuf_strip_suffix(), making the
code more idiomatic.

Signed-off-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b0f0776947..15919adbdb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -321,11 +321,10 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n->generation)
 		return n->tip_name;
 	else {
-		int len = strlen(n->tip_name);
-		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
-			len -= 2;
 		strbuf_reset(buf);
-		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
+		strbuf_addstr(buf, n->tip_name);
+		strbuf_strip_suffix(buf, "^0");
+		strbuf_addf(buf, "~%d", n->generation);
 		return buf->buf;
 	}
 }
-- 
2.24.0.801.g241c134b8d


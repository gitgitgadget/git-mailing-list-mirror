Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F2A51F463
	for <e@80x24.org>; Sun, 22 Sep 2019 08:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfIVITC (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 04:19:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39840 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbfIVITC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 04:19:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so9388607ljj.6
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGthUcYxDQJHTSe9NOxrSZ9Z5JoNMsAEWbU3ozUzyhc=;
        b=ZaTE2mxzFF7moM76BadkeaOQ/eYSvnVP8zdsEHWelywNyeoBEdXopUlh3GPyRv6lB9
         Cx5WOQfEJifyM6lmjzAdIX7O5uRJHf1i97JUlrRGhSBrtgrUMctHSQKYopNMNAkzrkmX
         vx2iMnQn2bM2md0+g7GS04WyzSjQLyDMUDWH9+YVJtdT4HZgPkq9aX/OonstiYraDN7m
         y4NVEVxZJ6y54eKgVM1S26nM3nUDg0X7yNPwcw/KFLFNcmnLgNkF+6o6hnAaTCM0mzBM
         A5uvUMpU+yqIv6YN+UK8V+1maRx8gZuYQcvTNC+47oAVQvkibufJCkmsiHAvTAPEchfj
         ITgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGthUcYxDQJHTSe9NOxrSZ9Z5JoNMsAEWbU3ozUzyhc=;
        b=QadNZjgaP51hofCiez4utmE2B9eblrIK13Fo3aTDz7F3nylHoFk0dCxPJhknw4Qd5a
         Imd7QTBM75LVtnzrcHWTB4GMa+SZ7sW1TZodsKIYFh3H1vd/uT3+sCzr03e2Hlx7LXwD
         U5MG+MomMSfMchbSiKdo4llubVP1uaB9SSOo3es0fm3FX6FtRW2Bs6l2xiMI/UY3g9/g
         oINSXXhaQ2rB4VmLhTvpZNts/UXhy37T5WoO61E55Twedkz16uWHvCDyi2o4XxsXKVwN
         rX/9UemiOlvGX4sFsmWXHYyHE/daUgAxic8gQG46gW1+3hxrwMeXN2ENixJu0Wo3qv5d
         SpDA==
X-Gm-Message-State: APjAAAVitBKKOCbW/IyL8DD/aHQMEGEVQFgmcyk3Ik2j8SHlsmK59uIh
        FsSHt4Kne9RzPzHPZpq+RyQ=
X-Google-Smtp-Source: APXvYqwwmR8o9XNIxXQDdbsKhLM8F8WspChXhfRbGglLxbXpGG6OSqV7VQF6gs+OxQ6kxMKCZPn3Ig==
X-Received: by 2002:a2e:7611:: with SMTP id r17mr4092023ljc.133.1569140340319;
        Sun, 22 Sep 2019 01:19:00 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id k23sm1541284ljc.13.2019.09.22.01.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 01:18:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] name-rev: rewrite create_or_update_name()
Date:   Sun, 22 Sep 2019 10:18:46 +0200
Message-Id: <20190922081846.14452-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214712.7348-8-szeder.dev@gmail.com>
References: <20190919214712.7348-8-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This code was moved straight out of name_rev(). As such, we inherited
the "goto" to jump from an if into an else-if. We also inherited the
fact that "nothing to do -- return NULL" is handled last.

Rewrite the function to first handle the "nothing to do" case. Then we
can handle the conditional allocation early before going on to populate
the struct. No need for goto-ing.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Hi SZEDER,

 For the record, --color-moved confirms that your patch is a move and
 the conversion around it looks good to me. I was a bit puzzled by what
 the moved code actually wanted to *do* and came up with this rewrite.

 I guess it's subjective which of these ways of writing this function is
 "better", but I found this rewrite helped in understanding this
 function. Feel free to pick up in a reroll, squash or ignore as you see
 fit. This is based on top of your whole series (your e5d77042f), but
 could perhaps go immediately after your patch 07/15.

 It seems there was some discussion around leaks and leak-plugs. That
 would conflict/interact with this. Instead of placing a call to free()
 just before the label so we can more or less goto around it, the middle
 section of this rewritten function would turn from "if no name,
 allocate one" to "if we have a name, free stuff, else allocate one".
 Again, it's subjective which way is "better", so trust your judgment.

 Martin

 builtin/name-rev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6969af76c4..03a5f0b189 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -83,21 +83,21 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 {
 	struct rev_name *name = get_commit_rev_name(commit);
 
+	if (name && !is_better_name(name, taggerdate, distance, from_tag))
+		return NULL;
+
 	if (name == NULL) {
 		name = xmalloc(sizeof(*name));
 		set_commit_rev_name(commit, name);
-		goto copy_data;
-	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
-copy_data:
-		name->tip_name = tip_name;
-		name->taggerdate = taggerdate;
-		name->generation = generation;
-		name->distance = distance;
-		name->from_tag = from_tag;
-
-		return name;
-	} else
-		return NULL;
+	}
+
+	name->tip_name = tip_name;
+	name->taggerdate = taggerdate;
+	name->generation = generation;
+	name->distance = distance;
+	name->from_tag = from_tag;
+
+	return name;
 }
 
 static void name_rev(struct commit *start_commit,
-- 
2.23.0


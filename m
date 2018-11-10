Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204F31F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeKJP1C (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:27:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38834 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJP1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so2828700lfg.5
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6VMT4Zx+iGF0TVR8H0FOJbIxJM8YVe+Xy5VTUjD4Ezs=;
        b=IcF6QaGWxi7FjkYy5X6k+oFnwJ0eH5SjlD4H+yE+8IxwI7E4jzScrYddQ8ZaZo/x5C
         nsbypc4sUWwS3FUOaqdY2rGp98PgEayhbA+7LzvaGZdIGQeqeMGOhiOygbjd8TxpobAK
         QXlfy65TtWVwMjEz82jjnb7dypGp65Nqmws7d1WJ8q6xDDK1TJHaMt4IfsLtkm94OE7s
         XgY8Bz0MfPzIQ8jQrMAQc9E8eQdt7pdqg/FzSkoygNvijQQiwGl9MiueDHlp5tqz3ySe
         lkVpKk5ylXh203/Q481sp/QeYOCWgJLU2mIIFhgVfodFWw64QHGlOtWqUvbVgiWrgJ/h
         JLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6VMT4Zx+iGF0TVR8H0FOJbIxJM8YVe+Xy5VTUjD4Ezs=;
        b=QlX7rpZrvlrxuqDh6BOVOTg2zru+zM5jmYgMlPvTH9efqfy2GqJFRemnnXQN7XgWlB
         +V1bxR6/AQUIuzNhbjZUgTzPdMeW2cKsVjxZHQpRT+BmLt3Rj37tkgvq8/YwsjOqmeh6
         vZwH6larZNkmu7+zwezhRRUI6rvoyaIu2l587BwSq4BYr8MP0fRdfEFHGLMouomwR9VE
         Wl2Vq8Ld4eJosEF+YWuLCYoAEHY0gP1bEUoJQfDYR3piUXOn68bDpVLW0j+DQz82VCAf
         wOxr2f4hoRMnoo4PVFDYVtOqGNomNJFtPxzsGv7m63OWdIAYwJHCgAdM+vk7b9wB6i0y
         CEEw==
X-Gm-Message-State: AGRZ1gLw4zEcAO7kdMaXOE32cYu0y8z03a3U/jSa276qbP1M8r5JkS88
        /SWtqaW+BFf0XrFvDCyaGDE=
X-Google-Smtp-Source: AJdET5cAtLDtkDRjiswCbNlkLlmkqhTC9LZXAA2FvqtP+B/AyTtFWrl9DIxqeV4C1u+Dl/G5udbUFw==
X-Received: by 2002:a19:f813:: with SMTP id a19mr6673565lff.67.1541826992340;
        Fri, 09 Nov 2018 21:16:32 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 09/16] remote.c: turn some error() or die() to BUG()
Date:   Sat, 10 Nov 2018 06:16:08 +0100
Message-Id: <20181110051615.8641-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first error, "internal error", is clearly a BUG(). The second two
are meant to catch calls with invalid parameters and should never
happen outside the test suite.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 81f4f01b00..257630ff21 100644
--- a/remote.c
+++ b/remote.c
@@ -620,7 +620,7 @@ static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 			 * FETCH_HEAD_IGNORE entries always appear at
 			 * the end of the list.
 			 */
-			die(_("Internal error"));
+			BUG("Internal error");
 		}
 	}
 	free(ref2->peer_ref);
@@ -707,7 +707,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		error("query_refspecs_multiple: need either src or dst");
+		BUG("query_refspecs_multiple: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -735,7 +735,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		return error("query_refspecs: need either src or dst");
+		BUG("query_refspecs: need either src or dst");
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
-- 
2.19.1.1231.g84aef82467


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E8D207F8
	for <e@80x24.org>; Sat,  6 May 2017 18:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbdEFStg (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 14:49:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33431 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdEFStc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2017 14:49:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id a46so4889061qte.0
        for <git@vger.kernel.org>; Sat, 06 May 2017 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4v6w+kfCMSpLH6TcNU8nsIbOzEvRdL7LzV1o6Ows5DE=;
        b=ChPz85t3qryGtAGOIM2auW4GSldsYZfqj4KV5TynNqEVMum1uHMehQjIJAenm2VHeg
         3mCpEJKufGQZfdoBGO2uIrQP91wI/997gErZ8I/aTcI+usQ5r194Vu2aVG9nrZA2D3Te
         j2yFPXJ5EZc3ATipzDlwavkbQ56v52sIWQ0vmVlVQq81Yxb7m7kxluKStKS0Sgm8Z/4I
         IU2SbF85yDRJ/2OeEhKr4n0Pmg3QQWXkv7Y+fRaZu4UhrKdCOlbwSuP5QPg4CsYAsLr0
         0HgFJlyl+B1QkuG54cn7m55mH8PxQl+pv5halrkeoX4a8rMJYsiSzB+JSKSydcJrvh/a
         0ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4v6w+kfCMSpLH6TcNU8nsIbOzEvRdL7LzV1o6Ows5DE=;
        b=PxmiguAnPIOhkJFpU4/uL3bBrTqsqiPgWyeTJ+yJdyEyGR2XtB//M5UVK4F5ztd/1b
         57JaffNEfuGQ7UbVuZJuMNQLPqKwe+Dg23aeThzBIeihdKUsgXMhioNqAfkLrGkIY8B/
         48Av8jsy4vwwgHYlzYFUKaRd9mG7i+br79nQ4aAwoNQn3a8iwHeOq7kfZEBw/K4n0o/5
         PNSNajjmvz7+yKONDj5X3kCYQ2GiaUUTroP5MGh8YSg5GAbvlWLNGSicKlPEJKoMMbR4
         dz/5U+IibE0ntZ64Pqpp74by4tu2uKtvqNl+CXJ75uKmF61kdMMiAKl269fWeT1qNNoL
         ZEYg==
X-Gm-Message-State: AN3rC/6GGrGjV1M9tbj8nQLxgolQud+oCpwT9uqQigEuH+z19PA1raFy
        rCPFTFg6/5hi4Q==
X-Received: by 10.237.33.188 with SMTP id l57mr47746427qtc.33.1494096571700;
        Sat, 06 May 2017 11:49:31 -0700 (PDT)
Received: from localhost.localdomain ([129.59.122.17])
        by smtp.gmail.com with ESMTPSA id 83sm6866347qkq.26.2017.05.06.11.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2017 11:49:31 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 4/9] dir: add method to check if a dir_entry lexically contains another
Date:   Fri,  5 May 2017 05:46:06 -0500
Message-Id: <20170505104611.17845-5-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
In-Reply-To: <20170503032932.16043-1-sxlijin@gmail.com>
References: <20170503032932.16043-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a method that allows us to check if one dir_entry corresponds
to a path which contains the path corresponding to another dir_entry.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dir.c b/dir.c
index 6bd0350e9..4739087f4 100644
--- a/dir.c
+++ b/dir.c
@@ -1852,6 +1852,14 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
+/* check if *out lexically contains *in */
+static int check_contains(const struct dir_entry *out, const struct dir_entry *in)
+{
+	return (out->len < in->len) &&
+			(out->name[out->len - 1] == '/') &&
+			!memcmp(out->name, in->name, out->len);
+}
+
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
-- 
2.12.2


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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEFA1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404919AbfISVrh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbfISVrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so45003wmp.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+hsqJFgagJxVDA3KJlpLNCTjsIknZmULmbijI32Y59E=;
        b=AOKuTxNqZXPBRn7Py2azdO1KgYsqPvlRUz2NVjMKAa/wruRuxDSrlPp1dPZmzO0RLX
         dJTea9tJ+rlsA6x7z8AeDX6hH4q+XzZh4Hd6EWzjrfNl8bAZFLi9P5EUHFVI0ZKJXVWm
         2RnjUninPeWsaDwbeV4DQqWUEd5bXuDCDP375BuNNLctpWdTXdLHItsQamNQcHXvi45x
         zIBbaTc34v4Gz5zGP0tPuDuF3azjO85N94+hiYZX1eaHvMl01FusetjXcPR5/Fx7Nie+
         DoQqjidjdxRGtiODpSpoXSJ8qHIHFeztwV+DiiM5lRMLiDOtAKbHoQp58DC6WHh1p3Q6
         AVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+hsqJFgagJxVDA3KJlpLNCTjsIknZmULmbijI32Y59E=;
        b=YfY2BUTcVkGOHqfSBRJF4ekO38CjYqsWuKPCXq8OpzosBBfru44UCulZENv2zJ869N
         /01JAXgEfKJNaIiIV+vw1UFv3Y7vFHpSJLS3qqLVHEgcNw7lsI2nVD3U6ZbLHkMIKuVi
         5GIvVFJ4LlshJwMFvIPZe3ELpvKtKWn3Zw4CrPQNNc2oxYMC6wzRFzjGN6OaZyM+cZZ6
         0VNHHC+VPV5lTw/vbEzUd+Js2XGUYyR1Fv3gQwAiC+XmQ1dkHyQ1p68bSxGsk+bJIRgt
         Y2cTKZN5ej/o4onJKQgmfOl4HuNtnHK5w17tOhWmYQpuTFKjqfxMZ4KpXzc7aQvH2cvK
         dH1g==
X-Gm-Message-State: APjAAAW25Q014a8JlPSlz+mEQ77ymNZZlugqgnw/oDj3N1KqMmPMn6lt
        /oUxUDVVwh37cjH375LVGyo=
X-Google-Smtp-Source: APXvYqyWmhCMkS0+GJd/3Wut9gYAXCCsWQeHNbzMH/QMfGJ5oumm3XUXSQTpCXgGgptzYQzKNJ6GwA==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr49969wmk.30.1568929651191;
        Thu, 19 Sep 2019 14:47:31 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/15] name-rev: drop name_rev()'s 'generation' and 'distance' parameters
Date:   Thu, 19 Sep 2019 23:47:06 +0200
Message-Id: <20190919214712.7348-12-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the previous patches in this series we can get the values of
name_rev()'s 'generation' and 'distance' parameters from the 'stuct
rev_name' associated with the commit as well.

Let's simplify the function's signature and remove these two
unnecessary parameters.

Note that at this point we could do the same with the 'tip_name',
'taggerdate' and 'from_tag' parameters as well, but those parameters
will be necessary later, after the recursion is eliminated.

Drop name_rev()'s 'generation' and 'distance' parameters.
---
 builtin/name-rev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 98a549fef7..f2198a8bc3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -102,8 +102,9 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag)
+		int from_tag)
 {
+	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 
@@ -112,7 +113,7 @@ static void name_rev(struct commit *commit,
 			parents = parents->next, parent_number++) {
 		struct commit *parent = parents->item;
 		const char *new_name;
-		int new_generation, new_distance;
+		int generation, distance;
 
 		parse_commit(parent);
 		if (parent->date < cutoff)
@@ -122,25 +123,25 @@ static void name_rev(struct commit *commit,
 			size_t len;
 
 			strip_suffix(tip_name, "^0", &len);
-			if (generation > 0)
+			if (name->generation > 0)
 				new_name = xstrfmt("%.*s~%d^%d", (int)len, tip_name,
-						   generation, parent_number);
+						   name->generation,
+						   parent_number);
 			else
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
-			new_generation = 0;
-			new_distance = distance + MERGE_TRAVERSAL_WEIGHT;
+			generation = 0;
+			distance = name->distance + MERGE_TRAVERSAL_WEIGHT;
 		} else {
 			new_name = tip_name;
-			new_generation = generation + 1;
-			new_distance = distance + 1;
+			generation = name->generation + 1;
+			distance = name->distance + 1;
 		}
 
 		if (create_or_update_name(parent, new_name, taggerdate,
-					  new_generation, new_distance,
+					  generation, distance,
 					  from_tag))
-			name_rev(parent, new_name, taggerdate,
-				 new_generation, new_distance, from_tag);
+			name_rev(parent, new_name, taggerdate, from_tag);
 	}
 }
 
@@ -284,7 +285,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 				tip_name = xstrdup(path);
 			if (create_or_update_name(commit, tip_name, taggerdate,
 						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate, 0, 0,
+				name_rev(commit, tip_name, taggerdate,
 					 from_tag);
 			else
 				free(to_free);
-- 
2.23.0.331.g4e51dcdf11


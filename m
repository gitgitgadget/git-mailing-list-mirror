Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8478B1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 02:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFDCNk (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 22:13:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39878 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFDCNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 22:13:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so3275881oig.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 19:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef9ObsAXUM7EDnDMgoIFzL7nq7HMDiW11MxW4p26eIA=;
        b=dJOJC031Nf/3RZCGOwA/Y7v2EuYMWyUKEwoy1lv41iuVNjEhSwr8CfsLdDmdbG0Mt0
         pdzVKJkvo9jWVrtoSYsXYr4lNe3N6gWxRmCfZ3MnmWCN+klMQeQUgJU6snxpSfxpbQ29
         zSqSLLs383z5u/XDLbw+WlmXWvwnG0JqFkf8IAPlPcVkf7USv8QdKQ4sxFedrchgWs+X
         BdZNifZnquqvK0qLju5+i/cLOeWJW7NK9smTcdpk74J7I/zsE35IiCfUQ0QXe0rWQBIM
         brDnjF6wRk4KCUsmCMC/YE3DrTmEsq7oxJWITwwTcgqX81LvTTQa5Lp5bI9iS2fRGHz7
         rpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef9ObsAXUM7EDnDMgoIFzL7nq7HMDiW11MxW4p26eIA=;
        b=ASQ1eBqLuQj30twUMZ8O9+zoDc/4d5RCuuprUeFNQLQj3AHDaEWIvJkqJVpEFgRbQd
         qBtQ/4WyOx6iCM65GTcojAZLK6IyTPNe7R5q+XWkT1FwG+WDq7rZBljUQpJ23jRkWvYb
         Z8F5wwGmzdFEaLX0usHFR33yN2SX9eJGtedLL8M9lG8vhPNpRAOX9uq9PsCiGt2dXDol
         nf8FTtfFI5IZKO0Ito2aJ/z4A8QuO6rRifkPRSa3/IE5pZEDwBYFcwe9uuJh9SCSydD0
         Gg9TYzxygbFLNi7iDR8kFsgjvmx2v5Mf3+sZs9otAnZi6lX5Dzd1T4eZnQ1fDLU5U1q2
         oUYg==
X-Gm-Message-State: APjAAAWDW2Tl1dvBUszYMYcem4VKzdjF5vTGveDtmROxZAlhHmkDKHS6
        AglkjKuFgFHFMg1llWHhFNpovUTF60I=
X-Google-Smtp-Source: APXvYqw3sLBonfHdtHy3e3RVkUjCz2H57FDt7n8677HccPOd7DwumpCKTaonUE1+JML1yJ7zSE+ucw==
X-Received: by 2002:aca:5e87:: with SMTP id s129mr2922853oib.95.1559614418362;
        Mon, 03 Jun 2019 19:13:38 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id m17sm5497913otl.38.2019.06.03.19.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 19:13:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 5/5] fetch: fix regression with transport helpers
Date:   Mon,  3 Jun 2019 21:13:30 -0500
Message-Id: <20190604021330.16130-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604021330.16130-1-felipe.contreras@gmail.com>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e198b3a740 changed the behavior of fetch with regards to tags.
Before, null oids where not ignored, now they are, regardless of whether
the refs have been explicitly cleared or not.

  e198b3a740 (fetch: replace string-list used as a look-up table with a hashmap)

When using a transport helper the oids can certainly be null. So now
tags are ignored and fetching them is impossible.

This patch fixes that by having a specific flag that is set only when we
explicitly want to ignore the refs, restoring the original behavior.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fetch.c           | 5 +++--
 t/t5801-remote-helpers.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9dc551551e..f2be50a4a3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -239,6 +239,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 struct refname_hash_entry {
 	struct hashmap_entry ent; /* must be the first member */
 	struct object_id oid;
+	int ignore;
 	char refname[FLEX_ARRAY];
 };
 
@@ -289,7 +290,7 @@ static int refname_hash_exists(struct hashmap *map, const char *refname)
 
 static void clear_item(struct refname_hash_entry *item)
 {
-	oidclr(&item->oid);
+	item->ignore = 1;
 }
 
 static void find_non_local_tags(const struct ref *refs,
@@ -374,7 +375,7 @@ static void find_non_local_tags(const struct ref *refs,
 			BUG("unseen remote ref?");
 
 		/* Unless we have already decided to ignore this item... */
-		if (is_null_oid(&item->oid))
+		if (item->ignore)
 			continue;
 
 		rm = alloc_ref(item->refname);
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 238774bc17..2d6c4a281e 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -303,7 +303,7 @@ test_expect_success 'fetch url' '
 	compare_refs server HEAD local FETCH_HEAD
 '
 
-test_expect_failure 'fetch tag' '
+test_expect_success 'fetch tag' '
 	(cd server &&
 	 git tag v1.0
 	) &&
-- 
2.21.0


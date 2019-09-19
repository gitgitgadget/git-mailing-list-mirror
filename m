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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A461F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbfISVrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40527 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404888AbfISVrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so4658683wru.7
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0Ivbp18e6VgGToW47wIP3uzjCX5eGkJPBMyfFmSgv0=;
        b=MxzHNd7lltQXS7yUMTx3G/gQKnYtgKurmxhe80bsIVWrTQXijb5sevm4Sb06VOg48k
         0dCEeNsu3qpwQaXEQhCrg6b1opsJyWEzTyaswOMJ7T0E9t5BXCeO8b4K/Bzd6A9QKmvs
         7FijOb/tV7mmSRrGvFmcjlVWsmuwHusslMELjQo6abau1XqXl04+K/nENQhGIBDeJ5rY
         84jhaLZEwR+rXqLsQjiAUOQOIFibXRrz9XQ7i5s7do2DHruSYe8I/YPF+d/VuwId6470
         gwgDZl2Su6Sufb5N6yHM7/7Oi9xQZbGBzWH7n0Ln1/sIDu1zHt8hwiVC2TorWamN2lyJ
         8/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0Ivbp18e6VgGToW47wIP3uzjCX5eGkJPBMyfFmSgv0=;
        b=sXzhUvNm4xzl8HMPJLCG31g76jDnazpBgFXs0gDAoO/hyCweiwcBhSRXZD+kympKWJ
         C6kMswzj/nocf9g+jqLTz9ZyZWe0To51xMuVm1CM7KwhPRqk0s+ot5JqLE19gE34SXCw
         Y+TRZpqnlbviPmzzVhUzxescXMPrED38wuwd2apEuQcD0/P48g1UUxi5f0FyFnrB3MqI
         ZLWzzKbdQwQ92ku9f40aaCONmhaDZtE2W0AdEJGgo7h9tZx3Nj+LdhIS4soEoFLDLWNS
         m/9a+yx72fgq6guQDXla+SRpFyUDeEgf1RekltgxrCIQ3S3ifgebgsM/RH+HdHgiiD/F
         iDwg==
X-Gm-Message-State: APjAAAUmdTWYWeqTlbfJbAYWJVE1WhlFJ2XCp6qmjiwjL/DWCnN5f6SQ
        nU9hiOyRuGsoNUFxQqIK8nQ=
X-Google-Smtp-Source: APXvYqwwU94GXLUcYnr2PwCcVwy17/40prNJx1hZ2TlRfAgOQzTaI4Bfbz5sRFStyniXZBUmTzw/qw==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr6334100wrx.220.1568929650092;
        Thu, 19 Sep 2019 14:47:30 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/15] name-rev: restructure creating/updating 'struct rev_name' instances
Date:   Thu, 19 Sep 2019 23:47:05 +0200
Message-Id: <20190919214712.7348-11-szeder.dev@gmail.com>
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

At the beginning of the recursive name_rev() function it creates a new
'struct rev_name' instance for each previously unvisited commit or, if
this visit results in better name for an already visited commit, then
updates the 'struct rev_name' instance attached to to the commit, or
returns early.

Restructure this so it's caller creates or updates the 'struct
rev_name' instance associated with the commit to be passed as
parameter, i.e. both name_ref() before calling name_rev() and
name_rev() itself as it iterates over the parent commits.

This makes eliminating the recursion a bit easier to follow, and it
will be moved back to name_rev() after the recursion is eliminated.

This change also plugs the memory leak that was temporarily unplugged
in the earlier "name-rev: pull out deref handling from the recursion"
patch in this series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 99643aa4dc..98a549fef7 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -107,14 +107,12 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
-				   distance, from_tag))
-		return;
-
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
 		struct commit *parent = parents->item;
+		const char *new_name;
+		int new_generation, new_distance;
 
 		parse_commit(parent);
 		if (parent->date < cutoff)
@@ -122,7 +120,6 @@ static void name_rev(struct commit *commit,
 
 		if (parent_number > 1) {
 			size_t len;
-			char *new_name;
 
 			strip_suffix(tip_name, "^0", &len);
 			if (generation > 0)
@@ -131,15 +128,19 @@ static void name_rev(struct commit *commit,
 			else
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
-
-			name_rev(parent, new_name, taggerdate, 0,
-				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag);
+			new_generation = 0;
+			new_distance = distance + MERGE_TRAVERSAL_WEIGHT;
 		} else {
-			name_rev(parent, tip_name, taggerdate,
-				 generation + 1, distance + 1,
-				 from_tag);
+			new_name = tip_name;
+			new_generation = generation + 1;
+			new_distance = distance + 1;
 		}
+
+		if (create_or_update_name(parent, new_name, taggerdate,
+					  new_generation, new_distance,
+					  from_tag))
+			name_rev(parent, new_name, taggerdate,
+				 new_generation, new_distance, from_tag);
 	}
 }
 
@@ -276,11 +277,17 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		if (commit->date >= cutoff) {
 			const char *tip_name;
+			char *to_free = NULL;
 			if (deref)
-				tip_name = xstrfmt("%s^0", path);
+				tip_name = to_free = xstrfmt("%s^0", path);
 			else
 				tip_name = xstrdup(path);
-			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+			if (create_or_update_name(commit, tip_name, taggerdate,
+						  0, 0, from_tag))
+				name_rev(commit, tip_name, taggerdate, 0, 0,
+					 from_tag);
+			else
+				free(to_free);
 		}
 	}
 	return 0;
-- 
2.23.0.331.g4e51dcdf11


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208AC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15DC2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHlAvQJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLILxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38757 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLILxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so14598470wmi.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMJEqnTL4WSK2zA9sO26NTWdBZ8asZt1BiAJxEElZBY=;
        b=cHlAvQJotGBaLw9kdrSBlXHRAxjWLgxjVt0thlhlVr5fKjUflG1npk1XeJ2RRxFa3f
         +EOBR3KDmdKHRIh7k1Mm/fwi4f01YH09cjCzhoM3vIQ5yDEwc/lnmrmMX8IZiGrUHGbo
         5UI39Cch8AwCKikGjH+FjH9/93Smb2F4krUVXBT0aPsusrIKqXHaM28lBVJvHGAKLL5F
         bsQKQ1E+pGuMMOCoVGv09YLAundnPw89LzD0LGXCZrI7+ZQw8PcUd7OdPQQI48pK2KeK
         LXmTPAyel6mdCdLewEKA/R4GwraLPocz1sMSRTnA+fxqMVpG99danmhb0bSNGUS994P3
         p5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMJEqnTL4WSK2zA9sO26NTWdBZ8asZt1BiAJxEElZBY=;
        b=duVpWtaACosqTSlz9LX3nV6sscDqDNHvgSLfGoQPcVeNUx15x22y1SMjZsSK9G+rxS
         sR5YFuE7VSR+pl1h9pVyV71/lLcmufKqAs8VR5uX25JY9PkwFzDZ6ovOlH0ZVZ9ghZtq
         bLvu9A0i9DULFWs1mGsQbfMmcUJnalRt3EKVVzGPyeVWdl79pbm7LMjK48bOXUqCod+j
         eKRokw9+HcwfAOmGH2FBeXGXGdn4STC/Sz+bKTjvWOiyKREbZi1nQZJ87trrW+NhjxCD
         Vf2dz0zJgpXifJq1Tgd1g/dXH+xIlILpmycuTbZWQ/MF7h6NVOjaNLbbqLdb5eoUDGvz
         5DZw==
X-Gm-Message-State: APjAAAVzm548jTFfc1Bd1E/0SEGXj+fO9AZAdJ8t29m0ojzj+9ObegkA
        BlPmU8rqAD1iYxLMv3PjA2M=
X-Google-Smtp-Source: APXvYqzhHKxx0j4D9xPplZTzSalZ55GsDA2vmgsa+3k1YK0C6gdiJQhcvNiy3Sa2M/l6vNW1L6LcPA==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr25472976wmj.170.1575892395804;
        Mon, 09 Dec 2019 03:53:15 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 11/14] name-rev: drop name_rev()'s 'generation' and 'distance' parameters
Date:   Mon,  9 Dec 2019 12:52:55 +0100
Message-Id: <20191209115258.9281-12-szeder.dev@gmail.com>
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

Following the previous patches in this series we can get the values of
name_rev()'s 'generation' and 'distance' parameters from the 'stuct
rev_name' associated with the commit as well.

Let's simplify the function's signature and remove these two
unnecessary parameters.

Note that at this point we could do the same with the 'tip_name',
'taggerdate' and 'from_tag' parameters as well, but those parameters
will be necessary later, after the recursion is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6416c49f67..fc61d6fa71 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -106,8 +106,9 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag)
+		int from_tag)
 {
+	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 
@@ -116,7 +117,7 @@ static void name_rev(struct commit *commit,
 			parents = parents->next, parent_number++) {
 		struct commit *parent = parents->item;
 		const char *new_name;
-		int new_generation, new_distance;
+		int generation, distance;
 
 		parse_commit(parent);
 		if (parent->date < cutoff)
@@ -126,25 +127,25 @@ static void name_rev(struct commit *commit,
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
 
@@ -288,7 +289,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 				tip_name = xstrdup(path);
 			if (create_or_update_name(commit, tip_name, taggerdate,
 						  0, 0, from_tag))
-				name_rev(commit, tip_name, taggerdate, 0, 0,
+				name_rev(commit, tip_name, taggerdate,
 					 from_tag);
 			else
 				free(to_free);
-- 
2.24.0.801.g241c134b8d


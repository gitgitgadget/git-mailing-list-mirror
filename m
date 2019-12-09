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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE9C2BD09
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6A92077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIiZOAdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLILxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLILxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so15257487wmj.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbC/uT9GE3FJSp0WaMFk5f3MwjiD6eA2B0INBs3ezTU=;
        b=hIiZOAdC7I56/Q4He5ziQ36oGXCK5jNPRt/ki+VKSFdJ1XX2ZUtgnzHIMqQY+DpTcK
         GV/ZWb+qfKZyYKzzEX8jtrTXquxMFapagL4m48AdEYVXKdy6U9Hx8FlHQP4qvJXbKAPr
         FzxQZfu+5m81tu4k0dZ+iz7ZlgfjVHDaenlOzoiYrpFsXg4wXSCf7krXsTEcK75RXzLs
         kWSy/VmzIyYP3LATXdnmUrxsggsObF55QZzHe1WbGIBCTOqHjChO6WFyFHNEozZa/1CM
         bf7VtP8zauZmb7zn5nE1UkP+QdfY8gSLqtDxlKzf1b6Win8YtbmCVcC5s0IVC/RaI64v
         cB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbC/uT9GE3FJSp0WaMFk5f3MwjiD6eA2B0INBs3ezTU=;
        b=leVowneaGttm0Aqei8TozkXyvvnQCpGQ1GQWjrSOmJAX0qgef8ZEYwckedv49kCOir
         CCcBKUbL1oiRxEExpbOHrn7BxKedxnwVjDo1WP/44j5pkVeUHUMN4sjBKtBz02YHHXI/
         3ImeNE5OuyrD0VrNCGSMg3MCmXKaAE8EA86ZOyBcYE3W9itr2M08C88q16g5Dm5g2r1C
         6BMyIU56r0TAGvKJWcb1Cbwj4n3wJM+A54MbPEigjJLatgtL4OFkzHdCLANlG7pupm5s
         01CBfm85mMK8kSjR3PWPSwEUvTLyrA6j8ssMlncVbrr5lVZi7LoeSt/dXe7Sq1beUXv2
         bkDQ==
X-Gm-Message-State: APjAAAWeTRRcxedn6sfqcxoPU5/wj2sP6axmECDxsnzJiefklHEPP/wj
        P96dJKzw5B54W4AuxC6KrOM=
X-Google-Smtp-Source: APXvYqwRUDkhbSru2jPcjZI4loT8Inyx7nkuVQ8h485qgRewc590lh8Nr6+E6aRFJFtk++fK7BpPkg==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr26225863wme.42.1575892394607;
        Mon, 09 Dec 2019 03:53:14 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 10/14] name-rev: restructure creating/updating 'struct rev_name' instances
Date:   Mon,  9 Dec 2019 12:52:54 +0100
Message-Id: <20191209115258.9281-11-szeder.dev@gmail.com>
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

At the beginning of the recursive name_rev() function it creates a new
'struct rev_name' instance for each previously unvisited commit or, if
this visit results in better name for an already visited commit, then
updates the 'struct rev_name' instance attached to the commit, or
returns early.

Restructure this so it's caller creates or updates the 'struct
rev_name' instance associated with the commit to be passed as
parameter, i.e. both name_ref() before calling name_rev() and
name_rev() itself as it iterates over the parent commits.

This makes eliminating the recursion a bit easier to follow, and the
condition moved to name_ref() will be moved back to name_rev() after
the recursion is eliminated.

This change also plugs the memory leak that was temporarily unplugged
in the earlier "name-rev: pull out deref handling from the recursion"
patch in this series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 5041227790..6416c49f67 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -111,14 +111,12 @@ static void name_rev(struct commit *commit,
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
@@ -126,7 +124,6 @@ static void name_rev(struct commit *commit,
 
 		if (parent_number > 1) {
 			size_t len;
-			char *new_name;
 
 			strip_suffix(tip_name, "^0", &len);
 			if (generation > 0)
@@ -135,15 +132,19 @@ static void name_rev(struct commit *commit,
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
 
@@ -280,11 +281,17 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
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
2.24.0.801.g241c134b8d


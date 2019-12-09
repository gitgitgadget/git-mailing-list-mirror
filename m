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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ADC2D0BE
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8875C2077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9tTEV8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfLILxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39282 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfLILxP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so14592628wmh.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U6oOWlxTlg4up0uHsTc+h8GvlFSt0/cOc0x63zl6BM4=;
        b=l9tTEV8G40Z6p6/E/LDnJqKEPehdwgaO/K11SJpagdtXr838402yTJpnwyLmG7mcnQ
         G2znq1XM7FG5H2KJXBhriEJHH8ILsWsehRU+iTNRYM/jiZWddJdRDZDttnEFmH07bhce
         qXUHirxkZGuqIICuq5BVernzkPySHA367iPoB7tsNLc8r/7eLICblDea5eDP80ULvEum
         OkKi9BLXamXSgUlVi1CmvFSy2Fsz7Cl/YlSv7zG9OrFZkBNJoLRsg+ZQs0h19IcjR8x/
         EjGHpGIE+olLpZglSd1hLF0FR7yJkisHpGR4n+ZLWYPA8xp6AypCnLKD+tOXL2xIV3I3
         DK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U6oOWlxTlg4up0uHsTc+h8GvlFSt0/cOc0x63zl6BM4=;
        b=bqsFgAva1edRNbbAAAjbAhV1bOYC6B/CaX/Q6aZCnE11RCGHqkSUKq0SyjSudFJ3g/
         sw17ULlwcrp83owdgms+X1HTT9J+5/wMsYD4I/+KmOLud1UgRqFPe4ZyKdXYZHaTh3dL
         LvVUBnCLIbmtuE2GXp3chDYcX82koQcPWGzKvCPor6qRcJUxAg27qx4K8EFVmF+960e3
         wBRG/CdzqtTiCvTErSKjP3rTeYaeRKRuRvmV4Vz4Gb1B7fgSulfmS2Ed/jgOKIojxEwS
         29DAX/VS0hc5QFJw95zQGYmkfe52rIumNavBVsWX6fEUh19gcmqcjIQSHyjoOEGPnAF+
         GZsg==
X-Gm-Message-State: APjAAAXIEYuRd4F7g6YO7jmOZEM+J7CK92A5xjUwfhzMgq+B9HHg9EKb
        S7nIH5IC0KG0Icf9tAX6rOo=
X-Google-Smtp-Source: APXvYqwNrYmYuxYAS+3WvljN0fKA9ZAohqaZb/8I9+E7lG2RYRQdPuoAVrGx6yYw825GiKlpNKNNcw==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr24812741wmb.164.1575892393294;
        Mon, 09 Dec 2019 03:53:13 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:12 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 09/14] name-rev: restructure parsing commits and applying date cutoff
Date:   Mon,  9 Dec 2019 12:52:53 +0100
Message-Id: <20191209115258.9281-10-szeder.dev@gmail.com>
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

At the beginning of the recursive name_rev() function it parses the
commit it got as parameter, and returns early if the commit is older
than a cutoff limit.

Restructure this so the caller parses the commit and checks its date,
and doesn't invoke name_rev() if the commit to be passed as parameter
is older than the cutoff, i.e. both name_ref() before calling
name_rev() and name_rev() itself as it iterates over the parent
commits.

This makes eliminating the recursion a bit easier to follow, and the
condition moved to name_ref() will be moved back to name_rev() after
the recursion is eliminated.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e112a92b03..5041227790 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -111,11 +111,6 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	parse_commit(commit);
-
-	if (commit->date < cutoff)
-		return;
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
 				   distance, from_tag))
 		return;
@@ -123,6 +118,12 @@ static void name_rev(struct commit *commit,
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
+		struct commit *parent = parents->item;
+
+		parse_commit(parent);
+		if (parent->date < cutoff)
+			continue;
+
 		if (parent_number > 1) {
 			size_t len;
 			char *new_name;
@@ -135,11 +136,11 @@ static void name_rev(struct commit *commit,
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
-			name_rev(parents->item, new_name, taggerdate, 0,
+			name_rev(parent, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
 				 from_tag);
 		} else {
-			name_rev(parents->item, tip_name, taggerdate,
+			name_rev(parent, tip_name, taggerdate,
 				 generation + 1, distance + 1,
 				 from_tag);
 		}
@@ -273,16 +274,18 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
-		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		if (deref)
-			tip_name = xstrfmt("%s^0", path);
-		else
-			tip_name = xstrdup(path);
-		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		if (commit->date >= cutoff) {
+			const char *tip_name;
+			if (deref)
+				tip_name = xstrfmt("%s^0", path);
+			else
+				tip_name = xstrdup(path);
+			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+		}
 	}
 	return 0;
 }
-- 
2.24.0.801.g241c134b8d


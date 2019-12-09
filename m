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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EEC00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3B92077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iredq4DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLILxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfLILxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so15769687wrl.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4fq45NdxYaon4kle3U5fa42nDQgIm2uBropBbY6Ewro=;
        b=iredq4DHqDUKb3EnfigyohSiixs+JJy/FrRPsPmyUkPSaFXa83FqFD9BkuM5BNZMrO
         9UBahZ/St9goH+1Wn2gkKzDMFRWYn0ihqqqu5kDVwlMBIwoeeRo3Q29nHoa6GfTrjvc0
         yEE9tJzS/C5TMCkU7V7TRo0vowjY7E04nLyE0cfL4no3LPt1qR+U4/hjhuzD4Q5+tq/L
         GQ0YmHlWE9Fq0D41qQfudk+Sn+vC9wDLr6ChJl+GcuJi++zDGoMXKNH5exbZuCM35ard
         aA1oAVx9KWPaWWagk1rnyx0m3dC5POlkmARsRmDXKaUXpJlT3CqYz9vmS0XtRn5EmRrl
         CIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fq45NdxYaon4kle3U5fa42nDQgIm2uBropBbY6Ewro=;
        b=oRrcAyzduc53b9+MbcaYJRZQFOwSnFY40gzq4aDIeLxlg6B4W39AP39F2ZbY2fmHfE
         yeFygpACC+bqTej8MnKZep8FKMxG/KIuVUthW35giSEL4GglCYgGcMUmkubpGhoQqc9h
         dyS8qNMPT3HGd39F5O5O7D03QcYCkh1OXKi5KeHRRC5IS1mRzcjXvJvcXm3eU9AVjPrG
         YcoZDiDesub1O6p0OpAq92iAirDpoCDjyatb3n/VnQaejhv+Kck+/w6etzfym6EU+vXU
         f1iaYL8aHAZucNR5rL3WhuWPr/xY21bJW5xui+O6hgeTOrIMiUNWFuOwlrsRxJVtsXr4
         pvpA==
X-Gm-Message-State: APjAAAWKU6ZgGtamUimRrl0NhjevS3NX0suiEM1bN2/M5ZkRkKR0fn38
        VwaeTZSrwni7xkNdTHOXyYg=
X-Google-Smtp-Source: APXvYqxW9A7+7z99LyY/xMMQXWVtgj2Ww9GP1vP1AYdP+dc220d65lg+tgahCE5OlQ4ozNwyITcskA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr1760998wrm.13.1575892392091;
        Mon, 09 Dec 2019 03:53:12 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:11 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/14] name-rev: pull out deref handling from the recursion
Date:   Mon,  9 Dec 2019 12:52:52 +0100
Message-Id: <20191209115258.9281-9-szeder.dev@gmail.com>
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

The 'if (deref) { ... }' condition near the beginning of the recursive
name_rev() function can only ever be true in the first invocation,
because the 'deref' parameter is always 0 in the subsequent recursive
invocations.

Extract this condition from the recursion into name_rev()'s caller and
drop the function's 'deref' parameter.  This makes eliminating the
recursion a bit easier to follow, and it will be moved back into
name_rev() after the recursion is eliminated.

Furthermore, drop the condition that die()s when both 'deref' and
'generation' are non-null (which should have been a BUG() to begin
with).

Note that this change reintroduces the memory leak that was plugged in
in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
case, 2017-05-04), but a later patch (name-rev: restructure
creating/updating 'struct rev_name' instances) in this series will
plug it in again.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e43df19709..e112a92b03 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -106,30 +106,19 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag,
-		int deref)
+		int generation, int distance, int from_tag)
 {
 	struct commit_list *parents;
 	int parent_number = 1;
-	char *to_free = NULL;
 
 	parse_commit(commit);
 
 	if (commit->date < cutoff)
 		return;
 
-	if (deref) {
-		tip_name = to_free = xstrfmt("%s^0", tip_name);
-
-		if (generation)
-			die("generation: %d, but deref?", generation);
-	}
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
-				   distance, from_tag)) {
-		free(to_free);
+				   distance, from_tag))
 		return;
-	}
 
 	for (parents = commit->parents;
 			parents;
@@ -148,11 +137,11 @@ static void name_rev(struct commit *commit,
 
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+				 from_tag);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
-				 from_tag, 0);
+				 from_tag);
 		}
 	}
 }
@@ -284,12 +273,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
+		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+		if (deref)
+			tip_name = xstrfmt("%s^0", path);
+		else
+			tip_name = xstrdup(path);
+		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
 	}
 	return 0;
 }
-- 
2.24.0.801.g241c134b8d


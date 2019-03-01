Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618ED20248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389456AbfCARul (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:50:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCARul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:50:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so12245470wmh.5
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDOHl0/6kUuGmp3187+2GHragFUtmdHA4Tw5glzaRS8=;
        b=vD0OdiUUJbY4Va8jpXyHv79gvmCBhe1nfGyDVpEPx0N35KbLQf+akHzet+TXnloJcn
         FgRaDe5yB2iq1s7Dqwu8yjRCCsNwMe0w0eHwyF5Xi+JD0cV0aMpP7lXjTV9hAHzqb9LW
         +V2gAHgUDM14AHvKFhx4TLPcZ5nNy2jr8OYCz1FC+iXAlG8TNtnHs8xj6SeEiUCqBwRg
         cB+wcPXN0yEK0r+WIJ92JFzQRNg3xIQzxdtNfjaP43VpQfvW3jhD+HDWV0s7+Hjej0lB
         lnqX2FV9Hnn6dgP10dYpXmrw570YaX17XMes6OlVQgSclSKEh+sxWPaDG2X/yclkk+J5
         wW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDOHl0/6kUuGmp3187+2GHragFUtmdHA4Tw5glzaRS8=;
        b=c/nvwEj7oqgJhdD6RQjpmzB8iA0NlWXe7wL5F+8devDTpXVo//P1oHEzYAdBpS61oK
         /YtWjQPAx3b8xaQszMy22LNsLCZzmtyXNVOMirz/bqD5jIHgcqnWT+Pi8AR40FyGG8Xm
         VNVUhNfVaf74+tiEZSVm5aHwciAkNXP5uuzdsmT/AaV+qpc4WUVNrqZFMr12a3xqEtjj
         CWRP5xG27ei5VUuoF2BHLdfHORkOJcjkwalTrmpTjxierZDgmWt10sMtsPj974qT+Ul0
         cJUjl9MnshoPwlPtZR0Ba+Y4th0OW7ysQqjpn9pPTfK+dIhwyg+z4C2MKlFC9yHg0tdy
         aPrA==
X-Gm-Message-State: AHQUAuYHwS/V4fBIkElh9N1hoH67NoN71YOC2uj5yC1USrIVWkIs2C/D
        5qO/lDJObsseq5ykaDVSn0Cqhrdp
X-Google-Smtp-Source: AHgI3IZ3FOCHl1Wr0JTN1F5vSTiyfFIEZQhVgx+RYyUqtKL29uWOZ0fm1Co8AkkKn7hl3MeUA4lBjQ==
X-Received: by 2002:a05:600c:2115:: with SMTP id u21mr4195194wml.70.1551462638820;
        Fri, 01 Mar 2019 09:50:38 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-112-206.w86-199.abo.wanadoo.fr. [86.199.35.206])
        by smtp.googlemail.com with ESMTPSA id o8sm11672247wma.1.2019.03.01.09.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:50:38 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 1/4] name-rev: improve name_rev() memory usage
Date:   Fri,  1 Mar 2019 18:50:21 +0100
Message-Id: <20190301175024.17337-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301175024.17337-1-alban.gruin@gmail.com>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

name_rev() is a recursive function.  For each commit, it allocates the
name of its parents, and call itself.  A parent may not use a name for
multiple reasons, but in any case, the name will not be released.  On a
repository with a lot of branches, tags, remotes, and commits, it can
use more than 2GB of RAM.

To improve the situation, name_rev() now returns a boolean to its caller
indicating if it can release the name.  The caller may free the name if
the commit is too old, or if the new name is not better than the current
name.

There a condition that will always be false here when name_rev() calls
itself for the first parent, but it will become useful when name_rev()
will stop to name commits that are not mentionned in the stdin buffer.
If the current commit should not be named, its parents may have to be,
but they may not.  In this case, name_rev() will tell to its caller that
the current commit and its first parent has not used the name, and that
it can be released.  However, if the current commit has been named but
not its parent, or the reverse, the name will not be released.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/name-rev.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index f1cb45c227..0719a9388d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -77,7 +77,7 @@ static int is_better_name(struct rev_name *name,
 	return 0;
 }
 
-static void name_rev(struct commit *commit,
+static int name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
 		int generation, int distance, int from_tag,
 		int deref)
@@ -86,11 +86,12 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
+	int free_alloc = 1;
 
 	parse_commit(commit);
 
 	if (commit->date < cutoff)
-		return;
+		return 1;
 
 	if (deref) {
 		tip_name = to_free = xstrfmt("%s^0", tip_name);
@@ -111,9 +112,10 @@ static void name_rev(struct commit *commit,
 		name->generation = generation;
 		name->distance = distance;
 		name->from_tag = from_tag;
+		free_alloc = 0;
 	} else {
 		free(to_free);
-		return;
+		return 1;
 	}
 
 	for (parents = commit->parents;
@@ -131,15 +133,18 @@ static void name_rev(struct commit *commit,
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
 
-			name_rev(parents->item, new_name, taggerdate, 0,
-				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+			if (name_rev(parents->item, new_name, taggerdate, 0,
+				      distance + MERGE_TRAVERSAL_WEIGHT,
+				      from_tag, 0))
+				free(new_name);
 		} else {
-			name_rev(parents->item, tip_name, taggerdate,
-				 generation + 1, distance + 1,
-				 from_tag, 0);
+			free_alloc &= name_rev(parents->item, tip_name, taggerdate,
+					       generation + 1, distance + 1,
+					       from_tag, 0);
 		}
 	}
+
+	return free_alloc;
 }
 
 static int subpath_matches(const char *path, const char *filter)
-- 
2.20.1


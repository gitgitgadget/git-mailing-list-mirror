Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE52202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdIVXfa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33831 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so2481357wma.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7V8mhuixhkV8yNoSt9tgdkFkajeVRsM0QGVOT19EDQ=;
        b=KVc1fIMUI4TxUWZTE3tCln8MVi4AJQBuUC9RwGOLKRuhH68RWIwOr/V6h2EQVneHYK
         ouTab1N72n9Jun78A86W4nWTGDXj7DmS4aiFN8n+sY4Zc86EV0Ccgl1mAGoRJllyq8EI
         qYmSkx0JTZb2dmOedpjUwVivlhpNigPwPYhcC2x5pgg//pSviBGI+8ltfFQQGohMrngp
         utWYxPCcUe1iGxG11Z5SZ1hGdUy5mG03lE0jtghmeJ9XzZ7HHke5qdsDIBWpJmOsBloa
         sLRDAK63qWBX/Puh1CpIR2m6j56hbuQi85KzBV8b+vwoPxOJ/qJkEGb5dd63p/jT3RnF
         Gn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7V8mhuixhkV8yNoSt9tgdkFkajeVRsM0QGVOT19EDQ=;
        b=j/73IgE7Xt4ZQiuwoEMOfXwxpZI6MnAlpo1xKUWR38adFKTjdPoYWdvWeEEyHehKJt
         AQ3KNWxU32DzJnUPcAuNkvkk+diyjwWsSloLp1kzuKefZI9uVfd50v7gAbbBMoHXgVCQ
         qKYfufugD8N1HFOHfZen/D30jqxNKlZyNYmcYjDsJo/TMmLD5wvmdQ9oVwt1/gMdfOiG
         5bx28fJS9Cxy9b9EgurZl6LahgYOST7kXIKYa1n9JUn28Fe//BKTa0tKbdZXoB880sEJ
         46QUokp/6xVV/Mjka1liSHwkltJgX8ionwsa+EcW3/Vh7nsW/Cb6Hk6CUb+G0EWusQFq
         gXgg==
X-Gm-Message-State: AHPjjUgTB6sijzclpaUj0HLDldnLOnoq2BIifq17PmbE+zvQ7nFihiPY
        RUxHImdyf0jr+nyIRXSTsxA2zA==
X-Google-Smtp-Source: AOwi7QDgKMrYc2ezrZHe2Y5q4E0KpMM2OSVZ8W941oC6nWJLsqDIV1w5cwgnE3nTsvhb0Q0ispqtIA==
X-Received: by 10.28.32.22 with SMTP id g22mr4588090wmg.38.1506123327641;
        Fri, 22 Sep 2017 16:35:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 4/6] object_array: use `object_array_clear()`, not `free()`
Date:   Sat, 23 Sep 2017 01:34:52 +0200
Message-Id: <f325af4048bc14d6194da169b02de7d18fff8471.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of freeing `foo.objects` for an object array `foo` (sometimes
conditionally), call `object_array_clear(&foo)`. This means we don't
poke as much into the implementation, which is already a good thing, but
also that we release the individual entries as well, thereby fixing at
least one memory-leak (in diff-lib.c).

If someone is holding on to a pointer to an element's `name` or `path`,
that is now a dangling pointer, i.e., we'd be turning an unpleasant
situation into an outright bug. To the best of my understanding no such
long-term pointers are being taken.

The way we handle `study` in builting/reflog.c still looks like it might
leak. That will be addressed in the next commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/reflog.c | 4 ++--
 diff-lib.c       | 3 +--
 submodule.c      | 4 ++--
 upload-pack.c    | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index e237d927a..6b34f23e7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -182,8 +182,8 @@ static int commit_is_complete(struct commit *commit)
 			found.objects[i].item->flags |= SEEN;
 	}
 	/* free object arrays */
-	free(study.objects);
-	free(found.objects);
+	object_array_clear(&study);
+	object_array_clear(&found);
 	return !is_incomplete;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index 2a52b0795..4e0980caa 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -549,7 +549,6 @@ int index_differs_from(const char *def, int diff_flags,
 	rev.diffopt.flags |= diff_flags;
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
-	if (rev.pending.alloc)
-		free(rev.pending.objects);
+	object_array_clear(&rev.pending);
 	return (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0);
 }
diff --git a/submodule.c b/submodule.c
index 36f45f5a5..79fd01f7b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1728,7 +1728,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 			add_object_array(merges.objects[i].item, NULL, result);
 	}
 
-	free(merges.objects);
+	object_array_clear(&merges);
 	return result->nr;
 }
 
@@ -1833,7 +1833,7 @@ int merge_submodule(struct object_id *result, const char *path,
 			print_commit((struct commit *) merges.objects[i].item);
 	}
 
-	free(merges.objects);
+	object_array_clear(&merges);
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..ec0eee8fc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -888,7 +888,7 @@ static void receive_needs(void)
 		}
 
 	shallow_nr += shallows.nr;
-	free(shallows.objects);
+	object_array_clear(&shallows);
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-- 
2.14.1.727.g9ddaf86


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9422D1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeDTTIw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:08:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35639 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDTTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:08:51 -0400
Received: by mail-wr0-f196.google.com with SMTP id w3-v6so25538654wrg.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEvOU/fm/9erRlUOvkkf/zxTxnUi+L9uV29FrEjOgtg=;
        b=vTYWZclnRGqJ9dBlcwjAZ/kmZAp3Y5O+m4cJIiEjzRnyOTso/3cdxdLfhdat/peu37
         Jwmj8U83OUtZm38FhPrgZ2oU8oK/mJh1W2EdjWzlx+czZNei38/fdA2JCpQzDJFS4sXQ
         chPI5uI7GDFX0GK/w5AQCVT9R72aV4moTQ3RUqrK1Hnez2ektF6vYStWhieftRtWQ3oR
         ogPFgPvJXTnPY92+9EUQmPEdXrVILCwlGDBeXNnKqyGlCW1mjskYixlO3JsKYz/HS1AB
         wjaU5rSsrFou09y4P7OqlRV9jvoHvdGUYSWvHS6BfXvBupUurt8AVFCZ6QmFZ1r3f+yB
         ga0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEvOU/fm/9erRlUOvkkf/zxTxnUi+L9uV29FrEjOgtg=;
        b=nWngp9Cv4BT2H2Y6VRqmpWf4M/yuNwzUz3U8120qJjM0rujsL9S7Arx6sKUOak7Pjo
         iBtXH8WWp7FQZfJdatkP99z9WJVChZaG6R9OnCmIhDTCcc2QkS+4tZerpi4lpoWehXCv
         LOYHJo88uFMsADSXWpQ360kx7F+DOz9QZEXwk7Zpo8weF3zdHwPdtzZ4rVBHJGNsqIcv
         gMMj0ucaMvM1ucnOgH8pRtiWjDoft0tcw+3q57E3K+tDOUtNfXmw/0upTOnXJwENxxHW
         it6AygsYHOIkfdeklm02p3E50rmp+bopSrc9yJA5l8I6B/h560GSsS7k8+vYc7vMJ9YE
         7oTw==
X-Gm-Message-State: ALQs6tBmiOiyhNj3uSB/jSHxK1XXuwj15JYdh81QOG0Z2mVJwczS6bHH
        /qooKbLazrsxGWorug818a37Y5XAYm8=
X-Google-Smtp-Source: AIpwx4/d8MwtYiaPFXy9jzUYjTTxK72OZdogRJdNX+vIb3vkVdQTxb5k/bpiQNLpvj4gucoL8SMfig==
X-Received: by 2002:adf:c4a6:: with SMTP id m35-v6mr9324587wrf.103.1524251329697;
        Fri, 20 Apr 2018 12:08:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w186sm2383328wmw.27.2018.04.20.12.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 12:08:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2] fast-export: fix regression skipping some merge-commits
Date:   Fri, 20 Apr 2018 21:08:29 +0200
Message-Id: <20180420190829.2433702-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <MW2PR18MB22841823133D9C96D4428CDDE5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <MW2PR18MB22841823133D9C96D4428CDDE5B40@MW2PR18MB2284.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

7199203937 (object_array: add and use `object_array_pop()`, 2017-09-23)
noted that the pattern `object = array.objects[--array.nr].item` could
be abstracted as `object = object_array_pop(&array)`.

Unfortunately, one of the conversions was horribly wrong. Between
grabbing the last object (i.e., peeking at it) and decreasing the object
count, the original code would sometimes return early. The updated code
on the other hand, will always pop the last element, then maybe do the
early return before doing anything with the object.

The end result is that merge commits where all the parents have still
not been exported will simply be dropped, meaning that they will be
completely missing from the exported data.

Reintroduce the pattern of first grabbing the last object (using a new
function `object_array_peek()`), then later poping it. Using
`..._peek()` and `..._pop()` makes it clear that we are referring to the
same item, i.e., we do not grab one element, then remove another one.

Add a test that would have caught this.

Reported-by: Isaac Chou <Isaac.Chou@microfocus.com>
Analyzed-by: Isaac Chou <Isaac.Chou@microfocus.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Hmph. Version 1 described the test as "todo". This version uses a better
description. No other changes.

 t/t9350-fast-export.sh | 22 ++++++++++++++++++++++
 object.h               |  9 +++++++++
 builtin/fast-export.c  |  3 ++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 866ddf6058..194782b05b 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -540,4 +540,26 @@ test_expect_success 'when using -C, do not declare copy when source of copy is a
 	test_cmp expected actual
 '
 
+test_expect_success 'merge commit gets exported with --import-marks' '
+	test_create_repo merging &&
+	git -C merging commit --allow-empty -m initial &&
+
+	git -C merging checkout -b topic &&
+	>merging/topic-file &&
+	git -C merging add topic-file &&
+	git -C merging commit -m topic-file &&
+
+	git -C merging checkout master &&
+	>merging/master-file &&
+	git -C merging add master-file &&
+	git -C merging commit -m master-file &&
+
+	git -C merging merge --no-ff topic -m "merge the topic" &&
+
+	oid=$(git -C merging rev-parse HEAD^^) &&
+	echo :1 $oid >merging/git-marks &&
+	git -C merging fast-export --import-marks=git-marks refs/heads/master >out &&
+	grep "merge the topic" out
+'
+
 test_done
diff --git a/object.h b/object.h
index f13f85b2a9..4d8ce280d9 100644
--- a/object.h
+++ b/object.h
@@ -129,6 +129,15 @@ void add_object_array_with_path(struct object *obj, const char *name, struct obj
  */
 struct object *object_array_pop(struct object_array *array);
 
+/*
+ * Returns NULL if the array is empty. Otherwise, returns the last object.
+ * That is, the returned value is what `object_array_pop()` would have returned.
+ */
+inline struct object *object_array_peek(const struct object_array *array)
+{
+	return array->nr ? array->objects[array->nr - 1].item : NULL;
+}
+
 typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 
 /*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 27b2cc138e..8377d27b46 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -650,9 +650,10 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 {
 	struct commit *commit;
 	while (commits->nr) {
-		commit = (struct commit *)object_array_pop(commits);
+		commit = (struct commit *)object_array_peek(commits);
 		if (has_unshown_parent(commit))
 			return;
+		(void)object_array_pop(commits);
 		handle_commit(commit, revs, paths_of_changed_objects);
 	}
 }
-- 
2.17.0


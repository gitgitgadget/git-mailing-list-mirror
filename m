Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A361F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRL5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 06:57:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRL5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 06:57:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so10302971pfb.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 03:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDDQgzumt+ZfAiRI84VFu6y3qsjjXLL+lCVlN7u3nSo=;
        b=bokbU3MXFHlnfB3qrvJVzzFryTdX6dC9zDP74uEieozHNpDwEX7W1mb+RLmaK3gu1X
         X5l1sfW9E7Ksq5Fvb5XcIN5VjET741CFGdNsRlTs9Jk5FsJcRn6xkLjN8FPmKrZkF+aS
         cxGWfvr2KRkQzhR3MdmotaRBxYLAo90A6k2iB5dnzJaNwij7tiemg5lhwMFVTErrWy7W
         caOeASYxbyLGp/gQcExPfs0MgCJtq2R27KN/tLfm408c8Q0sZhm8ZM/RTMQQqKz0Pr+V
         7TYn+u93WRe6oCmFRiJ+ZfhYKJoEOE5NFzw8nLKc5eolCAtNOXXlI6s0i2/pjYGcHiOm
         NOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDDQgzumt+ZfAiRI84VFu6y3qsjjXLL+lCVlN7u3nSo=;
        b=svzOBu9kVum7R7/shpZroDKuNUw1TL6SSkSbI+b64Cfjb89FeZedkmli7tvNONK8hZ
         mel08VUhuob8loPZV30/qSIN2eYfNe/TA1kostQ0+iK5SqfSDi8nRyApKSmhnKWXNLP6
         46QdURUc64oLhxgxLobEKOFCZWbp444e69iew7P+Uzx7sZimr3GsmptxSgpZLSscNxmg
         6Vk+fVDHj/AOgkh3epo0kbH5l+TizBn5lbSTFrCZ2CwsSmF5FLM0LOq+a9c/f1OX6QX2
         yUtWQDikyoeahZcsrNHwt1a5strnwpVpK7dJ0TJEc3qLH0QG5qSx9r2zPsC9TI7HkOI2
         ZxoQ==
X-Gm-Message-State: APjAAAWKVbq82LQHpqWrRnSaOyciLBKrcgHVUShUmsTtaxjceZpuEspu
        pFefeywKOkVkA5rAbTD4xoeZZdvN
X-Google-Smtp-Source: APXvYqwgPpyh0pZQFPMrAzTTKq0GvBu0vWYH5RKT+tNavL7tG1JMmktFhZj3oPOaYEjsFqVXojrEyQ==
X-Received: by 2002:a62:53:: with SMTP id 80mr34863779pfa.192.1574078271631;
        Mon, 18 Nov 2019 03:57:51 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id p5sm301514pgj.63.2019.11.18.03.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 03:57:51 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2] sequencer: handle rebase-merges for "onto" message
Date:   Mon, 18 Nov 2019 18:57:47 +0700
Message-Id: <20191118115747.31533-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.10.gc61c3b979f.dirty
In-Reply-To: <20191118112357.GA29922@danh.dev>
References: <20191118112357.GA29922@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to work correctly, git-rebase --rebase-merges needs to make
initial todo list with unique labels.

Those unique labels is being handled by employing a hashmap and
appending an unique number if any duplicate is found.

But, we forget that beside those labels for side branches,
we also have a special label `onto' for our so-called new-base.

In a special case that any of those labels for side branches named
`onto', git will run into trouble.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
Sorry for the noise, I forgot to check spelling for v1

And I forgot to delete From line when append to my MUA.

Range-diff against v1:
1:  48205889b4 ! 1:  9246beacf2 sequencer: handle rebase-merge for "onto" message
    @@ Metadata
     Author: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    sequencer: handle rebase-merge for "onto" message
    +    sequencer: handle rebase-merges for "onto" message
     
         In order to work correctly, git-rebase --rebase-merges needs to make
         initial todo list with unique labels.
     
         Those unique labels is being handled by employing a hashmap and
    -    suffixing an unique number if any duplicate is found.
    +    appending an unique number if any duplicate is found.
     
    -    But we forgat that beside of those labels for side branches,
    -    we also make a special label `onto' for our so-called new-base.
    +    But, we forget that beside those labels for side branches,
    +    we also have a special label `onto' for our so-called new-base.
     
         In a special case that any of those labels for side branches named
         `onto', git will run into trouble.

 sequencer.c              |  5 +++++
 t/t3430-rebase-merges.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 350045b1b4..fc81e43f0f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4569,10 +4569,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	strbuf_init(&state.buf, 32);
 
 	if (revs->cmdline.nr && (revs->cmdline.rev[0].flags & BOTTOM)) {
+		struct labels_entry *onto_label_entry;
 		struct object_id *oid = &revs->cmdline.rev[0].item->oid;
 		FLEX_ALLOC_STR(entry, string, "onto");
 		oidcpy(&entry->entry.oid, oid);
 		oidmap_put(&state.commit2label, entry);
+
+		FLEX_ALLOC_STR(onto_label_entry, label, "onto");
+		hashmap_entry_init(&onto_label_entry->entry, strihash("onto"));
+		hashmap_add(&state.labels, &onto_label_entry->entry);
 	}
 
 	/*
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f728aba995..4e2c0ede51 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -474,4 +474,25 @@ test_expect_success '--rebase-merges with commit that can generate bad character
 	git rebase --rebase-merges --force-rebase E
 '
 
+test_expect_success '--rebase-merges with message matched with onto label' '
+	git checkout -b onto-label E &&
+	git merge -m onto G &&
+	git rebase --rebase-merges --force-rebase E &&
+	test_cmp_graph <<-\EOF
+	*   onto
+	|\
+	| * G
+	| * F
+	* |   E
+	|\ \
+	| * | B
+	* | | D
+	| |/
+	|/|
+	* | C
+	|/
+	* A
+	EOF
+'
+
 test_done
-- 
2.24.0.10.gc61c3b979f.dirty


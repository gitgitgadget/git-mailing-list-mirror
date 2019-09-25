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
	by dcvr.yhbt.net (Postfix) with ESMTP id A73901F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411366AbfIYBkP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfIYBkP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so2373753pfb.7
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjLySYLBZHHft3O6gARhS8AXliebYlKeZZ9zMnuPoro=;
        b=mY4E+94y4qf8zonSjtixCY9JAu/9UPMndRDOlG8F2+MkC+eQsXMmfiurH4tboJ8GIO
         JlJV1puBjAt1TAjOHJKRV/PshVsFvA8qaACLHAUfpO87aMUFauwMFoJPybX7mX30c4j6
         pCAnFiisZI7SzH1ctAIuY0WhOyeMLLKzsSghY9Y3cq4YmmZt6jV6wwjOaPPj490c+0MW
         6E34cgIHQmH5nYZ+dQgTasuNMMKpgdwi66XdbX80bYLStpH735IIdjTNBTsQVvP5fE75
         6pW9NB9Q4jgIgPrlOrUXCPDe1wEDN0g8uKy3jQD3bTeZkxajes7uP9iOOAPcoPd+p4Ee
         kK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjLySYLBZHHft3O6gARhS8AXliebYlKeZZ9zMnuPoro=;
        b=doKPuM99fUn5N5j8C8zhssalPOuurauNyfsT3fdzKDV24sr9XAr7mLMkx7VMqQekaV
         ReHbm0W1dZ643MAOmK+BSemxv2ejmqPPFp57Onjt6+c13T5dsxqghE/CMDktC5Q61Zzo
         sv+Ka4DCke+AMxLN3ftzvEydLEADKKN2Xc+NbF7ScDw42GjMeQtkVlqJfASkNqRMeDmi
         D9fIFICfH3itgZ51TivHDm6MoHkuIaUylxoT8xgvKJt+Lk8ZvrYod8N/OefyEI/FR4Dd
         fw9mkxxO5kZvfxEla6Y0cEa0UyoIeOiPPKNgavRzxAU9C41aLJwjzE0/XNU7YEp/+f6i
         O0ZA==
X-Gm-Message-State: APjAAAUVVypKmWU02QI8lYc398ZRKzbG5uZyeMNmVROTsyHs59vUqLaw
        v8d4+BIqfVOif5aMqGrKNyoThBY0y0U=
X-Google-Smtp-Source: APXvYqwkreZZPlZM4GBEpoCB3kuzCsaYLJhNO7jRiWFk8xMbkhEfKhP/u1PWfgN5ikHMFZMWi8swPA==
X-Received: by 2002:a63:4b42:: with SMTP id k2mr6219232pgl.35.1569375614316;
        Tue, 24 Sep 2019 18:40:14 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/8] fast-import: fix handling of deleted tags
Date:   Tue, 24 Sep 2019 18:39:59 -0700
Message-Id: <20190925014005.17056-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If our input stream includes a tag which is later deleted, we were not
properly deleting it.  We did have a step which would delete it, but we
left a tag in the tag list noting that it needed to be updated, and the
updating of annotated tags occurred AFTER ref deletion.  So, when we
record that a tag needs to be deleted, also remove it from the list of
annotated tags to update.

While this has likely been something that has not happened in practice,
it will come up more in order to support nested tags.  For nested tags,
we either need to give temporary names to the intermediate tags and then
delete them, or else we need to use the final name for the intermediate
tags.  If we use the final name for the intermediate tags, then in order
to keep the sanity check that someone doesn't try to update the same tag
twice, we need to delete the ref after creating the intermediate tag.
So, either way nested tags imply the need to delete temporary inner tag
references.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c          | 29 +++++++++++++++++++++++++++++
 t/t9300-fast-import.sh | 13 +++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..dab905d667 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2793,6 +2793,35 @@ static void parse_reset_branch(const char *arg)
 		b = new_branch(arg);
 	read_next_command();
 	parse_from(b);
+	if (b->delete && !strncmp(arg, "refs/tags/", 10)) {
+		/*
+		 * Elsewhere, we call dump_branches() before dump_tags(),
+		 * and dump_branches() will handle ref deletions first, so
+		 * in order to make sure the deletion actually takes effect,
+		 * we need to remove the tag from our list of tags to update.
+		 *
+		 * NEEDSWORK: replace list of tags with hashmap for faster
+		 * deletion?
+		 */
+		struct strbuf tag_name = STRBUF_INIT;
+		struct tag *t, *prev = NULL;
+		for (t = first_tag; t; t = t->next_tag) {
+			strbuf_reset(&tag_name);
+			strbuf_addf(&tag_name, "refs/tags/%s", t->name);
+			if (!strcmp(arg, tag_name.buf))
+				break;
+			prev = t;
+		}
+		if (t) {
+			if (prev)
+				prev->next_tag = t->next_tag;
+			else
+				first_tag = t->next_tag;
+			if (!t->next_tag)
+				last_tag = prev;
+			/* There is no mem_pool_free(t) function to call. */
+		}
+	}
 	if (command_buf.len > 0)
 		unread_command_buf = 1;
 }
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 141b7fa35e..74bc41333b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -85,6 +85,15 @@ test_expect_success 'A: create pack from stdin' '
 	An annotated tag that annotates a blob.
 	EOF
 
+	tag to-be-deleted
+	from :3
+	data <<EOF
+	Another annotated tag that annotates a blob.
+	EOF
+
+	reset refs/tags/to-be-deleted
+	from 0000000000000000000000000000000000000000
+
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
 	git whatchanged master
@@ -157,6 +166,10 @@ test_expect_success 'A: verify tag/series-A-blob' '
 	test_cmp expect actual
 '
 
+test_expect_success 'A: verify tag deletion is successful' '
+	test_must_fail git rev-parse --verify refs/tags/to-be-deleted
+'
+
 test_expect_success 'A: verify marks output' '
 	cat >expect <<-EOF &&
 	:2 $(git rev-parse --verify master:file2)
-- 
2.23.0.177.g8af0b3ca64


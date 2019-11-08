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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6A91F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfKHJoQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46903 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id l4so3749913plt.13
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R2cv6W7pwwevfjzqI2cdatUqk/ZCUseSEgHm6Y1tDlk=;
        b=eTVlNpTV1YnlNQVdFVDblQPFUYlc3+5uqAcZ8BZoNFnDR9LMXt/tKdKGLYFpaJjJ5s
         aZ5+GE+eT0s7OpYFKILBQ9Ia4YqhjrR84uPS4i8JpJlTx/tHrWDHQW0Ci8OrcEQwS/zH
         rQinrfZyWvftyz0FdjIDPmJtFeF6G0kz/NJ7ZSYWHkTHh++fZ/6OhTSjr4zUZ04lbzbw
         CGLWDz/WJIOe042ah8hx9bsH+4+vGxiV692KEmhOT36QaKU8aUP6z1U/0uXzUZc41MHI
         Crgd6Hzbk7no8F8drH8HkR7LXBHejrUj/SmRRxS+zQIrwDzD+jAUQoGwwHVs/hAQD+Wm
         retQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2cv6W7pwwevfjzqI2cdatUqk/ZCUseSEgHm6Y1tDlk=;
        b=TsY0Rakg1EjZo3ospUGgsOjCi4PVj5EY34XD7r26SbflLMFsOa1xQHUSWeDY7BzAuS
         pP9w2Uu9Ap7oVnRP0QWONNhcbSEuB3b4jD80bo4oWjQ+6xGFCxG8fSw2elO1UBhEKP6s
         LVQWICv5tOraxEabIbvlnFlEbIvx0ggwgZW6PV1HFhZDHvD3E22S3qUpsBmiFfIKw8Ns
         r8yDbyZ+B+Gb7g3j33HlYLYO0ZC15Msiujm+c9hl3iKyKPbUXJn35lWJkWTZVkJMVJwR
         Op2DK8eN0A2l6f9j+SDd9X6Kld41TRRZGSav2XkDcE7ZEX8n6Kw9wudypr1jkOuZ/863
         O7aw==
X-Gm-Message-State: APjAAAWFF2D3Cm3jCqT7HMq03mhTJmK9HnQ9mscH7Ac+MOC1h5LTqnQU
        PO0pN3gw64UHL4gm/0m8EJLLd1y/
X-Google-Smtp-Source: APXvYqzUm1ub9VrlNvOsvR8RRxPLJQE6Tl3H910MRobDkpJigJkkDn6mEMTuiPOHFw2svY8cTt1ufg==
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr12480072pjx.42.1573206254763;
        Fri, 08 Nov 2019 01:44:14 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:14 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 9/9] sequencer: fallback to sane label in making rebase todo list
Date:   Fri,  8 Nov 2019 16:43:51 +0700
Message-Id: <860dee65f49ea7eacf5a0c7c8ffe59095a51b1ce.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later stage of rebasing, we will make a ref in
refs/rewritten/<label>, this label is extracted from the subject of
current merge commit.

If that subject has forbidden character for refname, git couldn't create
the rewritten ref. One such case is the merge commit subject has
a multibyte character encoded in ISO-2022-JP.

Provide a sane fallback in order to help git-rebase works in such case

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

I don't know if this is the _right_ way to do.
We may discard this patch and fix the test instead.

 sequencer.c            | 11 +++++++++--
 t/t3433-rebase-i18n.sh |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4d12ad3cc6..5a00941205 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4562,6 +4562,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	while ((commit = get_revision(revs))) {
 		struct commit_list *to_merge;
 		const char *p1, *p2;
+		const char *hex_oid;
 		struct object_id *oid;
 		int is_empty;
 
@@ -4609,9 +4610,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			if (isspace(*p1))
 				*(char *)p1 = '-';
 
+		hex_oid = oid_to_hex(&commit->object.oid);
+
+		if (check_refname_format(label.buf, REFNAME_ALLOW_ONELEVEL) < 0) {
+			strbuf_reset(&label);
+			strbuf_addf(&label, "label-%s", hex_oid);
+		}
+
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s -C %s",
-			    cmd_merge, oid_to_hex(&commit->object.oid));
+		strbuf_addf(&buf, "%s -C %s", cmd_merge, hex_oid);
 
 		/* label the tips of merged branches */
 		for (; to_merge; to_merge = to_merge->next) {
diff --git a/t/t3433-rebase-i18n.sh b/t/t3433-rebase-i18n.sh
index 537d18c330..93e5402849 100755
--- a/t/t3433-rebase-i18n.sh
+++ b/t/t3433-rebase-i18n.sh
@@ -45,7 +45,7 @@ test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
 	compare_msg eucJP.txt eucJP UTF-8
 '
 
-test_expect_failure 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
+test_expect_success 'rebase --rebase-merges update encoding eucJP to ISO-2022-JP' '
 	git switch -c merge-eucJP-ISO-2022-JP first &&
 	git config i18n.commitencoding eucJP &&
 	git merge -F "$TEST_DIRECTORY/t3433/eucJP.txt" second &&
-- 
2.24.0.8.g2e95ca57d2.dirty


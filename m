Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226481F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKKGEY (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40321 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKKGEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so7348392plt.7
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiFHs5lTg5cVIgwCLvoPeXW0wlHuHmw23P8fywgF06Y=;
        b=c2f5/+bgt9edLAV7LdXsiLi9+lLGKMest7wrh8CZQMoEc5f78duKAXzjnm3DDb7/fi
         cC/HCqzPlcx6us5URhddPYmL6LimM0S0W/goSrZWHLOhw+vDtRf1df3uZ/XfzTEnGSss
         cksqJrTAJN1GFuN/vcZN43DHd8AjZhn99Ss/yC9NqMiQvj/LT8z3AmP/GapY/9JV1gJa
         WPdG3o5QTAhrxbtgS1bq84+cCMGoE8qhA4X9nI/DlH5UgUVeny9qpaBIod+RvtCFk6X+
         4mSSpIKyyTq1f6uiwa8ekfvcZFMm0ZAV0RjqYnSrURIbI+8sdbgVL3+xI5Zf5nEzOyef
         RjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiFHs5lTg5cVIgwCLvoPeXW0wlHuHmw23P8fywgF06Y=;
        b=XycPExDIJ1rDXZSYExOPaErNZtrexaQdSu0I4xHKHRjz6nbK5tFTXggT6Bs3WYiqq9
         FbGqC7EjSmBRRF5dQ52QZzmmubuasI5EqTFYX6s0vp+lh3ja3KoZaAovW6So38pHIWoI
         0tKjHiHpdJEhTYqboi6ImTiDSQkTAl+46nvUNhWWaNBwjWulChJ1z6y5/yu8IraVxP8P
         G9UADyuPMpD8ck+zVDxxnAjjvkrYkjzIUUavpd8vz5BTcF/vl7I1P88cFu9U/B5P8teK
         IxG476VF4ZLyJK25sfkDoKhS2iQVSXe/4jZcUEQJR6N74fMfWWZPbOk18+d1Ujb2FGAp
         1MUg==
X-Gm-Message-State: APjAAAUBYHW9GUVKaZsXfBPzJKRqKHV3n7cuEgMotn2gbNX/KZp5d2NL
        +/db1H8PxteFKU3zuXiYV/ZB/9De
X-Google-Smtp-Source: APXvYqxfB+ZG5T9UNJfkQ1evhRHIIu5Rl6VJmVPmP+tAoTJlkPZ+Hdhy9i/5eqXgHwnI8XbKjgmEJg==
X-Received: by 2002:a17:902:266:: with SMTP id 93mr23704704plc.163.1573452262115;
        Sun, 10 Nov 2019 22:04:22 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:21 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 6/9] sequencer: reencode squashing commit's message
Date:   Mon, 11 Nov 2019 13:03:39 +0700
Message-Id: <f04a9d16981cf0b7a58d53f466f767f5f68d0960.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On fixup/squash-ing rebase, git will create new commit in
i18n.commitencoding, reencode the commit message to that said encode.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c            |  8 +++++---
 t/t3900-i18n-commit.sh | 10 +++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6ab1bba39d..b5712e59d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1574,6 +1574,7 @@ static int update_squash_messages(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int res;
 	const char *message, *body;
+	const char *encoding = get_commit_output_encoding();
 
 	if (opts->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
@@ -1600,7 +1601,7 @@ static int update_squash_messages(struct repository *r,
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
-		if (!(head_message = get_commit_buffer(head_commit, NULL)))
+		if (!(head_message = logmsg_reencode(head_commit, NULL, encoding)))
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
@@ -1621,7 +1622,7 @@ static int update_squash_messages(struct repository *r,
 		unuse_commit_buffer(head_commit, head_message);
 	}
 
-	if (!(message = get_commit_buffer(commit, NULL)))
+	if (!(message = logmsg_reencode(commit, NULL, encoding)))
 		return error(_("could not read commit message of %s"),
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
@@ -4152,9 +4153,10 @@ static int commit_staged_changes(struct repository *r,
 				 */
 				struct commit *commit;
 				const char *path = rebase_path_squash_msg();
+				const char *encoding = get_commit_output_encoding();
 
 				if (parse_head(r, &commit) ||
-				    !(p = get_commit_buffer(commit, NULL)) ||
+				    !(p = logmsg_reencode(commit, NULL, encoding)) ||
 				    write_message(p, strlen(p), path, 0)) {
 					unuse_commit_buffer(commit, p);
 					return error(_("could not write file: "
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index a518281b04..d277a9f4b7 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -224,7 +224,15 @@ test_commit_autosquash_multi_encoding () {
 		git commit -a --$flag HEAD^ &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git rev-list HEAD >actual &&
-		test_line_count = 3 actual
+		test_line_count = 3 actual &&
+		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
+		if test $flag = squash; then
+			subject="$(head -1 expect)" &&
+			printf "\nsquash! %s\n" "$subject" >>expect
+		fi &&
+		git cat-file commit HEAD^ >raw &&
+		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
+		test_cmp expect actual
 	'
 }
 
-- 
2.24.0.164.g78daf050de.dirty


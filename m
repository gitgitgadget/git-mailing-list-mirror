Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B4FC4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3D42246B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLLQxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407685AbgLLQww (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:52:52 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7684DC0613D3
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:12 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id q25so11345928otn.10
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2y16zpbJLgQCBtnJuWPErw4b7gTF1z77tim59YOdNg=;
        b=UgShE8q0c0gaMGgA3YUkt178/pRyqTj9aZyzHx+DeXdwUvztxFSg8sKQU8VfWsQpK/
         fUl5eFrV8LJPZUyphAL6UJ3YHdrsusZAYjb5CQNtj/m2JTHkR4EGKOEnMdaw199QZWvL
         HnXGVTI+lNj1X9yNoY2OHrj8sWLZnRlm+YnzRzTNjcK/Rs9mkdEq9j2zpROtqDbkwygp
         iZB+QAp+HJsU2M3W9xNBv3EAvcSBjdQBlkCHS5zlZTVKcv9i5CLJ7NWxRKNmZnaA1so1
         9mJD92sZxCvRDV5GMFe2gntf5q493QzM7CdyH0ENC61uFMJTJ1MphfzOzk0IsEZtmzm3
         69iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2y16zpbJLgQCBtnJuWPErw4b7gTF1z77tim59YOdNg=;
        b=XWrvPyp4qgm6yN0o7hDj4KPd7a5k24yqZ4NWuesP4ps9vWjwHB+DoKPvPJg0d39pgR
         wDUAfW2rjcISNAEDbaFtrOVl2di+VoD+89JCTccpTrqJ54tX7ORmcJMCfa38hCQ0KAPu
         fM9aGYnUwLs9NRd4XfLliFhda0pMtf9BqjGkKmilQr4JSLLoxhilyIxz/4jnwygvQgSQ
         bXAUJztUHq7NkGWYxjc85EB6hzB2kW1PHns/QReOAOdeffzu1ly0jxcZPR5ddq7k3bwC
         vxTsI4eS97KcxbYn/Ditjsb+2+SoJl34+OyEq4EDKkiq98Bi1tR2MbMeBSy36mzIpTDV
         TZMw==
X-Gm-Message-State: AOAM531/5OEc0dG/lGEHHyYbX4AKnHW9Z0xFDN807u8jD0uiDI0TSkqw
        cU1bmp3g9LcAOfAadQoSapzdpjIHD3dl1Q==
X-Google-Smtp-Source: ABdhPJwr6WRhLIz0T9eznrmLYrQW/IJOftBB2bXGx0OkGhVQ1fO8hqNbuT8yKvqJ9wOpnZjkY2PxIQ==
X-Received: by 2002:a9d:3786:: with SMTP id x6mr14203991otb.176.1607791931652;
        Sat, 12 Dec 2020 08:52:11 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o17sm926512otp.30.2020.12.12.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:52:10 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/3] pull: refactor fast-forward check
Date:   Sat, 12 Dec 2020 10:52:06 -0600
Message-Id: <20201212165208.780798-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165208.780798-1-felipe.contreras@gmail.com>
References: <20201212165208.780798-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It makes the code much cleaner.

Plus, we would like to be able to make this check before the decision to
rebase is made in a future step.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index aa56ebcdd0..03e6d53243 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -924,6 +924,20 @@ static int run_rebase(const struct object_id *newbase,
 	return ret;
 }
 
+static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_head)
+{
+	int ret;
+	struct commit_list *list = NULL;
+	struct commit *merge_head, *head;
+
+	head = lookup_commit_reference(the_repository, orig_head);
+	commit_list_insert(head, &list);
+	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
+	ret = repo_is_descendant_of(the_repository, merge_head, list);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1040,22 +1054,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
-			struct commit_list *list = NULL;
-			struct commit *merge_head, *head;
-
-			head = lookup_commit_reference(the_repository,
-						       &orig_head);
-			commit_list_insert(head, &list);
-			merge_head = lookup_commit_reference(the_repository,
-							     &merge_heads.oid[0]);
-			if (repo_is_descendant_of(the_repository,
-						  merge_head, list)) {
+			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
 				ret = run_merge();
 			}
-			free_commit_list(list);
 		}
 		if (!ran_ff)
 			ret = run_rebase(&newbase, &upstream);
-- 
2.29.2


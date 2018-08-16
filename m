Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154491F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeHPF0b (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:31 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:44798 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:31 -0400
Received: by mail-qk0-f201.google.com with SMTP id w126-v6so2996889qka.11
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7QEWliHIwcZtKDsvKG182yNZK4PnK9h0Fqq63/i8AEQ=;
        b=Vy+ln0mjWMCUuVhs6Fv+u/4nHavUecVL870jqfZ7bbs94HxKJ01ER+kSuYzbMfLDHp
         S0enczHcsnAbk3VBvWpJygsCJW+jTpGpr+6MzI2KNBruLDSmoTKJQaf55OiyHIjeuw0O
         nzqmU02IZVNjeySoAJbzisr0dle7eDo2p/qnZ1H4j1A7hSeF0ZE+Kz8nu9Zjywz2DCVN
         4EcqJq/bJdsMKEkO76EkVBCkJAXLn3oV5+/sJKJrUkvLDJovqNG3RJAddRSJ4E53aeC1
         kI4UM+w/sl0eCiMPMsl4mgoXn61LeThjb87llpzh8//m9o560KsCz6TOYbnQDPoDogx/
         EeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7QEWliHIwcZtKDsvKG182yNZK4PnK9h0Fqq63/i8AEQ=;
        b=Nc1k0bv4dEa381/P0Pjnq2Q7xi6F+su2iPSkPqv/7q3q15v5kpWQeLoZEE3TMGa6pa
         X2ybzX5dY//XPt2CFxMPpo5yiz9zUv2xYhLM6QnuQ4Q6UUUal52HlsZ9YhHPBSjGbL2c
         1Ac7L29CxzZXGDoFWbug609vMPc/u5eJZyiec2w8FWFYPdsQd1xHuIp8H0/kLWWrLJP6
         CscYc69Dj3qpoYfLX0uBGuve5aovOHZoKbaFJMK4xDrwDGCB5AZPoZfJ8xE0+p1B1Q2d
         pm5siU+D8ISyfszm8+a7GRVytza+qL//e73tlBZJf9AKrkiwdMsD0q6Y7LMYOuxrYtsM
         p0DQ==
X-Gm-Message-State: AOUpUlFl4qIRtiPOdUN76lvSQoeGI9nbzbZeEzHVXcepuzYKQ5A2YXE5
        H8+H3DHtpG+KxVsaI/x1NqIZEurl1gb829s8YFtVzgsjgbou25B2IaCW9LaQ8ACVaI4SjPzCD3k
        KtZGllG9x6oOWbdEwt2F+5XzBI721pB1l9bYcGgo41wQRI3iYH3G0QomrmDa6
X-Google-Smtp-Source: AA+uWPxfkX9YPxrzRLTMnkJyRAmJCwUt5EJkKy//X47zLhzA0Q1EdFUt4nz5Q0VVHMpXBG0x20+j8esReRWw
MIME-Version: 1.0
X-Received: by 2002:ac8:7344:: with SMTP id q4-v6mr16382105qtp.30.1534386683643;
 Wed, 15 Aug 2018 19:31:23 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:58 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-6-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 5/7] submodule--helper: factor out allocation of callback cookie
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 639d0bb20a1..1c9a12781fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1688,6 +1688,13 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	return needs_cloning;
 }
 
+static void *update_clone_alloc_cb(int i)
+{
+	int *p = xmalloc(sizeof(*p));
+	*p = i;
+	return p;
+}
+
 static int update_clone_get_next_task(struct child_process *child,
 				      struct strbuf *err,
 				      void *suc_cb,
@@ -1700,9 +1707,7 @@ static int update_clone_get_next_task(struct child_process *child,
 	for (; suc->current < suc->list.nr; suc->current++) {
 		ce = suc->list.entries[suc->current];
 		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
-			int *p = xmalloc(sizeof(*p));
-			*p = suc->current;
-			*idx_task_cb = p;
+			*idx_task_cb = update_clone_alloc_cb(suc->current);
 			suc->current++;
 			return 1;
 		}
@@ -1715,7 +1720,6 @@ static int update_clone_get_next_task(struct child_process *child,
 	 */
 	index = suc->current - suc->list.nr;
 	if (index < suc->failed_clones_nr) {
-		int *p;
 		ce = suc->failed_clones[index];
 		if (!prepare_to_clone_next_submodule(ce, child, suc, err)) {
 			suc->current ++;
@@ -1724,9 +1728,7 @@ static int update_clone_get_next_task(struct child_process *child,
 					   "any more?\n");
 			return 0;
 		}
-		p = xmalloc(sizeof(*p));
-		*p = suc->current;
-		*idx_task_cb = p;
+		*idx_task_cb = update_clone_alloc_cb(suc->current);
 		suc->current ++;
 		return 1;
 	}
-- 
2.18.0.265.g16de1b435c9.dirty


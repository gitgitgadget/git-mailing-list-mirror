Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61AB1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHET0U (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50788 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeHET0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so11469782wmc.0
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qi0DgXlwCkyL/2Vw54moKCBMeu7ldyNzWmc12UmiHNw=;
        b=EW8hIq2A6pq1eYb5hNCDnVnjkIhD5mkCrtNlg5Y7FsEt48I8k8kudEldr8DNF7jgxd
         83Pv8/9W6m4aFvEy+jWtGcuTrmXFEHXz0tnttFCKToY3kY22Vxy4Qc2YFMpeJdNTlERS
         jKDIG+pDT1ijzZ8hnzkCpapeyYhSZc4zVSoco9bxppowyAxD357ME00KRvvXdr4KVNRk
         2Zs7mleCm+uqlSZ1ahgj5WkaKU8Jg95ch6KHd3HudVKRX8tD4larknklLz7/Z8L738/Q
         wzypazS4r3JuQK8dGkcamPTW224YjMYqW+mffYCYwamWwNA1JFAEvQmG6GSH7cwxS0C9
         AiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi0DgXlwCkyL/2Vw54moKCBMeu7ldyNzWmc12UmiHNw=;
        b=oUEZHjYtElS42oCM6cwLmKdZXXTPl0yHlKDhpBwYTGtSBQUm/4qCq8MNjQ+DS1HgZp
         Rd8evxM1758u6iUOpPC0238KrnP/DWHOBH6EliBF+txBi8i1ewF8hFpdjx5v2p053U3U
         d3Ssi0OIJl+ZgZApcoJMzx3G+Mf9YXosDOJWlwdnLbJCrkgi/K9ejzJTFlwvqQFc/20X
         uMwTKPadaYf3SBeeyldveY5fv7hVvReEBjtnswkj/C+UHINwrxd+dYSaNd71ya6PV1JN
         +4BXHJ16P9bR9zKgHdSVlJmzsit+JrsU71FvK3e0g40vO0bf8y7rOVTS1aP6IeuJjduu
         515w==
X-Gm-Message-State: AOUpUlFad4XKBxp854yf4KQpmBTZOTVGycdl5DyDvWiIobHjS2Lh9QoM
        gexiCg53sGodpwn4jgnsppZysKvF
X-Google-Smtp-Source: AAOMgpfzug9K7BEYQdKvLe0jbYnISoda9IO5G72uPUnamqRg1oJE5HCOHIMJaRS4iNpmWPYj3iXfpQ==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr9246423wma.129.1533489661618;
        Sun, 05 Aug 2018 10:21:01 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id w4-v6sm13292667wrl.46.2018.08.05.10.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:21:00 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 11/11] rerere: recalculate conflict ID when unresolved conflict is committed
Date:   Sun,  5 Aug 2018 18:20:37 +0100
Message-Id: <20180805172037.12530-12-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when a user doesn't resolve a conflict, commits the results,
and does an operation which creates another conflict, rerere will use
the ID of the previously unresolved conflict for the new conflict.
This is because the conflict is kept in the MERGE_RR file, which
'rerere' reads every time it is invoked.

After the new conflict is solved, rerere will record the resolution
with the ID of the old conflict.  So in order to replay the conflict,
both merges would have to be re-done, instead of just the last one, in
order for rerere to be able to automatically resolve the conflict.

Instead of that, assign a new conflict ID if there are still conflicts
in a file and the file had conflicts at a previous step.  This ID
matches the conflict we actually resolved at the corresponding step.

Note that there are no backwards compatibility worries here, as rerere
would have failed to even normalize the conflict before this patch
series.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c          | 7 +++----
 t/t4200-rerere.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index f78bef80b1..dd81d09e19 100644
--- a/rerere.c
+++ b/rerere.c
@@ -815,7 +815,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		struct rerere_id *id;
 		unsigned char sha1[20];
 		const char *path = conflict.items[i].string;
-		int ret, has_string;
+		int ret;
 
 		/*
 		 * Ask handle_file() to scan and assign a
@@ -823,12 +823,11 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * yet.
 		 */
 		ret = handle_file(path, sha1, NULL);
-		has_string = string_list_has_string(rr, path);
-		if (ret < 0 && has_string) {
+		if (ret != 0 && string_list_has_string(rr, path)) {
 			remove_variant(string_list_lookup(rr, path)->util);
 			string_list_remove(rr, path, 1);
 		}
-		if (ret < 1 || has_string)
+		if (ret < 1)
 			continue;
 
 		id = new_rerere_id(sha1);
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index afaf085e42..819f6dd672 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -635,6 +635,13 @@ test_expect_success 'rerere with inner conflict markers' '
 	git commit -q -m "will solve conflicts later" &&
 	test_must_fail git merge A &&
 	cat test >actual &&
+	test_cmp expect actual &&
+
+	git add test &&
+	git commit -m "rerere solved conflict" &&
+	git reset --hard HEAD~ &&
+	test_must_fail git merge A &&
+	cat test >actual &&
 	test_cmp expect actual
 '
 
-- 
2.18.0.720.gf7a957e2e7


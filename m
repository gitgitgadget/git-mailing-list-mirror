Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D275B1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeFEUsP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43703 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeFEUsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so3828790wrm.10
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vWP95b6mF7gZBWP+sXykEHJ1WaXSvCcmJfW6/ZJn2+g=;
        b=lBuZx4ckdbcw582zbsLPYaywRQ+9nVhxrTjA/ZkJzL41FgAeV5cVv37JqhMbxp+OyN
         xKq4hGy58O4N8epZqJ4UtmtQ0M7JmaERg8UDb9AiX43/0HVxQWcHT8k/U4t733HKbbMK
         uNYVOiEyw+p8GXBR5sXvNeUDZRM3RqkoZTsebdQnEgfuHqI933Bu/woKTWMdfpnAQA9P
         UcLaVvHYmcmNbEIZlMUKb3W3N5HsDaS3q8xP4qpriHdon/gbilr40m3RGnYIJ1j4RRnD
         iplqUdj3cfGtXiN81N/g1eZYu5n8kboVJ1V7hrNhnfwxHPNE2a31TENTtKKrceVv1dX3
         pIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vWP95b6mF7gZBWP+sXykEHJ1WaXSvCcmJfW6/ZJn2+g=;
        b=BJDHBNgir07T6a03+ObHhfH1TRtKYjqlIqmQ4u9O+y91+eX55qmjVbHyhnDpJUkNdW
         I0opNHhRXH+QCtQsa0Ozm1l1FwSf2CNivP+ekYkx38Yh/fnleMrFPTlIC50PjRgEt4Ip
         ZJkmMLwcM863AvkmMmLFtRt+fQOZOmpek/+ZESn5twbK26bXrSQ8WEswUBHH1onehA5I
         AEXCLqCGwgNjgQapj0k6gNyqxr4BGDY51cws75kujC5Co82E6poRE8oI8DpaijAr+0g8
         czGWIC/K/q7V34rFQ/4sTkjErne4sfjY6QIM7WUfsjeU8Fe9X4O3uGdrCD9sEBvgxJVv
         X4FQ==
X-Gm-Message-State: APt69E2pEa9zifA3s2aQbEI5S6D8+1g2gdVaWLpc2clWz7A7Yhg+fMCv
        m+GjCOfF4kF9Czltsm+lYbPnFC+t
X-Google-Smtp-Source: ADUXVKIwn31Eckj7imutogSQxuWdYG2H7e/qYesaoPF9D3wkAFmXSBP79uum3NIOITOTkAg9viXHIA==
X-Received: by 2002:adf:aef3:: with SMTP id y106-v6mr129276wrc.53.1528231691518;
        Tue, 05 Jun 2018 13:48:11 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 84-v6sm2598944wme.16.2018.06.05.13.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 10/10] rerere: recalculate conflict ID when unresolved conflict is committed
Date:   Tue,  5 Jun 2018 22:52:19 +0100
Message-Id: <20180605215219.28783-11-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
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
index f611db7873..644f185180 100644
--- a/rerere.c
+++ b/rerere.c
@@ -818,7 +818,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		struct rerere_id *id;
 		unsigned char sha1[20];
 		const char *path = conflict.items[i].string;
-		int ret, has_string;
+		int ret;
 
 		/*
 		 * Ask handle_file() to scan and assign a
@@ -826,12 +826,11 @@ static int do_plain_rerere(struct string_list *rr, int fd)
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
index f433848ccb..9578215ff2 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -636,6 +636,13 @@ test_expect_success 'rerere with inner conflict markers' '
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
2.17.0.410.g65aef3a6c4


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 008171F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeGNWFe (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46579 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbeGNWFd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so28261712wra.13
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVJyniGjeLRVckzmrUYUXLyMY/9E5XFzJO5+wD8fhPc=;
        b=oEsoR2nwDeIpouvQ61+KV9Y3aF745qdqi+GaAPbRHKMngRltuh1TDeoDMQJxPapTUp
         3DcrKB7UOyjM4q4S2FTKkcefAIsncTrevucSfRtLkGOXbxl4CH0+6IekgcgjeHxTTUOw
         VA6E6zATORY9hvkbx0nWEbq6Be+ZuwW0dSMRyzY1hfGHBppJ4UrBI6JkI7bThDNRAuKd
         N4yXLY45pyhr35hX17oI2KUKy7nIDq2z4QNjLhYe296NTrXAlKRQjHooNnITBryHZKmt
         JwJZDDkAmhdzZeuA5Ao7WslxJLNr0kqpcsREwPbap1L5zQPD8YANTtltI9y7fRkJV5xF
         MuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVJyniGjeLRVckzmrUYUXLyMY/9E5XFzJO5+wD8fhPc=;
        b=B8RNG+XToMJ2lJHKazGTUkeSZ41UF8NERjlqXKDG0vjQZio5SVmHc3rTLuIKh+47Eu
         W14bNCRDu81ebmj9Q+Mg3Hd6FsDVmYAQPyF5pMm0EYNUpjL2Vlnm4buv5XjZAguvUeQr
         pjPNoPjVojv9i7l/zCgF4hvHISkVApyzLiZ6prFHsqxFi6VMSpoMlYDP5cEMgHCHQiE3
         T3BMnB4ZKWzUZMExEOLMfpVrfHIpbr1rCuvoWXuH0y/A8L2ykgW9i+9PaliLWIph6/W0
         kadeeosEkvZZKIQjmGgWBAfp0bBEzEVMvhZcNJIiopPDFv3Txhiv8BBTBtvscRVEMBgR
         gCNw==
X-Gm-Message-State: AOUpUlGLcY2ppCiZywu6mCUJfEuRPNC4ajAFdPl72xrwmwvj4QdUi3ee
        vbId5/smYT1FxFfsc8/066UlHKmG
X-Google-Smtp-Source: AAOMgpe93WPU82e/ga/kzASZkaMXQDP6qrE5mooFBhWBUxsAPQCzS9i4vA7+Au5mY+XFXlAeZbEoww==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr7713145wro.263.1531604706162;
        Sat, 14 Jul 2018 14:45:06 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id r17-v6sm32063491wrt.44.2018.07.14.14.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:45:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 11/11] rerere: recalculate conflict ID when unresolved conflict is committed
Date:   Sat, 14 Jul 2018 22:44:43 +0100
Message-Id: <20180714214443.7184-12-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
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
index d63fe2b33b..bfb37ed4fc 100755
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927C91F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeFEUsT (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34812 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeFEUsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id q4-v6so20348519wmq.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYN3hdd60IhiQB4up5kTZed2ImGTxLsJt5gE6oH8Pks=;
        b=l6MJdxv6Kz2Yb4SWk1bDKcmoj5Wbkd6xAaef9MdhiH/d7MQAyb6VJekmgwrgjmzd0I
         L0SK6K9vj2vXuzyDUDqjVLZNFvo22lEFGJV4pNKsrWCRJ7Ed7beh8Q0Ax3InHwBcUIyF
         Ct1chLGn1BPymKOV8Q3U2TzQtOyr9UZWz6kWqTWvh6IWMOuDXUySChZAC+dUgdXLglDe
         GOTppR30HYzUGwhm2pl3JXll78SPOnv8UnJaeD999qvNH64aWTCgduN9i1w2Vg9Ngvmv
         bKa2qikcrlNtA/ezY2vT9Hjw4voFSxJGAJK2DeVVaQU2hxBh5T1P1hs01Yn3phLm5oJl
         mDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYN3hdd60IhiQB4up5kTZed2ImGTxLsJt5gE6oH8Pks=;
        b=hyHN1pXygS0sB++WMME/ALwHUozxw2oq0CkNDLz5Spb2cakxLlXookAIiVL7dDy7WC
         i9NgxWtSqJfCjfhjXr3Akx6joKvA0xtel5z3d5UOrYu7XrdgUZrlRd71MC/JV6QV+ivU
         /I3GHryOFM4yaGTJsMOADQJVxGH37OOs7nE63ZekvonWLRl+fwRBly13xZEdtKTtARH4
         aAtlP8gdeYvJII7dQpfSjHtSMriaEr98nHM49409J1bdvigC3QG4vfvAkVXjy/ZiYQGa
         T04wSnk9mGvwqkonrm065mDspmvLVfSazf8HBmekrUCc4e8Q1T6G+/SbCA9rx1ieaUDB
         t2Yg==
X-Gm-Message-State: APt69E3jgO7sLWf+9O5WCkBkR6CAac3nsQ39Q15HnOxt9VwXwSp8DpX6
        MQP4Bvn7sOX0jYUejvxL3YQnFQ+s
X-Google-Smtp-Source: ADUXVKKNmBpUfyesfgd6jNKLxEoPe4UgJTPLP4spND7yc7pydO1MeRDNrb1wEJa036XTMSdvUr6aOQ==
X-Received: by 2002:a1c:3607:: with SMTP id d7-v6mr463479wma.39.1528231684709;
        Tue, 05 Jun 2018 13:48:04 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g205-v6sm3403409wmg.43.2018.06.05.13.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 06/10] rerere: fix crash when conflict goes unresolved
Date:   Tue,  5 Jun 2018 22:52:15 +0100
Message-Id: <20180605215219.28783-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when a user doesn't resolve a conflict in a file, but
commits the file with the conflict markers, and later the file ends up
in a state in which rerere can't handle it, subsequent rerere
operations that are interested in that path, such as 'rerere clear' or
'rerere forget <path>' will fail, or even worse in the case of 'rerere
clear' segfault.

Such states include nested conflicts, or an extra conflict marker that
doesn't have any match.

This is because the first 'git rerere' when there was only one
conflict in the file leaves an entry in the MERGE_RR file behind.  The
next 'git rerere' will then pick the rerere ID for that file up, and
not assign a new ID as it can't successfully calculate one.  It will
however still try to do the rerere operation, because of the existing
ID.  As the handle_file function fails, it will remove the 'preimage'
for the ID in the process, while leaving the ID in the MERGE_RR file.

Now when 'rerere clear' for example is run, it will segfault in
'has_rerere_resolution', because status is NULL.

To fix this, remove the rerere ID from the MERGE_RR file in the case
when we can't handle it, and remove the corresponding variant from
.git/rr-cache/.  Removing it unconditionally is fine here, because if
the user would have resolved the conflict and ran rerere, the entry
would no longer be in the MERGE_RR file, so we wouldn't have this
problem in the first place, while if the conflict was not resolved,
the only thing that's left in the folder is the 'preimage', which by
itself will be regenerated by git if necessary, so the user won't
loose any work.

Note that other variants that have the same conflict ID will not be
touched.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c          | 12 +++++++-----
 t/t4200-rerere.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index ef23abe4dd..220020187b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -824,10 +824,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		struct rerere_id *id;
 		unsigned char sha1[20];
 		const char *path = conflict.items[i].string;
-		int ret;
-
-		if (string_list_has_string(rr, path))
-			continue;
+		int ret, has_string;
 
 		/*
 		 * Ask handle_file() to scan and assign a
@@ -835,7 +832,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * yet.
 		 */
 		ret = handle_file(path, sha1, NULL);
-		if (ret < 1)
+		has_string = string_list_has_string(rr, path);
+		if (ret < 0 && has_string) {
+			remove_variant(string_list_lookup(rr, path)->util);
+			string_list_remove(rr, path, 1);
+		}
+		if (ret < 1 || has_string)
 			continue;
 
 		id = new_rerere_id(sha1);
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index eaf18c81cb..5ce411b70d 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -580,4 +580,26 @@ test_expect_success 'multiple identical conflicts' '
 	count_pre_post 0 0
 '
 
+test_expect_success 'rerere with unexpected conflict markers does not crash' '
+	git reset --hard &&
+
+	git checkout -b branch-1 master &&
+	echo "bar" >test &&
+	git add test &&
+	git commit -q -m two &&
+
+	git reset --hard &&
+	git checkout -b branch-2 master &&
+	echo "foo" >test &&
+	git add test &&
+	git commit -q -a -m one &&
+
+	test_must_fail git merge branch-1 &&
+	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
+	mv test.tmp test &&
+	git rerere &&
+
+	git rerere clear
+'
+
 test_done
-- 
2.17.0.410.g65aef3a6c4


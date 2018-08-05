Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361DE1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeHET0M (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55549 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeHET0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so11431017wmc.5
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfudNmjYu9QKSbTsPBg2Voe+0TGoRtWGuHexP9o/2DI=;
        b=Vb+auXoffr2NMpn33xy8L0FUE0Dn+h901NsjXO1UKpWpNZmxZvbTZr82X1x4Enpaog
         vAyBao5/QbArZM6RkyRCG2JUqTwNYKMX78CsdXQKb27Jc/jPv1ChrfNU6x8r6QG0qvxw
         GPiXw/oRJ8x0FmIaT6i+Yvsk+b8O06TG9fgiysvx8lbp+REWINYFf/tm4IDsgbqfEUYr
         nbTMZ6MINVbggOlEoV/tgHfQC250bc3Mksdc7/X3698HvyD/DUAiNTyJrdPM9VlgXQ6a
         443rEYzadxJjLOTcd6CAFOysVHmxD/VMjiRQbltQ0+HQXqbPD22ez4TLKqkIILEzodBy
         dJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfudNmjYu9QKSbTsPBg2Voe+0TGoRtWGuHexP9o/2DI=;
        b=IgBoN6sF7uE0Cdx6DVx8Fp2stTTN35mQ46nlT1pMIBfTnZD7KjXzzoS+6yUF1P9KxY
         DcR4asKgW4FQbPWyVupU3WY7p1a6gHdofXwDwtbAw4iPgdwdG+ATSkX5ewngg8RxmbeU
         7OEvjifQ6A0ojPcC8y6SgMm0j+XcGAiBEIEmLRUTPBtNaHSGmzWtmSCGJoMBv/cc+Jir
         Nfw5HZVla5BT2DoKJrpUhSlIBw/UZ6Zb1/wtvoFyQhz7YHWhyUc8ca/Cw4ZtzR6XtLtS
         QC6EwTSVXNhI3cTvYNH+C36W8eaGEjThxeRhG5uJaxuq/1Z55pwNwimn/aoep487KW22
         ATzQ==
X-Gm-Message-State: AOUpUlEP1qLLwOrdKR9hvBjtrIrmeNBeeVA7llz11cDLu9YmpOOAmClL
        ThwmSBv4DBhX6ibpWj/AfGFKqWng
X-Google-Smtp-Source: AAOMgpd6/wU0+ffhbzt7UvQnRONkfx72AUqfUiEJKKS9xkoQVQ8zvoEjjuoM/GQjVf9O3L5YQy7Htg==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr9516663wmd.77.1533489654302;
        Sun, 05 Aug 2018 10:20:54 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id u7-v6sm7630800wmd.46.2018.08.05.10.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:53 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 06/11] rerere: fix crash with files rerere can't handle
Date:   Sun,  5 Aug 2018 18:20:32 +0100
Message-Id: <20180805172037.12530-7-t.gummerer@gmail.com>
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

Currently when a user does a conflict resolution and ends it (in any
way that calls 'git rerere' again) with a file 'rerere' can't handle,
subsequent rerere operations that are interested in that path, such as
'rerere clear' or 'rerere forget <path>' will fail, or even worse in
the case of 'rerere clear' segfault.

Such states include nested conflicts, or a conflict marker that
doesn't have any match.

This is because 'git rerere' calculates a conflict file and writes it
to the MERGE_RR file.  When the user then changes the file in any way
rerere can't handle, and then calls 'git rerere' on it again to record
the conflict resolution, the handle_file function fails, and removes
the 'preimage' file in the rr-cache in the process, while leaving the
ID in the MERGE_RR file.

Now when 'rerere clear' is run, it reads the ID from the MERGE_RR
file, however the 'fit_variant' function for the ID is never called as
the 'preimage' file does not exist anymore.  This means
'collection->status' in 'has_rerere_resolution' is NULL, and the
command will crash.

To fix this, remove the rerere ID from the MERGE_RR file in the case
when we can't handle it, just after the 'preimage' file was removed
and remove the corresponding variant from .git/rr-cache/.  Removing it
unconditionally is fine here, because if the user would have resolved
the conflict and ran rerere, the entry would no longer be in the
MERGE_RR file, so we wouldn't have this problem in the first place,
while if the conflict was not resolved.

Currently there is nothing left in this folder, as the 'preimage'
was already deleted by the 'handle_file' function, so 'remove_variant'
is a no-op.  Still call the function, to make sure we clean everything
up, in case we add some other files corresponding to a variant in the
future.

Note that other variants that have the same conflict ID will not be
touched.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 rerere.c          | 12 +++++++-----
 t/t4200-rerere.sh | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index da1ab54027..895ad80c0c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -823,10 +823,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
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
@@ -834,7 +831,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
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
index 8417e5a4b1..23f9c0ca45 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -580,4 +580,25 @@ test_expect_success 'multiple identical conflicts' '
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
+	echo "<<<<<<< a" >test &&
+	git rerere &&
+
+	git rerere clear
+'
+
 test_done
-- 
2.18.0.720.gf7a957e2e7


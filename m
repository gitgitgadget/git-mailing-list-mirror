Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5360AC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2564220716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYGjZFEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgA1Ol3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46368 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgA1OlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so16261868wrl.13
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0SyfK0NNwZIpBCHt23KPP5OREVsx0Sn8T1pAy8LCx8=;
        b=OYGjZFEdX6FvNaR4P6MDeBJ+1Irr+0O78pnddzDve5a6Gw5TpHi2LKPLSZxoj2GpAv
         GDI03ZtEue3tFLEzbahpBIvOaIajRAemncevhqzqRQ//j/5934KWWItf8nzEYGCoj6Hr
         Mkyx+VK1icOOg5UmWN25MNnpWi8I6bfTG5JxIf3wRl0giUZISO1m7G5cNfNZTtXtBjoc
         5vyeB+rxm2YebpFldYCcOSfWxuqCc58KkQ/RN/sKY9rmzixdaUQd6fMkZUe5CPOxet1M
         rK7tx3gts3vtDzH4kOdCIOcIHBMAHd0ROZ/tz1gsQLpOOxPIHwpHlfUqIWsn5AVhwm4R
         Djvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0SyfK0NNwZIpBCHt23KPP5OREVsx0Sn8T1pAy8LCx8=;
        b=CZfUSvOtTX2vRDZvMxp0ebWyVWTkeLHLcKnCVFFyTnDXeoawdjkVKrnUht07xFmCE6
         gEuC+hPbYVadV7Zu89tADALlnkLKmiCxnqs2IycYeZ+B/LADJqfmRtPcd8js6v8H8t7Q
         oij0rSucboHHhu4PT+IakThwVae1V9mmkBgbLXK3Jl4LYnvYWaDFd2DX5ytMSI+SlGtB
         SbQ9qeADBPFkrlUm67MnV4nvb+Tgv0BmKDhY3syIuxisrNmHmr2lTnUqxwN4nuzVev5h
         fGoLBSNd8cy44vcSwrUIe84hWgdrik633uZJbJF4K0Rfj40B6Bxsg8fAMeHKGKz3ztND
         ky5g==
X-Gm-Message-State: APjAAAXUJZ8HMj3mYOj5PmK/4KS/DRXBFAjmeRHRJ5CBINTj/DkmC48P
        juqxEjlwlsn4u76F/bCo+aMzhclJ
X-Google-Smtp-Source: APXvYqwy2I7H6m1b80M7JCVW6osZjxNpAoWoEpFlP1tzvC4Sy9S0gxNJ+aEJRRwlTMugN44Hn/GylQ==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr30704160wrw.271.1580222482390;
        Tue, 28 Jan 2020 06:41:22 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:21 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 08/11] bisect: libify `check_merge_bases` and its dependents
Date:   Tue, 28 Jan 2020 15:40:23 +0100
Message-Id: <20200128144026.53128-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

In `check_merge_bases()` there is an early success special case,
so we have introduced special error code `-11` which indicates early
success. This `-11` is converted back to `0` in `check_good_are_ancestors_of_bad()`.

Handle the return value in dependent function `check_good_are_ancestors_of_bad()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index dee8318d9b..2a6566d066 100644
--- a/bisect.c
+++ b/bisect.c
@@ -806,13 +806,16 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
  * - If one is "bad" (or "new"), it means the user assumed something wrong
- * and we must exit with a non 0 error code.
+ * and we must return error with a non 0 error code.
  * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
+ * - If a merge base must be tested, on success return -11 a special condition
+ * for early success, this will be converted back to 0 in check_good_are_ancestors_of_bad().
  */
-static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static int check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
+	int res = 0;
 	struct commit_list *result;
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
@@ -827,11 +830,16 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			res = bisect_checkout(mb, no_checkout);
+			if (!res)
+				/* indicate early success */
+				res = -11;
+			break;
 		}
 	}
 
 	free_commit_list(result);
+	return res;
 }
 
 static int check_ancestors(struct repository *r, int rev_nr,
@@ -865,7 +873,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
-	int fd, rev_nr;
+	int fd, rev_nr, res = 0;
 	struct commit **rev;
 
 	if (!current_bad_oid)
@@ -880,10 +888,13 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
+
 	rev = get_bad_and_good_commits(r, &rev_nr);
 	if (check_ancestors(r, rev_nr, rev, prefix))
-		check_merge_bases(rev_nr, rev, no_checkout);
+		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
+	if (res)
+		exit(res == -11 ? 0 : -res);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-- 
2.21.1 (Apple Git-122.3)


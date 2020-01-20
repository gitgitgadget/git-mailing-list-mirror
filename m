Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A59C33CB8
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C72C217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbOuBVwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgATOik (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33209 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgATOik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so29871897wrq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTB/m8VkZYS/JJf+6MC8iCuMTVLqOlueF2pee02iWyg=;
        b=hbOuBVwCzZJVyQ6aSnKXgXjgke6XbGbkQB9gHHDao491hwc5L2w99blqipVZbb9NtB
         8luSA+oOVjZBcfd5ARY20P/TA0HjMnKfgC3+nQCe1uJamenrTh4q49r6Qmu/+ss5d0D/
         Py+bvfBC7YriWvmPzkvGsvEQrEMrtHvzpj+XinLWjFM+AHRURfl274kDiNKefyLKomZi
         wRKIFnfwwKUEJI0x+sSHIgfW7EUY4zCIv8mkxr5iBfhVY7OCogNOxCpeORTKQj42hhkg
         ChUn6BBZiVLATwWCrd8E9R3LQ+DNxOxbBQlW50YdVI0zwtOLsC7oPYY5AnigWnX3xdIL
         FAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTB/m8VkZYS/JJf+6MC8iCuMTVLqOlueF2pee02iWyg=;
        b=prTOQpy5pllj19N+I4HeRodwJHynGO6zqHvzAvFW1s7Mb+i89R5llYI5RjQYgCv/KN
         uy956PzHtSUxJayDLVtg86auv0mgCuJtkcLbA6aK6bM0SCde5GFWMQSxLM7gmHRkN2Kt
         f2X8gwQW1JxgV4Iz/U24mxrjf1HReeCgOiR2dUv9sRSB1eeJ+yM2JNqnS9dClSumgy0x
         tvkhXSq8mmIYAYmDAbLg5xlnLgDxb/yX0kVOD9JHSK+jiOBwSvHhnalORJpt4l/jHOMA
         w1SRxfTWegSaIjr5/wpqxvkYM1F2IdLI9/lB2RVdql1E862+IDetHyvlvbeVyAIk6w0m
         lmhw==
X-Gm-Message-State: APjAAAWLDVx9cZKiCUewDEeHcaweFu/gBYj7ggwSs2Gx4FyAmYaQPt+S
        Ah+Ez0pbmLrGniQtyBhB14qYjdJY9Ks=
X-Google-Smtp-Source: APXvYqwfoZKYuMBs1DTPVcpFlvYt3nsc1y9qGmes5+TFLEghlrwlN9q0a2QinGFEZ3qBznrroJYN+Q==
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr19076767wrr.104.1579531117915;
        Mon, 20 Jan 2020 06:38:37 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:37 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 08/29] bisect: libify `check_merge_bases` and its dependents
Date:   Mon, 20 Jan 2020 15:37:39 +0100
Message-Id: <20200120143800.900-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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

Turn `exit()` to `return` calls in `check_merge_bases()`.

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
index 385afaf875..367258b0dd 100644
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
+	if(res)
+		exit(res == -11 ? 0 : -res);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-- 
2.21.1 (Apple Git-122.3)


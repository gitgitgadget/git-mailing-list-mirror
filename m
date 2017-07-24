Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370FD203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbdGXVQF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:16:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36540 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbdGXVQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:16:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id 184so14066946wmo.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53Ih9ZPtqOm2ySTJogYqYtwtK/NREmdDv7xJ10PBdSw=;
        b=dqsBYHCirPY/mqft1NqjGlEawa1SOdPFLtR9cRt45kcuAkrrClu4b7JqH4cgmeZArB
         DtF/uQ7tbJKc7BSGwe5D2K3eUOHY8FK7MbGMRIzorkEW9vkRFe408Hb+CaOcpicc75ir
         uw9hJkSHWejfrYg5wQlXp1fnCe4jdj/H1eOdMUdUox+RDVc6r9gweRscS2/mYRqZdh8r
         b8ByExr6RJewBf1XQRNhP4qS1SoT1PNOClyLu8wmu1sFQL2SIJKrgAcCpWK2oafMQVuC
         3UBjy4ZfmHKRaD+vVzbexpmcS7X6LGKXsYwmzRNPGBSKs13U+at0mtkxpXg7ypEsfmc1
         h/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=53Ih9ZPtqOm2ySTJogYqYtwtK/NREmdDv7xJ10PBdSw=;
        b=BSE5HdsH+OQ8Twp9EAQ2Leoby53nTR42jGEQFyGwILezFySNEp37SE0oLVmChtrbwh
         B4qYXdDlmw28l2RbTPbuh2U9IQu1AaCXk0+HqcY6V/bICKhHl7BVsF8BR1IAn9iU9GLB
         y7kafRGMqHaJrprTnt48ywe1MM5ICl73uWqcnxJqcFdTMBh+1mFKRcl4L3MfpbJWpV4U
         gA5WCx/q4zKBVn2NujRpYug1yucro9ij5eT5gscLqX9pVh5YovZcAsvxiKYYI8lgH/k3
         L0xGuiPhUojQJip0JK9oJKaiD7GKpAkZquK9oZGqh48NHcWUhaHVse0EyX0Al5YW7bGE
         u38w==
X-Gm-Message-State: AIVw1129N9UD4W6wC+U0VzyUmiUAZSa0iiz8Iei6yJ8cCSwZ/RNEQGja
        Z+a2S5IlEPSZ4w==
X-Received: by 10.28.199.67 with SMTP id x64mr5570702wmf.94.1500930963066;
        Mon, 24 Jul 2017 14:16:03 -0700 (PDT)
Received: from localhost.localdomain (x4db2767d.dyn.telefonica.de. [77.178.118.125])
        by smtp.gmail.com with ESMTPSA id j31sm13829876wre.67.2017.07.24.14.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 14:16:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Smith <whydoubt@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2] blame: fix memory corruption scrambling revision name in error message
Date:   Mon, 24 Jul 2017 23:15:50 +0200
Message-Id: <20170724211550.17224-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.88.ge338f4246
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When attempting to blame a non-existing path, git should show an error
message like this:

  $ git blame e83c51633 -- nonexisting-file
  fatal: no such path nonexisting-file in e83c51633

Since the recent commit 835c49f7d (blame: rework methods that
determine 'final' commit, 2017-05-24) the revision name is either
missing or some scrambled characters are shown instead.  The reason is
that the revision name must be duplicated, because it is invalidated
when the pending objects array is cleared in the meantime, but this
commit dropped the duplication.

Restore the duplication of the revision name in the affected functions
(find_single_final() and find_single_initial()).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Use xstrdup_or_null() in the first hunk.

 blame.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index 91e26e93e..f575e9cbf 100644
--- a/blame.c
+++ b/blame.c
@@ -1663,7 +1663,7 @@ static struct commit *find_single_final(struct rev_info *revs,
 		name = revs->pending.objects[i].name;
 	}
 	if (name_p)
-		*name_p = name;
+		*name_p = xstrdup_or_null(name);
 	return found;
 }
 
@@ -1735,7 +1735,7 @@ static struct commit *find_single_initial(struct rev_info *revs,
 		die("No commit to dig up from?");
 
 	if (name_p)
-		*name_p = name;
+		*name_p = xstrdup(name);
 	return found;
 }
 
@@ -1843,6 +1843,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 
 	if (orig)
 		*orig = o;
+
+	free((char *)final_commit_name);
 }
 
 
-- 
2.14.0.rc0.88.ge338f4246


Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AEFC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D3921D7E
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMQdtSZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgIMOzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIMOyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452DC06178C
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s65so8433893pgb.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV6Sb7OJ4njbdFgNDyK6TG1dhsyvC+/pWkmKFIL2Wt0=;
        b=FMQdtSZPP4Vdsy1KqM+Mua1R+ezzV7YfzcV6awYwaF6C2HgL2E8YLQZtWERWUiAvxN
         e256EJqF9zYBYE6Gy3rqcLQvvzOIk0LBDZHuMFMJRrEBYm6T8VXkr9KF+pg4YRNzsfaY
         sbzuJ7eVOVlm5SleDh4BeJvCw721F4uec6uO4HIyX/oOzSDYJQaLlM3bocbMv/h/xOVN
         /KR/DgJyfmgKmbKmmMuuDTU3Bn85WkWBsjDGzuBZ8wXhu5apSWwe3IOmrwZZIozjg6b3
         kmKcCx2u6S4PEeiohIg2jIeDwlmzg3qrVQbLQngzY7MnIBAFYt8wpqRP67qHOMM5UhZf
         r4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV6Sb7OJ4njbdFgNDyK6TG1dhsyvC+/pWkmKFIL2Wt0=;
        b=s8Jg6nqm+u6DzblROpPBcVa2vE40pJHVNFCkgxenoa00Hs5UVYj9NroAzwi+x4w1Wp
         Un5C2yk9TgeCU5kC0HHdoIHdySd6346MGhlLeFaZuwPPFWZPspC8OxzuaTj8EHmZA+sG
         D3lN//Tzgr8pYymhAegn2vH7eVNWhfrrjmLp1E/fGY56nubIYC+3y1MqA2B6byOPgftp
         IataUH/vWPDyDFTZnIL3TkbEc2PmnedVw8HrQ3eXRwSx5LZG/NHmNhRTE9e8koqqUjqI
         2kYSJbpSILatpzwrmkqPbtKa69KhfiKEG4TyD7eKXB81PUAqFY5Wga/OqZZYvjeNlXVq
         f9Eg==
X-Gm-Message-State: AOAM531S+1z2Z8Q/c8QmlZblJ81JxLbK0/6yUHdnj4VECTxXb35tKAl4
        qiVtvWZzd6f7yta7ZeT3bbZFOuxuF2Lr6ifqfNI=
X-Google-Smtp-Source: ABdhPJyhdY4yLuKSoev7XjCrRXvJ/bsS+Z6CNV1iNJ6R1vesBO03Wl0nD1dRl1rhQcY2sCD1kvIsSg==
X-Received: by 2002:a63:5363:: with SMTP id t35mr7867290pgl.443.1600008882514;
        Sun, 13 Sep 2020 07:54:42 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:41 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 6/7] doc: add reference for "--[no-]force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:12 +0530
Message-Id: <20200913145413.18351-7-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation for using the new option; append notes for
"--force-with-lease" about using the new option to prevent
unintended remote overwrites when being used in setups where a
tool implicitly updates remote-tracking refs in the background.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/advice.txt |  9 ++++++---
 Documentation/git-push.txt      | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index bdd37c3eaa..acbd0c09aa 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -10,9 +10,8 @@ advice.*::
 		that the check is disabled.
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent',
-		'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', and 'pushNeedsForce'
+		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
 		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
@@ -41,6 +40,10 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	pushRefNeedsUpdate::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when its remote-tracking ref has updates that we
+		do not have locally.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..b40fe7e7cf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -320,6 +320,12 @@ seen and are willing to overwrite, then rewrite history, and finally
 force push changes to `master` if the remote version is still at
 `base`, regardless of what your local `remotes/origin/master` has been
 updated to in the background.
++
+Alternatively, specifying `--force-if-includes` an an ancillary option along
+with `--force-with-lease[=<refname>[:expect]]` (when "<refname>" or "<expect>"
+values are unspecified) at the time of `push` will verify if updates from the
+remote-tracking refs that may have been implicitly updated in the background
+are integrated locally before allowing a forced update.
 
 -f::
 --force::
@@ -341,6 +347,19 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
+--[no-]force-if-includes::
+	Force an update only if the tip of the remote-tracking ref
+	has been integrated locally.
++
+This option verifies if the tip of the remote-tracking ref on which
+a local branch has based on (for a rewrite), is reachable from at
+least one of the `reflog` entries of the local branch about to be
+updated by force on the remote. The check ensures that any updates
+from the remote have been incorporated locally by rejecting a push
+if that is not the case.
++
+Specifying `--no-force-if-includes` disables this behavior.
+
 --repo=<repository>::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
-- 
2.28.0


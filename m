Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB560C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B108B2067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 06:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klZUnWRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFHGZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFHGZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 02:25:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DCC08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 23:25:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c8so17341794iob.6
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 23:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dduL+xqp+uc1hgwXRLnQEqd86DPk5wZs0F227Ak3BC4=;
        b=klZUnWRDxVeZItoeOaffNW2siILJfY3Ug8uw+Wzd7TYN2VwMI6QGgUAZ/WUcM9FJC8
         sxZCASCft6BfMhcSSt9IDLYfnQbsKLOb8ppLTg7agnuep7mvlp9xF1YYCwOoP/HMd4lI
         3Ju7KS9fD4gEan0inuCjYIYZQQKMsf1OZ6tV1hA0aacJcR81dXtgp2K0fdBOT1QoPlsZ
         Vz9Mj9wqhuk8JAeRXcVGFB1Bbn2B6gZKKlO++gFr/tPyoYPasnRrQkDVCjLXDTlYB+0o
         Td+nC3+WO4sZxidm0w1oOLaAuhIeGjwqCT1PTpg33Ikn8Z/AjCbA38AwnSfhoxCZjzBu
         1+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dduL+xqp+uc1hgwXRLnQEqd86DPk5wZs0F227Ak3BC4=;
        b=nLveLT0GNmZmy6pd2BHIwMNXhsZARe3ObBTVb8CHBXd/HuNwXgo0eurBNmDxRuF0PW
         tHFHUQzpP51ER4BYjDPsAEoOE6V1wYsjNdH1oKYGVJ9s962LiaD0cxjudLs62CylL24X
         p+6kmAHXMJYHRU9yZTHnNT5oUMICsj4YyXi2h4uMmieTmvE082wnmkFkFcQ3vvzQISrI
         dhyTYqJlJjtuPwuAnScKMCyc+KTcChcbSz1Q2RWzfSkcPtOx+I8ywZK/kziD1lTpZgfl
         78NO0oY9/nrxNRrdRtbMpjNLMiazJAFXR1zf7sZ/Gu5bgLnqDfbxpwgp26r78omlELHQ
         9Hpw==
X-Gm-Message-State: AOAM531vPjRyLtTIvsEhcveOq42NAcOy8FQ/XehRf4mdnMDy6cZoIOvN
        jW9h82JISbahMVUGs4IzWJr8di5Okkw=
X-Google-Smtp-Source: ABdhPJwa/d0K4zy41GegIL5CKsBGHPK7waUqEZ6dfu4Ofta+w9qLbYdcrYa7CN2+DbUdU9/6qR0lKQ==
X-Received: by 2002:a05:6638:10b:: with SMTP id x11mr19835995jao.109.1591597502608;
        Sun, 07 Jun 2020 23:25:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id s73sm7477948ilk.41.2020.06.07.23.25.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 23:25:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/8] worktree: make high-level pruning re-usable
Date:   Mon,  8 Jun 2020 02:23:52 -0400
Message-Id: <20200608062356.40264-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da
In-Reply-To: <20200608062356.40264-1-sunshine@sunshineco.com>
References: <20200608062356.40264-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The low-level logic for removing a worktree is well encapsulated in
delete_git_dir(). However, high-level details related to pruning a
worktree -- such as dealing with verbosity and dry-run mode -- are not
encapsulated. Factor out this high-level logic into its own function so
it can be re-used as new worktree corruption detectors are added.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 27681a1396..d0c046e885 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -133,6 +133,14 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
 	return 0;
 }
 
+static void prune_worktree(const char *id, const char *reason)
+{
+	if (show_only || verbose)
+		printf_ln(_("Removing %s/%s: %s"), "worktrees", id, reason);
+	if (!show_only)
+		delete_git_dir(id);
+}
+
 static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
@@ -146,12 +154,7 @@ static void prune_worktrees(void)
 		strbuf_reset(&reason);
 		if (!should_prune_worktree(d->d_name, &reason))
 			continue;
-		if (show_only || verbose)
-			printf_ln(_("Removing %s/%s: %s"),
-				  "worktrees", d->d_name, reason.buf);
-		if (show_only)
-			continue;
-		delete_git_dir(d->d_name);
+		prune_worktree(d->d_name, reason.buf);
 	}
 	closedir(dir);
 	if (!show_only)
-- 
2.27.0.290.gba653c62da


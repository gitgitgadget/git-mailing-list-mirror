Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDFCD1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 16:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJRAhD (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 20:37:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44257 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbeJRAhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 20:37:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id c56-v6so30774583qtd.11
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I4Jwu8qkQEbRvOUECSKt3I+ZwdOY6/3t4M1e0SBz4Aw=;
        b=LH8qCDxXp6y6nlV75mbxaBNLis6D9P3AA9h6nytxwzWieezWx1Abrzpw7ekGPNF5Gl
         mz0D4CnZgP0q0YQ1ucHfroTODR1/Ax6sR0Fhmzr9DfOezXT6DSj7OBorFLR0MPKUHqsw
         hsL5xJymAK1eNLrQT3iwQOIhZzBK6uJ+r7gQCvN5MSgDuu72scmQZp3db0PJT4ZAjqqO
         lhKiNPmDtnL+3kQACaKiFyftUkn9vBBm/Eo56DCL56Uya5lKPj27lETYUJTAbOI1tWKr
         H97Soa4VM/242pX2tL46lC1fcetwt1AfPrAD6wzG8Y529WR4+rz5CG0NGyN3VkkCy2p7
         LxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I4Jwu8qkQEbRvOUECSKt3I+ZwdOY6/3t4M1e0SBz4Aw=;
        b=SzgzwGMrzEgPdyhy0DlSOnLAz9+I4Vt3dfdEzhGfj2AL9u59PuroQdhF84lzfuKu+g
         H0a1ov12eWxns14uhxlUDuJoWcSrxEN0PtqQSrFb1FgzpntNfPjvvuplh7AoFjVju7yI
         bITJHYD79TiEpQA74xiHZQRSuADw6A15U3Hc8aMN5lFW/6s0OhYlZHgWUOsTJtILkoGO
         mRVyCrELX89OlZKULcUGvdP+q6Do+DCpXLtWFWJPQq3qx5bIkvFgBEr/rHts/eo0uWzI
         9Rl0p4v5SuLN6Ghcq3lT9XAohYfG0vUTYMnkt7Laru6cvXRk/CzZ9hUWquO+j/k3q2Y8
         FTag==
X-Gm-Message-State: ABuFfojDYyYuAyVHQna093vyN53/YVX4dWKNDuoEqx+oqXGj4MAqQ26O
        jeHBdUdaKb7r3UcqD+fTbXWLy0C4Wqo=
X-Google-Smtp-Source: ACcGV61SGSpoP6FSvOJrw9isVWwuijcJQpz7WuIQTndkBK5EBS+8Gl0ppn/NV/TEUt7y0XP3nSQSRg==
X-Received: by 2002:ac8:1e1e:: with SMTP id n30-v6mr25659851qtl.181.1539794431692;
        Wed, 17 Oct 2018 09:40:31 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x12-v6sm10843700qtk.6.2018.10.17.09.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:40:30 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v1 1/2] reset: don't compute unstaged changes after reset when --quiet
Date:   Wed, 17 Oct 2018 12:40:20 -0400
Message-Id: <20181017164021.15204-2-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181017164021.15204-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When git reset is run with the --quiet flag, don't bother finding any
additional unstaged changes as they won't be output anyway.  This speeds up
the git reset command by avoiding having to lstat() every file looking for
changes that aren't going to be reported anyway.

The savings can be significant.  In a repo with 200K files "git reset"
drops from 7.16 seconds to 0.32 seconds for a savings of 96%.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/git-reset.txt | 4 +++-
 builtin/reset.c             | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1d697d9962..8610309b55 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -95,7 +95,9 @@ OPTIONS
 
 -q::
 --quiet::
-	Be quiet, only report errors.
+	Be quiet, only report errors.  Can optimize the performance of reset
+	by avoiding scaning all files in the repo looking for additional
+	unstaged changes.
 
 
 EXAMPLES
diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..0822798616 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -376,7 +376,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
 			if (get_git_work_tree())
-				refresh_index(&the_index, flags, NULL, NULL,
+				refresh_index(&the_index, flags, quiet ? &pathspec : NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
 			int err = reset_index(&oid, reset_type, quiet);
-- 
2.18.0.windows.1


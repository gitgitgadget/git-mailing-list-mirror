Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D45C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiCYRgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiCYRgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:36:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF4CFB99
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:34:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w27so14544818lfa.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6P2xBlJhuw5F+U0DGaBLdO/Xan/ji+qT8ynp6WrIC6M=;
        b=HOPEs9XEhAypQSGArOYMGVdk6cxgIrLJojowGutUP8GRc4IK566Q5JJlBaqOyZhVFi
         DJq2Ut9cSWSSlW4YU9VzuRcAhPdfJy1YMpW/vv7aIDV9jPgllt4IC81OlyZ4PQf+3W/3
         ZXJmQFkMOjLpZwaJxrs8XTT/G6MWVrvi+s/+T61jZ02AWmrZk46khhgdihabf7wZRRML
         HKXfZwRmsNXTsGqhavnKIKR2saLhM+yKsHnbAfiggjaHY7H8wibLYN7mSuiwcdNW2n1S
         dRz+n9si0zv5oIrio3ORonpEBFE++UYo4D4K//idBfLx4KitjpTRBbliKCqk85T21YTe
         Bh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6P2xBlJhuw5F+U0DGaBLdO/Xan/ji+qT8ynp6WrIC6M=;
        b=jtkLRbsSzFLZVdcFY+gQaOssfcyw10Hmgiep9obeHnzD8TO7jel6ZGTyDAftzaG8JL
         P4U3Gkg7tqN5nCoZQv/XKBBmVFtX7dTXsrrJdLpSMbDp3NQPQ9bTDYtDppLAYYJCLQgF
         jq2PEBtGf7ps6rBJphfLqImLUU5NENgJm4VtuIGFzqmfZ9LUXNwPOCByxotu3U74WOlU
         SQVbf/4maDUbkakmyI+AAhFd9ullg7u+RMQ1Qj0oBjE3GUS+1cislGDHmADPZV/5MZFs
         pkYsYs6w+h97+/WQbEQ77avwBHoOjU7FyyhgqKs0b8rykBQnBnkmFJ92tA1z22rr6PgI
         sPEw==
X-Gm-Message-State: AOAM533GoiZdPQvqePS1w9Hl3mxwruZ6EuNtzR272UG9kla61qTWRf31
        b5fmVn4ptC1VsD94+VY3+FlaYabafv1H2A==
X-Google-Smtp-Source: ABdhPJxnqfSnXq7JhxXeaEQiHhatPW0OW0SkWSUltJMLyScVpN1l95IL0nUiTvgj8ovTIDe43pB3qg==
X-Received: by 2002:a5d:5106:0:b0:204:fe5:a66 with SMTP id s6-20020a5d5106000000b002040fe50a66mr10116567wrt.33.1648228776534;
        Fri, 25 Mar 2022 10:19:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/27] revision.[ch]: split freeing of revs->commit into a function
Date:   Fri, 25 Mar 2022 18:18:29 +0100
Message-Id: <patch-v3-05.27-12fb45f02c1-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the existing code for invoking free_commit_list() and setting
revs->commits to NULL into a new release_revisions_commit_list()
function. This will be used as part of a general free()-ing mechanism
for "struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 2646b78990e..ef45762bf21 100644
--- a/revision.c
+++ b/revision.c
@@ -2923,6 +2923,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+static void release_revisions_commit_list(struct rev_info *revs)
+{
+	if (revs->commits) {
+		free_commit_list(revs->commits);
+		revs->commits = NULL;
+	}
+}
+
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 {
 	struct commit_list *l = xcalloc(1, sizeof(*l));
@@ -4080,10 +4088,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * boundary commits anyway.  (This is what the code has always
 	 * done.)
 	 */
-	if (revs->commits) {
-		free_commit_list(revs->commits);
-		revs->commits = NULL;
-	}
+	release_revisions_commit_list(revs);
 
 	/*
 	 * Put all of the actual boundary commits from revs->boundary_commits
-- 
2.35.1.1509.ge4eeb5bd39e


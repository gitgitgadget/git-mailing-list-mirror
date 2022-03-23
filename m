Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B9CC433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiCWUeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbiCWUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0648C7FB
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so6089214wmb.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWlkSlsXciI6gSNgf8eFL3LemQQ1dSau2oM+JYLZXIE=;
        b=jM1dle3gKqmOOqza3GfP99UjYiPzahbvV5t8LD3H8GQdI3KvX50n7QJ4hQnW79Luhc
         ukHP4RhQ740RLG12rWEf11M4W4l8fAEhjRHOir2SFGkX1NH1Sb2dxqtTirrshMWqdlsf
         6aEqJhxCt4urUukbc8vNqFhINtrI/KyV9Yd38a3Y53TbQjSmsgZBV9iNeUhUdrfEe0A2
         aphtudQUkCZx0PyHZhEY8FfOGU+34j2EuWGg0pt/JkxF0LCvn2Dve6N1L4s72pWS5mJ1
         ve4qdgRCi8gDsAbclG6eQQZvb1KvTr3OvB/mc8njFc1//9ROBCp2Bs+6DUOwl7hhE7Di
         uNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWlkSlsXciI6gSNgf8eFL3LemQQ1dSau2oM+JYLZXIE=;
        b=JK49Mt+cdqFEd944o1jHKzNalAOjfnwGqOioMHbU/SZq39NizLsujcLj+ihR3L5v2K
         8v2x/TwfyfxEwRJisb8CKBRcj41tLkHJpmhQyaZF0GEonH0iENniQZ2Pc5ejT1Q2Epy8
         95t1Dp/LMUmB1q51wc1UaaSdENbGHelqhhWDWSqLMLDZNvGqimwpFlEvSm1b7bi4ggcf
         HCtufWVmIhPbBcq8IiVzZ+VoRr3EN4J6oDplnLC91L6kH7YmJu7MqmI+mcgVPE5Q+xUL
         1wqlFtoquMF6mpOuPycBmzEBaK9rYmLZhd68h9sCVlGVu66MbnCF4OyqWvvqthAyG1BP
         izAg==
X-Gm-Message-State: AOAM533fsYx+QOths6IaCYy3WmH5ssT0Mvm7kLu1TJxxB3ISb7JTjU72
        m/DGHRVIuzHjEJxuIeHVBBESdymjjgohIg==
X-Google-Smtp-Source: ABdhPJxSagKhw74X5PrF94xAc4u+RhdfbWewmIYxkhzVUGed/r4JFD5SP3yjVVxWvFIJqaCLeHmY5g==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr1744933wml.51.1648067551124;
        Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:30 -0700 (PDT)
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
Subject: [PATCH v2 05/27] revision.[ch]: split freeing of revs->commit into a function
Date:   Wed, 23 Mar 2022 21:31:55 +0100
Message-Id: <patch-v2-05.27-4c0718b43d7-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
 revision.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 2646b78990e..303d1188207 100644
--- a/revision.c
+++ b/revision.c
@@ -2923,6 +2923,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+static void release_revisions_commit_list(struct rev_info *revs)
+{
+	struct commit_list *commits = revs->commits;
+
+	if (!commits)
+		return;
+	free_commit_list(commits);
+	revs->commits = NULL;
+}
+
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 {
 	struct commit_list *l = xcalloc(1, sizeof(*l));
@@ -4080,10 +4090,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
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
2.35.1.1452.ga7cfc89151f


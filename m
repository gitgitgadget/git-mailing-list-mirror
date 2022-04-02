Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E7C433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354685AbiDBKwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354593AbiDBKwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B22141DBA
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so7241566ejd.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHbNYT/Tg0aFEhjitPVXF/Yje193NZpwKF5mWwtG554=;
        b=PmG4wfdTFzZLI+dXAhMNfx3R27SwHIv3c36ILUm9wZs6vMQ5Y0dVTTdupGlgCHOEYE
         D1kKzSz6cUxN5pujj2zPDRJAkk0hYtOnh88C5i5rAeU21Icf4Gp94Vzr6viym2IK+mK/
         fNfdqwSCKXVKICbZ8pYgf63TTLZSPhiTuejk3ptzC9S2wEdB32eLIuXXO2zZMVC5ZlKe
         1aiYxBii2hxgP3IjlSg2rXnm0B1FdfpCu8NjOOxY32Q4fGlSSfHe/6wSNH0fc1hwsJ7S
         aq1rrZGEPoryJZ/Fq+d+91CMQyVMtd80+HHNpF5z+4d6dRbT4uTdTQ+OE02Fu45s1acy
         pI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHbNYT/Tg0aFEhjitPVXF/Yje193NZpwKF5mWwtG554=;
        b=mMMo+89hSbDtpEm4zK9708l6qqKdBXqaqxR9y9yJ10G0+w/POVfdSDHmTdwvqrdE7p
         7/mz6DRlyZn2m6FeeNZfhdMDUUuEhDo2/tvGL5Xc5kJEPN+llPr3aLOgVp2eUhHeaOe6
         gtii4rcAdy6yKBUkpXCCOoJQMyYamOGURkE3/J9T72NET+UY08FEOblujU+IN0wYLvw/
         wNqOy9LzKb/40YCIpVb/vKDNO9InkyTcAkvUmfnl7vOU4RmFsLgxdFQuMjLNsZvcSa0A
         HBI4seFAJvp19zhQYbx7yO58wbUsxRVQH5vwWM26AcNVp+x+zLH1RrmMn5PmdTHt6Blc
         0syA==
X-Gm-Message-State: AOAM531ZJPTGL33KA0buZj7FHPGzjm0xwjpbqJmgDXmSFUUTHqbpAwjS
        ZmTBU8M/5jOFQcA58nXQOXZ78knfLNl+CQ==
X-Google-Smtp-Source: ABdhPJwgWpxfPkFqkWzuzp/TnFI4R8g/HtFR5btBiUd8BYHFkB36zVg7dObYLPNUPQL3ETRnEUWVaQ==
X-Received: by 2002:a17:907:9693:b0:6e4:1968:8cc6 with SMTP id hd19-20020a170907969300b006e419688cc6mr3377162ejc.59.1648896610354;
        Sat, 02 Apr 2022 03:50:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 26/27] revisions API: have release_revisions() release "topo_walk_info"
Date:   Sat,  2 Apr 2022 12:49:40 +0200
Message-Id: <patch-v5-26.27-fbf233ec768-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the existing reset_topo_walk() into a thin wrapper for a
release_revisions_topo_walk_info() + resetting the member to "NULL",
and call release_revisions_topo_walk_info() from release_revisions().

This fixes memory leaks that have been with us ever since
"topo_walk_info" was added to revision.[ch] in
f0d9cc4196a (revision.c: begin refactoring --topo-order logic,
2018-11-01).

Due to various other leaks this makes no tests pass in their entirety,
but e.g. before this running this on git.git:

    ./git -P log --pretty=tformat:"%P   %H | %s" --parents --full-history --topo-order -3 -- README.md

Would report under SANITIZE=leak:

    SUMMARY: LeakSanitizer: 531064 byte(s) leaked in 6 allocation(s).

Now we'll free all of that memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index ef98e4711f3..28c3c3ff9b4 100644
--- a/revision.c
+++ b/revision.c
@@ -2945,6 +2945,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
@@ -2958,6 +2960,7 @@ void release_revisions(struct rev_info *revs)
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3470,17 +3473,22 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 		indegree_walk_step(revs);
 }
 
-static void reset_topo_walk(struct rev_info *revs)
+static void release_revisions_topo_walk_info(struct topo_walk_info *info)
 {
-	struct topo_walk_info *info = revs->topo_walk_info;
-
+	if (!info)
+		return;
 	clear_prio_queue(&info->explore_queue);
 	clear_prio_queue(&info->indegree_queue);
 	clear_prio_queue(&info->topo_queue);
 	clear_indegree_slab(&info->indegree);
 	clear_author_date_slab(&info->author_date);
+	free(info);
+}
 
-	FREE_AND_NULL(revs->topo_walk_info);
+static void reset_topo_walk(struct rev_info *revs)
+{
+	release_revisions_topo_walk_info(revs->topo_walk_info);
+	revs->topo_walk_info = NULL;
 }
 
 static void init_topo_walk(struct rev_info *revs)
-- 
2.35.1.1585.gd85f8dcb745


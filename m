Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F27C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354584AbiDBKwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354531AbiDBKwB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E413140760
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z92so5646781ede.13
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ezM1nLx6Oakk7WrujcCl99MGdl3LvkqNCGR3Ka2aWE=;
        b=RSCPmvKn2iJHJ2bWGVK9f/nQYPlWzcWNUjFSQv5XWH2ym1ul2HITuT6hqYFFwmrrVc
         Zi6jdkJUivSLpLPnZqggIqZPPrhoCwIaS01x/T85o9JLuk5Mb+HPvJ8X/rza+vo+649E
         8GI0rlXkKeOX5Pomf4mUBhhV0QadDpBxT+QEpsmMgtAtDXcejZTeHwlP5jCxWE7GOLo6
         wyi6zG0P1hfOoATDnw8J2ocqYmw0DNXAoXDJoONvZk0EmHyLjTC0PLf2UO9Vx0RgwVGR
         616SPGKKLKptqkP/bgtR3kh5qlt1cvlZQ+uHljj+2m6vvcLfBE4WHjle0GDBxAsN7MX4
         vqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ezM1nLx6Oakk7WrujcCl99MGdl3LvkqNCGR3Ka2aWE=;
        b=PR1xfDa5mibh92sw+GqUJfiL/+nIRu34ROcskc3FDOXOAcTqq0PLTvXthdS+H9ROdW
         ik95JAXvgkhqDSoF7QrYDlLG+P5ltlFlCKwA2fJq6uBH8Znh1E84L+NClo9JW8KryBrT
         UQ7JgmUTOgS6hRPpkIG2piIngfcb7sTJwP7HqDrhOXXoBUi7SYLGNCkXm3fZQHhPXbYZ
         wTr67tf8m2TFWLgTsqTjGRPGGQXOv5hcVMuqUpjn61ac/pozB3sia033Vrs3nHLhnEJ3
         P272BfOaK4/9qtD22/0B1Ed9iLQcxmwnt1LuX2f7e3enfvpYcnBNg99Yb0zqTcV3oo6d
         zjjg==
X-Gm-Message-State: AOAM531OyeGlHJF62/fmAzJ5klf6VKU/LDSJv4fwkIbv+ChzfJR5Fgdj
        JzGE2Zoysbxo8bey9vpDuigq7CXKVsocTA==
X-Google-Smtp-Source: ABdhPJy9j1W5mKkQuIsdCe2065boTjujvDTdWudP2TtYDr3hS08kROM7ONpiSbk7h29YJQkqQ2wZHg==
X-Received: by 2002:a05:6402:1708:b0:41c:b3e2:c4e7 with SMTP id y8-20020a056402170800b0041cb3e2c4e7mr836598edu.197.1648896600727;
        Sat, 02 Apr 2022 03:50:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:00 -0700 (PDT)
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
Subject: [PATCH v5 16/27] revisions API: have release_revisions() release "commits"
Date:   Sat,  2 Apr 2022 12:49:30 +0200
Message-Id: <patch-v5-16.27-285673e40bf-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"commits" in the "struct rev_info".

We don't expect to use this "struct rev_info" again, so there's no
reason to NULL out revs->commits, as e.g. simplify_merges() and
create_boundary_commit_list() do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 472fff1e0a7..553f7de8250 100644
--- a/revision.c
+++ b/revision.c
@@ -2928,6 +2928,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 void release_revisions(struct rev_info *revs)
 {
+	free_commit_list(revs->commits);
 	object_array_clear(&revs->pending);
 }
 
-- 
2.35.1.1585.gd85f8dcb745


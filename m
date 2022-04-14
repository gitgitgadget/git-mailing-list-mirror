Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A457C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiDNF7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiDNF7R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:59:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5E34BBD
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso5309189wml.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH7tSyOC3TRcAvUH4rC30W5ZZTOi/7NTrfqQhPq7bcs=;
        b=MEZ029QjhtRuNCtZneqfzH9W7qSlGU1icyHXkfLmSXBxfJMWkBPT9sMwGkH132DT82
         aKLAqsiV74Ewi7DNHZrz+AJAuTsLbJJ53S4mMJHa9uU42zz3key919gJ6jdy8msdsOge
         O1YM8XotzvRMAQeGqi+Xwdyx7iV4Bxdb0x3dJQxr4ZQCe+DOvPg5wCvdzRVfBDAurcxw
         s/dq68pKIgk/Ot2Oh+O5pfyjHaGf3YbNayWOjDWIIGbhuzeL8CV4m8XlpUaSPPbalhqn
         bBFMU8ZAocvcDom4+bffZN67kADSXG06n+e3meLsCPjJV9yUWZJbdJsqtap8dtmISre9
         Xiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH7tSyOC3TRcAvUH4rC30W5ZZTOi/7NTrfqQhPq7bcs=;
        b=kUlw3Qy4F8sZ2woSbf1Yr3nNzE6Cu+Q6b4UtQ8C0VrzoUhqemxtRgcQnV+fKqHnQmB
         EY+EhgFJSVLSZRtKj4YpeNg9JCxLuHUwUHalMntUammK5k3xq6pq0slCgftBhMg+3QID
         23HfjKPMMj1v+vx1UPsMMTbmUbckHQymEgVJVINveK9ufzzHos/6D4WvsAJwtgOxW+9H
         8h4DjxO91ivP5DsJ8S62O8GTLNV4ZGEfrnaF5nPRxIkHVnE/JmJl6/hLyrrNCG2Sqzyv
         Mj1S5bFwqYw4oyNXc7OO1HCCpCURc1uy9vxd8+k4JZ7J0v1V3ZAtlJnwWQneNp3b7C2b
         rFqA==
X-Gm-Message-State: AOAM5329I2nzPxfmtW7q+z92mqEWgRMIilPoSYHWN8dKtr5HTf/HKdqW
        2I7d9q05zeaeAoAoPGc0n7WNKyc0KRCxPQ==
X-Google-Smtp-Source: ABdhPJyAzfXRyILaCaSsH4ZQcbEYLRW4Mq/Zo455m2j/ndhn0YuSDuHsFmD3kVRjjJUEmVJ/I9Cifg==
X-Received: by 2002:a7b:cb0d:0:b0:38e:aaf3:b08f with SMTP id u13-20020a7bcb0d000000b0038eaaf3b08fmr2009097wmj.12.1649915810701;
        Wed, 13 Apr 2022 22:56:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0038e8fb63293sm960453wmq.22.2022.04.13.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 22:56:50 -0700 (PDT)
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
Subject: [PATCH v6 25/27] revisions API: have release_revisions() release "date_mode"
Date:   Thu, 14 Apr 2022 07:56:38 +0200
Message-Id: <patch-v6-25.27-4aadeabaae7-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"date_mode" in the "struct ref_info".

This uses the date_mode_release() function added in 974c919d36d (date
API: add and use a date_mode_release(), 2022-02-16). As that commit
notes "t7004-tag.sh" tests for the leaks that are being fixed
here. That test now fails "only" 44 tests, instead of the 46 it failed
before this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index 63f17c085c9..307f41e8891 100644
--- a/revision.c
+++ b/revision.c
@@ -2951,6 +2951,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
+	date_mode_release(&revs->date_mode);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
-- 
2.36.0.rc2.843.g193535c2aa7


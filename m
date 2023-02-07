Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152E9C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBGPEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBGPEk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 10:04:40 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040014202
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 07:04:39 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so10597604pgr.12
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UC9Jl79RCGfCD+V1rNm3JYOJpfK1rwNgY727PJTCnLk=;
        b=D/qv7Pw6a9+aFtlR45Rk6fTVU5Ma26nSGqELbmWnSzfEnJQYT0CnPdC+m7X06TT/j4
         GzhxcnZCOpY7//IpxiiLzvGCFcNUpfYAjpxScBVIcJ04mNHyfCaefla9xjpKof39Zv+z
         Dkye9/gNWb9M5uIBDXfLlV+PprEN3/9JZsg9DcA3CetBxN4ttGHdWWLlT4Hq3HxtV+Io
         htu/inkw7Rn99n3K/+iNL7cVsCRV9eLlhh8V+VuwryEuamgWsh4BMR71Fdo5DYfJRiXR
         M6gCRXS9Z/6OIWpslgrkHGK/RqxAWYpa1iaDoQqFEvkWE7LOBwDiALKzdY6661cLSNxE
         jqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC9Jl79RCGfCD+V1rNm3JYOJpfK1rwNgY727PJTCnLk=;
        b=tHNNFFWRCdluEyZk4MghLyqnlFov8YHwVrXQ2i8s1SDyou7QoGuyGkVe/8N51eBfHg
         kQ5ZKMxGhZ5pzWkcvCSMg69eRwwS+AtIoWI52lSVJBv2NCgGKdQR6gR76pJwZzDFPgUu
         bsOqkKcT0zhIN3NSyMeujsWd9Au+JiGaEOGVoqYoQefoX8KgaLz80KB4APLiWU84ORq0
         LI8FyoFrB3vMlfeNyhQkgvzjkWi0j9PJ85OyNsGPZNNNRZleIyss1SPeNvq8z73BAGap
         oBa+RZH8kwQWa8xMKfoxo00xa5aRFS8kQo4/0Uw12PsLAawnn0B8k3VjQMQVBiRga/nx
         o6gw==
X-Gm-Message-State: AO0yUKWlo+NMsO5EI9F50Ubhc+3EZtI5FpxFRmifBHLnvchuOegSa7bS
        c9LBihYZQYCoy4/1z1yWq7T2Ccf30gJNSSeT
X-Google-Smtp-Source: AK7set8SNShwUVrQ2MnexpMfM8MKeZRcPO6G+7jQMD3Mq4kAbA+LqlQADhBLz/OFJhp+fan6aLAlNg==
X-Received: by 2002:a62:2902:0:b0:593:da8:6f34 with SMTP id p2-20020a622902000000b005930da86f34mr2683968pfp.5.1675782278922;
        Tue, 07 Feb 2023 07:04:38 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.136])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005907716bf8bsm9349545pfo.60.2023.02.07.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:04:38 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, five231003@gmail.com
Subject: [GSoC][PATCH] commit: warn the usage of reverse_commit_list() helper
Date:   Tue,  7 Feb 2023 20:33:59 +0530
Message-Id: <20230207150359.177641-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function reverse_commit_list() has destructive behavior when
used to reverse a list in-place. Warn about this behavior.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

This patch has been sent based on the confusion that can be caused while
using the reverse_commit_list() helper function. One example of this is
a recent patch that I submitted[1] where the use of this function broke
try_merge_strategy() in merge.

It is also based on the discussions[2] there that I send this patch.

[1]: https://lore.kernel.org/git/20230202165137.118741-1-five231003@gmail.com/
[2]: https://lore.kernel.org/git/xmqqmt5uo9ea.fsf@gitster.g/

 commit.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index fa39202fa6..9dba07748f 100644
--- a/commit.h
+++ b/commit.h
@@ -198,7 +198,12 @@ void commit_list_sort_by_date(struct commit_list **list);
 /* Shallow copy of the input list */
 struct commit_list *copy_commit_list(struct commit_list *list);
 
-/* Modify list in-place to reverse it, returning new head; list will be tail */
+/*
+ * Modify list in-place to reverse it, returning new head; list will be tail.
+ *
+ * NOTE! The reversed list is constructed using the elements of the original
+ * list, hence losing the original list.
+ */
 struct commit_list *reverse_commit_list(struct commit_list *list);
 
 void free_commit_list(struct commit_list *list);
-- 
2.25.1


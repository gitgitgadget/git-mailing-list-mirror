Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB3C52D11
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 04:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjAUEaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 23:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjAUE3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 23:29:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31BE056
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 20:29:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so4998205wms.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 20:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YleaBYL0BTWN8hvq7/knLZ+VY0ux6qJ9sQVbsJBleAE=;
        b=C5PWfLRnZKHliKj5zAjMYxCxHRTPztnbqFU9m3K8n5niRWCMJwxTJK7hzWJ2LHDC6O
         3oMJHbFoatUh9gTIL+KZOmPMaWq0K7iTJj+KiyF/X9GU9mbDeMkMBTOfJVu04u949UNP
         A1EnAddJTPXzY2qd5+e5FTOYyEwom3hv00oZ3bX19i7AfBnCB34QVhozNyzAs3rp9cIh
         tpAI/H6QMd9/EemFiAziyLLhhbVXPoowo9y2CGInRlEmYwcyQ5uXtD3tHSV9WreJHYe9
         HiBoj5o2BdxQCbYZdgJUEf4TFDr+l1taXGZMNoqs8pOcmkZ03zXBX5zsmiap1lDmJUC0
         k+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YleaBYL0BTWN8hvq7/knLZ+VY0ux6qJ9sQVbsJBleAE=;
        b=k7dCH8lH3kwLVaPloLxcwZTwIQT3jr33nBiAoxnuoIHbX9lXN7cy+oLpm/6cSmdkzp
         PWhP/KuabBJOhg/Yltkm50JXErRS7ZiZ1CztZCMi2glKIG6M3lVP+lH5+T8fsKYHgBb8
         0wr5Jx5KXNIjJN2bs74W2QZ1maZHedWnPaCcK/F2K4wh8pAiJXKSRTSTYlfDnk5g+EWA
         ZkBmWaxLu4ucWKJPlxj5jq6zPZBOVki7qaNA112YZAHGfNF0CD2mv4KyFLd+xXFRHbbo
         vCsjY9rv+58niPt3e/E8ypSiBnMDSGWAovao8vGubm8SThX6SRnTsvMPJ0B0jCACjg/y
         nJgA==
X-Gm-Message-State: AFqh2kob1xgRawsFAfS9M/zT9Y97IrRtk/gvyGKhMhOrUtkFg1EzJHyy
        6IzJu+dbujwGi4oEw7aN/LaXNxl3s2Y=
X-Google-Smtp-Source: AMrXdXtPbjGRcQf4gPTRU3Wc5YYDQ8DmS3lEutS++/tD8ApwsjFjRMundA5CpfUaMuBl2xFo+FFfGA==
X-Received: by 2002:a05:600c:6008:b0:3db:141c:1e09 with SMTP id az8-20020a05600c600800b003db141c1e09mr11746886wmb.23.1674275338532;
        Fri, 20 Jan 2023 20:28:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003cf71b1f66csm4641260wmq.0.2023.01.20.20.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 20:28:57 -0800 (PST)
Message-Id: <pull.1468.git.1674275336636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 04:28:56 +0000
Subject: [PATCH] name-rev: stop including taggerdate in naming of commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 7550424804 ("name-rev: include taggerdate in considering the best
name", 2016-04-22) introduced the idea of using taggerdate in the
criteria for selecting the best name.  At the time, a certain commit in
linux.git -- namely, aed06b9cfcab -- was being named by name-rev as
    v4.6-rc1~9^2~792
which, while correct, felt very suboptimal.  Some investigation found
that tweaking the MERGE_TRAVERSAL_WEIGHT to lower it could give
alternate answers such as
    v3.13-rc7~9^2~14^2~42
or
    v3.13~5^2~4^2~2^2~1^2~42
A manual solution involving looking at tagger dates came up with
    v3.13-rc1~65^2^2~42
which was then implemented in name-rev.

It turns out that this taggerdate heuristic isn't needed due to a
subsequent change to fix the naming logic in 3656f84278 ("name-rev:
prefer shorter names over following merges", 2021-12-04).  Simply
removing the taggerdate heuristic from the calculation nowadays
still causes us to get the optimal answer on that particular commit
of interest in linux.git, namely:
    v3.13-rc1~65^2^2~42

Further, the taggerdate heuristic is causing bugs of its own.  I was
pointed to a case in a private repository where name-rev reports a name
of the form
    v2022.10.02~86
when users expected to see one of the form
    v2022.10.01~2
(I've modified the names and numbers a bit from the real testcase.)  As
you can probably guess, v2022.10.01 was created after v2022.10.02 (by a
few hours), even though it pointed to an older commit.  While the
condition is unusual even in the repository in question, it is not the
only problematic set of tags in that repository.  The taggerdate logic
was a workaround that is no longer needed, and is now causing suboptimal
results in other cases.

As such, remove the taggerdate in the comparison.  However, note that
"taggerdate" is actually also used to store commit dates since
ef1e74065c ("name-rev: favor describing with tags and use committer date
to tiebreak", 2017-03-29), where it is used as a fallback tiebreaker
when distances are equal.  We do not want to remove that fallback
tiebreaker, we are only removing the use of actual taggerdates as a
primary criteria overridding effective distance calculations.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    name-rev: stop including taggerdate in naming of commits

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1468%2Fnewren%2Ffix-name-rev-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1468/newren/fix-name-rev-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1468

 builtin/name-rev.c  | 4 +---
 t/t6120-describe.sh | 6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..df50abcdeb9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -113,9 +113,7 @@ static int is_better_name(struct rev_name *name,
 	 * based on the older tag, even if it is farther away.
 	 */
 	if (from_tag && name->from_tag)
-		return (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name_distance > new_distance));
+		return name_distance > new_distance;
 
 	/*
 	 * We know that at least one of them is a non-tag at this point.
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9a35e783a75..c9afcef2018 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -657,4 +657,10 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 
 check_describe -C disjoint2 "B-3-gHASH" HEAD
 
+test_expect_success 'setup misleading taggerdates' '
+	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
+'
+
+check_describe newer-tag-older-commit~1 --contains unique-file~2
+
 test_done

base-commit: 221222b278e713054e65cbbbcb2b1ac85483ea89
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0871F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeFNRbN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:31:13 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:39992 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754819AbeFNRbL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:31:11 -0400
Received: by mail-qt0-f202.google.com with SMTP id o10-v6so5180195qtm.7
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VAb8kq6VhMeBL0Unw2UkiI1wG2Ew5VV+JaHtW2HhCro=;
        b=Bixm2gdQzYvxkgvBHY02Jpzk+13S4WuQv6DKnryKCQEv26qr6IEjZyVnLqfmE30Vdy
         KeBaoFA+nEFtsdE4vdtw01XNE1101yzZr6g5qc/d/Uj0M19jLMcnjtedh2th+dYwue4Y
         TI2+Kd6JuEP1n/LYKMoNmcLNjgVK8AVWQ8n/mJTSx5M7GVb0A13vnPc/7jpFH925mzQ9
         1WvdY0JIh6na1gvfWQHJz60DonKYWr7BcXCdrNov0qUK3MDx3rZHZQDWXwahtWHaPHXv
         kknqxW6Q6L9GuE6Yi8BXpQfCdlahBtGp2E3bZowKcBunRjCX+eqQIfxkp4Jd4TEbI0Or
         s3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VAb8kq6VhMeBL0Unw2UkiI1wG2Ew5VV+JaHtW2HhCro=;
        b=bq5TuFv2VU/XtfzoU2BVffIVY+sjRUcqop9P8T9CZ05+t4VTIak57bpkoHyUu+yk2Q
         KlhBMUk4gPmpmv5RWagUPoNK4fCegcExXE96YHJFSbgcfkQba4gtgbKa9l2OfN6z7qDW
         dW69pqx99N0tYkrdBfEwdVy1AH8E4LYcXBORElQ6kKy3cagpFe/CE77PLfPgFlA8NJLj
         JjATGp1ffFIkvh4W9x6B6xHGald8rY/xWhUENvthi9wuYBvvFA3J0QQWPitIk3pco4JW
         ymoDpE2Jgy4qvMHd3MFM+qPFOpb8ad/nCT6czyCaZEoSvLYvuZUThVZCtQou3OAisuwr
         wGBg==
X-Gm-Message-State: APt69E3vfI7kcliHWx0XgTxeueVjGk9q88/oEKSOG8KLPxwo8v2qFdA9
        pjOGSR0K807c9LzqfWTcdEbv4Xvg/x8Y
X-Google-Smtp-Source: ADUXVKKz8cCYtiETkzwecmQt+u3p9oOsAgOXi75JV8+KA5ybY4Lu88pBJ9aSlc/WfWkEzNZQmmZf/DJ3TucI
MIME-Version: 1.0
X-Received: by 2002:ae9:ebd5:: with SMTP id b204-v6mr1754087qkg.54.1528997470781;
 Thu, 14 Jun 2018 10:31:10 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:31:07 -0700
In-Reply-To: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
Message-Id: <20180614173107.201885-1-sbeller@google.com>
References: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] submodule: fix NULL correctness in renamed broken submodules
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net, kaartic.sivaraam@gmail.com,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching with recursing into submodules, the fetch logic inspects
the superproject which submodules actually need to be fetched. This is
tricky for submodules that were renamed in the fetched range of commits.
This was implemented in c68f8375760 (implement fetching of moved
submodules, 2017-10-16), and this patch fixes a mistake in the logic
there.

When the warning is printed, the `name` might be NULL as
default_name_or_path can return NULL, so fix the warning to use the path
as obtained from the diff machinery, as that is not NULL.

While at it, make sure we only attempt to load the submodule if a git
directory of the submodule is found as default_name_or_path will return
NULL in case the git directory cannot be found. Note that passing NULL
to submodule_from_name is just a semantic error, as submodule_from_name
accepts NULL as a value, but then the return value is not the submodule
that was asked for, but some arbitrary other submodule. (Cf. 'config_from'
in submodule-config.c: "If any parameter except the cache is a NULL
pointer just return the first submodule. Can be used to check whether
there are any submodules parsed.")

Reported-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 939d6870ecd..0998ea23458 100644
--- a/submodule.c
+++ b/submodule.c
@@ -740,12 +740,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		else {
 			name = default_name_or_path(p->two->path);
 			/* make sure name does not collide with existing one */
-			submodule = submodule_from_name(the_repository, commit_oid, name);
+			if (name)
+				submodule = submodule_from_name(the_repository,
+								commit_oid, name);
 			if (submodule) {
 				warning("Submodule in commit %s at path: "
 					"'%s' collides with a submodule named "
 					"the same. Skipping it.",
-					oid_to_hex(commit_oid), name);
+					oid_to_hex(commit_oid), p->two->path);
 				name = NULL;
 			}
 		}
-- 
2.18.0.rc1.244.gcf134e6275-goog


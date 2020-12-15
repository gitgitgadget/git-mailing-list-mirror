Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C54C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCACF227C3
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgLOS3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgLOS3c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:29:32 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F19C0611CC
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so137753wmb.5
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 10:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S4/DVQKCYPIWucP+lIG6DURVvz/AJQSCPqWWg0rL0oY=;
        b=SUlqqQMmd8qdpIdDUKbQmuavDhchcxqlIkfHrf6yRt285o17A/pW8r595N6Rl2ukPq
         s7MLrgY+WyzL/5e0wnAhbLJcfX46llUZtQ5AWac5ksgUu84XB1tFEavCk04YfjZQYOYm
         rvO/FQ9GD4wFB4QCPFrQvtmUrTDhMvlPECtjcOhXiXqTZy+IO7/8Au+WuZ/uJyNmSnpy
         7nGu5fr3PEszRcnIb6FnsX0KHfjfjCtYSVbwy6reGVUUoe+WwkcrN9WReZNlixd1wCJk
         ImRpBlz8TMSLuRpGdU44YC1TWJyvDfTNRDoRXd4jeZQO1wgPG073e9HQmTNzTNjSZ0Ws
         BIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S4/DVQKCYPIWucP+lIG6DURVvz/AJQSCPqWWg0rL0oY=;
        b=iZVaM22aH+/YPJCwmxC+PGDrjG9Ih/f2WI2CiRMvQOiprK2tmKBYQSm7VDe1kpBCEV
         O3arVorjFQ8jQT2ZqEK2urt6cH+DMORW9Nw0mt35hbxUANnP5uGpuoZZTXNpHMA3HK+L
         kLJnQytgf0KTpN89JoWdQh42ezNvI+JZSwqObNViAqJHB+xHjaVMAkFDm5jMq4w9ul1x
         Ukb3oSYwP8d/jWK7lgFyV0KMaD3pnHWrOeScF4b96sEksZgI7Digl40xpTz+YpN4u7uZ
         0ckc4A49RRArKkaJqMt09FR1eAMNGeDz7aCAS62yups4AbcBRhX3Ujlxy23OI0EBL1w8
         p55g==
X-Gm-Message-State: AOAM531NdU7+trRfOG8qVRO/jfy7+7AmOgGHb5Os547vH9OWs06/qOnV
        5a3/0KdFyF9K/UWC0HE+C5AT1u1NL+k=
X-Google-Smtp-Source: ABdhPJwv6JPnjP0IhN22rm/UQVtqBN9q8Ja0BaEsbcn3EtMhkt+FluydezXHhXWLi18fyqoWd4p/Jg==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr162696wml.113.1608056897229;
        Tue, 15 Dec 2020 10:28:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm35828319wrg.55.2020.12.15.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:28:16 -0800 (PST)
Message-Id: <73426c166877194d3c53a2ea250751318d223d21.1608056886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
References: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
        <pull.812.v3.git.1608056886.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Dec 2020 18:28:05 +0000
Subject: [PATCH v3 10/11] merge-ort: add implementation of normal rename
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement handling of normal renames.  This code replaces the following
from merge-recurisve.c:

  * the code relevant to RENAME_NORMAL in process_renames()
  * the RENAME_NORMAL case of process_entry()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_rename_normal()
  * setup_rename_conflict_info()

The consolidation of four separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

(To be fair, the code for handling normal renames wasn't all that
complicated beforehand, but it's still much simpler now.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1c5b2f7e3b9..26f357e524f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -870,7 +870,11 @@ static int process_renames(struct merge_options *opt,
 					 rename_branch, delete_branch);
 			} else {
 				/* normal rename */
-				die("Not yet implemented");
+				memcpy(&newinfo->stages[other_source_index],
+				       &oldinfo->stages[other_source_index],
+				       sizeof(newinfo->stages[0]));
+				newinfo->filemask |= (1 << other_source_index);
+				newinfo->pathnames[other_source_index] = oldpath;
 			}
 		}
 
-- 
gitgitgadget


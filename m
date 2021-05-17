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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085BC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66FC61241
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhEQM0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhEQM0M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:26:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABCEC06174A
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5177097wmc.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIaSykTHkZm7kVR794lpGSXGwJW8B3o4eXrOf0WDx9w=;
        b=qjam2Y/U0OjMevHYsu0gVhDoql9ku8ul9iRFbN//PPuSM0urSojNoFJyER635WKytm
         loK5GfmL3lhfQxpp7YpF+mrF4BUnZmT44bYu+QpjZtzIh+1YuABstS6yo+yA+XDr98iU
         5riZqfIyAAA7xz7oDfxaDvqWZ/E6nMwdDbrGQ0bGiGk3g3WHvJHP2ykAy+deO5PTQaBx
         ZKW2FBiVqjpD+53Q1NyyOIMWe3nQCNJzaUaLPYE5zREVptpCt1FoamDd9qQU0CH4b/qn
         O1IB2BLTyi+SvOYIXHJGlSMDsmswZpu4tQoLUEtiL8qtVeMelmklaNOHl+OOnTIQsWRR
         ZZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIaSykTHkZm7kVR794lpGSXGwJW8B3o4eXrOf0WDx9w=;
        b=l+cCGSwZREc3OSk0sTb6H2UcIj22VOuGJFF8xCoVrgdFgaQ+hodxIC+U4oOXY0u8K7
         k3phUs9aUyjSkviSO+MvLbLKGRpCsS3j1GVaRvF71WdojlykdT9NNN4SCR1Jkw8PPBT9
         mjUkXOD3q/C0Ku5WSXgXcR5yDN+72yWjzQEoMDpTVxCXpL+WuNbd6eA1QMbzEuDzoadW
         ywsh+ZZyclCQ5HQ+lV0YyZQPyRhjXsH6bPZTZ6yoyrZF4UDM9ZffyVhQp6jM3mL1MIu5
         kroq+S1FniQXSdd3HqK9PlK/8KrBM6rZXkncDuX7WBb3y6bR1ms385+jdEMMNHHWqI29
         ffhg==
X-Gm-Message-State: AOAM530Gpmu0beabisWBw58ciO7NCqvsiIoCipTjqZvPqxxpFGw1R+Ll
        sMQGgEBZ9bKuKo3N8aWb2WCHFb9/TUg=
X-Google-Smtp-Source: ABdhPJw9LzNvyHsJoZNJ0AQjUrYs73oGTFW2LWAH35N+q2YrQMdmUjaSa+fPbVlzwzCsucypU4nA3w==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr23132714wmi.72.1621254294266;
        Mon, 17 May 2021 05:24:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm21184848wmj.39.2021.05.17.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:24:54 -0700 (PDT)
Message-Id: <b3e578ac0365fba9ef015f2e9a06593ce85d2814.1621254292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 May 2021 12:24:49 +0000
Subject: [PATCH v2 1/4] hashfile: use write_in_full()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The flush() logic in csum-file.c was introduced originally by c38138c
(git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26)
and a portion of the logic performs similar utility to write_in_full()
in wrapper.c. The history of write_in_full() is full of moves and
renames, but was originally introduced by 7230e6d (Add write_or_die(), a
helper function, 2006-08-21).

The point of these sections of code are to flush a write buffer using
xwrite() and report errors in the case of disk space issues or other
generic input/output errors. The logic in flush() can interpret the
output of write_in_full() to provide the correct error messages to
users.

The logic in the hashfile API has an additional set of logic to augment
the progress indicator between calls to xwrite(). This was introduced by
2a128d6 (add throughput display to git-push, 2007-10-30). It seems that
since the hashfile's buffer is only 8KB, these additional progress
indicators might not be incredibly necessary. Instead, update the
progress only when write_in_full() complete.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 csum-file.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7510950fa3e9..3c26389d4914 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -25,21 +25,14 @@ static void flush(struct hashfile *f, const void *buf, unsigned int count)
 			die("sha1 file '%s' validation error", f->name);
 	}
 
-	for (;;) {
-		int ret = xwrite(f->fd, buf, count);
-		if (ret > 0) {
-			f->total += ret;
-			display_throughput(f->tp, f->total);
-			buf = (char *) buf + ret;
-			count -= ret;
-			if (count)
-				continue;
-			return;
-		}
-		if (!ret)
+	if (write_in_full(f->fd, buf, count) < 0) {
+		if (errno == ENOSPC)
 			die("sha1 file '%s' write error. Out of diskspace", f->name);
 		die_errno("sha1 file '%s' write error", f->name);
 	}
+
+	f->total += count;
+	display_throughput(f->tp, f->total);
 }
 
 void hashflush(struct hashfile *f)
-- 
gitgitgadget


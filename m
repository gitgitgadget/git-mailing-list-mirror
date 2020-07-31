Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3102FC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0778320791
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTfELATT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGaXdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGaXdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:22 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DCC06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so33264835iof.12
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQcugFfn5Wgx4+KU26yD2EPjdPvfnMbw8pSKoG73lIM=;
        b=mTfELATTywcOZAJ3VMOSV56ju8JWlYy+ue/ANCqXkk7zyI+xoK+IMgFp6pEyaDraOI
         hGQFOMpklCMTB/zbkghTOcPySi05QeRgjlNJUHEsMfUV+eteAWuuwQ9Zg7KTHjzhWBOs
         4JtsxuI5VX7kW40cwxWaoGxjZo8i4xd9cMfpMz7gBAL3TFF8tK/wrfRUx8YBvXRVIwa6
         VRNfeQUncOmdOq3h2S3+bhrn0u5fh/CjIwktQpgSblsSK3NUH8X7Ym/ak3XPS1nvDcOo
         3cCg5ZL0Xf141byIPrAiOH4iiImIWIsmS53KYSixAZoIWtRN29d824DqDPtq0SoVpCjs
         oyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hQcugFfn5Wgx4+KU26yD2EPjdPvfnMbw8pSKoG73lIM=;
        b=DkofzPdgfoIcNsg0SejKFaj70pqn0i9sNVVC9UIWTXcXqw+lTQBorauyhvSZkpLftl
         LrU2GPClrRMXsiH1rq9Ir0Gb2M7PtAZNBf2+u3UuEOX+E+EEuvRQjygv5MLzbQwYEAtE
         BEVLjJXR8K+XdKePgCu4GO9595cB/OGp2N/KflX91AvrPI1hU8X4AB16GbCPv7KwhBX8
         aumiWNSwfO65kfytwOd8dbK49olOm3VDuDtXXOEOSb1/rvApFmLDci+XAqSLThvAduFz
         yTr+Ystvp+RShCFSPdF7KzUmDs1O0GQE7URpBdJPtBG9VPGPVWaE6CJKQrOaulU59Dxg
         yH/g==
X-Gm-Message-State: AOAM533gMiB3yFOj/a3otCh6eua5CJnLLtQdw9NGKkrbMKowaLoW9UQD
        lv5sgTvuGvynTEdw1fiq4U95aHdfaFA=
X-Google-Smtp-Source: ABdhPJzCaqHhDVGfVEf6AhxUOWZ0i3UOC4UQMGz+Qd+NQ8r3EEVmAX30+0JAiouwpAY94hk08oqKnA==
X-Received: by 2002:a6b:7610:: with SMTP id g16mr5957808iom.115.1596238401598;
        Fri, 31 Jul 2020 16:33:21 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t18sm3336758ild.46.2020.07.31.16.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 16:33:21 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/4] worktree: drop bogus and unnecessary path munging
Date:   Fri, 31 Jul 2020 19:32:13 -0400
Message-Id: <20200731233214.22131-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.203.gce1f2e0ef1
In-Reply-To: <20200731233214.22131-1-sunshine@sunshineco.com>
References: <20200731233214.22131-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The content of .git/worktrees/<id>/gitdir must be a path of the form
"/path/to/worktree/.git". Any other content would be indicative of a
corrupt "gitdir" file. To determine the path of the worktree itself one
merely strips the "/.git" suffix, and this is indeed how the worktree
path was determined from inception.

However, 5193490442 (worktree: add a function to get worktree details,
2015-10-08) extended the path manipulation in a mysterious way. If it is
unable to strip "/.git" from the path, then it instead reports the
current working directory as the linked worktree's path:

    if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
        strbuf_reset(&worktree_path);
        strbuf_add_absolute_path(&worktree_path, ".");
        strbuf_strip_suffix(&worktree_path, "/.");
    }

This logic is clearly bogus; it can never be generally correct behavior.
It materialized out of thin air in 5193490442 with neither explanation
nor tests to illustrate a case in which it would be desirable.

It's possible that this logic was introduced to somehow deal with a
corrupt "gitdir" file, so that it returns _some_ sort of meaningful
value, but returning the current working directory is not helpful. In
fact, it is quite misleading (except in the one specific case when the
current directory is the worktree whose "gitdir" entry is corrupt).
Moreover, reporting the corrupt value to the user, rather than fibbing
about it and hiding it outright, is more helpful since it may aid in
diagnosing the problem.

Therefore, drop this bogus path munging and restore the logic to the
original behavior of merely stripping "/.git".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 worktree.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/worktree.c b/worktree.c
index fa8366a3ca..355824bf87 100644
--- a/worktree.c
+++ b/worktree.c
@@ -82,13 +82,8 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
-
 	strbuf_rtrim(&worktree_path);
-	if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
-		strbuf_reset(&worktree_path);
-		strbuf_add_absolute_path(&worktree_path, ".");
-		strbuf_strip_suffix(&worktree_path, "/.");
-	}
+	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-- 
2.28.0.203.gce1f2e0ef1


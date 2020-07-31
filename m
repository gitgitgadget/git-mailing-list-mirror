Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B58C433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911DF20791
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwTqRWU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGaXd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgGaXdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:23 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4769C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so33257848ioh.5
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVt3E+hP/lbIR4ZzN16MFc73EE6QUrLi3ujSr+mBL4I=;
        b=bwTqRWU0mK6NCo9Ouz3N6JluSbvkl/DPAFlUMQgMzngp+VEiOe2KPxYQcrVgCNLHRY
         3SpPa2cNAQrDrvTcivrOTX1CSD21Kp/bnHXEqXxidZ7sC26iN7f/iHlFWAH3Wr0Dw+yI
         dZmbiKfezNza+QHfmQ6ImdbCKfuCEXX2UVOpVbKdcsAVKkn+jTVUZoLEH0kRq6TwP1rJ
         osQTdu2boekn/p3R9lNrR1t1+r2pw+twZ5fqgr1WNP+2BVfs9MZC7ncPwDak67xoYDRV
         tLS/EAv6s28eNtG9F556YXFToRIZzcQh2QCA2JsBKKcxT4PF/muAaIy/Do8QtJ5FLPb6
         0Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fVt3E+hP/lbIR4ZzN16MFc73EE6QUrLi3ujSr+mBL4I=;
        b=J7adihrxGtpaRLLXq4THMZoBLE8xTHxiqXGhIjy1Q0mQXqaHkgzebH42Rjv6prvdiW
         C+lElUGj6m/hbqVec/MpxQVc40keAkq4aLwCAc+CQ+oPIu30H9bxhezvttu2HbCrNJ8i
         EI6+6LIoIB0g9V9KaJkG/WKYtnN5hQtN6Ckp9wP8SwZxNlYze4B5PWlH1/ULB44YyHdP
         3eQ6nMV9UIwCGWIHCKV49Ck+WwICgmKKeQuYBGVt+Nqj/qHD50+Tf31VaFTbVShxPnd6
         XnesUcjCoByG2BE/gzgqdpM6Y54XLdeOzFEShpTv5hBDsgZivTWaw/fbABSEGljI1s+I
         P6rg==
X-Gm-Message-State: AOAM531ANa+0khvJkZCmWeyUAhmDX8GCrbx6Bzr9//++Eat7MoyqPvUy
        TSySZyEU2HshQTg1zDRVkvU5g7+YHj8=
X-Google-Smtp-Source: ABdhPJzO8dFibZF8ffiRhmA02XmUwk68h2Ttg+h78R8AVyy1bVZEBtCXrDwj7oJUMXujvoqrBE+AMg==
X-Received: by 2002:a5d:9051:: with SMTP id v17mr5747470ioq.88.1596238402742;
        Fri, 31 Jul 2020 16:33:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t18sm3336758ild.46.2020.07.31.16.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 16:33:22 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/4] worktree: retire special-case normalization of main worktree path
Date:   Fri, 31 Jul 2020 19:32:14 -0400
Message-Id: <20200731233214.22131-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.203.gce1f2e0ef1
In-Reply-To: <20200731233214.22131-1-sunshine@sunshineco.com>
References: <20200731233214.22131-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order for "git-worktree list" to present consistent results,
get_main_worktree() performs manual normalization on the repository
path (returned by get_common_dir()) after passing it through
strbuf_add_absolute_path(). In particular, it cleans up the path for
three distinct cases when the current working directory is (1) the main
worktree, (2) the .git/ subdirectory, or (3) a bare repository.

The need for such special-cases is a direct consequence of employing
strbuf_add_absolute_path() which, for the sake of efficiency, doesn't
bother normalizing the path (such as folding out redundant path
components) after making it absolute. Lack of normalization is not
typically a problem since redundant path elements make no difference
when working with paths at the filesystem level. However, when preparing
paths for presentation, possible redundant path components make it
difficult to ensure consistency.

Eliminate the need for these special cases by instead making the path
absolute via strbuf_add_real_path() which normalizes the path for us.
Once normalized, the only case we need to handle manually is converting
it to the path of the main worktree by stripping the "/.git" suffix.
This stripping of the "/.git" suffix is a regular idiom in
worktree-related code; for instance, it is employed by
get_linked_worktree(), as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    This is a followup to 5f4ee57ad9 (worktree: avoid dead-code in
    conditional, 2020-06-24) which dropped dead code from the manual
    normalization done by get_main_worktree() but which did not
    eliminate the special cases.
    
    It's also a direct response to Junio's observation[1] that it would
    be better if we didn't have to handle these special cases in the
    first place.
    
    [1]: https://lore.kernel.org/git/xmqqbll8569x.fsf@gitster.c.googlers.com/

 worktree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index 355824bf87..62217b4a6b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -49,10 +49,8 @@ static struct worktree *get_main_worktree(void)
 	struct worktree *worktree = NULL;
 	struct strbuf worktree_path = STRBUF_INIT;
 
-	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
-	if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git */
-	    !strbuf_strip_suffix(&worktree_path, "/.git")) /* in worktree */
-		strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */
+	strbuf_add_real_path(&worktree_path, get_git_common_dir());
+	strbuf_strip_suffix(&worktree_path, "/.git");
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
-- 
2.28.0.203.gce1f2e0ef1


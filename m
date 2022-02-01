Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D844C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiBARcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiBARcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:32:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB31BC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:32:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c24so36223391edy.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ssg33W7kXYsc9/KpIIX8vAGhxEYktmDBsy4rx3jjCXU=;
        b=CVY8ysEwVvDEsu9DzKdtjt1hR6RuOdmtCyqNhJLjBBUHFMndVffQ1u46hi7NtjWyuK
         bkeF1tofhwj9mHGWrXFukqGBlyAH1M7nSrCS4j0a8CRHQM3Itu5dpPJYu3YufWAAmlwR
         1XPch74Tj56+UTJOZuIeRVMRGU3UE9rUsjBq/o1EXaFkmIgANUhxMRs95dGCfqbGDtWC
         TI9aL/p+nyPN386Va6ivlTKXdtsTax8Ew1lzj98z/jHhTBJVXzP8nKlXeaZpNcgGMFkQ
         VAMXlaee0wXnHsrxznoIEamY97ALaDLP7Xa7osgnclePKuxzP1Xr9MUA8kqvYFIfxxMh
         zyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ssg33W7kXYsc9/KpIIX8vAGhxEYktmDBsy4rx3jjCXU=;
        b=MEDg5V3YICyLxld2wx7eWTpjj8Mk39m9GLyB6KIWTX5uY/y26G7R0VjwhaPDlCnZVl
         3THXTFzEI8PMzIsl7RxbImV27Xs6TqerLuHGguorU10Wz8gX2wwOmmq29s9/HW5oPH6l
         i2THtgWXUy26GVM/n67eNPHe0+OSFoMQukBHYrrAlAwGhY7Kt2s9gVHIYmMlwOplO7zJ
         fkSxIhzaiosm8gt/CMxnWA/2CvFyztYFPjOGiJJHrLopohc+HLkli4lvCZmbjwiQnglL
         Xx/gi9mxRIBclSQPjw04CzcfLY3Ma+DcWwPzcQeMf2+uK8/KUA3mu0zclwSTatbs6n3L
         graA==
X-Gm-Message-State: AOAM533llOW5PPIOsqcXB0bkXoc2YR1RL1UYqhQtfuYXEItGqsiliFfy
        JiIhln2ei5lxGRR6PuBtjlE=
X-Google-Smtp-Source: ABdhPJwqm1WgKusGpkNtKSt9jDUVLHBaih/bE5+xfHUuNOTM/p1rklvxxjNf5MhLsGz2b9YVmpCF0g==
X-Received: by 2002:a05:6402:2066:: with SMTP id bd6mr26360292edb.364.1643736722439;
        Tue, 01 Feb 2022 09:32:02 -0800 (PST)
Received: from localhost.localdomain (77.119.174.203.wireless.dyn.drei.com. [77.119.174.203])
        by smtp.gmail.com with ESMTPSA id m16sm11245160eji.110.2022.02.01.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:32:01 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH RESEND] subtree: force merge commit
Date:   Tue,  1 Feb 2022 18:26:04 +0100
Message-Id: <20220201172601.262718-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.35.0.295.gee0e44bcb6
In-Reply-To: <xmqqpmqy12u0.fsf@gitster.g>
References: <xmqqpmqy12u0.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
fail with error `fatal: Not possible to fast-forward, aborting.`, but
the command does want to make merges in these places. Add `--no-ff`
argument to `git merge` to enforce this behaviour.

Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
Reviewed-by: Johannes Altmanninger <aclopte@gmail.com>
---

I think this was meant to be queued but forgotten.

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  I'll drop these two reviewed-by lines while queuing.

Changes since v2: removed/added reviewed-by trailer

BTW is there a good way to tell "git send-email --in-reply-to"
to prefill "To:" and "Cc:" based on the message I'm replying to?

 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 71f1fd94bd..1af1d9653e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -975,10 +975,10 @@ cmd_merge () {
 
 	if test -n "$arg_addmerge_message"
 	then
-		git merge -Xsubtree="$arg_prefix" \
+		git merge --no-ff -Xsubtree="$arg_prefix" \
 			--message="$arg_addmerge_message" "$rev"
 	else
-		git merge -Xsubtree="$arg_prefix" $rev
+		git merge --no-ff -Xsubtree="$arg_prefix" $rev
 	fi
 }
 
-- 
2.35.0.295.gee0e44bcb6


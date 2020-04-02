Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4330AC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1316D20857
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro2GqpYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgDBInE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:43:04 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54624 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBInE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 04:43:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so1260181pjb.4
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Et85pOCbGmXdzJ+o5qkMnmBFxKD2L5uERNuIJuVRXKA=;
        b=ro2GqpYvEJEUZ/50kLGGmjKUdd22APvoERs+o3UjPBZ+z8B0CF6fsJZS3tnduBnswj
         npEEkploUrnD9rG+SkYCYbt5WUhWj/WV1MIylwBSWQdAI0bzbq+LSaL+KQtFreYFUcAY
         sUGjT9A9x4u9E9JF+sHcst8tfA1p1hHFJlMkfmfG/LpHbIJ/9hsO/zMDDxmTpOmHPCg5
         BbcsX71js8aAoQD066hjpk6sImAFtUKPKvOwR2qWjmXvUUjfXr39EIRKO0o/rJ48c3B6
         CHWXOoRNxYpuiDTMBPN6S6A1vnOu2DC3GsJ1gcfX7/L94hPxZjtf86YSgpMm78JN9ls8
         FB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Et85pOCbGmXdzJ+o5qkMnmBFxKD2L5uERNuIJuVRXKA=;
        b=gVDeUGQYFhK1I82lAZwME3Kn+X35lYASsIBnk4crec2/5ts15GzGI1O60o9bPh1ZC/
         nR7h+H3lFQedhBPiw44mjcnbIyAUC3dYAZYMIExyetfPcLReOibHi4NhDbSuRSrfFP4+
         sw+DxkvsRfvGJ8NJpQSj2DCXGb7eEAmX6/rse9Npo5RLIREMFOziFpFPPD9xoINKRHYM
         qkCogsnFEbWDkkJujJ5K97+Ckcd/sOXioST0gRMUx4tN7ahgsNqyJ/6h16Ro6PmRhEM2
         RckLbaQOkGYJmbGqm108LLDWW/phKVOwndWJn04jRv5JV53CZGsgP/CTZJ6ypM5u02Eg
         IBIw==
X-Gm-Message-State: AGi0PuZdTzGUPLrLW7jUqGBmnLKr3VHy7dqKyoBdcitw5drEwvpNoUJq
        nHLJzv2Zujr3H/iGaZwrz54=
X-Google-Smtp-Source: APiQypII1C9TuB7+xd77KjCHyVnWPdcZiZgVbF+QKjaGEteoo98Y8ow0nUnx71jlgcXuBJRLTb8E9g==
X-Received: by 2002:a17:90b:909:: with SMTP id bo9mr2651837pjb.125.1585816982706;
        Thu, 02 Apr 2020 01:43:02 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id o14sm3189299pfh.147.2020.04.02.01.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 01:43:01 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     xuejiang <xuejiang@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] git-submodule.sh: setup uninitialized variables
Date:   Thu,  2 Apr 2020 16:42:51 +0800
Message-Id: <20200402084251.85840-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.24.1.15.g448c31058d.agit.4.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: xuejiang <xuejiang@alibaba-inc.com>

We have an environment variable `jobs=16` defined in our CI system, and
this environment makes our build job failed with the following message:

    error: pathspec '16' did not match any file(s) known to git

The pathspect '16' for Git command is from the environment variable
"jobs".

This is because "git-submodule" command is implemented in shell script,
and environment variables may change its behavior.  Set values for
uninitialized variables, such as "jobs" and "recommend_shallow" will
fix this issue.

Helped-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Li Xuejiang <xuejiang@alibaba-inc.com>
---
 git-submodule.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1cb2c0a31b..d69d24a857 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -43,6 +43,8 @@ custom_name=
 depth=
 progress=
 dissociate=
+jobs=
+recommend_shallow=
 
 die_if_unmatched ()
 {
-- 
2.20.1.7.g153144c


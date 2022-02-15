Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C5C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiBOQAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241109AbiBOP76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D6BDE4C
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h6so32894576wrb.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4j62eB1Kl2emaHdog2W10LxWoiaSgrRC86C2r+OLHCg=;
        b=WN/M7o8nakMHmAlgJh0y+LR+HUc4iCDQ4psiNjVR2Eb2HZFtyFKIITdM9nKTEhWZkz
         vVND1stjP2awv2FwYpNB1r9JmEwq1W/5+YwO6DeKlQ5AYRZd32KgrFxOMTRRPlqLX4IV
         191E2n8LXoZdWtkgNLTv/z+DuvSQavsXfiW/xlOvzpoyCebF+ZIGB3ua+tfuXvSYNBXx
         fjKx230tvI2xDTZnSTlqjhevGyn5qYdfLE3qwSv421ErX2433CPw2h1CM4mZISZtRPBw
         vYuM/K/lIufdkIZ9OMpFxjcHFxdVynkBwNVfGfBnMq3HCloEPW3C8ND80ecXpfrIZhcY
         1Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4j62eB1Kl2emaHdog2W10LxWoiaSgrRC86C2r+OLHCg=;
        b=BB77RlC/1iET7glusmRtLL6z1o18Xj8Tb1vbyAZHkINRFvW9iQBj5gKmrM4DP07c7w
         eQj3Zoexlkgev0hfhF8eF089keMbKy3dgq9o8aEP1IOCOnpPxzRXWYATHnoTXu00ida7
         sI4EgFGqrDAdkha75/SokVSCWGC8OqvRFma6vIf+8TLGVJUsQbOou5gR1PUXMJtzW1iG
         z8q2VRlkrMqsW0FFVBYFaUA0BLTchfEDAhJ9OzBLFHh82tqUbBYaW7YPI/ps+nBxF4fz
         ZoByK4v50I1w+jYKJTfz9O/ozN5U8IgTTrzCi+e7tpxsobdZSa/RepljDbM5gJ+/DNLk
         HUjw==
X-Gm-Message-State: AOAM533cgsjjuGwdObdTP9kERQS41WLAwQMfRwVe/n/s96W0+dz+DNxJ
        Bd8yLu+gIu67i/6wHAGLeI26O2glqRY=
X-Google-Smtp-Source: ABdhPJxnYFo0qSQDuvqbiL7fxwz+cPeVL8DIdhjER/uq5wcOWLMb8uJx99whkwLJ+mBRC+j/v1n1FA==
X-Received: by 2002:adf:d1c6:: with SMTP id b6mr3633233wrd.320.1644940786387;
        Tue, 15 Feb 2022 07:59:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm22004333wry.77.2022.02.15.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:45 -0800 (PST)
Message-Id: <be1672e32b24e45dd0916c92d10f077e3673ec2c.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:21 +0000
Subject: [PATCH 11/23] unpack-trees: initialize fsmonitor_has_run_once in
 o->result
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize `o->result.fsmonitor_has_run_once` based upon value
in `o->src_index->fsmonitor_has_run_once` to prevent a second
fsmonitor query during the tree traversal and possibly getting
a skewed view of the working directory.

The checkout code has already talked to the fsmonitor and the
traversal is updating the index as it traverses, so there is
no need to query the fsmonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index a7e1712d236..13e2e5de82c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1756,6 +1756,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
+	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget


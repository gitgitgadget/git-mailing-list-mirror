Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97675C433E3
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DC3206D8
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5XZ7ZiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHICx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICxy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:53:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1256C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:53:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so5052325wrh.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lIJ686Wi8AQ681+Y0AaT7IH17wTkCl0SzjBrEmyX2N8=;
        b=o5XZ7ZiG3ex/zGCEaWLa5TMRY8vMV6es6OiekrsaBKeAN7A3stoPNhqe3QALrMmrtc
         OqJ2aGqyu560MZdmOu5IYiEEivOuDqXwn5sChIsusKqVJbOcc7hyNM7JB4aTxQP8oolc
         YYz79IKEVRfFAEaIGX1TB+D/oCUNKttSPfQBmYAxkS77DSwoJKk4MCfO1Xgnua8k9vkA
         q5DzXhBmYRcsHLjG0JYpE2vUk06I2YF32Zm2OR9syF/nBnyOO1VaLUAD8Q2q9uOzrzR7
         JVPZ7FklKouz0TG3HBwf4QEs0G2ccJNShPsmqIyFgha5JJGKf2jVG40yoqibjBzAxA5+
         rktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lIJ686Wi8AQ681+Y0AaT7IH17wTkCl0SzjBrEmyX2N8=;
        b=P3Lk03Vgr4GcXGMFoxCHiq23PiHeVAYStP51ZkbQO2zta9hpINGQWE9lwtkmJlSRgy
         obqNebnmHhemxlkq30o+cw+qE3Qle1SiNBKokphp/oN+ZF4LmXWEU96hZWnI7NldSdyX
         mPI9GxH5Cl1PSro69+XlOwGIV6lfhJ0B6qbtRI1yc7Y3nRQU98ZqePJN6JKLkw/YAeLz
         4zvHMbe4bJ4JNRFGSOi1iThd/rHmUiQQ1t6ELXGY1CK8p/C4TOQDEJHKT6YvxPvciiqT
         fOykovqsT1TNujZlNlLHyUnZbK79ORi+bE4gbjIzbJ8KWP+Vyv2OS8Qq1mCYNTn8rVwf
         jfcA==
X-Gm-Message-State: AOAM531QBS6Iclhs+M0qpEYPn+ZcY3bQ3hqD9deTWXSaRLkJT7gPcKrY
        H67AHlojObEnEXGLyVPZaP01iuKx
X-Google-Smtp-Source: ABdhPJx2ruT6FsrVoWBvy3W8fN5ukK2zgGI19u9eraqTUnNSIhkOI7rlUEmatwVA4npT85vSSsER0Q==
X-Received: by 2002:adf:e845:: with SMTP id d5mr18757363wrn.228.1596941632343;
        Sat, 08 Aug 2020 19:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm14555693wro.34.2020.08.08.19.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 19:53:49 -0700 (PDT)
Message-Id: <cf61239f9332a9cd91110a9b6319b1133ff3bd27.1596941624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Aug 2020 02:53:36 +0000
Subject: [PATCH v2 02/10] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In indegree_walk_step(), we add unvisited parents to the indegree queue.
However, parents are not guaranteed to be parsed. As the indegree queue
sorts by generation number, let's parse parents before inserting them to
ensure the correct priority order.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 6de29cdf7a..4ec82ed5ab 100644
--- a/revision.c
+++ b/revision.c
@@ -3365,6 +3365,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (parse_commit_gently(parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget


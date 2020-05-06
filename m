Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC4C4724C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B617C20735
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AymxsJoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEFIAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgEFIAt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 04:00:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC47CC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:00:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so589265pfb.10
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jt0SOv54Q8fzlLAplV2Dzowsj5UsGTs46677UrXlCYY=;
        b=AymxsJoRiGZcMy0obk/KVl+t4/lD68Gwi3SDOM8LZS6vG3gnYVPtpzpl9WM0N1wjnO
         Ys9OFw0qgpvScwOBCujS6N2f+Ylq9yPUr1Oec28UvzFJLctI1ERfoStfVrM8lIb/JFak
         wdQlaF9kFUJ83HrKwG93ffdRYusqGw6V1e4VvvEERTQ/E+clzAQdVZh5k8ANMFOEpRhA
         cp3/DaKF9p3y9VH7p9SbL+YI1UVjf9hW0hupUerZG9+HD9PeBsePcFmhCtiO6Xv9im7N
         Sch9UmziQsUa6JFt3mWVjvp9d5g+aAPl5piq9HS8s0B6F9DZgHXBmFwMr2QQ2JsG3m2V
         7PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jt0SOv54Q8fzlLAplV2Dzowsj5UsGTs46677UrXlCYY=;
        b=h8q9CWd9WtY47SgVxu7HfQq9qMvkfcxpxEcOUB1CQir95FnmQk87rBAyQEmS7VWN8q
         YKaQSHqNNthHAu73RyfswNj8l/sJ5b/+9eYN5RCtW5zi2XH/EbxKkoOx5Vjd7OBfk1H9
         WAQ3IygsSGo6Os7les1lLvEel6xD9ULwP/ruik44FSDzS7pmbO/WjkuDKEDbVAP3eDBY
         YPmUyh5xbQGaSuoWP3UfnPGZWRE1BC1QJpjyQtrFWm8ubkMKc9KfPIj21Ym67irZp2zo
         0I6JS+r/vvFl9zzv7/fvYD8lD0+d4CTfT1v/mBLw144L4UHVkSqJHavwBh98w2cpMgy5
         M0Cw==
X-Gm-Message-State: AGi0PuYSdg1wrTX0MiZoxevacKqlP2wHjaOoY7Wy9D7kP5QBg97738m2
        /bdV+Ar5m/U9qaZv39n4LA0Fvcdz52ZljA==
X-Google-Smtp-Source: APiQypJj4IE6vAh5t9007jLW27AkjmEY75Gn47WlXMTt/ZtQSQEHkd07f3eYa0ncvO/A7mdN2kcQPQ==
X-Received: by 2002:aa7:9d90:: with SMTP id f16mr7220317pfq.48.1588752048778;
        Wed, 06 May 2020 01:00:48 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id s44sm4312629pjc.28.2020.05.06.01.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:00:48 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v6 3/4] gitfaq: partial cloning a repository
Date:   Wed,  6 May 2020 13:30:22 +0530
Message-Id: <20200506080023.12521-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common issue' section which covers issues with cloning
large repositories. Use partial cloning to selectively clone the
repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 875cfa0acd..5dfbb32089 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -244,6 +244,17 @@ I want to change the remote of my repository. How do I do that?::
 One can list the remotes of a repository using `git remote -v` command.
 The default name of a remote is 'origin'.
 
+[[partial-cloning]]
+The repository I am trying to clone is too big.  Is there an alternative
+way of cloning it in lesser space?::
+	A good way to save space when cloning a repository is by using
+	`partial clones`.  A partial clone will clone the full history of
+	the repository but will skip out the entities specified by the
+	`--filter` option one uses in `git clone`.  Any entity which has
+	not been cloned to save space can be cloned	on-demand (hence this
+	presumes that the user has an always-on network connection to the
+	original repository).  See linkgit:partial-clone[1].
+
 Hooks
 -----
 
-- 
2.26.2


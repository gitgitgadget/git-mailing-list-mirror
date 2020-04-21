Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FDC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B174D2076A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfuM18KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgDUNMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNMi (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:12:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D756C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so6741252pgg.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPGXNRz08nd5NAQZZyjrUa9x/USDr2TA+UONIpWHaEw=;
        b=RfuM18KK4xRM3pf00VuPw6RBgp5FDTZR/ON/QiNVGsq5yLbvLa6qrkD78f5dEnjf8S
         6mbHMUiXcZnvKHyTgTaH0xgGXiwitNb+y5tzbV4m4k8V8x2apmLgw4YQG1h25SevWBWr
         ztx8fFMfFXpxwxTJiNps7FyVk0kO0P7BcDR4g8c9uIapkMnKQ/Nd7ptU/kh+kCQsui7h
         Op3cb44YXo2KlDMUZ+gVpShTBfqkhTee+2BUoAUwQ1Uc+CZQkm1BwXQgy4haC2mfV2Xv
         vBJb/DQZdmJ/p49F4erZRFsqcXgBczzsmH9hlS0enz62Bafx9OQovGYzLba35IszcXbw
         78mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPGXNRz08nd5NAQZZyjrUa9x/USDr2TA+UONIpWHaEw=;
        b=Urq5f9Au5sgUqI6ZyDsUuL76x97DoiVkbfY89CMgQgRzV6wm5SK+lHSN8oaqn/nUev
         iqeyt4F/pr0ZQXJNiLyY24O8Iau6UxHUrklketdyjeLb9w4tXDJtIUHzSBkTWiE6cYff
         mYfGzTv8FImL8raGGSiQCnYuSao011SifzdnIR4X2d92tuPRas0nrGF95u5zIBTzjUxa
         2A5H4gjK1Upuan00DjprZHeD4zNzYyCHJaZCbAlVKVo3Daz08uXGTWHn/XZ1obtX8Jdg
         xpPdjw5rH7PByTLlxrHn1HfqUSaabiUpBBEowea+HMzext38WsC/B7NUk5UeEpRT+qTL
         IRzA==
X-Gm-Message-State: AGi0PuYKlDAX9ljBbB/5yu1fO8AmfSRXh978LNHv8EV71STvoWB4U0ZK
        tqniJSgEILXtswr9sf75jSCyTiPaMTw=
X-Google-Smtp-Source: APiQypLprAY4mwOwJCM37SycuY/dcE76YOkRZCQVihuK+ale8l7O2VKBnDYzjXmuAZ+rGojbhxY+3A==
X-Received: by 2002:a63:4665:: with SMTP id v37mr20184694pgk.297.1587474757428;
        Tue, 21 Apr 2020 06:12:37 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g2sm2451492pjd.9.2020.04.21.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:36 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 2/4] gitfaq: changing the remote of a repository
Date:   Tue, 21 Apr 2020 18:42:21 +0530
Message-Id: <20200421131223.29337-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository, covering various cases in which
one might want to change the remote and the ways to do the same.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 96767e7c75..13d37f96af 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -244,6 +244,37 @@ I asked Git to ignore various files, yet they are still tracked::
 	category, it is advised to use `git rm --cached <file>` as well as
 	add these files/paths in the `.gitignore`.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any). There
+	might be different circumstances in which one might need to change
+	the remote:
+
+		1. One might want to update the URL of their remote; in that
+		   case, the command to use is, `git remote set-url <name> <newurl>`.
+
+		2. One might want to have two different remotes for fetching
+		   and pushing; this generally happens in case of triangular
+		   workflows: one fetches from one repository and pushes to
+		   another. In this case, it is advisable to have separate
+		   remotes for fetching and pushing. But, another way can be
+		   to change the push URL using the `--push` option in the
+		   `git set-url` command.
+
+		3. One might want to push changes to a network protocol
+		   different from the one they fetch from. For instance,
+		   one may be using an unauthenticated http:// URL for
+		   fetching from a repository and use an ssh:// URL when
+		   you push via the same remote. In such a case, one can
+		   change the 'push' URL of the same remote using the `--push`
+		   option in `git remote set-url`. Now, the same remote will
+		   have two different kinds of URLs (http and ssh) for fetching
+		   and pulling.
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.20.1


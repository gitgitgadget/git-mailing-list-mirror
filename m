Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F245C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C3A22CF7
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIvJLwQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHFBFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHFBFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43550C061756
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 18:05:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 9so7343464wmj.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fxbI3gNG8JdTQkG5Y25d1d2hrsEBJ51XfvP7YONYgA8=;
        b=NIvJLwQECtlsLtO4HRmDIAnYztOM3hqOjQ1SVNRjUkwS4dt6z5T3z76y46Xa269ej/
         fFk2y5+CiVOsQv6JSnv0LvbvErCj//gLmdCQW0TX68+1tT57VTGvgPRkzB/7ULfFQ2FM
         advuBYpnDfs149nW3osBMNEP1RKEpIWKWBnxUNVyqyGBBRnL5OXtgfB0s083DpjdRafC
         Urqhbkg+kg4v58k2mmM0dPfSFPFDldY4Cvf/HOTy8i+xDuWVJqyLTr+j8qepEx+qXpPy
         Xqgmny3RT0UOcaE+6C5bQkNjnxiOfsQk647sI7+k9gIeL6SLJmUnyYn8drJmNJ4jp2jK
         /sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fxbI3gNG8JdTQkG5Y25d1d2hrsEBJ51XfvP7YONYgA8=;
        b=f6xnJjV0dFzF+TmMUhBQd1bDsma77ipQK8056f70ZBkQI3vrR2JJ0/SDSOZ4CMyNMS
         Ytgo8kLQUqMsG0eL0EigCFAmyZ7/HVSqzki0LctJxp0mqLcHqcaEOGJnhbdK6tRk0X2z
         6DuOKoKFzFgK7nxAK5h56ci48w9KInbBVPTlyu+/+th85vZUvrveTBz2k90tF7KpkTj0
         iODh7zefYcBjoOw53mOig4YtiUmx7JYKNcRVFDuZe4IbT7SaWhvGHsJRxGS/vGatMgj6
         K5YBoulFot2N12/jr6HdLgZDstIhbRM0FCIgJVwn9XNod6txt8vK562zCT84Xw3uHccy
         J6/g==
X-Gm-Message-State: AOAM532sWdEmoHEDsyh69XjOZZw9YodDkFz5VA3BSsDrgFH7cjs6szFl
        QOlunoydxpYBbxhoN/mzX+hAE1c1
X-Google-Smtp-Source: ABdhPJz0Irz18C17CIt7qY5sHMJ2ru55edOyDUP3Yap9lWrF0jPVYqtZO9D59o0A1f6IjeObijGM3Q==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr5814425wme.50.1596675906987;
        Wed, 05 Aug 2020 18:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm4314366wmc.28.2020.08.05.18.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:05:06 -0700 (PDT)
Message-Id: <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:05:01 +0000
Subject: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

In the not POSIX environment, like Plan 9, sh might not be looked up
in the directories named by the $PATH.

Signed-off-by: lufia <lufia@lufia.org>
---
 config.mak.uname | 12 ++++++------
 git-gui/Makefile |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7eba69e54..f3eb2b91a2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -4,12 +4,12 @@
 # Microsoft's Safe Exception Handling in libraries (such as zlib).
 # Typically required for VS2013+/32-bit compilation on Vista+ versions.
 
-uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
-uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
-uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
-uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
+uname_S := $(shell $(SHELL_PATH) -c 'uname -s 2>/dev/null || echo not')
+uname_M := $(shell $(SHELL_PATH) -c 'uname -m 2>/dev/null || echo not')
+uname_O := $(shell $(SHELL_PATH) -c 'uname -o 2>/dev/null || echo not')
+uname_R := $(shell $(SHELL_PATH) -c 'uname -r 2>/dev/null || echo not')
+uname_P := $(shell $(SHELL_PATH) -c 'uname -p 2>/dev/null || echo not')
+uname_V := $(shell $(SHELL_PATH) -c 'uname -v 2>/dev/null || echo not')
 
 ifdef MSVC
 	# avoid the MingW and Cygwin configuration sections
diff --git a/git-gui/Makefile b/git-gui/Makefile
index f10caedaa7..c47603c397 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -11,9 +11,9 @@ GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
-uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
-uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
+uname_S := $(shell $(SHELL_PATH) -c 'uname -s 2>/dev/null || echo not')
+uname_O := $(shell $(SHELL_PATH) -c 'uname -o 2>/dev/null || echo not')
+uname_R := $(shell $(SHELL_PATH) -c 'uname -r 2>/dev/null || echo not')
 
 SCRIPT_SH = git-gui.sh
 GITGUI_MAIN := git-gui
-- 
gitgitgadget


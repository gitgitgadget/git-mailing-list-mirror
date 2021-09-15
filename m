Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05200C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDE561185
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhIOIMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhIOILh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:11:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5BC061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 2so1627417qtw.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/7sUsd7sXBB4TyNldi9psar4Z2EeHkW+mTAth3OCRc=;
        b=MbykRhql+2bYLS8w3awGKnSq0FITvZSmCImD94RB+MFTC0/enj4nKIwl3CrbDn7Omg
         eNimuslWcJ62XJl/wWReC34AqWKPDpLWQX7/xYCLwcxksFD1rnz082Voa0hxqqBLMavM
         qgzQ4jtUM3rJ+Ic53RtopaQp7QTiRosrg5CzF8AnbwVWga/u7pkot5YBh2H3/wSUm3IK
         ZOCXhbd9ei2e6y1Wfuu/7zudgExSpCAMJfLpvnrPRIdjrT9RAmoQsZTRQXiFrdadBVOA
         WhvL4l8/pl42tfEurB8RQa69L7smQdR9ScYhZK89XcWukGtBatcqGIMkySXBMUDvzUIJ
         nxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/7sUsd7sXBB4TyNldi9psar4Z2EeHkW+mTAth3OCRc=;
        b=BGpvbPHKKx1jcaQ6P5uwbjlEnF4GibS8gl+MR2BX4/tSxrAvP0yd3iTqNy/5To4ze3
         /VMUi7rvV+jedDcNRyp7ZFbc5HT6yEzrOuaRYwgenwtBUgNl0df4P0wIJE6P9oqlNKyr
         n21KW46gIx9W1H3F5Nf8+LLVcd31dJsev355GpR5aMc+GiwnxfKFkqsNS23qmH2mtjWb
         cHzaVqJYICdk47GUsIxIuAR59tMRCUrFednQ+WjsMIsxVW+svjrNZL1+K5WKtlXrG6Tl
         5AwauR2RlLrq8B/7x/flXexARCgk+GcdnPHFIvL0e+4vSRjzlIex+9o1FxWaedp3hHjX
         8Nsw==
X-Gm-Message-State: AOAM532Y9HYAgybR+TlMTVzharkMqxlhhGPGZ6JLZ9gJdk7I+elevzJP
        BUNnCGsmZ6/29Xojwhmk3QthSj+rZek=
X-Google-Smtp-Source: ABdhPJxrb1Vr3cA2o3wz+9+NsMIMpFq32v/Btj3cEgoseobR93MN55NfwkawM3bsXr+XRZLpfHsicg==
X-Received: by 2002:ac8:5909:: with SMTP id 9mr8883561qty.50.1631693404896;
        Wed, 15 Sep 2021 01:10:04 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 20sm9661435qkn.31.2021.09.15.01.10.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:10:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sam@vilain.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] Documentation: cleanup git-cvsserver
Date:   Wed, 15 Sep 2021 01:09:48 -0700
Message-Id: <20210915080948.11891-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210915080948.11891-1-carenas@gmail.com>
References: <20210915080948.11891-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few typos and alignment issues, and while at it update the
example hashes to show most of the ones available in recent crypt(3).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-cvsserver.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4d13367c77..4dc57ed254 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -99,7 +99,7 @@ looks like
 
 ------
 
-Only anonymous access is provided by pserve by default. To commit you
+Only anonymous access is provided by pserver by default. To commit you
 will have to create pserver accounts, simply add a gitcvs.authdb
 setting in the config file of the repositories you want the cvsserver
 to allow writes to, for example:
@@ -114,8 +114,9 @@ The format of these files is username followed by the encrypted password,
 for example:
 
 ------
-   myuser:$1Oyx5r9mdGZ2
-   myuser:$1$BA)@$vbnMJMDym7tA32AamXrm./
+   myuser:sqkNi8zPf01HI
+   myuser:$1$9K7FzU28$VfF6EoPYCJEYcVQwATgOP/
+   myuser:$5$.NqmNH1vwfzGpV8B$znZIcumu1tNLATgV2l6e1/mY8RzhUDHMOaVOeL1cxV3
 ------
 You can use the 'htpasswd' facility that comes with Apache to make these
 files, but only with the -d option (or -B if your system suports it).
@@ -126,7 +127,7 @@ pwhash in NetBSD) and paste it in the right location.
 
 Then provide your password via the pserver method, for example:
 ------
-   cvs -d:pserver:someuser:somepassword <at> server/path/repo.git co <HEAD_name>
+   cvs -d:pserver:someuser:somepassword@server:/path/repo.git co <HEAD_name>
 ------
 No special setup is needed for SSH access, other than having Git tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
@@ -136,7 +137,7 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
-cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
+   cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
@@ -184,8 +185,8 @@ allowing access over SSH.
 +
 --
 ------
-     export CVSROOT=:ext:user@server:/var/git/project.git
-     export CVS_SERVER="git cvsserver"
+   export CVSROOT=:ext:user@server:/var/git/project.git
+   export CVS_SERVER="git cvsserver"
 ------
 --
 4. For SSH clients that will make commits, make sure their server-side
@@ -201,7 +202,7 @@ allowing access over SSH.
    `project-master` directory:
 +
 ------
-     cvs co -d project-master master
+   cvs co -d project-master master
 ------
 
 [[dbbackend]]
-- 
2.33.0.481.g26d3bed244


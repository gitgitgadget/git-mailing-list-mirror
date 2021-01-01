Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A556EC43219
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7220798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhAACRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbhAACRW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:22 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C74C0617B1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:01 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id x203so4614318ooa.9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8mKORRpRI9fPDn2V8Zms/7N9R3NTwWJG6UpREQQJag=;
        b=IXSIhnIRDJ/DEB5Wy0R17+AUsWWaYkeRIEwI9Lu3g55JfOw/Qm/3eMvptapLnjlmce
         xQUfkYENl5sDroqm7UhTVPuHNDfrNVHh2gtSemTggOxvwi9yOWba4NXBg6ArK5jFUT1e
         t/nceR0M7pzTRNTchNqmW/JYNW5AlvOuEjPwIQqmJuDisx+ehc47tSF9X0qsmeBgh2QR
         1kNkDWgkwKIu8n1oRArAw0SJ5DVns2+CzBHNiAOExOUWUl3CiCG5LVHHmTG6O0ZWemIa
         mWF12c0/wiZ4mXZBEUu5UVYs548ADXb1kMqY+vgOAWqvWdQg6ZEaran5s6QCQ2u2GjCq
         ZGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8mKORRpRI9fPDn2V8Zms/7N9R3NTwWJG6UpREQQJag=;
        b=A688mwGF6ft//Jmn7EGqIjXba8But33LKi66MuzT0ofBcagBHWL5fP82F32+mb0NKI
         tDRd2I4CnGnP0DnR+DAuhLgyCE2LaYbTMqEY3FJ7u/BnSm/SgZjEDEZx8oC/9Jw/jcSG
         0Z6NyC/Q3s8O37FeEZLDxu4AT/7mjLHd+2x4TQ1STvGHebIxIQeB8C2tY52yAN/paaWD
         ftboGmUAbLHMMiwJwXVWazNR18quDOzyPg9dALWNxXDUtIfnCT8bmX530tSU7M30Qqed
         +Vc9Mkl/w94lJ57mla+5xrxITfTwdhB8ViB6l4Tk64Zbbo7npSLI/c5IZS+hZVc2hrly
         R7uA==
X-Gm-Message-State: AOAM533LHGSWtvKSHxXCo7zVZdIzpU4OfMaNRgHVDxV+uFO9QgLHzpGr
        QDJ6msrl5pATjSGE1Jbru+CnxiZVcZNHVw==
X-Google-Smtp-Source: ABdhPJyYx8AeY4QTuLzzMNYQKTI/Zn70+z69RbrjqeOXDvf+OKhP2DeHOANVMlahKOdCrBCZYTP8iQ==
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr39363262ooo.66.1609467421046;
        Thu, 31 Dec 2020 18:17:01 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c12sm8573791ots.7.2020.12.31.18.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:00 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 23/47] completion: simplify __gitcomp
Date:   Thu, 31 Dec 2020 20:15:58 -0600
Message-Id: <20210101021622.798041-24-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b356e3c86f..00a78039b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,9 +332,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index fbd03a0180..4eef9c5199 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -62,7 +62,7 @@ __gitcomp ()
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-...${4-} ")
+			array+=("--no-... ")
 			break
 		fi
 		c="$c${4-}"
-- 
2.30.0


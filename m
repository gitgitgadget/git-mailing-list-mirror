Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32DDC4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6BD207CD
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnQNrHvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgJ1Xp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgJ1Xp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:45:58 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD22C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:45:58 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y186so1435625oia.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZ+FG+1Hi7umcZDm3yFJ7TGD+Ohtdv4wbLuBKS06dO8=;
        b=jnQNrHvP94Lu0jRVFUlFMXVK9GIMsKjEzcftwcy6vLlu9Pbh41IBrm98Xj1tTsbM2H
         dNeKlFqC5orB80BCK4pIcnot0HBFunMzYVDIC9b7gCDG10k2McPUE6oN1FC74bTjp+ow
         6D5iS+1/yhUYtFU2kvlxqejCzn/Set0GimnL1+4/B5uXeC+j4iff7Q7YaNP9eEfnl7mR
         O+KgoAfvRBLvCt3D1Dt6k4aIKJZX46IqZttVjcfH2qWY5g14+kQKDhNUPZXjrP+moIH9
         DkX0mJEBCqvHRXP9/GFUB8ZZzqFZc+JMZkwv+WxK4pykSvo7gaBUTJhHB0dPGLnWYauT
         VyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZ+FG+1Hi7umcZDm3yFJ7TGD+Ohtdv4wbLuBKS06dO8=;
        b=PxXrXT3NdSQ/dAw9eEvYPPXh9sMn3TQkV9MV+3WQGQc6qmaBI2smIEF9kDuS4jugdz
         0HhLmrxuadS6hkVWkvQQ3iTbEzSYlLxzkRMTx+p57BJBiR5WKgmJhoTCG9Gjhglj1LMc
         I7hhzwswKkNT+LcThBOGwDJPvK55xF/DpUCQQ0z7UdPnin0fB2QVNysNpGoJXM2UcVTG
         DvjSQR9W97xhOXNFXsAzcKwEViADhfoqh7L0H6ikolPrJFm6i0XVVS1/UZTjD8AR1t6e
         TKMenQdM57tvyAbze9a97eO98yCKtVPGkQc/RbKQQZibaiIBSXidcxpe5z6yduWRU86n
         KiOg==
X-Gm-Message-State: AOAM533csyfCUpb//e1SQT4wiyH0GXv3WbigIpLePP2MRk6ReimOt/A7
        36Jh19scZk4+twAC7MiWn0yV5kE2tWWsjX52
X-Google-Smtp-Source: ABdhPJxTGCrDrPejK22/xx2HJX+dnm7b9kpxdO8rihkrNOLs0kx9wjNGcuuCGM5SPWXfl3u/PAT7cg==
X-Received: by 2002:aca:b1c2:: with SMTP id a185mr3655547oif.83.1603850836230;
        Tue, 27 Oct 2020 19:07:16 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m6sm1871353otm.76.2020.10.27.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/29] completion: zsh: fix __gitcomp_direct()
Date:   Tue, 27 Oct 2020 20:06:44 -0600
Message-Id: <20201028020712.442623-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers append a space suffix, but zsh automatically appends a
space, making the completion add two spaces, for example:

  git log ma<tab>

Will complete 'master  '.

Let's remove that extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a96ad87e7..ec7dd12a41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3498,7 +3498,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -- ${=1} && _ret=0
+		compadd -Q -- ${${=1}% } && _ret=0
 	}
 
 	__gitcomp_nl ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index ce47e86b60..2cefae943a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -74,7 +74,7 @@ __gitcomp_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${=1} && _ret=0
+	compadd -Q -- ${${=1}% } && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.29.1


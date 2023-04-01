Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C80C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDAIt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjDAIsP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398024AD1
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:24 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so11579394fac.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vka5Rqm5gCIxmGMpmzySz/PgEqPe097/HMTBjmEmj4k=;
        b=FGkOUeEyVGvGm3HuD/i0syz5uG1CuVuOb/biRzsLfXLFRkVJWMA+tcG5GYYrCDB3l0
         z0desIpEBnIZnrw4cAjPDu6memL41UAAuDkpemuaTo9u3acW1erGTgaCgGAORmZ7G4P4
         h15Sify3U8q42tL/ZOTGJyADvTPdNoPtx6DPf/Q5LaG/uc0VZ80lQOw52xYFg2PecoY3
         2bllr1DC4OUCTSYYp8vXmyQ13se6HuMZzDUMTsZ3OempmYnXjBavhQ0YKhdq815vlgpe
         v9kB1cE5YRpuDun/1l070BDt5wDwCozL4VVUgjB1bGPQdI9Oru4ldx8eKO/+SiiMsUTo
         1Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vka5Rqm5gCIxmGMpmzySz/PgEqPe097/HMTBjmEmj4k=;
        b=Cb7DdHT/gaucVmnSt9gVlFmtAewwGRzmfMJstVbVvkXiIP+v1ps9xJDoo/F8HX2tTC
         Rm+1fm02zoz+nnMHT83jgJCSRdfFDjqAr2RFtsBrqmQVWaaCFYQ/K0xCNcqjJpfk7JQq
         FJcf5gm9zRpmEVpAuVGFqmP/5NbyRFCxL7c/u4ehBG55MjnioRMu0gh7YgvMGMewckcV
         +cdVAZzRBgVTI12/A7yaUrXwdIRZI/Rq6TNGjU88gEK0qkmZZdFLKAMgV9ra92y/1xZt
         VVXvdOB5FZUNqemQAsajpyy+j1MJGmOUtos2URhusbHzQtl9cWgWIJ1uJnt6jltfAKX9
         IjIQ==
X-Gm-Message-State: AAQBX9cukGgV6nUoJCzeRC1NqgYhchoCBmHY73HVRr5dpMKrBPk8SWf8
        eRSHaCp0AmvSvJKSm3u/n1lWAAm+2dU=
X-Google-Smtp-Source: AK7set8ZBA+G0PLv/RXUI6C9ZTlav6IaT9iyHFv3vqkf6ZTa4UsenN+sLEdBxEVRdbIsZysL2fedeg==
X-Received: by 2002:a05:6870:47a2:b0:177:97ba:2ec4 with SMTP id c34-20020a05687047a200b0017797ba2ec4mr16760692oaq.3.1680338843872;
        Sat, 01 Apr 2023 01:47:23 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id zq42-20020a0568718eaa00b0016b0369f08fsm1736611oab.15.2023.04.01.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 41/49] completion: zsh: fix direct quoting
Date:   Sat,  1 Apr 2023 02:46:18 -0600
Message-Id: <20230401084626.304356-42-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently using "compadd -Q" is almost always wrong, we want zsh to add
quoting when necessary. However, if we remove the -Q option, that would
make zsh add an extra "\ " at the end of some completions.

We can manually remove the spaces from the completions that have them,
and then add the suffix with the -S option, thus there's no more need
for the -Q option.

This makes completions like "stash@{0}" complete correctly:

  git stash show <tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index dc04c5b703..e2a7f55539 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	emulate -L zsh
 
 	local IFS=$' \t\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
 __gitcomp_opts ()
@@ -85,14 +85,17 @@ __gitcomp_opts ()
 		fi
 		array+=("$c$sfx")
 	done
-	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
+	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	# words that don't end up in space
+	compadd -p "${2-}" -S "${4- }" -q -- ${${(f)1}:#*\ } && _ret=0
+	# words that end in space
+	compadd -p "${2-}" -S " ${4- }" -q -- ${${(M)${(f)1}:#*\ }% } && _ret=0
 }
 
 __gitcomp_file ()
-- 
2.33.0


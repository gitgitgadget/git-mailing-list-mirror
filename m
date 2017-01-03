Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0DC1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760569AbdACSbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:31:51 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33560 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbdACSbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:31:45 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so78089781pfd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57ZiQLVkdbYXBJyaf1OpFEQx+wANPqTa39iNJf8xias=;
        b=CS2UYnfNX7z69TpT3asB4u6XjyLiVqdivoZ+3jao9jEA3Icde27qF1Z0Z7ko9+iCHM
         FRrlyKUYZ7ho6KZItCHYlwL4LjmNsB9SMYh8UkbAbPY9MVD2vQ5PkdK1Q4Ptr5uOi2fg
         326Wa1e8+qhoNrvnwb9L2DSKWKc6nAu+XNTtiLw8iTruhCQ6uqw0GCB13RxLmcymn7lK
         Goc8ObUB6Y9+MRhDksCnLrEM3LvIvKhPu7Rtn2NRijbfGAU0PTtgA/KPVMirVb2q1EhR
         kDhQHyHJeK6LyEvmf6QLiWAUqpMjJhRcmEYMlaIMpxp2ufEIUhoa+wDYdrPqVC+Be3c4
         S+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=57ZiQLVkdbYXBJyaf1OpFEQx+wANPqTa39iNJf8xias=;
        b=UrB86L3Lox+Q2CUtgUF2gd55/enVPoKUAPgmMetkqCdr59GSrm0DgU3IVZD+MEi69W
         aDNRxCWQvCtnTrCd5MAN0nTkIQs1cfbJj780fIeAsve5dSQxRKvi+NZWKdoeXkMG70eI
         Tb3Bi2qpxNvjeNudmgMaNvtz+L4UlMarsj9NllPP3dZdZDW+qCFg66N+bU175Qhs/MMx
         L2k8RJqZzCNSRV5bQUQ32chTGOZOxw4+BtxcdW/O/EBp3lkDv7ypa1OXkt/CUkqTa2DL
         mgLI18MYC57LL7ppWmUPk0yWp9+SuTguMkwNBffpl++mC/epq70nt0QoUaRLxrFY5osL
         Hruw==
X-Gm-Message-State: AIkVDXKQdrnYpBZJaA0EpUP9QuktVTj+6p/yeRAYphHw8zDHB2sSvjaw67D6YKoyfqfqqqyL
X-Received: by 10.99.1.132 with SMTP id 126mr117531149pgb.129.1483468258408;
        Tue, 03 Jan 2017 10:30:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b58c:264b:e559:128])
        by smtp.gmail.com with ESMTPSA id l11sm141456455pfb.28.2017.01.03.10.30.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:30:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule.c: use GIT_DIR_ENVIRONMENT consistently
Date:   Tue,  3 Jan 2017 10:30:47 -0800
Message-Id: <20170103183047.17968-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.g8b4ce6293d.dirty
In-Reply-To: <6dd0a31e-d877-5311-37ef-313ed9ab9716@web.de>
References: <6dd0a31e-d877-5311-37ef-313ed9ab9716@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In C code we have the luxury of having constants for all the important
things that are hard coded. This is the only place in C, that hard codes
the git directory environment variable, so fix it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

v2:
  argv_array_pushf and realigned.

v1:
  Signed-off-by-the-format-patch-config ;)
  
  This is the only occurrence for "GIT_DIR=" in C, but what about ".git"
  git grep "\.git\"" *.c finds some places, which we may want to convert
  to DEFAULT_GIT_DIR_ENVIRONMENT?
  (mainly things that are newer if I can judge the places correctly
  lots of submodules, worktrees and the no data in ".git" bug AFAICT)
  
  Thanks,
  Stefan

 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index ece17315d6..973b9f3f96 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1333,5 +1333,6 @@ void prepare_submodule_repo_env(struct argv_array *out)
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
 	}
-	argv_array_push(out, "GIT_DIR=.git");
+	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
-- 
2.11.0.259.ga95e92af08.dirty


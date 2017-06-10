Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29331FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdFJNkr (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35163 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdFJNkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id x58so19592428qtc.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKmKHzMAc/tIiemECX0M94DRbIQtf3RAwT6/0njzRqk=;
        b=PVFX5k3kqJZpUT6P1dTq5I0b3KFDR0AWHgRo6uFx4TXbszxd+E+lbSxTTEMfQWhlZV
         QdUhim47ecewCjkm6Y8j3TRNwfGMtL5k3lmdCjplB9qs/EDCCFStZzr5Gz2h9aeKJZTK
         D0hr9STvfTPCH2EXTMxXwutGyVbaCso//rS0/Uj5mQT0faJnDeRzHGdPaVdthWBdwtrO
         TeWLxbQZkxjWGhhmrMf/epnlM8F6rSdLHZd4y4jknlQV0PxJFmZ1BPJCfTeYpSR1iK4d
         6PkXeYo/6IZFVXejSx/qk57oLibo6PNE34Q23YVG5q0qF/0diJlS7GY8b3cpgH1oXwro
         Pjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKmKHzMAc/tIiemECX0M94DRbIQtf3RAwT6/0njzRqk=;
        b=cfvbq2qjqN9HytV/W5BTX+4uBmQwga4eOj6XE0GVfe+4Te5nncunuHSD0oQ+clN3q5
         1uSHjzvlvIk0zaEuRoMWedGWME5YxqoArgWFkxa3Jyy995yajrf+ECQzBixHPtYFlysg
         ZNuRTCjWsE2MWs+mNSua0NUDaxhVweSAOVXDuvDPQn/No7AN1sgTjqqTQVuI0tO2JhLH
         rrBTO0LBih4456d4tLoTjNXgbNDHo3TkZUb3F1juWNAm2bLr6QBM2wpFktZOkS3lOzy3
         8aBFI5seulnMLRnqjS21W4m+aGxNmBba3hsdrW5/+szXJlQtSNO26FT9J+yl9Z7BrE7D
         JlCQ==
X-Gm-Message-State: AODbwcC2vFlhLqRmiN9uMIT++V/NzSotDzC87ziY0nsXe0HcIlIrDRwB
        kvIQzuu9ESqgYnY05Yw=
X-Received: by 10.200.55.98 with SMTP id p31mr54038257qtb.64.1497102045506;
        Sat, 10 Jun 2017 06:40:45 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:45 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 2/7] dir: make lookup_untracked() available outside of dir.c
Date:   Sat, 10 Jun 2017 09:40:21 -0400
Message-Id: <20170610134026.104552-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the static qualifier from lookup_untracked() and make it
available to other modules by exporting it from dir.h.  This will be
used later when we need to find entries to mark 'fsmonitor dirty.'

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 dir.c | 2 +-
 dir.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9efcf1eab6..5f531d9eed 100644
--- a/dir.c
+++ b/dir.c
@@ -666,7 +666,7 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 						    struct untracked_cache_dir *dir,
 						    const char *name, int len)
 {
diff --git a/dir.h b/dir.h
index a89c13e27a..75655ebe35 100644
--- a/dir.h
+++ b/dir.h
@@ -354,4 +354,7 @@ extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git
 extern void relocate_gitdir(const char *path,
 			    const char *old_git_dir,
 			    const char *new_git_dir);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
-- 
2.13.0


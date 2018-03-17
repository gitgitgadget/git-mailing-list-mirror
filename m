Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB771F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeCQWUc (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:20:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34861 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeCQWU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:20:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id 5so9111495wmh.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nXG+FGVatg8zKFJuaUxk42EVDqGzovL5SsgKwe4Fag4=;
        b=DVElHqBOnckPmRvAhLQpaSRfXwQWAP1yAdLes/4shTg4X2FbFDaLwfnfDuXEIme+mi
         WFfDkXfGgpsFHkAijH3GQEDS7kg+1AY4nDPyvpsx4yQ3nXn89ac1n+9xXk3TVUs3C4Ao
         VtebJeIjXWtIR0NzWJ3PupYRfAcKbu9ajHmnyg3qzu/E17DzFkVYiI4UC0EJWKfbsFk7
         ej8FZ+otuTW7qt+JTP4TImHt96dTvEm13KwZuNK3nHs3PNfpctle0PRiRaFV9MWLKQn8
         p6LjXtUPJoxF3mZ712bgr540Xap73fpOQC51JJp4H1TTG65oah6e6eoWt8impyj2sgGs
         tulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nXG+FGVatg8zKFJuaUxk42EVDqGzovL5SsgKwe4Fag4=;
        b=YqH6BX9NmPLj1WVWJsZ7EwxNCC2qM17aE1UeN1uc6sGDrhBRHY29xtnJYGfKkLFUza
         XO3U2lCpAmtj/+gnz9YlFQjkYjL+9VxJLTugK4cY3ha9AGuavJ3n3sMjDbnkckA2jJ6m
         x3DKHx+jCW+yXRQf8+sviAzAwG58rYqufCSkee513OCqFjPzAYj2vAyQCOrVKy3zv2lM
         HeqbPRCgISsRcTT7mj3BIYN/N18tA+zwf0SOw9+gEs399xvwrKRghEzRyTU5zeEf3+T0
         0l1SRpdx7ki0qklIeAgwjIqv+Z8vdeA7BSQ3SAMWlkE9Z4iM5sqpb/ybYA4tZeINbC41
         9ZBg==
X-Gm-Message-State: AElRT7HIHUyWTUcsKJyiS7BdvQTGuKygIP9Dp3DwTfhb3q8et/wwF8L/
        d4azoXTUBp/fxv5OTx38LQtj/uZI
X-Google-Smtp-Source: AG47ELvAeJe6xurDl+x+cS0ywqlt3feRLLif+3SWoIZpoNGmEUkTZlIJo0aPdkosBNeVj7iUm2FIrg==
X-Received: by 10.28.159.209 with SMTP id i200mr4584659wme.87.1521325227274;
        Sat, 17 Mar 2018 15:20:27 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b81sm8145619wmb.36.2018.03.17.15.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:20:26 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 2/4] worktree: be clearer when "add" dwim-ery kicks in
Date:   Sat, 17 Mar 2018 22:22:17 +0000
Message-Id: <20180317222219.4940-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317222219.4940-1-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no indication in the "git worktree add" output that
a new branch was created.  This would be especially useful information
in the case where the dwim of "git worktree add <path>" kicks in, as the
user didn't explicitly ask for a new branch, but we create one from
them.

Print some additional output showing that a branch was created and the
branch name to help the user.

This will also be useful in the next commit, which introduces a new kind
of dwim-ery of checking out the branch if it exists instead of refusing
to create a new worktree in that case, and where it's nice to tell the
user which kind of dwim-ery kicked in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e5d04f0b4b..2266c132f9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	if (opts->new_branch)
+		fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
+
 	fprintf(stderr, _("worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
-- 
2.17.0.rc0.231.g781580f06


Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE890C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9575820855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oieCRlK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKUApy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:45:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42745 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUApx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:45:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so626581pgt.9
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5/QjjM4hJEQ864bRh5vHngUlDOY3Ar7wdN15yIavUs=;
        b=oieCRlK+T9YSZhfk5JA2nJHeCw9Kbol9aQDoais+Vj/NqYo0DNxG+gsJ69agyVM/pB
         07YOW/rvOX4pnUfDQd/xczCmQV/dMZwrg9jlWEY3QqvRzPTxhQCVn581PPF3/B/to9nL
         2AhmskMnsNvAHqVFxKE4wKjsy1QTOIeHzi7CXfhiaThq0YCPz3u62XXEaqAwfsS05QWb
         zUhDsNmJUQtIz5yJtyJLGEXbKaDDHO4L1NAkbDLYKFnwhY6HCu/KUAhU0rK9+jLe7vBd
         BH5D/irEHXtg8g7pBdbo62f/BRqBakRBsbkprEzO8TJtI0guG+f5jYYDqlUMSCdyvCQC
         BJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5/QjjM4hJEQ864bRh5vHngUlDOY3Ar7wdN15yIavUs=;
        b=WffFdizwPCcXkF3kKaApsY7MGSKeUVEVkjU3RX5nJUt/PAUK21faq8uOb1Qls1R0UK
         FarP2+5JSZMovRuRt8/DsLjULnvUUbEZ1KulH/tT5Du3JtVlD/nMVtaXf86WaHcjB18f
         kq3n6Ysyfw4vtfUQeVUZ82uJFU7UWH3Fp5EioN9kJtkH5j7Kv0EfUpfmdAQKe1VmT/Vt
         IYETYRKq0SUbGF723RVKWckcIrSE2p/sDhi35I+ytQm5XsTuIkG56JyWpMcAA2FDEMJ1
         VDkvFJSs/cuiB2F43YW/FPP+iNkO7RkDEkyDf4cQtS2xBLuL42MezRdNU713jor2KeEL
         Dvgw==
X-Gm-Message-State: APjAAAUJaVL+mRLXMmFXFoJ7y/yyOdcGXo0iWFJOfCNjohLzo27e/Ceu
        emdkGZxApT48OHbC9qvh+uxyYYWJ
X-Google-Smtp-Source: APXvYqwr8yWFMNlltDUceoxwWHWI2/Djh92Wfm2uSEBTbGph6DSmW19NyG8Df+2QfNvyH+fmra1BkA==
X-Received: by 2002:a63:521c:: with SMTP id g28mr6626764pgb.238.1574297153073;
        Wed, 20 Nov 2019 16:45:53 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y11sm617786pfq.1.2019.11.20.16.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:52 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:50 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 02/21] t0014: remove git command upstream of pipe
Message-ID: <c0a513145deea51a5b216cb6344b1b3a17c54423.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the `git frotz` command would fail but its return code was
hidden since it was in the upstream of a pipe. Break the pipeline into
two commands so that the return code is no longer lost. Also, mark
`git frotz` with test_must_fail since it's supposed to fail.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0014-alias.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2694c81afd..8d3d9144c0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -38,8 +38,8 @@ test_expect_success 'looping aliases - internal execution' '
 #'
 
 test_expect_success 'run-command formats empty args properly' '
-    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
-    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
+    test_must_fail env GIT_TRACE=1 git frotz a "" b " " c 2>actual.raw &&
+    sed -ne "/run_command:/s/.*trace: run_command: //p" actual.raw >actual &&
     echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
     test_cmp expect actual
 '
-- 
2.24.0.450.g7a9a4598a9


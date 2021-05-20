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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C9C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274F56135C
	for <git@archiver.kernel.org>; Thu, 20 May 2021 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhETVst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhETVsr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 17:48:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302DC0613CE
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so26654383lft.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbQncOG/KfycyARQfcu0X5g1uj2Y12NXje0qRt++RfU=;
        b=dUHnu/MHCA1FgfVSBxUUD34ePfdKZ06HB4PyvbD5NJt2cf75nUlGk7663Fw0/XP9T3
         e9M+pJcB6/s+z1waAXiCK08dckRNRz3+URS9VX70WoAgw9E8xpwxkGXjs3yKjQQ4pxsx
         4ekPeztJyiEAHPNztC6sb9mxFruRKZDPsH9olgyZf3y4RZzaRtGnXkZzWQyfnfPsMYbj
         BtAR2JuckxmbsGn9PpwnUWAutCG9LimDpXtTAh29YMMlr7BQPrWEzjZrw1iuWqo/JkzS
         4h6wQHVhxQsrdNtey0dh1lbaSdgzTVQN9C1+wBNcLoW4FdaBvGReDbo7BzJvQWlmRGEs
         pnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbQncOG/KfycyARQfcu0X5g1uj2Y12NXje0qRt++RfU=;
        b=CGJkmY1bc8fPx1MTKlkz0aZu8ganGIJtEOI+s6wT43RKveXz7EmM2GylzhptvqSR5s
         fxBSwvhy4irMWKsJnEZN3TiAsTz05xklYZPRdsk1xUPtUciiJHVbSkU66RaewYrcLs7B
         Xw+5t5iF2IgybOI1MZl9LBL1hxXIqABF5ngjzvKWkOBhosugyk59snOSRg2PQg8Rjfh3
         VNFIOPZmxhxKAs6vi278eLjtZTv0tsig9nWUzIwDqz8rW8TDIlbKtJ2ARhTRGa+a+uPD
         6Q0LDWfFjsJkNMpYhPVgvswo7S8bDsJHW2E+h5uYLZ6Ewzl9bESjQ9FHU+eTL0vI9Iip
         xwBg==
X-Gm-Message-State: AOAM532Y4xWOG8vW9SsJzql6T27ddR2wvvuY4nyxTYkyzcCM/S/cwGRL
        o5oIB8Ab2oa/vDKRpEp8TFg=
X-Google-Smtp-Source: ABdhPJwofwvKehQdtBXtNazG1FCMYIATT0p4TlV4rN3/+RelW7Fkpk/rYUWF2tWNNVev9O4NSPUhVg==
X-Received: by 2002:a19:674d:: with SMTP id e13mr4749620lfj.652.1621547244056;
        Thu, 20 May 2021 14:47:24 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p2sm408414lfh.31.2021.05.20.14.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 14:47:23 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 08/10] stash list: stop passing "-m" to "git log"
Date:   Fri, 21 May 2021 00:47:01 +0300
Message-Id: <20210520214703.27323-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520214703.27323-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Passing "-m" in "git log --first-parent -m" is not needed as
--first-parent implies --diff-merges=first-parent anyway. OTOH, it
will stop being harmless once we let "-m" imply "-p".

While we are at it, fix corresponding test description in t3903-stash
to match what it actually tests.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/stash.c  | 2 +-
 t/t3903-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index d68ed784d2af..fe8e97428808 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -761,7 +761,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
-		     "--first-parent", "-m", NULL);
+		     "--first-parent", NULL);
 	strvec_pushv(&cp.args, argv);
 	strvec_push(&cp.args, ref_stash);
 	strvec_push(&cp.args, "--");
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5f282ecf6175..873aa56e359d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -859,7 +859,7 @@ test_expect_success 'setup stash with index and worktree changes' '
 	git stash
 '
 
-test_expect_success 'stash list implies --first-parent -m' '
+test_expect_success 'stash list -p shows simple diff' '
 	cat >expect <<-EOF &&
 	stash@{0}
 
-- 
2.25.1


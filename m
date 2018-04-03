Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB151F404
	for <e@80x24.org>; Tue,  3 Apr 2018 04:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDCEbY (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 00:31:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36313 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDCEbY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 00:31:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id 91-v6so7245006pld.3
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ujlfoNn+1yUEonWglv8eeiK9Y9dTN2p6SstLE2jYCM=;
        b=ke+MuSIr+6k6sdoDkkuAUY42erlxEbGUMCBR3iQa3Cwp121plmOFB+aQGwR/1LFX9M
         zlzIOivRIurfgL1qaky3WtIvqQGw7iIkoLGPp97iSt44UK76YAKnx1Cv1JvKwvfslHla
         /uXqwl55JEfVD0JXzYpJFmuIN+4vVPzbP9W74A2vY00YAxU3v7wed5g4pNLWJ7v7GqLL
         QmTYaIiWpEzoM/RWcJOQZ6XuKQ95fHEUP643i47eFo0SUyuo2wjdIhzjU9ZVZqw9GiXa
         FrAeDlP7pfMyi2XmjClcvyAgNxgk0TCvvAX7wOVXvC3Nl5Kkv/1o6i2bXQXxNkAjv0ql
         0cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ujlfoNn+1yUEonWglv8eeiK9Y9dTN2p6SstLE2jYCM=;
        b=Jf41sh/irQzUJCPNG+qfqmgS9E6KsjIqddY+S+H6WAaVU95msIdhTPFUq3z0tGSPd9
         p1oM4sR3D0Cl/VmeodfVOLFrdyw1nehB8yFFK5k8pQZpi74FQ9hwq1uvNQxT+OHFgQYo
         wzrqkfbILiFH+NZouMlML5/UrSHKx6K+y5OHLsrZH5TnzGICWADODtk3oDY3XJ99gENA
         vmj6miYoALEsOLZURkqHv+2zZ9qIRl5VrLdpHHbWtOLLOL+IiAddTgopQSudD6+k+i6W
         +NdxEI9teGO1JhyrDfYWNd4wdJ2Ct9qGhjcu1vufbDTPg8GweUrHoMWzgy4QqfWPpDvW
         CivQ==
X-Gm-Message-State: AElRT7F60Nt6fqxbTdnp3+w4WF1db+h3OqzY911WOfYLtYVi4/VbRcIe
        1y7x1BR5khBqxiSkjDA19rnegQ==
X-Google-Smtp-Source: AIpwx4/nsgBvbABuDrazEXLpQdVVT5yXYqbHZuzokaccTVIpGAW98b09RXXRslISXGBpgeBQvD2Xuw==
X-Received: by 2002:a17:902:bc45:: with SMTP id t5-v6mr12448552plz.343.1522729883164;
        Mon, 02 Apr 2018 21:31:23 -0700 (PDT)
Received: from localhost.localdomain ([157.50.37.209])
        by smtp.gmail.com with ESMTPSA id q62sm3363163pfd.61.2018.04.02.21.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 21:31:22 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] branch --list: print useful info whilst interactive rebasing a detached HEAD
Date:   Tue,  3 Apr 2018 10:01:00 +0530
Message-Id: <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing interactively (rebase -i), "git branch --list" prints
a line indicating the current branch being rebased. This works well
when the interactive rebase is initiated when a local branch is
checked out.

This doesn't play well when the rebase is initiated on a detached
HEAD. When "git branch --list" tries to print information related
to the interactive rebase in this case it tries to print the name
of a branch using an uninitialized variable and thus tries to
print a "null pointer string". As a consequence, it does not provide
useful information while also inducing undefined behaviour.

So, print the point from which the rebase was started when interactive
rebasing a detached HEAD.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 ref-filter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7..db2baedfe 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1309,10 +1309,14 @@ char *get_head_description(void)
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(&state, 1);
 	if (state.rebase_in_progress ||
-	    state.rebase_interactive_in_progress)
-		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
-	else if (state.bisect_in_progress)
+	    state.rebase_interactive_in_progress) {
+		if (state.branch)
+			strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+				    state.branch);
+		else
+			strbuf_addf(&desc, _("(no branch, rebasing detached HEAD %s)"),
+				    state.detached_from);
+	} else if (state.bisect_in_progress)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
-- 
2.17.0.rc0.231.g781580f06


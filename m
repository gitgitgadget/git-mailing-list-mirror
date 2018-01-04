Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749871F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeADWw7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:52:59 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:41455 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeADWw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:56 -0500
Received: by mail-pg0-f45.google.com with SMTP id 77so1272191pgd.8
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8qGJtj1PDGQSVH9vFt1CtKdKyr18YKA6JHMNcY0TUfg=;
        b=VwIMcw3cn3LEAZjwNwQ5Ogo1rH+d1r0vP4I56NT4wj96PaY+Y2P3znfYw5XlpocT+N
         NCXg7v96w0pwxpCBmNCQYJEwMIFpEA2/PCRSXhClZFNfKz1I79JTwnKd2RXpHtFRgQCH
         lfTemBR1bDsMtCoIlJoSHjj3fX+7Mi04O3WFEv8dzO1CUxECCqShrh+484EsB3hUtfAZ
         4J1p+N1Z2cn27DV+8wpDOuptZGBrTk/bCPWuqKQSEO6/1gHNrlwYhkn/MEcYFnKsoZEU
         WjGTT3qn9/nXOY5YBJdVc9YcZdG8RWkgKqJvRAu54cF3Gza8FQBOYdmTk/sZcHu6nxMx
         FMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8qGJtj1PDGQSVH9vFt1CtKdKyr18YKA6JHMNcY0TUfg=;
        b=UpqZqfKlP3R78aAQORMkJip1KeX8A9VfZChQVSa/4wp1jMpRv7tCXR++Bcz5REnQ+X
         Y8Igg3cp1c/451Zc8jlrDbig0pm/gOxp1LpWp6PMYfIpojnr2G4DUd2RFo+0aFoLCGLx
         b3lavI5b3o86U78OG4y2mynau/AwKAoH3irUBePz/SM9wYRA80ew+Lpomfd3EQT6LBcn
         xzPpiYeEeZk0vcfkgcPSCnCxRtFDlrUU1TYC9inhnxvlKlBxcgsaKZ5mdngTsTXr6gst
         iiwohXsROSP1uO+6VxbAU1wuP9Z2CjKE06fdmBDH7j3NUqoaEs2Ahl//6XyB+X01vmM0
         uehw==
X-Gm-Message-State: AKGB3mI7f/7CEuoMdWcelcep6lvOu9bZXhlHw1GhQgNL3Il59Xc4jZ/q
        U5d+TU6jX+W6YyLCB6Dss+lnYg==
X-Google-Smtp-Source: ACJfBou4ohc9BdgE2+4iqaS1ZE7rhPqzOPlbheSEm0Lu3GdcAXKYG8gxdlj2dHZAzMdQXJhJ4WdjYQ==
X-Received: by 10.99.112.75 with SMTP id a11mr848477pgn.140.1515106375704;
        Thu, 04 Jan 2018 14:52:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id x3sm7473478pgv.73.2018.01.04.14.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:55 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 5/6] diff: properly error out when combining multiple pickaxe options
Date:   Thu,  4 Jan 2018 14:50:43 -0800
Message-Id: <20180104225044.191220-6-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104225044.191220-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
 <20180104225044.191220-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f506b8e8b5 (git log/diff: add -G<regexp> that greps in the patch text,
2010-08-23) we were hesitant to check if the user requests both -S and
-G at the same time. Now that the pickaxe family also offers --find-object,
which looks slightly more different than the former two, let's add a check
that those are not used at the same time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c             | 3 +++
 diffcore-pickaxe.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a872bdcac1..42858d4c7d 100644
--- a/diff.c
+++ b/diff.c
@@ -4123,6 +4123,9 @@ void diff_setup_done(struct diff_options *options)
 	if (count > 1)
 		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
+	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
+		die(_("-G, -S and --find-object are mutually exclusive"));
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 72bb5a9514..239ce5122b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -251,7 +251,6 @@ void diffcore_pickaxe(struct diff_options *o)
 		}
 	}
 
-	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
 		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
 
-- 
2.16.0.rc0.223.g4a4ac83678-goog


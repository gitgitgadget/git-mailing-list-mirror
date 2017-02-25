Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8377A2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 07:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdBYHcT (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 02:32:19 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34600 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdBYHcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 02:32:17 -0500
Received: by mail-pf0-f194.google.com with SMTP id o64so1845551pfb.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=ZINw3DcE4zSxnYPh+2U9AGrnc4hrxZf3ktai7klLDV2WZTchjEphgzwyF39PNpHkcE
         bXfCmuUaUCOPiv3TJNKyzV6EzOh0hBjFqzrwv0UkYjIcFKxiVIX5SmPrk38LlYtsL6Ev
         Wfb2NPsYqMSAvB2ymxtE1p2kHMdwLu9WRuYP1+wCjPoVoQ8lo5AcU8WlWSPWvt51Aqpk
         4NBFOvyCGaQH82rkklsbMWXYPQpg2iEBjwrYq9tqCrA6fTGnY0FEmdrcXeaqbn5jzYma
         iGZdEvwf9xaVtZhSdI1szxrnp3gOfUYLc/whxBTbWlwiujnOFyNoHskGVTqqSDASlfwh
         wuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qydMrluMTq6MKFE5lLXU7N1NSY2ksosB24NZf5QOAm0=;
        b=Ipov82hU2wCKekLSHGIbh7e1hfMfx9fkTuEvVSD4ciWfCBT0zyG7am/b/SoGCCJE0h
         roituUd22wnDYklISrvoTOe371o9gymJx37eFmHtDxBCrvX5XegF1dRgC+8ZAmlH0cOn
         F/PVv+CHovj7ciz3uNBeQCc1NGazL5MH52KGy+EsrqgiUDLfGH2HytiGaQ7Gg4l3GtiW
         coFLjs/SN9VrE4jB4b4YEoKoupQ7PHtLz4FIFZRJdoHkmgk2W8qaly0JgFumNO08NJmd
         beb/aGbGUcfDzcj59OzbSilZnyxhBW5uaLi1E5EdM0gGpy/X9rUy6GmvF+x0WloY2SKj
         iioA==
X-Gm-Message-State: AMke39k0keKXuF6p7EaN/iAaPrpzKpcND3MVr2izr7yWimZhi2KiyAHLQ5bfRPTK6ZK6AA==
X-Received: by 10.98.137.152 with SMTP id n24mr1551770pfk.43.1488007504482;
        Fri, 24 Feb 2017 23:25:04 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id s5sm12615282pfd.107.2017.02.24.23.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 23:25:03 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 1/6 v5] revision.c: do not update argv with unknown option
Date:   Sat, 25 Feb 2017 07:24:42 +0000
Message-Id: <1488007487-12965-2-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

handle_revision_opt() tries to recognize and handle the given argument. If an
option was unknown to it, it used to add the option to unkv[(*unkc)++].  This
increment of unkc causes the variable in the caller to change.

Teach handle_revision_opt to not update unknown arguments inside unkc anymore.
This is now the responsibility of the caller.

There are two callers of this function:

1. setup_revision: Changes have been made so that setup_revision will now
update the unknown option in argv

2. parse_revision_opt: No changes are required here. This function throws an
error whenever the option provided as argument was unknown to
handle_revision_opt().

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec..5674a9a 100644
--- a/revision.c
+++ b/revision.c
@@ -2016,8 +2016,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->ignore_missing = 1;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
-		if (!opts)
-			unkv[(*unkc)++] = arg;
 		return opts;
 	}
 	if (revs->graph && revs->track_linear)
@@ -2234,6 +2232,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
+			/* arg is an unknown option */
+			argv[left++] = arg;
 			continue;
 		}
 
-- 
2.1.4


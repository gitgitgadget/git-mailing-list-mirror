Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A821120281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969148AbdEXFQn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35463 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969140AbdEXFQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:36 -0400
Received: by mail-oi0-f66.google.com with SMTP id m17so31047866oik.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HVrqNRhYUIlfgIcatE9dwIFWIwxMc4vuRvH5mCe20oE=;
        b=gXnk63awKlDaMGH6GiMDxlPVlGX+SdxsJCEjL6xUndUxeTrS3p0WaUhBWz6zk4Dz59
         Np6/6MCgGhtQj5Z6GZ0orUm6AOqGgsNOowMBYNcSUKwIFKdPIJtd7K2h0/YqLUP7h9+v
         d4MuG+3grX0rSxVfVRrF7RvbsP2CIBTV3pJ+qz9UctVn/eC1qH1AvJv7pdu5qc8W4sV4
         2DYXNacW2cmNJNEZUzmzcdTutGEY6DAivgy+7Do2rj/zdP/j/d2bsn3iO1KGJsENPOAp
         0nNQBgiPsGekuT2W3HCoSj4EXCSBl5CN5KHLebikXKsku8ckV7/mlis+e7qgvs8bzArn
         qDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HVrqNRhYUIlfgIcatE9dwIFWIwxMc4vuRvH5mCe20oE=;
        b=bENt8dezjMis94Yc89B8UssOpkCc0QbhV8L/xa+gVpmdLvm90nfZ/ncrMBCGFoxo0w
         6bgveC0nhS+n8wr9gAEbMDqcVd9+sR39HlH2msBf29l5vqYZ9KEN5tXVZqy5SdqbDVVb
         FjQ8WVwLSwqkyeGg1LucbYy9xfNwLX9CrfBk9tiEHhe8CUEupvfKkKDUgRzwq7HyV80x
         CCamLNisD/aSXS8ZLwej07uZwfNVjKUkD3hb1ZW6gx2zpoFwPKiabUsrk9JZ9SyXyFwH
         V6ONG40S/Y75c0cxnxHwsdfAJokUgA+VvlfEy6UlE2FePCg0M/pB8IY5VOpfi57E2L3M
         IIjw==
X-Gm-Message-State: AODbwcBMFeeOFxdmHIkwt/pwKP/mSoRedT3u6oTFyeZVstpYYo2iyg7e
        vNsf4HjyZ5ggYw==
X-Received: by 10.202.219.11 with SMTP id s11mr17000480oig.213.1495602996237;
        Tue, 23 May 2017 22:16:36 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:35 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 14/29] blame: move show_root flag to scoreboard
Date:   Wed, 24 May 2017 00:15:22 -0500
Message-Id: <20170524051537.29978-15-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The show_root flag is used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 161d15c..fdd41b4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -384,6 +384,7 @@ struct blame_scoreboard {
 
 	/* flags */
 	int reverse;
+	int show_root;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -1784,7 +1785,7 @@ static void assign_blame(struct blame_scoreboard *sb, int opt)
 				mark_parents_uninteresting(commit);
 		}
 		/* treat root commit as boundary */
-		if (!commit->parents && !show_root)
+		if (!commit->parents && !sb->show_root)
 			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
@@ -2885,6 +2886,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (blame_copy_score)
 		sb.copy_score = blame_copy_score;
 
+	sb.show_root = show_root;
+
 	read_mailmap(&mailmap, NULL);
 
 	assign_blame(&sb, opt);
-- 
2.9.3


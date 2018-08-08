Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD35C208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeHHQL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35451 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1309056edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvfuVWeQcgCkBbCN3zCkvoa/l7e+1Ge/PFXHGlg0TCM=;
        b=XIF4SJSPNW6wodL4R2FLZNKVALJuogfYJthizCIKQkpU1LBcckSHkrhGD3iYh+1rkr
         J274rMb7N3PeuetdEWxhol+F4uwpocrloKQXhL+lJklGw+qCblc9QYNIWkrKQ1Q6949c
         7xb2p4kHjfmKArWKwtn/xH1duMSBE0ybsJ4m69UTdPR4wNlxgLwqtJChsWuKvyH/JSj+
         jDpS+0eRTVdoYpVuDs97BGj4mcJWUN6L5Y9/KC8T6d231PBP5dLWR74fX9juXxIg0ZIL
         vKDWQUP2rz4aUXXHnTO9iilrwzgIet2Ek/SafBSIyEX3q2H9rxDNIqBZVC44wrYmoaN+
         r3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvfuVWeQcgCkBbCN3zCkvoa/l7e+1Ge/PFXHGlg0TCM=;
        b=MDrH9uafYr2ceDfBgpp3UFHIcYbcvNejGBE1ww8BIgRLRYdEOEmQi7BYqUWOIkm/aw
         JaKZQzX6sbgCVeNfaHoKthM23+PajTB/jisPUhaV6xBWub06x1lyvRvgUD8yLCgvIQ/K
         +GXMDDaq/xzFy3tQcCXXgApvg+fnhi1HuH0W7BroU/QDrrW+tBlVG8tgVDHBHGIvI1XD
         otNiC/tgCIpEUvYca4OljZr7fO9omKiZ+ybkZBdjTxrtTw3r/0vF1ZJ6/ShlV+Vox5xn
         teiNaYVM7+94qQPaFpA+sFKrjPQR8V0pX13nttKrnGIlGYKq81DZ2UCHFB6vMDgNjWXw
         VWfw==
X-Gm-Message-State: AOUpUlGt8wasznTZlcvMZI8yqMNSgcw8SExVwHZsB9hj2GqTFSD07eAN
        s2smYhX7y0kCuAIgWtisF/92T1u4
X-Google-Smtp-Source: AA+uWPwp4ah5YHk5Aq12I2kakz7bTvlcENzyzpeHXA0jCiPjkB7UC6yRQFLqfNCJIp9xsbCSJZcgfQ==
X-Received: by 2002:a50:ac65:: with SMTP id w34-v6mr3398066edc.211.1533736298810;
        Wed, 08 Aug 2018 06:51:38 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:38 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 08/11] builtin rebase: support --force-rebase
Date:   Wed,  8 Aug 2018 19:33:27 +0545
Message-Id: <20180808134830.19949-9-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this commit, we add support to `--force-rebase` option. The
equivalent part of the shell script found in `git-legacy-rebase.sh` is
converted as faithfully as possible to C.

The --force-rebase option ensures that the rebase does not simply
fast-forward even if it could.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52a218cd18..8a7bf3d468 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -86,6 +86,7 @@ struct rebase_options {
 		REBASE_NO_QUIET = 1<<0,
 		REBASE_VERBOSE = 1<<1,
 		REBASE_DIFFSTAT = 1<<2,
+		REBASE_FORCE = 1<<3,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -181,6 +182,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->flags & REBASE_VERBOSE ? "t" : "");
 	add_var(&script_snippet, "diffstat",
 		opts->flags & REBASE_DIFFSTAT ? "t" : "");
+	add_var(&script_snippet, "force_rebase",
+		opts->flags & REBASE_FORCE ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -409,6 +412,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BIT('f', "force-rebase", &options.flags,
+			N_("cherry-pick all commits, even if unchanged"),
+			REBASE_FORCE),
+		OPT_BIT(0, "no-ff", &options.flags,
+			N_("cherry-pick all commits, even if unchanged"),
+			REBASE_FORCE),
 		OPT_END(),
 	};
 
@@ -551,10 +560,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
 		int flag;
 
-		if (!(options.flags & REBASE_NO_QUIET))
+		if (!(options.flags & REBASE_FORCE)) {
+			if (!(options.flags & REBASE_NO_QUIET))
+				; /* be quiet */
+			else if (!strcmp(branch_name, "HEAD") &&
+				 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+				puts(_("HEAD is up to date."));
+			else
+				printf(_("Current branch %s is up to date.\n"),
+				       branch_name);
+			ret = !!finish_rebase(&options);
+			goto cleanup;
+		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
 		else if (!strcmp(branch_name, "HEAD") &&
-			resolve_ref_unsafe("HEAD", 0, NULL, &flag))
+			 resolve_ref_unsafe("HEAD", 0, NULL, &flag))
 			puts(_("HEAD is up to date, rebase forced."));
 		else
 			printf(_("Current branch %s is up to date, rebase "
-- 
2.18.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C6A1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbeAaLHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:31 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44768 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbeAaLHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:30 -0500
Received: by mail-pf0-f195.google.com with SMTP id 17so10799651pfw.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ag8owOsx7yW+SlFQB5rvxY9qV5B24sEPaZvlUl5oUo=;
        b=OuJj1lpdUnWFULE3vFiZ9/PrxJu8CfIzgeuR3EN8IeXYKkzFDcm1Gl2mh6AwnNAmfe
         x6wdJgNC7HCfaDOtyb6Gov3DW4sxzB/cC+JC+LW7WgIY1zp9+Vzq/dVbYKUqSz6jhdAs
         WSlBiVyOuuz/W72iJ4MAZmG+2mI8mDh7aCdNEWnXDHBlcgtW6ZpDOXWYASxWdZ+43E23
         cLY+1XT4xXu3w2vJ7em6d7HBfN/M48qCgCHLFbJRmiPJiyfY4QcwSk30lVivhoohoji4
         3G223mFUZMWsIP57xPmJh1n4y5yprCbkUHQDMG+0Jon8YzEFJs3v9D/HStOo/OXbU9GP
         HB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ag8owOsx7yW+SlFQB5rvxY9qV5B24sEPaZvlUl5oUo=;
        b=eA3Oai36p24j5X1G14CEmyjv7q7a8rUx0Cb7omaw+7xy6o38D/XGINw0+CA+zNuhwr
         mzVUyi8BHhMQAaVMT/AlrCzMSRfWGj/f+pMQ0VGb48dl4QNwXfoNBvJkSHSjQela1vQ1
         tzOIBugDeNQkdemmSkMaXcjEzyKZq8kACNoAFRagd/w0b07M4dsd3P2neYU53sR04S9k
         X2c6n0eRPURQgIHCyniqvwu4kqQFyDOyYFokdbkiIh78vz5MhSVM1J7rYRN+tfJfYNiL
         jcYAhJiGgw8xkPGhLV8+31S5wb2UFLk+pAtBc366fhC9tmJC3ou9x2507Z6upbKCXXP3
         iVHQ==
X-Gm-Message-State: AKwxytfsoUZf7863of6uyC6rP520s38ZADwk1JaLFU5P5ADcPCTvrkEz
        vA3kYjurLeFLVGT8RIy9jDX4pQ==
X-Google-Smtp-Source: AH8x224LOGXat7hzWL/lxbWmCh/3RTfhLqaS06poFkyjoWjcF0HuGWIgBctvvcxC5HvGiwddousKQg==
X-Received: by 10.101.81.13 with SMTP id f13mr13899696pgq.242.1517396849842;
        Wed, 31 Jan 2018 03:07:29 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id l64sm32720459pfg.62.2018.01.31.03.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 20/41] completion: use __gitcomp_builtin in _git_grep
Date:   Wed, 31 Jan 2018 18:05:26 +0700
Message-Id: <20180131110547.20577-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--after-context=
--before-context=
--color
--context
--exclude-standard
--quiet
--recurse-submodules
--textconv

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c                         | 13 ++++++++-----
 contrib/completion/git-completion.bash | 16 +---------------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..496f33336e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -832,8 +832,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('L', "files-without-match",
 			&opt.unmatch_name_only,
 			N_("show only the names of files without match")),
-		OPT_BOOL('z', "null", &opt.null_following_name,
-			N_("print NUL after filenames")),
+		OPT_BOOL_F('z', "null", &opt.null_following_name,
+			   N_("print NUL after filenames"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('c', "count", &opt.count,
 			N_("show the number of matches instead of matching lines")),
 		OPT__COLOR(&opt.color, N_("highlight matches")),
@@ -884,9 +885,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
-		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
-			 N_("allow calling of grep(1) (ignored by this build)")),
+			PARSE_OPT_OPTARG | PARSE_OPT_NOCOMPLETE,
+			NULL, (intptr_t)default_pager },
+		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
+			   N_("allow calling of grep(1) (ignored by this build)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f694331cfc..6e78737a13 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1551,21 +1551,7 @@ _git_grep ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--cached
-			--text --ignore-case --word-regexp --invert-match
-			--full-name --line-number
-			--extended-regexp --basic-regexp --fixed-strings
-			--perl-regexp
-			--threads
-			--files-with-matches --name-only
-			--files-without-match
-			--max-depth
-			--count
-			--and --or --not --all-match
-			--break --heading --show-function --function-context
-			--untracked --no-index
-			"
+		__gitcomp_builtin grep
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410


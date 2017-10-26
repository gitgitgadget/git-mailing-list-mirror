Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3AB2055E
	for <e@80x24.org>; Thu, 26 Oct 2017 02:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdJZCTq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 22:19:46 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:55664 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdJZCTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 22:19:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15so1476474pgc.12
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0Gn0PjVxCS25RYGoNX0yj29AoW+NwSHCSLldnI3thuQ=;
        b=qkjORCVF0RZjWyKSRNDqEwkcOHRToqjRdFHFx64z6TippkJ4kGs9SDLZ0/eimvJWhC
         m0+fjgSrKgXb3iT8CbWW4jw7o3B2EM8umTyOL/d8oL/czpvtYFNEN8HfR/eNwbCsTeOR
         fda1MNG8UVsfRyPLDh7qGOBXpiB9pm1rZkpA0ZYpKAK/+nzpbEhOMXW37c+k0Igyn28o
         XYm2+/WnRGERJwza4YBPYKe8h6BleFjv7xUpTxI8eM5lk3FYcBXo9zvyiJY8KJFBdkvv
         Yhi+ZyX7Q+SvRQeSoV3QqhEzXoKPrpTYvM7s+yQkLOtbpQxiK2Cg48bn1A7o7U4qmRJN
         2qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Gn0PjVxCS25RYGoNX0yj29AoW+NwSHCSLldnI3thuQ=;
        b=ZmF1CCNFtOeVb/Cqt3h1D9kOJJLq603jbGj6gzdrmjeQv1LTWdwdAKLQYO+izuhHTM
         XKHDgBT9AD1XEl6TbypC6QzxfKX4J+bT6jbQnfcArLi7huhAmzR9MZDW9Oqocmx299uC
         GRAgiUl/AkGK/sp5lS/VGEFDVQlqkjMsmWUA9Ir/pMDMXBD5hpwwTq2xawnyxxYTsdxa
         /04Yo7ILizO3IU2Kt0gr4+51JlpyrxpCEfi8tJvZIEQMACufcWMsPUOxSJXnkYthsN4a
         vdEfpjDxA22GwEOCPBw7Ms9KsDD/O7GmFM+EVn73xLmFlRXGSBRAxvRySo5d0JSrKXwk
         +awA==
X-Gm-Message-State: AMCzsaVWm3bpbcwO1YzIxyzzEN3hseApnOn+x/XgEgEnbjIwbHIRbHo4
        T6nYCmC2rm00ird+NiYohqhn5c4Vl6c=
X-Google-Smtp-Source: ABhQp+TOb/8AIGsqWjCyMeNY2UZXbJmRh7ZIr2IE2MtZyOP4/iF4BvaWJplG3736PbE5iC4kXSGnWw==
X-Received: by 10.84.217.142 with SMTP id p14mr3240993pli.313.1508984385044;
        Wed, 25 Oct 2017 19:19:45 -0700 (PDT)
Received: from CLI-30675.office.atlassian.com ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id e22sm6000790pgn.28.2017.10.25.19.19.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 19:19:44 -0700 (PDT)
From:   Isabella Stephens <istephens@atlassian.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com,
        bturner@atlassian.com, Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH] blame: add --fuzzy-lines command line option
Date:   Thu, 26 Oct 2017 13:19:29 +1100
Message-Id: <20171026021929.1346-1-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the -L option is used to specify a line range in git blame, and the
end of the range is past the end of the file, git will fail with a fatal
error. It may instead be desirable to perform a git blame for the line
numbers in the intersection of the file and the specified line range.
This patch adds a --fuzzy-lines command line option to allow this.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 Documentation/blame-options.txt | 5 +++++
 builtin/blame.c                 | 4 ++++
 t/t8003-blame-corner-cases.sh   | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index dc41957af..664cd8f8b 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -19,6 +19,11 @@
 +
 include::line-range-format.txt[]
 
+--fuzzy-lines::
+	Use fuzzy line ranges. If a range specified with -L starts on a line
+	within the file but ends past the end of the file, display the blame
+	for the existing lines rather than failing.
+
 -l::
 	Show long rev (Default: off).
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 67adaef4d..d25b39d40 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -661,6 +661,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
+	int fuzzy_lines = 0;
 	int show_stats = 0;
 	const char *revs_file = NULL;
 	const char *contents_from = NULL;
@@ -670,6 +671,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
 		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BOOL(0, "progress", &show_progress, N_("Force progress reporting")),
+		OPT_BOOL(0, "fuzzy-lines", &fuzzy_lines, N_("Use fuzzy line ranges")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
@@ -878,6 +880,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
+		if (fuzzy_lines && lno < top)
+			top = lno;
 		if (lno < top || ((lno || bottom) && lno < bottom))
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 661f9d430..6e7657df2 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -220,6 +220,12 @@ test_expect_success 'blame -L with invalid end' '
 	test_i18ngrep "has only 2 lines" errors
 '
 
+test_expect_success 'blame -L with invalid end and fuzzy-lines' '
+	git blame -L1,5 tres --fuzzy-lines >out &&
+	cat out &&
+	test $(wc -l < out) -eq 2
+'
+
 test_expect_success 'blame parses <end> part of -L' '
 	git blame -L1,1 tres >out &&
 	cat out &&
-- 
2.14.1


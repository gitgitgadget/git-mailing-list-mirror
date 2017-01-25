Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C751F437
	for <e@80x24.org>; Wed, 25 Jan 2017 05:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdAYF15 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 00:27:57 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34713 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdAYF14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 00:27:56 -0500
Received: by mail-ua0-f196.google.com with SMTP id i68so18252819uad.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 21:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVRqToHJbi0d/03E9M0BI78c6fppGcPJgXkfRiihJFk=;
        b=PwdYsw53TyuoLOe+CraePiGGia/5qMPxRVK2Zk38LYQwrfYdaR0RUR07XD6eU4hbrf
         k/XRwblc0Kdbc7WRaHdX+znXM/zgRM46mHF+2NOTSAunHYIstw7jPkNCm0cF2OprBhIi
         aK6GL/za60tIL2BeG2pej3AbPCH6cEyhoYLhh40nXFG2EQ4rHjn8xR52UM1xcouKaGrA
         5APmnN+RIR4hiSvtdv+wTgdc/MU8Z2/fh8nFAS0Y7SYtiBVnQB6hERKSQdaaft78UQyg
         YMu8/hk3WV8iJwgVVb2jdK7Hy1d579OusG7VhlIqx/PW7rpRaxB5zwjBbNGffZkElZEw
         7H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVRqToHJbi0d/03E9M0BI78c6fppGcPJgXkfRiihJFk=;
        b=MBDHKavzlnjxnc7qWnLVNCiTfKkYIMIKZGKbqFvO4XmSxP6062qsgpuhRd+PHWGm3W
         Mp4jSAbw2Gim1/kCGxiA+KoCds1z6UapFomMqPkTlItE1JrIJyN9cWRKXSNS7lUd1qMn
         0RnHbg6v04IZwCByL5a3u2jTZdZwBVgpGHJqyEvEY8WoPe9rpjRc7lIOSw7uNzLWiSPA
         BNSr1TXTTRvubR9ITRD1zZFAwd+3rY4YQxT6Zkm1zIChTtZrp3QdNbKb+5GD8U08usyX
         WIYCXq0Wa8aiEvAb7Nt8GSL+L9Gxc3JyWm1DxwpJ/XSrtzWN026P0gRpNm2kTdAKjyJT
         34Dg==
X-Gm-Message-State: AIkVDXLpRRTzJMSBopH5j0RPYC18lsMq1It7Fks9Sk+Od5A655k5xdmR7J0wpd/b/SmBqg==
X-Received: by 10.176.85.26 with SMTP id t26mr16734763uaa.1.1485322075401;
        Tue, 24 Jan 2017 21:27:55 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id d9sm8794212uag.4.2017.01.24.21.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 21:27:54 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     apelisse@gmail.com, kevin@sb.org, gitster@pobox.com, peff@peff.net,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1 2/3] blame: add --hint option
Date:   Tue, 24 Jan 2017 23:27:33 -0600
Message-Id: <20170125052734.17550-2-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
In-Reply-To: <20170125052734.17550-1-eantoranz@gmail.com>
References: <20170125052734.17550-1-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When printing aggregate information about revisions, this option
allows to add the 1-line summary of the revision to provide the
reader with some additional context about the revision itself.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/blame-options.txt |  4 ++++
 Documentation/git-blame.txt     |  2 +-
 builtin/blame.c                 | 13 +++++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index be2a327ff..64858a631 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -53,6 +53,10 @@ include::line-range-format.txt[]
 	Aggregate information about revisions. This option makes no
 	difference on incremental or porcelain format.
 
+--hint::
+	Show revision hints on aggregated information about the revision.
+	Implies --aggregate.
+
 --encoding=<encoding>::
 	Specifies the encoding used to output author names
 	and commit summaries. Setting it to `none` makes blame
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 385eaf7be..ed8b119fa 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--progress] [--abbrev=<n>] [--aggregate] 
+	    [--progress] [--abbrev=<n>] [--aggregate] [--hint]
 	    [<rev> | --contents <file> | --reverse <rev>..<rev>] [--] <file>
 
 DESCRIPTION
diff --git a/builtin/blame.c b/builtin/blame.c
index 09b3b0c8a..7473b50e9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1885,6 +1885,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
 #define OUTPUT_AGGREGATE      02000
+#define OUTPUT_HINT           04000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -2001,8 +2002,12 @@ static void print_revision_info(char* revision_hex, int revision_length, struct
 	if (line_number && (opt & OUTPUT_AGGREGATE))
 		printf(opt & OUTPUT_ANNOTATE_COMPAT ? "%*d)" : " %*d) ",
 			   max_digits, line_number);
-	if (!line_number)
-		printf(")\n");
+	if (!line_number) {
+		printf(")");
+		if (opt & OUTPUT_HINT)
+			printf(" %s", ci.summary.buf);
+		printf("\n");
+	}
 }
 
 static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
@@ -2018,6 +2023,9 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	get_commit_info(suspect->commit, &ci, 1);
 	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
 
+	if (~(opt & OUTPUT_AGGREGATE) & (opt & OUTPUT_HINT))
+		opt=opt|OUTPUT_AGGREGATE;
+
 	if (opt & OUTPUT_AGGREGATE)
 		print_revision_info(hex, revision_length, ent, ci, opt, show_raw_time, 0);
 
@@ -2638,6 +2646,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
 		OPT_BIT(0, "aggregate", &output_option, N_("Aggregate output"), OUTPUT_AGGREGATE),
+		OPT_BIT(0, "hint", &output_option, N_("Show revision hints"), OUTPUT_HINT),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
-- 
2.11.0.rc1


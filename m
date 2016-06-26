Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E7D20179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcFZRQa (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:16:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34679 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbcFZRQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 13:16:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so26541228lfl.1
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 10:16:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymuflBEGRTJLjP7pYUCPhiMVAUQKSx1kQmwfhkd19VY=;
        b=HbLz0K3nJSfTrWi3csGK0OYWpe9FhGRhLWLNaxZPCho7OYaJkXSRcla745DVoTCCYs
         nwhhvoNndS8lHkVcuHTxHaY7cH7rTxnYzGXpnEFS4d8fkVmNwaV9aOP9bKTI10mKG4RR
         mT8la4e/N/ytkntH/ePsmyqI1+vJ/KCwZc4cp/SsX2Ls+sVqYuk5Mr2txMj/B0rH4FSz
         G5pm/gOIneyI+O3NPQNlhJXEOKz/JOHIo3zvR7sYdz3nkmnplL1zImtAgKDKwDA4JAJx
         qkGMS1xDdkufpc4zvKtVwA/qCcpWPXcXRErBlsyzL1n4hltmUxxw+YMcVMrz126XAgUg
         WwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymuflBEGRTJLjP7pYUCPhiMVAUQKSx1kQmwfhkd19VY=;
        b=VDbIzzgtyD7VefLeSNZNxjzo7pOT6yQCdn8cnsVU2oUClSJyV/Zs7X8kHxeEcn2DJ5
         O99vmqrjacFlvRDoFnjMrhjYnhglPB/77gtJM8OE2wuR5/uYJ9Z9WhW6e50t8ysurEB1
         LfgOMxyIXG85/2DsTShf4mybPgQiN2M5JRmPy4q0QeOTQ+U4cRgiRru7DBsesdc/AZ0k
         T/eEK5IcBypmicgxj/Mc3AV4IgZN8xg5uBxMA1/Jj5cAKgEe+80ld/0c1yKSXOfSvrTF
         GQqI5w+17mys7GN478yKAIZdBsdb8Con7rbtnmc+ZEQZL03BAHKLkepKc+dYuXZcXVnB
         z/QA==
X-Gm-Message-State: ALyK8tJNgj8uZPKfqSY49otPjUNHeYhR9LdwEaGnaERlqX44yNCpeZYBz1eQqHdhKaVrJA==
X-Received: by 10.46.32.28 with SMTP id g28mr4007395ljg.34.1466961386178;
        Sun, 26 Jun 2016 10:16:26 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm2624773lfu.26.2016.06.26.10.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 10:16:25 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 3/3] diff.c: add --relative-names to be used with --name-only
Date:	Sun, 26 Jun 2016 19:16:16 +0200
Message-Id: <20160626171616.27948-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160626171616.27948-1-pclouds@gmail.com>
References: <20160626171616.27948-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The difference with --relative option is, this option does not filter
paths outside cwd. You can add two more chars " ." on your command
line for that.

This serves two purposes

 - user friendlier to copy/paste. When full paths are shown, you can
   still use ":/" magic to get around it, but unless you're a lefty
   you need to move your right hand between the keyboard and mouse for
   each path. Not very efficient.

 - script friendly. Strictly speaking a very light form of scripting
   from command line prompt when you just pipe paths to the next
   command. Paths relative to cwd would be much easier to pip this
   way.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 It would be great if --relative could be used for this (and it feels
 weird that the option performs both actions at once, stripping _and_
 filtering where filtering could easily be done with pathspec). But
 it's too late to change --relative behavior now.

 Documentation/diff-options.txt |  4 ++++
 diff.c                         | 21 ++++++++++++++++++---
 diff.h                         |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index d9ae681..1554008 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -481,6 +481,10 @@ ifndef::git-format-patch[]
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
+
+--relative-names::
+	When used with `--name-only`, paths are shown relative to
+	current working directory.
 endif::git-format-patch[]
 
 -a::
diff --git a/diff.c b/diff.c
index bd5d190..3a938ac 100644
--- a/diff.c
+++ b/diff.c
@@ -3335,6 +3335,13 @@ void diff_setup_done(struct diff_options *options)
 	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
+	/*
+	 * --relative can change "prefix", which may cause unintended
+	 * consequences for --relative-names
+	 */
+	if (DIFF_OPT_TST(options, RELATIVE_NAME) && options->relative_names)
+		die(_("--relative and --relative-names are mutually exclusive"));
+
 	if (options->prefix)
 		options->prefix_length = strlen(options->prefix);
 	else
@@ -3792,7 +3799,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (skip_prefix(arg, "--relative=", &arg)) {
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 		options->prefix = arg;
-	}
+	} else if (!strcmp(arg, "--relative-names"))
+		options->relative_names = 1;
 
 	/* xdiff options */
 	else if (!strcmp(arg, "--minimal"))
@@ -4347,8 +4355,15 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 		const char *name_a, *name_b;
 		name_a = p->two->path;
 		name_b = NULL;
-		strip_prefix(opt, &name_a, &name_b);
-		write_name_quoted(name_a, opt->file, opt->line_termination);
+		if (opt->relative_names)
+			write_name_quoted_relative(name_a,
+						   opt->prefix, opt->file,
+						   opt->line_termination);
+		else {
+			strip_prefix(opt, &name_a, &name_b);
+			write_name_quoted(name_a, opt->file,
+					  opt->line_termination);
+		}
 	}
 }
 
diff --git a/diff.h b/diff.h
index 125447b..ad6423d 100644
--- a/diff.h
+++ b/diff.h
@@ -139,6 +139,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int relative_names;
 /* white-space error highlighting */
 #define WSEH_NEW 1
 #define WSEH_CONTEXT 2
-- 
2.8.2.531.gd073806


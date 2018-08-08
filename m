Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F74B208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeHHQLa (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35454 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so1309154edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5FHiG1/DMx/Q+OKRW9D9GjYSop/vkQA/qvKY4NJoAk=;
        b=PjmtS6P0PqcnOZEJUXrTzW84nmfIuTMKEmiOqScq+dKNQr6z3Hx4Q8obKgRACr/H4s
         oOGAeHj0wk+k/bYQu8M9VPaQ4fv8TEbL8YB/5KftF17Ny//IrJO1PMJ165G27qSdPAeO
         QpC4JTaPIEgS0+6xXT7pVZ36xM40L2+fECBdXlkw5T+S66f8hwv26AO6R+dLNvXgmzDJ
         abC8oxV4UVDVdpLZVTQ8YVn6P1srKIQW9x93Ow5okyilZAKYiCzfGdTF8wZPIM/pMyfL
         4Tima/3VB0cGPygx2C89njJgTPVjHX81Vho+WQGKctVP3RQnzgRESSDZfDMywVYf2mbS
         1a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5FHiG1/DMx/Q+OKRW9D9GjYSop/vkQA/qvKY4NJoAk=;
        b=FMWZqC4nSCnRk+fT+LPY1yPM0Y5G/IHyFm9IVduqNy3WAIZ7yLzCspwzseEL+nPKgS
         3ohh4S81uFJqK5qXQVKwtQMRZIo3zx75G4ad4NZVoereasEPlE/RwUc2WkJ1Lpvi5cuB
         0pDnXo+Mew9SJ37Qss497oc645vp9wXxXAXM8LvG03q2huOwTdUgBqg4qxHvOGfoVrKH
         hKmSUF8P/Q22XK4Tdvp//I7R06NrI+foOK0tEJiCTTGUhv3sZGU/ydmZNTn3ldQPg/cj
         fBasKSCfZlJNLFQI1GiiLkp32RLUIHGKNVMrLR/K/v3BlOt/kYsajUqZrfZEmNopLEZY
         yC1A==
X-Gm-Message-State: AOUpUlHPP+l3/G1GBcldY2+CL1uHEmH4YwMbM3FwK5NkydfLE5aBAK8d
        Frh5YS50Yug4gmKmHgWAz5QbRxJY
X-Google-Smtp-Source: AA+uWPx4z0h65w6bNz1oroqIx2JTS5axDAV4ix9bINPtIjmDGFqWFLrJTUC/TQW3PXPEQz7ctPW9sw==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr3268733edb.237.1533736302487;
        Wed, 08 Aug 2018 06:51:42 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:41 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 09/11] builtin rebase: start a new rebase only if none is in progress
Date:   Wed,  8 Aug 2018 19:33:28 +0545
Message-Id: <20180808134830.19949-10-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To run a new rebase, there needs to be a check to assure that no other
rebase is in progress. New rebase operation cannot start until an
ongoing rebase operation completes or is terminated.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8a7bf3d468..a261f552f1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -87,6 +87,7 @@ struct rebase_options {
 		REBASE_VERBOSE = 1<<1,
 		REBASE_DIFFSTAT = 1<<2,
 		REBASE_FORCE = 1<<3,
+		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
 	} flags;
 	struct strbuf git_am_opt;
 };
@@ -392,10 +393,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.git_am_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
-	int ret, flags;
+	int ret, flags, in_progress = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -447,6 +449,30 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	git_config(rebase_config, &options);
 
+	if (is_directory(apply_dir())) {
+		options.type = REBASE_AM;
+		options.state_dir = apply_dir();
+	} else if (is_directory(merge_dir())) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s/rewritten", merge_dir());
+		if (is_directory(buf.buf)) {
+			options.type = REBASE_PRESERVE_MERGES;
+			options.flags |= REBASE_INTERACTIVE_EXPLICIT;
+		} else {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s/interactive", merge_dir());
+			if(file_exists(buf.buf)) {
+				options.type = REBASE_INTERACTIVE;
+				options.flags |= REBASE_INTERACTIVE_EXPLICIT;
+			} else
+				options.type = REBASE_MERGE;
+		}
+		options.state_dir = merge_dir();
+	}
+
+	if (options.type != REBASE_UNSPECIFIED)
+		in_progress = 1;
+
 	argc = parse_options(argc, argv, prefix,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
@@ -455,6 +481,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	/* Make sure no rebase is in progress */
+	if (in_progress) {
+		const char *last_slash = strrchr(options.state_dir, '/');
+		const char *state_dir_base =
+			last_slash ? last_slash + 1 : options.state_dir;
+		const char *cmd_live_rebase =
+			"git rebase (--continue | --abort | --skip)";
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "rm -fr \"%s\"", options.state_dir);
+		die(_("It seems that there is already a %s directory, and\n"
+		      "I wonder if you are in the middle of another rebase.  "
+		      "If that is the\n"
+		      "case, please try\n\t%s\n"
+		      "If that is not the case, please\n\t%s\n"
+		      "and run me again.  I am stopping in case you still "
+		      "have something\n"
+		      "valuable there.\n"),
+		    state_dir_base, cmd_live_rebase,buf.buf);
+	}
+
 	if (!(options.flags & REBASE_NO_QUIET))
 		strbuf_addstr(&options.git_am_opt, " -q");
 
-- 
2.18.0


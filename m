From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/14] apply: add --work, --no-work options
Date: Mon, 14 Oct 2013 17:29:19 -0500
Message-ID: <1381789769-9893-5-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqk4-00079L-QH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601Ab3JNWfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:35:54 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:46350 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3JNWfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:35:53 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so4099863oag.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ebm7YZSPIeBJ6atHaaLYhr4QXfLKmQe+78IILDHzHMs=;
        b=QYnB0dT4h5waLS9VyfwBI9OILS7IrJ0MeYImV1p0kUTzJZt3X+eCz8tuZ4hY3rfb92
         8yllJmIqyVkskiEv846vYJI+AVaCCQamqjWXn5Gkgo+9SP52Atzfbf9iAQYQNSfVbx4f
         gtcIvP+E0qosePUye8w3pQS1drqIf0S6suoh55wwdRXxT134SWGp7WsGrxGpLMEADalJ
         WPhl/23qDoIHbTjapnI0J8g2Vn/8F0qSZauAfYSHROmdtCo9MRPZ2NCkBS4JYtRWKKT9
         KifvhKNoinpM5pzbEU3WwvJnWtU2oxaFg0Wlb/eP9gf7/9BHVsXFWSaAzmT7z15lQjOg
         TOwg==
X-Received: by 10.182.40.201 with SMTP id z9mr3519919obk.45.1381790153127;
        Mon, 14 Oct 2013 15:35:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xx9sm44536813obc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:35:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236131>

'git apply', 'git apply --index', 'git apply --cached' do different
things, but what they do is not precisely clear, specially since no
other commands has similar distinctions.

With --no-work (--work being the default), it's clear what the option
would do; modify, or not, the working directory.

So, --work (the default), doesn't cause any changes, and --no-work
enables the current --cache if used with --index.

Eventually --work might replace --cache, if these options are
standarized in the whole git toolset.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-apply.txt | 6 +++++-
 builtin/apply.c             | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 8c047ef..95f5485 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [<patch>...]
+	  [--verbose] [--no-work] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -75,6 +75,10 @@ OPTIONS
 	cached data, apply the patch, and store the result in the index
 	without using the working tree. This implies `--index`.
 
+--[no-]work::
+	Apply a patch with or without touching the working tree, essentially
+	`--no-work` plus `--index` are the equivalent of `--cached`.
+
 -3::
 --3way::
 	When the patch does not apply cleanly, fall back on 3-way merge if
diff --git a/builtin/apply.c b/builtin/apply.c
index 42b5a4b..a3dd89d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4350,6 +4350,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int errs = 0;
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
+	int work = 1;
 
 	const char *whitespace_option = NULL;
 
@@ -4381,6 +4382,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
+		OPT_BOOLEAN(0, "work", &work,
+			N_("modify the working tree")),
 		OPT_BOOLEAN(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &threeway,
@@ -4433,6 +4436,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
 
+	if (check_index && !work)
+		cached = 1;
 	if (apply_with_reject && threeway)
 		die("--reject and --3way cannot be used together.");
 	if (cached && threeway)
-- 
1.8.4-fc

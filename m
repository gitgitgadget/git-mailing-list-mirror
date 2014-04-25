From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 10/14] apply: add --work, --no-work options
Date: Fri, 25 Apr 2014 13:12:43 -0500
Message-ID: <1398449567-16314-11-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknD-00079k-7V
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbaDYSX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:58 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48756 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbaDYSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:56 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so4507976oag.26
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MIryLWnoUmPzvzyvCN1Zm6nrIF+r17lI1dykSX0U67E=;
        b=0mwoEjF+etFYv2O3DXUh8YsOUQ1EDwWZ+dWXRcLnrAmNAojTgBhkzIBmTFy6PPKDqv
         a58jaBZeAiDa7PVhXr1KSCszj09C1h5yVLf91+xUxAHUIjHpxwDJZKeuhKayEH47o3UC
         8L1fwhnxhhxU7yySIyOKeZHWcwEnHadGn/380SA6GnAglGkPQOEGbkVDRwXODGFLZU/T
         gTNJRSCySmohqB3fL7gvCZWdKcdjE7rtW5j5o3GJ+AAtBRdfPl+7ESzmHKLVbROSNdbU
         HnX4lK9hhCK7ffLPezgCB71n16cWnbsXAeFkuBbcWYcc+5pMbUWylPzoae/O/48NSg6W
         o75w==
X-Received: by 10.182.171.7 with SMTP id aq7mr2673117obc.67.1398450236089;
        Fri, 25 Apr 2014 11:23:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h1sm17050459obr.15.2014.04.25.11.23.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247084>

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
index a97363c..68cdef1 100644
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
 		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
+		OPT_BOOL(0, "work", &work,
+			N_("modify the working tree")),
 		OPT_BOOL(0, "apply", &force_apply,
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
1.9.2+fc1.2.gfbaae8c

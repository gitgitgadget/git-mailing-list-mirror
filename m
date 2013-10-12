From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 10/14] apply: add --work, --no-work options
Date: Sat, 12 Oct 2013 02:04:38 -0500
Message-ID: <1381561488-20294-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtQA-0006tW-Jy
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab3JLHLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36185 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab3JLHLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so3391963obc.8
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyX0nN++Q8GXeWdCjVjRKiW2pI/tYuO78Au0zTf+dCo=;
        b=KnbFqYvs3hDIyZujNpMie0+WIiRacgnhanigZgAyT1WS4CFOJPJyHD+/Az0QI/8+D4
         Un578Ik9FtiYzSbMUUu05+36bXt+G5P4HtVzw7I10cmw0n2ZBZtBOWyD9Bw/6R7Gmarf
         CuBYog4qbScPMT3RP7SfuEDre+V0dKySglhlT4hPW9Sg6Cj1sv2FeBnxQusGsiRIpLV9
         +qhNoxLYPyGjTgK3DRFQsojOD96VZ/ikin6MLxifBs0/oHfkineNMtOsREqkedQB1L0o
         NT014G2FZQjZ7sy7L+R8psCV8os1q0ER1eWbe4ah78NApheix1h9nKGLcrmvHVwxEYZK
         3ezQ==
X-Received: by 10.60.95.229 with SMTP id dn5mr17830342oeb.26.1381561861352;
        Sat, 12 Oct 2013 00:11:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm28651678obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236040>

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
index ce44327..6167061 100644
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

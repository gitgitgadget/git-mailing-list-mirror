From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 3/9] log, format-patch: parsing uses OPT__QUIET
Date: Sat,  3 Aug 2013 13:51:20 +0200
Message-ID: <1375530686-2309-4-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aNN-0006I5-6c
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358Ab3HCLvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:48 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:55844 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab3HCLvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:09 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so755852eak.15
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0IvI7HdUnCiGcdZjybDblTX9Hv+/otZWy4NSO7Azz44=;
        b=b391ClGFKMZd2zbZIxru0D5R2gF0qkzRAR9qtP5FS/venJFW4Gbf8wyRnRF5c3IyL6
         eoPRxHVv6xTRQB6LI74yj7IFgLSdLdYgVNNzwPh7ajQ0WpohPNUSAY7AuabaZ/RMlQPx
         ibTR2Squ2itQrErs9bKHpxJwJqdWUGC13Z79gLApBOemvn85R8tosTA7+JEItiRmVeMN
         QBoltT+VkkivwcYntOaGXMPi2FARhamJerHT/b8GRNXXtvfQ7nNmg5W/MHMYdBeMVqT4
         Hklsgwondmpv/vu2Ns8j8TrizuH36sEy2xxTt3HhnLbP7AIQ1nEQg9q4NFWOzoCCGR8w
         f0uA==
X-Received: by 10.14.251.10 with SMTP id a10mr6168533ees.76.1375530668027;
        Sat, 03 Aug 2013 04:51:08 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id cg12sm18891464eeb.7.2013.08.03.04.51.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231590>

This patch allows users to use the short form -q on
log and format-patch, which was non possible before.

Also the documentation of format-patch mentions -q now.

The documentation of log doesn't even talk about --quiet, so I'll leave
that for more experienced git contributors. ;)
It doesn't seem to change the default behavior, but in combination
with --stat for example it suppresses the actual stats.
however the only relevant code in log is
	if (quiet)
		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/git-format-patch.txt | 1 +
 builtin/log.c                      | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index e394276..9e0ef0e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -242,6 +242,7 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 Note that the leading character does not have to be a dot; for example,
 you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
+-q::
 --quiet::
 	Do not print the names of the generated files to standard output.
 
diff --git a/builtin/log.c b/builtin/log.c
index 1dafbd0..ed4dec4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,7 +121,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOL(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
@@ -1210,8 +1210,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_BOOLEAN(0, "quiet", &quiet,
-			    N_("don't print the patch filenames")),
+		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
 
-- 
1.8.4.rc0.16.g7fca822.dirty

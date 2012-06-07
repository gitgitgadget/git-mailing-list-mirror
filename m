From: =?ISO-2022-JP?B?S2VudGEgTXVyYXRhICgbJEJCPEVEGyhCIBskQjgtQkAbKEIp?= 
	<mrkn@cookpad.com>
Subject: [PATCH] Introduce --current option to git-branch builtin command.
Date: Thu, 7 Jun 2012 16:23:14 +0900
Message-ID: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 09:23:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScX3x-0000uw-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 09:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab2FGHXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 03:23:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47525 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab2FGHXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 03:23:15 -0400
Received: by dady13 with SMTP id y13so474170dad.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 00:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=a/8dI8DDo/k1mDJ73VQIedFe3PshIN3AWksLbyEcUwc=;
        b=deODtpL10D64WmzBWDR5J1XF0U1otKYwPksRFZcJZGXunD7sO6xw4HnOM7aO1/iIVT
         IsWwpGloYcGHTTspXfy6KwwRizRjHa8puuh2qyoe56FlQ2f0yx92bUHm+teb6kdSjOuG
         sANP0WgSqTEphHWPaPSQ28FR3KaYM1JGVvDUxY9AjvZchd3mqYVXfABUjrPq8AkGNNsk
         4c61OaOrq0Bk/Oomr6u7rijIulkiqtvDbUvh5LG3KNYf9VLtxPd9QOVZAuVy8WJyORn8
         02vC2e75IpuzxCCrlw2sPg4KWxCPeRAmCch8pytnA3QieGwygvceUPtacNxUKd8TkYVD
         in4A==
Received: by 10.68.217.100 with SMTP id ox4mr5784049pbc.87.1339053794635; Thu,
 07 Jun 2012 00:23:14 -0700 (PDT)
Received: by 10.142.114.6 with HTTP; Thu, 7 Jun 2012 00:23:14 -0700 (PDT)
X-Gm-Message-State: ALoCoQmc3G+rawlPqbj63AybCJtqmLQqhwu7ENuRRXf99koOnEQMjkOtr500ut8DKAs/YL2Ckc4X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199373>

Introducing --current option to git-branch builtin command.
This option allows us to simply show the current branch name.

---
 builtin/branch.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..21e4675 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -19,6 +19,7 @@
 #include "column.h"

 static const char * const builtin_branch_usage[] = {
+       "git branch --current",
        "git branch [options] [-r | -a] [--merged | --no-merged]",
        "git branch [options] [-l] [-f] <branchname> [<start-point>]",
        "git branch [options] [-r] (-d | -D) <branchname>...",
@@ -711,7 +712,7 @@ int cmd_branch(int argc, const char **argv, const
char *prefix)
 {
        int delete = 0, rename = 0, force_create = 0, list = 0;
        int verbose = 0, abbrev = -1, detached = 0;
-       int reflog = 0, edit_description = 0;
+       int reflog = 0, edit_description = 0, show_current = 0;
        int quiet = 0;
        enum branch_track track;
        int kinds = REF_LOCAL_BRANCH;
@@ -768,6 +769,7 @@ int cmd_branch(int argc, const char **argv, const
char *prefix)
                        opt_parse_merge_filter, (intptr_t) "HEAD",
                },
                OPT_COLUMN(0, "column", &colopts, "list branches in columns"),
+               OPT_BOOLEAN(0, "current", &show_current, "show current
branch only"),
                OPT_END(),
        };

@@ -794,7 +796,7 @@ int cmd_branch(int argc, const char **argv, const
char *prefix)
        argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
                             0);

-       if (!delete && !rename && !edit_description && argc == 0)
+       if (!delete && !rename && !edit_description && !show_current
&& argc == 0)
                list = 1;

        if (!!delete + !!rename + !!force_create + !!list > 1)
@@ -852,6 +854,12 @@ int cmd_branch(int argc, const char **argv, const
char *prefix)
                        rename_branch(argv[0], argv[1], rename > 1);
                else
                        usage_with_options(builtin_branch_usage, options);
+       } else if (show_current) {
+               const char *branch_name = head;
+               if (detached) {
+                       branch_name = _("(no branch)");
+               }
+               printf("%s\n", branch_name);
        } else if (argc > 0 && argc <= 2) {
                if (kinds != REF_LOCAL_BRANCH)
                        die(_("-a and -r options to 'git branch' do
not make sense with a branch name"));


-- 
Kenta Murata

COOKPAD Inc.
http://cookpad.com

MG Shirokanedai Bld. 5F, 5-12-7, Shirokanedai
Minato, Tokyo, 180-0071 Japan

From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] add: allow configurations to be overriden by command line
Date: Thu, 18 Jun 2009 02:17:54 -0700
Message-ID: <1245316674-32377-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 11:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDky-0007EW-Rj
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbZFRJR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 05:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbZFRJRz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:17:55 -0400
Received: from mail-pz0-f175.google.com ([209.85.222.175]:58966 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbZFRJRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 05:17:54 -0400
Received: by pzk5 with SMTP id 5so215864pzk.33
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=chnGRGuC3JEvQH8SnF3JxhuWh04kqCga34WkM5Ns/nk=;
        b=AL5UhZpg6RSh90ac/dW0Ir/IE6kGlUPMkk/MglOuHX64giHN84B8fgv9FPjypybyDd
         f+Avh19pH08LBxi/r4HitjRPCtH455Pwnvwb7IQ8+Hy+YhuCnqMjFoCWPZq4ynq2BGMa
         KOW2xKKMP6M45ZKF6lyaLZ02adRT6CPv6XNAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ci0TRniGS53DTZ4XoizjY3Yek5m6p4+Cy+T1Bn7Q6GzjN5IJIFICaKdtvIxGA7n+yt
         ZyvAdPpstgcNsj6KGJgzxuswYNaF0roibT1vqIjV0ZkJHdcF3dfQzcRoirIPmpdeYAM+
         l/zKg2xRAXlT9CM0UIX0UJpRNrfj9UhzRLq5c=
Received: by 10.114.67.17 with SMTP id p17mr1771398waa.163.1245316677105;
        Thu, 18 Jun 2009 02:17:57 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id j26sm144032waf.28.2009.06.18.02.17.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 02:17:56 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 18 Jun 2009 02:17:54 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121823>

Don't call git_config after parsing the command line options, otherwise
the config settings will override any settings made by the command line.

This can be seen by setting add.ignore_errors and then specifying
--no-ignore-errors when using git-add.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-add.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index c1b229a..56e5221 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -298,6 +298,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int add_new_files;
 	int require_pathspec;
 
+	git_config(add_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
@@ -305,8 +307,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_interactive)
 		exit(interactive_add(argc - 1, argv + 1, prefix));
 
-	git_config(add_config, NULL);
-
 	if (edit_interactive)
 		return(edit_patch(argc, argv, prefix));
 	argc--;
-- 
1.6.3.2.306.g4f4fa

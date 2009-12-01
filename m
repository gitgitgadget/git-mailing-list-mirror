From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] help: Do not unnecessarily look for a repository
Date: Tue,  1 Dec 2009 11:27:34 -0800
Message-ID: <1259695654-3182-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 01 20:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYNC-0000VQ-3x
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZLAT0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbZLAT0m
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:26:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56087 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbZLAT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:26:40 -0500
Received: by bwz27 with SMTP id 27so3784521bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RNVjnqtsWlKZ58yekHsxKIezeCqk701ffz8IVq3WWL0=;
        b=OWhVbe5L1Hl1f7HEgwZLJ//qw/bkX+CsSi1A6TpPaKo0rpkO23hW+NM5W/0+dAnIm7
         pR7nv04hHhlXS1cZrpE6h2B8ZQRz+bn+gdsbKtn12DBLgBC7JnDzpu014ziIHidGrtB6
         Qe7Ae6fApAPyUYQfKJ3Dd4OQ38e4+Ix18+iFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GLS3tDRwu/thjGTetnSVx8lyXUotfNJYpfg9BugQtVYaR+bPvJPqYf5YreN+iWDPpl
         qTDP6rIaRa6eyF9iZyevLpViXz++rvRhEP6jmv9KgFOm8o/MCdmh449apzkurY4Wvj1O
         FRcgmYtq/vkAmcHRR56774tb6F1bTkwRi4MWk=
Received: by 10.204.24.71 with SMTP id u7mr6577972bkb.35.1259695605270;
        Tue, 01 Dec 2009 11:26:45 -0800 (PST)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 2sm537762fks.43.2009.12.01.11.26.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 11:26:44 -0800 (PST)
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134252>

Although 'git help' actually doesn't need to be run inside a git
repository and uses no repository-specific information, it looks for a git
directory.  Searching for a git directory can be annoying in auto-mount
environments.  With this commit, 'git help' no longer searches for a
repository when run without any options.

7c3baa9 originally modified 'git help -a' to not require a repository.
This applies the same fix for 'git help'.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 builtin-help.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index ca08519..09ad4b0 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -427,9 +427,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
-
 	if (!argv[0]) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
@@ -437,6 +434,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
 		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
-- 
1.6.5.3

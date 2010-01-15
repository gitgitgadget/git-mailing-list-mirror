From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/3] difftool: Add '-x' and as an alias for '--extcmd'
Date: Thu, 14 Jan 2010 23:16:01 -0800
Message-ID: <1263539762-8269-2-git-send-email-davvid@gmail.com>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 15 08:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVgTw-0002ja-1a
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 08:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0AOHQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 02:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378Ab0AOHQO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 02:16:14 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:50258 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab0AOHQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 02:16:13 -0500
Received: by ywh6 with SMTP id 6so280712ywh.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cKfadVp5t8XnClT/HvP3fWdcr/t2V0kqGeYkXMMFT+s=;
        b=VyEJJwmzdoUg/8Y4/XC12fTvFxMEUa5teK4WtKDBhic74y8naSG0bhmKQlEC+4vVJw
         s59sxreRHAerdIKdFkWQJz7oHKh8Me9Zh0K1vmZvjtuXl7MG1U2ZC9pvHQJIaVLlPW84
         vAK+8n0EtN83pgjQk3eYSaGZ/zN59x8otyi+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eyme8Qr6/CeMeD59lw05FHWz0804LyNQkqAvIznuLoRX5TyTbhB/ZEV8YuTN/u/EUs
         XTgfoCInxnaHYavb9XRoG0q4IckSArDBwZPLnim8MsKpjJKZEXA7KUp7mE6HG5T/4vuZ
         WyA52zaETvzXLhMvYyir663M6wIs8hT74ULDU=
Received: by 10.150.165.17 with SMTP id n17mr164974ybe.321.1263539772780;
        Thu, 14 Jan 2010 23:16:12 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm613204ywc.51.2010.01.14.23.16.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 23:16:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.196.g1f735
In-Reply-To: <1263539762-8269-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137053>

This adds '-x' as a shorthand for the '--extcmd' option.
Arguments to '--extcmd' can be specified separately, which
was not originally possible.

This also fixes the brief help text so that it mentions
both '-x' and '--extcmd'.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-difftool.txt |    3 ++-
 git-difftool.perl              |   21 ++++++++++++++-------
 t/t7800-difftool.sh            |    8 ++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index f67d2db..5c68cff 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,7 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [-y|--no-prompt|--prompt] [<'git diff' options>]
+'git difftool' [<options>] <commit>{0,2} [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -58,6 +58,7 @@ is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
+-x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
 	'git-difftool' ignores the configured defaults and runs
diff --git a/git-difftool.perl b/git-difftool.perl
index f8ff245..d639de3 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -1,5 +1,5 @@
 #!/usr/bin/env perl
-# Copyright (c) 2009 David Aguilar
+# Copyright (c) 2009-2010 David Aguilar
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
 # git-difftool--helper script.
@@ -23,8 +23,9 @@ my $DIR = abs_path(dirname($0));
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [-g|--gui] [-t|--tool=<tool>] [-y|--no-prompt]
-                    ["git diff" options]
+usage: git difftool [-t|--tool=<tool>] [-x|--extcmd=<cmd>]
+                    [-y|--no-prompt]   [-g|--gui]
+                    ['git diff' options]
 USAGE
 	exit 1;
 }
@@ -62,14 +63,20 @@ sub generate_command
 			$skip_next = 1;
 			next;
 		}
-		if ($arg =~ /^--extcmd=/) {
-			$ENV{GIT_DIFFTOOL_EXTCMD} = substr($arg, 9);
-			next;
-		}
 		if ($arg =~ /^--tool=/) {
 			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
 		}
+		if ($arg eq '-x' || $arg eq '--extcmd') {
+			usage() if $#ARGV <= $idx;
+			$ENV{GIT_DIFFTOOL_EXTCMD} = $ARGV[$idx + 1];
+			$skip_next = 1;
+			next;
+		}
+		if ($arg =~ /^--extcmd=/) {
+			$ENV{GIT_DIFFTOOL_EXTCMD} = substr($arg, 9);
+			next;
+		}
 		if ($arg eq '-g' || $arg eq '--gui') {
 			my $tool = Git::command_oneline('config',
 			                                'diff.guitool');
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 1d9e07b..69e1c34 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -225,8 +225,16 @@ test_expect_success 'difftool.<tool>.path' '
 test_expect_success 'difftool --extcmd=cat' '
 	diff=$(git difftool --no-prompt --extcmd=cat branch) &&
 	test "$diff" = branch"$LF"master
+'
 
+test_expect_success 'difftool --extcmd cat' '
+	diff=$(git difftool --no-prompt --extcmd cat branch) &&
+	test "$diff" = branch"$LF"master
+'
 
+test_expect_success 'difftool -x cat' '
+	diff=$(git difftool --no-prompt -x cat branch) &&
+	test "$diff" = branch"$LF"master
 
 
 '
-- 
1.6.6.6.g627fb.dirty

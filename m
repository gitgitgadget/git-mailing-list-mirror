From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] format-patch: autonumber by default
Date: Thu,  2 Oct 2008 22:15:00 +0200
Message-ID: <1222978500-5780-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <20081002200333.GA29303@coredump.intra.peff.net>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 22:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlUb9-0005oj-KY
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 22:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbYJBUPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbYJBUPD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 16:15:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:1524 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbYJBUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 16:15:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so861100fgg.17
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0a/zNNKaBhg3lFYCGTB6Trj6M4qMRmFj/lO59VOCOh0=;
        b=oIKFGm9GJxBqywP+S1rC388bS+S05FO0gf6B5UWcd2e9g3Isx/i/Edg4t6gFac7XCk
         H7nhCHJUoTW6FZ9w7Zq+kupBDMIHbKKX449K6qjIaYSd3+tINmAsRsKuCZf3QPTBgTvi
         lUC5wdmAR2QuBteBqBKjO5APOYxv0DSk7yqus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ApB0cu/4fda+4QipN/qla1PqsuBlGfJWVgq0jd6n3ngnSDWTzbOMcJRLwWHlaYkewI
         8ubsVDrILVWb5Fi7uVELkprK8JzSwYKSCHTGaS2UotBiLeVzzSzx6f4cXNpXqdTsDFfC
         VhB3uYmNmYDKyfeEcS/vLKOex1w6RL0UaVGxU=
Received: by 10.181.11.3 with SMTP id o3mr29616bki.105.1222978498898;
        Thu, 02 Oct 2008 13:14:58 -0700 (PDT)
Received: from localhost ([78.13.48.14])
        by mx.google.com with ESMTPS id 31sm9856631nfu.9.2008.10.02.13.14.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 13:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <20081002200333.GA29303@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97368>

format-patch is most commoly used for multiple patches at once when
sending a patchset, in which case we want to number the patches; on the
other hand, single patches are not usually expected to be numbered.

In other words, the typical behavior expected from format-patch is the
one obtained by enabling autonumber, so we set it to be the default.

Users that want to disable numbering for a particular patchset can do so
with the existing -N command-line switch. For users that want to change
the default behavior we provide a 'noauto' option for the
format.numbering config key.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/config.txt           |    5 +++--
 Documentation/git-format-patch.txt |    9 ++++++---
 builtin-log.c                      |    6 +++++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbe38cc..9a9ed98 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -633,8 +633,9 @@ fetch.unpackLimit::
 format.numbered::
 	A boolean which can enable sequence numbers in patch subjects.
 	Setting this option to "auto" will enable it only if there is
-	more than one patch.  See --numbered option in
-	linkgit:git-format-patch[1].
+	more than one patch. This is the default behavior and can be
+	disabled by setting this option to "noauto".  See --numbered
+	option in linkgit:git-format-patch[1].
 
 format.headers::
 	Additional email headers to include in a patch to be submitted
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index adb4ea7..d7be5bb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -59,7 +59,9 @@ If -o is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
 If -n is specified, instead of "[PATCH] Subject", the first line
-is formatted as "[PATCH n/m] Subject".
+is formatted as "[PATCH n/m] Subject". This is the default behavior
+when outputting more than one patch, and it can be suppressed with
+the -N command line option.
 
 If given --thread, 'git-format-patch' will generate In-Reply-To and
 References headers to make the second and subsequent patch mails appear
@@ -171,14 +173,15 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
 in the repository configuration, new defaults for the subject prefix
-and file suffix, and number patches when outputting more than one.
+and file suffix, and disable automatic numbering of patches when outputting
+more than one.
 
 ------------
 [format]
 	headers = "Organization: git-foo\n"
 	subjectprefix = CHANGE
 	suffix = .txt
-	numbered = auto
+	numbered = noauto
 	cc = <email>
 ------------
 
diff --git a/builtin-log.c b/builtin-log.c
index fc5e4da..5187dc2 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -426,7 +426,7 @@ static int istitlechar(char c)
 
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
-static int auto_number = 0;
+static int auto_number = 1;
 
 static char **extra_hdr;
 static int extra_hdr_nr;
@@ -484,6 +484,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			auto_number = 1;
 			return 0;
 		}
+		if (value && !strcasecmp(value, "noauto")) {
+			auto_number = 0;
+			return 0;
+		}
 		numbered = git_config_bool(var, value);
 		return 0;
 	}
-- 
1.5.6.5

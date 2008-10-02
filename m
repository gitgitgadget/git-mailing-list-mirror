From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 16:41:45 -0400
Message-ID: <20081002204145.GA98400@Hermes>
References: <91634D16-B28A-4458-97A9-C469B5AF4E5D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:43:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlV0t-00089j-4D
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 22:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbYJBUlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 16:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbYJBUlx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 16:41:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53665 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbYJBUlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 16:41:51 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 84F481FFC4C0; Thu,  2 Oct 2008 20:41:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,UNPARSEABLE_RELAY 
	autolearn=no version=3.1.7-deb
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id E3CC11FFC438;
	Thu,  2 Oct 2008 20:41:42 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <91634D16-B28A-4458-97A9-C469B5AF4E5D@silverinsanity.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97371>


format-patch is most commonly used for multiple patches at once when
sending a patchset, in which case we want to number the patches; on
the other hand, single patches are not usually expected to be
numbered.

In other words, the typical behavior expected from format-patch is the
one obtained by enabling autonumber, so we set it to be the default.

Users that want to disable numbering for a particular patchset can do
so with the existing -N command-line switch.  Users that want to
change the default behavior can use the format.numbering config key.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 This is what I was talking about.  The appropriate setting to turn it off is
 "false", not "noauto".

 Re-sending with the correct CC list.

 Documentation/config.txt           |    9 +++++----
 Documentation/git-format-patch.txt |    8 +++++---
 builtin-log.c                      |    3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da18a54..5ba3ffa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -640,10 +640,11 @@ fetch.unpackLimit::
 	`transfer.unpackLimit` is used instead.
 
 format.numbered::
-	A boolean which can enable sequence numbers in patch subjects.
-	Setting this option to "auto" will enable it only if there is
-	more than one patch.  See --numbered option in
-	linkgit:git-format-patch[1].
+	A boolean which can enable or disable sequence numbers in patch
+	subjects.  It defaults to "auto" which enables it only if there
+	is more than one patch.  It can be enabled or disabled for all
+	messages by setting it to "true" or "false".  See --numbered
+	option in linkgit:git-format-patch[1].
 
 format.headers::
 	Additional email headers to include in a patch to be submitted
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index adb4ea7..ac36ce8 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -58,8 +58,10 @@ output, unless the --stdout option is specified.
 If -o is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
-If -n is specified, instead of "[PATCH] Subject", the first line
-is formatted as "[PATCH n/m] Subject".
+By default, the subject of a single patch is "[PATCH] First Line" and
+the subject when multiple patches are output is "[PATCH n/m] First
+Line". To force 1/1 to be added for a single patch, use -n.  To omit
+patch numbers from the subject, use -N
 
 If given --thread, 'git-format-patch' will generate In-Reply-To and
 References headers to make the second and subsequent patch mails appear
@@ -81,7 +83,7 @@ include::diff-options.txt[]
 
 -n::
 --numbered::
-	Name output in '[PATCH n/m]' format.
+	Name output in '[PATCH n/m]' format, even with a single patch.
 
 -N::
 --no-numbered::
diff --git a/builtin-log.c b/builtin-log.c
index fc5e4da..93987ee 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -426,7 +426,7 @@ static int istitlechar(char c)
 
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
-static int auto_number = 0;
+static int auto_number = 1;
 
 static char **extra_hdr;
 static int extra_hdr_nr;
@@ -485,6 +485,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			return 0;
 		}
 		numbered = git_config_bool(var, value);
+		auto_number &&= numbered;
 		return 0;
 	}
 
-- 
1.6.0.2.589.gcd70

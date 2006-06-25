From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-grep: allow patterns starting with -
Date: Sun, 25 Jun 2006 17:38:41 +0200
Message-ID: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 25 17:38:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuWhE-00014x-RK
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 17:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFYPip (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 11:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFYPip
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 11:38:45 -0400
Received: from moooo.ath.cx ([85.116.203.178]:60140 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751110AbWFYPip (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 11:38:45 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22633>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
I did not find another way to use patterns starting with -, if it is
possible without the patch please tell me and ignore the patch :)
example:
% git grep -- --bla HEAD HEAD~1 -- --foo
HEAD:--foo/bla:test --bla foo

 builtin-grep.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 2e7986c..d0677cc 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -817,8 +817,13 @@ int cmd_grep(int argc, const char **argv
 			}
 			usage(builtin_grep_usage);
 		}
-		if (!strcmp("--", arg))
+		if (!strcmp("--", arg)) {
+			if (!opt.pattern_list && argc > 0) {
+				argc--; argv++;
+				add_pattern(&opt, *argv, "command line", 0);
+			}
 			break;
+		}
 		if (*arg == '-')
 			usage(builtin_grep_usage);
 
-- 
1.4.1.rc1.g29f4a-dirty

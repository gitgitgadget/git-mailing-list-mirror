From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Make git add -u honor --dry-run
Date: Thu, 15 May 2008 18:20:59 +0200
Message-ID: <1210868459-9511-1-git-send-email-vmiklos@frugalware.org>
References: <482C5FF8.1060200@isy.liu.se>
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwgDN-0002sZ-2R
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 18:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbYEOQU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756804AbYEOQU7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 12:20:59 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41667 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672AbYEOQU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 12:20:59 -0400
Received: from vmobile.example.net (dhcp-8.r.wlan.bme.hu [152.66.144.8])
	by yugo.frugalware.org (Postfix) with ESMTP id C9F011DDC5B;
	Thu, 15 May 2008 18:20:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A704E185E19; Thu, 15 May 2008 18:20:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <482C5FF8.1060200@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82210>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, May 15, 2008 at 06:08:24PM +0200, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> I'm not familiar enough with the code to see how to best fix it.

Something like this?

 builtin-add.c         |    3 ++-
 t/t2200-add-update.sh |    7 +++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 4a91e3e..222497d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -212,7 +212,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		if (read_cache() < 0)
 			die("index file corrupt");
 		pathspec = get_pathspec(prefix, argv);
-		add_files_to_cache(verbose, prefix, pathspec);
+		if(!show_only)
+			add_files_to_cache(verbose, prefix, pathspec);
 		goto finish;
 	}
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index b664341..13ad975 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -88,6 +88,13 @@ test_expect_success 'replace a file with a symlink' '
 
 '
 
+test_expect_success 'add everything changed with --dry-run' '
+
+	git add -u --dry-run &&
+	test -n "$(git diff-files)"
+
+'
+
 test_expect_success 'add everything changed' '
 
 	git add -u &&
-- 
1.5.5.1.211.g65ea3.dirty

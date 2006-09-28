From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-format-patch: fix bug using -o in subdirectories
Date: Thu, 28 Sep 2006 21:55:35 +0200
Message-ID: <20060928195535.GA25262@moooo.ath.cx>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com> <20060922111201.GA10124@moooo.ath.cx> <fcaeb9bf0609280325l1e88e9u75e8eac122e05e60@mail.gmail.com> <7vzmckufu0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:56:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1yz-0001u5-CX
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWI1Tzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWI1Tzm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:55:42 -0400
Received: from moooo.ath.cx ([85.116.203.178]:22225 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751930AbWI1Tzl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 15:55:41 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzmckufu0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28044>

This was introduced by me in commit v1.4.2.1-gc08e524.

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Junio C Hamano <junkio@cox.net> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> 
> > This patch works great. I assume you forgot it?
> 
> Thanks for reminding.
Argh, there is a bug.  When prefix is not NULL and -o is specified
git-format-patch fails:
~/src/git/a% ../git-format-patch -o ./b HEAD~1
fatal: Two output directories?
---
 builtin-log.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 130b53a..9d1ceae 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -270,8 +270,6 @@ int cmd_format_patch(int argc, const cha
 
 	rev.extra_headers = extra_headers;
 
-	output_directory = prefix;
-
 	/*
 	 * Parse the arguments before setup_revisions(), or something
 	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
@@ -350,6 +348,9 @@ int cmd_format_patch(int argc, const cha
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 
+	if (!output_directory)
+		output_directory = prefix;
+
 	if (output_directory) {
 		if (use_stdout)
 			die("standard output, or directory, which one?");
-- 
1.4.2.1.ge767

From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 05/11] parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
Date: Fri, 20 Jun 2008 01:22:30 +0200
Message-ID: <adba33a239d99b30fcccedc0638b060daec1016e.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
 <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
 <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TTe-0006Lk-E3
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYFSXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYFSXWo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46947 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYFSXWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:40 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 394CF1DDC5E
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AAD0518E0E9; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <702cfa09fdf6203e1199415af21de787c4a19ead.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85565>

This new option tells parse-options not to ignore argv[0]. This is
useful when argv cames from split_cmdline(), as in that case argv[0]
contains a valuable option as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 parse-options.c |    5 +++++
 parse-options.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b98833c..1d01a86 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -249,6 +249,11 @@ int parse_options(int argc, const char **argv, const struct option *options,
 {
 	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
 
+	if (flags & PARSE_OPT_ARGV0_IS_AN_OPTION) {
+		args.argv = argv;
+		args.argc = argc;
+	}
+
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
 
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..3238401 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -20,6 +20,7 @@ enum parse_opt_type {
 enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1,
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+	PARSE_OPT_ARGV0_IS_AN_OPTION = 4,
 };
 
 enum parse_opt_option_flags {
-- 
1.5.6

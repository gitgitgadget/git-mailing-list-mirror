From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 05/10] parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
Date: Wed, 11 Jun 2008 22:50:29 +0200
Message-ID: <7b7cdd9349feee76ad97243df807f8f360484083.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
 <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
 <dedcc8309fed3282df455bec7fbc9d0f8275b74b.1213217187.git.vmiklos@frugalware.org>
 <9a5a141bd92756b529514579818a2c59a1a03899.1213217187.git.vmiklos@frugalware.org>
 <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XIq-0000Zk-Na
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYFKUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbYFKUuo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32879 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYFKUug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:36 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 8A1321DDC60
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:32 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8D16318DFDE; Wed, 11 Jun 2008 22:50:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <c72207b02d37f3d8c064534264219f4dd38c7559.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84659>

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
1.5.6.rc2.dirty

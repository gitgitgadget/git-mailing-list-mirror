From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 05/10] parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
Date: Thu,  5 Jun 2008 22:44:31 +0200
Message-ID: <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
 <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org>
 <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org>
 <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 22:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MLe-0006Hd-OK
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 22:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbYFEUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYFEUoo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 16:44:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46515 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbYFEUod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 16:44:33 -0400
Received: from vmobile.example.net (dsl5401CC68.pool.t-online.hu [84.1.204.104])
	by yugo.frugalware.org (Postfix) with ESMTP id D82861DDC60
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 22:44:29 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id BE5C918E2AA; Thu,  5 Jun 2008 22:44:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1212698317.git.vmiklos@frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83974>

This new option tells parse-options not to ignore argv[0]. This is
useful when argv cames from split_cmdline(), as in that case argv[0]
contains a valuable option as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 parse-options.c |    5 +++++
 parse-options.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index aa164d0..4d4f302 100644
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
1.5.6.rc0.dirty

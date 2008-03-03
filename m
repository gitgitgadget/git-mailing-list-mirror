From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] More on worktree fixes
Date: Sun, 02 Mar 2008 16:28:09 -0800
Message-ID: <7vejasmz1i.fsf@gitster.siamese.dyndns.org>
References: <20080302103300.GA8867@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVyY5-0000lJ-D6
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 01:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbYCCA2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 19:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYCCA2W
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 19:28:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbYCCA2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 19:28:18 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B1DB2083;
	Sun,  2 Mar 2008 19:28:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BCBEB2080; Sun,  2 Mar 2008 19:28:13 -0500 (EST)
In-Reply-To: <20080302103300.GA8867@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of "Sun, 2 Mar 2008 17:33:00
 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75860>

Will replace what has been queued in 'pu', but I had to apply the same
fix-up as I did to the previous round when I queued the previous round.

Interdiff below...

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 2a7687e..eebbd6b 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -17,7 +17,6 @@ int cmd_bundle(int argc, const char **argv, const char *unused_prefix)
 	int nongit = 0;
 	const char *cmd, *bundle_file;
 	int bundle_fd = -1;
-	char buffer[PATH_MAX];
 
 	if (argc < 3)
 		usage(bundle_usage);
diff --git a/setup.c b/setup.c
index f0de42f..e225597 100644
--- a/setup.c
+++ b/setup.c
@@ -318,9 +318,6 @@ void setup_git_directory_gently(int *nongit_ok)
 		if (PATH_MAX - 40 < strlen(gitdirenv))
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 		if (is_git_directory(gitdirenv)) {
-			static char buffer[1024 + 1];
-			const char *retval;

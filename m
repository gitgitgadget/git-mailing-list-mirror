From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] help -a: do not unnecessarily look for a repository
Date: Wed, 28 Oct 2009 09:30:22 +0000
Message-ID: <20091028093022.30253.qmail@d8110c1e8cdcdf.315fe32.mid.smarden.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org> <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302> <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org> <20091027133040.28836.qmail@fe20635a713ff7.315fe32.mid.smarden.org> <7viqe0yrnu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34rU-0005Zs-O6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbZJ1JaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbZJ1JaX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:30:23 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:4388 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754444AbZJ1JaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:30:22 -0400
Received: (qmail 30254 invoked by uid 1000); 28 Oct 2009 09:30:22 -0000
Content-Disposition: inline
In-Reply-To: <7viqe0yrnu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131440>

Although 'git help -a' actually doesn't need to be run inside a git
repository and uses no repository-specific information, it looks for a
git directory.  On 'git <TAB><TAB>' the bash completion runs 'git help
-a' and unnecessary searching for a git directory can be annoying in
auto-mount environments.  With this commit, 'git help' no longer
searches for a repository when run with the -a option.

The fix is from Johannes Schindelin, the annoying behavior has been
reported by Vincent Danjean through
 http://bugs.debian.org/539273

Signed-off-by: Gerrit Pape <pape@smarden.org>
---

On Tue, Oct 27, 2009 at 11:11:01PM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Hi Junio, I suggest to apply this patch from Johannes to master.

> Could you help by coming up with a suitable log message?
>
> It's a bit too much to ask me to hunt for ancient discussion to
> correct the <<all the ack go here>> myself to describe what the
> issue was,

Sure, sorry for that.  Regards, Gerrit.


 builtin-help.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index e1ade8e..ca08519 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -417,9 +417,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	const char *alias;
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
-
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 
@@ -430,6 +427,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+
 	if (!argv[0]) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
-- 
1.6.5.2

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from searching
 for git repository
Date: Fri, 4 Sep 2009 12:22:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjVwt-0002g4-1w
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbZIDKWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933478AbZIDKWh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:22:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:49218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933437AbZIDKWg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:22:36 -0400
Received: (qmail invoked by alias); 04 Sep 2009 10:22:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp043) with SMTP; 04 Sep 2009 12:22:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qbv8z8PIqjg7vZK1VCSMl+Kq0bT/smF/CPLo2g4
	LPUBdID8eOO99G
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127703>

Hi,

On Fri, 4 Sep 2009, Gerrit Pape wrote:

> On 'git <TAB><TAB>' the bash completion runs 'git help -a'.

Correct me if I am wrong, but does "git help -a" not list aliases?  If it 
does, "git help" must search for the Git repository.

If it does not, then "git help" needs fixing, not the completions.  I.e. 
something like this:

-- snipsnap --
[PATCH] git help -a: do not look for a repository

<all the acknowledgements go here>

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-help.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index e1eba77..719aa23 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -416,9 +416,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	const char *alias;
 	load_command_list("git-", &main_cmds, &other_cmds);
 
-	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
-
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 
@@ -429,6 +426,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+
 	if (!argv[0]) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();

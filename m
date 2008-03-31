From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] aliases not working outside of a working copy
Date: Mon, 31 Mar 2008 17:46:04 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0803311745170.18259@racer.site>
References: <8aa486160803310819r3a905bbeg5f993a55aaf6efbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1489964442-1206978365=:18259"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 17:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgMDh-0007EC-Ed
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 17:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYCaPqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYCaPqG
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 11:46:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:46449 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752743AbYCaPqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 11:46:05 -0400
Received: (qmail invoked by alias); 31 Mar 2008 15:46:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 31 Mar 2008 17:46:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MnWVHlpiMjWBxRdEgNoO0SSm1g+21miZtf9WUNV
	o9FJLIEHu1yAtB
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160803310819r3a905bbeg5f993a55aaf6efbf@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78587>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1489964442-1206978365=:18259
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 31 Mar 2008, Santi Béjar wrote:

> af05d67 (Always set *nongit_ok in setup_git_directory_gently())
> 
> The problem is with the alias system that detects if you are in a
> working copy, not with the command, as the
> command just works fine.

Ah, right.  I think that this hunk:

diff --git a/git.c b/git.c
index 13de801..b7729d7 100644
--- a/git.c
+++ b/git.c
@@ -142,14 +142,14 @@ static int split_cmdline(char *cmdline, const char ***arg

 static int handle_alias(int *argcp, const char ***argv)
 {
-       int nongit = 0, envchanged = 0, ret = 0, saved_errno = errno;
+       int envchanged = 0, ret = 0, saved_errno = errno;
        const char *subdir;
        int count, option_count;
        const char** new_argv;
        const char *alias_command;
        char *alias_string;

-       subdir = setup_git_directory_gently(&nongit);
+       subdir = setup_git_directory_gently(NULL);

        alias_command = (*argv)[0];
        alias_string = alias_lookup(alias_command);


of the commit you mentioned is utterly wrong.

Ciao,
Dscho

--8323584-1489964442-1206978365=:18259--

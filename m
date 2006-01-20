From: sean <seanlkml@sympatico.ca>
Subject: git-grep documentation
Date: Fri, 20 Jan 2006 08:47:23 -0500
Message-ID: <BAYC1-PASMTP07F7EA1F3B544C07AA01F8AE1F0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 20 14:52:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezwga-00082M-NT
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 14:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWATNwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 08:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWATNwO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 08:52:14 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:35426 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750974AbWATNwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 08:52:13 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 20 Jan 2006 05:53:27 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 376D1644C23
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 08:52:11 -0500 (EST)
To: git@vger.kernel.org
Message-Id: <20060120084723.5ba3170d.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 20 Jan 2006 13:53:28.0093 (UTC) FILETIME=[E3E7ECD0:01C61DC8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


It looks as though git-grep.sh was coded to allow git-ls-files
options to be passed after a '--' marker.   However, this marker will 
never be seen by the script unless the user identifies the <pattern>
by preceding it with an '-e'.   

If it's not seen the '--' ends up getting passed to git-ls-files and any
options are mistakenly interpreted as paths.  For instance, the following
two commands will do different things:

$ git-grep -e NAME -- --others Documentation/git-grep.txt
$ git-grep    NAME -- --others Documentation/git-grep.txt


Either the comment in the git-grep.sh script should be changed to
say that only paths are acceptable after the '--' or fixed up to 
handle this case a bit better.   The documentation patch below is 
only applicable if the script is fixed first.

Sean


diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2bfd8ed..c2c6ff3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -8,7 +8,7 @@ git-grep - print lines matching a patter
 
 SYNOPSIS
 --------
-'git-grep' [<option>...] <pattern> [<path>...]
+'git-grep' [<option>...] [-e] <pattern> [-- [<ls option>...]] [<path>...]
 
 DESCRIPTION
 -----------
@@ -20,12 +20,21 @@ OPTIONS
 -------
 <option>...::
 	Either an option to pass to `grep` or `git-ls-files`.
-	Some `grep` options, such as `-C` and `-m`, that take
-	parameters are known to `git-grep`.
+
+	The specific `git-ls-files` options that may be supplied are:
+	`--cached`, `--deleted`, `--others`, `--killed`, `--ignored`, 
+	`--exclude=*`, `--exclude-from=*`, or `--exclude-per-directory=*`.
+	
+	All other options will be passed to `grep`.
 
 <pattern>::
 	The pattern to look for.
 
+<ls option>...::
+	Additional options for `git-ls-files` which must be preceded
+	by the '--' marker.   See `git-ls-files` for a list of 
+	available options.
+
 <path>...::
 	Optional paths to limit the set of files to be searched;
 	passed to `git-ls-files`.

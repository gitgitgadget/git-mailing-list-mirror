From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.13
Date: Wed, 14 Jan 2009 00:36:43 +0100
Message-ID: <20090113233643.GA28898@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 00:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMsq3-000066-E1
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 00:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759522AbZAMXhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 18:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759911AbZAMXhA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 18:37:00 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:55119 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759725AbZAMXg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 18:36:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 6A63B52C468
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:36:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNKuNd+KPs7d for <git@vger.kernel.org>;
	Wed, 14 Jan 2009 00:36:44 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7A81C52C30F
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:36:43 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 407D16DFD25
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:35:35 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 66A3D39A9FE; Wed, 14 Jan 2009 00:36:43 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105559>

Hello,

This release contains a major rewrite of the IO layer of tig to use
fork+exec instead of popen() and remove use of stdio's fopen() and
friends. The new IO API removes the need for shell quoting and improves
the overall speed of loading view data. On the downside, it brings a few
incompatibilities wrt. commands given via the environment. While the
patch series began by being based on git's run-command.c module, the
final version contains no code from git.

The release also brings a few new features, such as new identifiers for
use in external commands as well as a handful of bug fixes.

What is tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various git
commands.

 - Homepage:	http://jonas.nitro.dk/tig/
 - Manual:	http://jonas.nitro.dk/tig/manual.html
 - Tarballs:	http://jonas.nitro.dk/tig/releases/
 - Git URL:	git://repo.or.cz/tig.git 
 - Gitweb:	http://repo.or.cz/w/tig.git

Release notes
-------------
Incompatibilities:

 - Commands from the environment (e.g. TIG_MAIN_CMD) will no longer have
   access to shell features, such as subshells and variable expansion.
   The easiest way to upgrade your configuration is to put such commands
   in a script file.

Improvements:

 - Display repository references in the sorted order: tags, heads,
   tracked remotes, remotes.
 - Add bash completion for blame.
 - Tree view: edit files of the current branch.
 - Run requests: new identifiers %(directory), %(file), and %(ref)
 - Improve responsiveness and view loading speed by using select(2).

Bug fixes:

 - Separate blame revision and file argument by "--" to avoid problems.
 - Main view: fix redrawing of the last commit wrt. the revision graph.
 - Fix waiting for input after executing a run request in pager mode.
 - Status & stage view: refuse to open directories and deleted files.
 - Tree view: show error when requesting blame for all non-file entries.
 - Do not draw loading views, which are not displayed.
 - Fix launching of mergetool from a subdirectory.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 NEWS                        |   29 +
 VERSION                     |    2 +-
 contrib/announcement.sh     |    2 +-
 contrib/tig-completion.bash |   25 +-
 manual.txt                  |  281 ++++---
 tig.1.txt                   |    6 +-
 tig.c                       | 1774 +++++++++++++++++++++--------------
 tigrc.5.txt                 |   23 +-
 8 files changed, 1325 insertions(+), 817 deletions(-)

    53	Jonas Fonseca

-- 
Jonas Fonseca

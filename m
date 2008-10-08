From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig-0.12.1
Date: Wed, 8 Oct 2008 15:14:08 +0200
Message-ID: <20081008131408.GA24706@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 15:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnYt1-00047a-1q
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 15:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYJHNOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbYJHNOP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 09:14:15 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:33365 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbYJHNON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 09:14:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 8720F19BF41
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 15:14:11 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08256-08 for <git@vger.kernel.org>; Wed,  8 Oct 2008 15:14:08 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id C490E19BF40
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 15:14:08 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id A88336DF88D
	for <git@vger.kernel.org>; Wed,  8 Oct 2008 15:13:14 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 97E2B1A4001; Wed,  8 Oct 2008 15:14:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97797>

Hello,

It's time for another release of tig, this one tagged as a minor update
focusing mainly on bug fixes. There are, however, also a few nice
usability improvements, such as support for reverting uncommitted and
unstaged changes and reloading of repository references when refreshing
the views using them.  Note that this version of tig depends on git
version 1.5.4 or newer!

In the pipeline, I have a scary patch containing 859 insertions and 462
deletions, which I plan to release as the equally scary version 0.13.
The patch imports git's run-command.c module, which should remove
problems related to using stdio and will also remove the need to do
nasty things such as shell quoting. This is still a work in progress and
needs some more polishing and testing, but should anybody be interested,
it is available in the wip/run-command branch (to be rebased at will).

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
Improvements:

 - Status view: revert uncommitted diff chunks and unstaged files with
   changes. Bound to '!' by default.
 - Main view: use --topo-order also when rev-list arguments are given on
   the command line.
 - Log view: support for refreshing.

Bug fixes:

 - Status view: use ls-files' --exclude-standard so user specific ignore
   rules are effective. The option was added in git version 1.5.4.
 - Stage view: fix assertion failure triggered when updating while
   status view is not displayed.
 - Help view: avoid confusion by showing "(no key)" instead of "'?'" for
   unbound requests.
 - Reload repository references when refreshing the main (and log) view.
 - Do not maximize views when refreshing.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 NEWS                    |   22 +++
 TODO                    |    9 +-
 VERSION                 |    2 +-
 configure.ac            |    8 +-
 contrib/announcement.sh |   53 ++++++
 manual.txt              |    2 +
 tig.c                   |  381 +++++++++++++++++++++++++++------------
 7 files changed, 351 insertions(+), 126 deletions(-)

Jonas Fonseca (25):
      Add script for preparing release announcements
      TODO: support for jumping to parents' blame in the blame view
      status: add support for checking out files with unstaged changes
      main: automatically refresh after run requests
      Main: use --topo-order when arguments are given on the command line
      Cleanup exclude rule setup by using ls-files --exclude-standard flag
      Also allow files to be checked out from stage view
      Avoid refreshing views when checkout is canceled by user
      Reload repository references when refreshing the main view
      Make GIT_CONFIG only contain the config subcommand
      Improve handling of unmatched quotes in ~/.tigrc
      Cleanup and make option argument strings const
      Improve checkout error reporting
      Show complete shortlog for small releases
      Simplify view refreshing by adding new OPEN_REFRESH flag for open_view
      Make OPEN_REFRESH imply OPEN_NOMAXIMIZE
      Add support for refreshing the log view
      Fix bug introduced in commit for using --exclude-standard flag
      Clear the status line when closing a view
      Help view: use "(no key)" instead of "'?'" to not confuse unbound actions
      Help view: move requests from the Misc group into separate groups
      Consolidate and share view resetting via new reset_view()
      Avoid triggering assertion failure when reloading the status view
      Rename checkout to revert and support individual diff chunks reverts
      tig-0.12.1

-- 
Jonas Fonseca

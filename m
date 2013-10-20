From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Documentation: revamp gitk(1)
Date: Sun, 20 Oct 2013 18:57:41 +0200
Message-ID: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
References: <cover.1370806329.git.trast@inf.ethz.ch> <874nblpamj.fsf@linux-k42r.v.cablecom.net> <874nbdnomj.fsf@hexa.v.cablecom.net> <51F6CB7D.1070806@web.de> <87siyu98cq.fsf@linux-k42r.v.cablecom.net> <20130818115456.GA6772@iris.ozlabs.ibm.com> <874namay5p.fsf@linux-k42r.v.cablecom.net> <xmqq61v18u5s.fsf@gitster.dls.corp.google.com> <87k3hhadhj.fsf@linux-k42r.v.cablecom.net> <20131014052547.GB25344@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 20 18:57:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXwK8-0000Qz-3O
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 18:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab3JTQ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Oct 2013 12:57:48 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:4181 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab3JTQ5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Oct 2013 12:57:47 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 20 Oct
 2013 18:57:36 +0200
Received: from linux-a99i.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 20 Oct
 2013 18:57:42 +0200
X-Mailer: git-send-email 1.8.4.1.810.g312044e
In-Reply-To: <20131014052547.GB25344@google.com>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236419>

The gitk manpage suffers from a bit of neglect: there have been only
minor changes, and no changes to the set of options documented, since
a2df1fb (Documentation: New GUI configuration and command-line
options., 2008-11-13).  In the meantime, the set of rev-list options
has been expanded several times by options that are useful in gitk,
e.g., --ancestry-path and the optional globbing for --branches, --tags
and --remotes.

Restructure and expand the manpage.  List more options that the author
perceives as useful, while remaining somewhat terse.  Ideally the user
should not have to look up any of the references, but we dispense with
precise explanations in some places and refer to git-log(1) instead.

Note that the options that have an easy GUI equivalent (e.g.,
--word-diff, -S, --grep) are deliberately not listed even in the cases
where they simply fill in the GUI fields.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

Jonathan Nieder wrote:
> Support for just the sticked form is better than nothing, especially
> if the gitk(1) manpage gains a note about it.  In the long run I guess
> the ideal would be to add a parse-options-like library to the tcl
> support.

Ok.  I'm generally not happy with the state of that manpage, so I took
the chance to improve it (and include a note about sticked forms).
The approach is really my own opinion; I ran a half-hearted attempt at
an IRC survey but none of the willing victims had any 'gitk'
invocations in their history.

I'll hold the gitk patches until we get this one sorted out, but then
just do the sticked form as before.


 Documentation/gitk.txt | 107 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c17e760..d44e14c 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -8,7 +8,7 @@ gitk - The Git repository browser
 SYNOPSIS
 --------
 [verse]
-'gitk' [<option>...] [<revs>] [--] [<path>...]
+'gitk' [<options>] [<revision range>] [\--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -16,21 +16,38 @@ Displays changes in a repository or a selected set of commits. This includes
 visualizing the commit graph, showing information related to each commit, and
 the files in the trees of each revision.
 
-Historically, gitk was the first repository browser. It's written in tcl/tk
-and started off in a separate repository but was later merged into the main
-Git repository.
-
 OPTIONS
 -------
-To control which revisions to show, the command takes options applicable to
-the 'git rev-list' command (see linkgit:git-rev-list[1]).
-This manual page describes only the most
-frequently used options.
 
--n <number>::
---max-count=<number>::
+To control which revisions to show, gitk supports most options
+applicable to the 'git rev-list' command.  It also supports a few
+options applicable to the 'git diff-*' commands to control how the
+changes each commit introduces are shown.  Finally, it supports some
+gitk-specific options.
+
+gitk generally only understands options with arguments in the
+'sticked' form (see linkgit:gitcli[7]) due to limitations in the
+command line parser.
+
+rev-list options and arguments
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This manual page describes only the most frequently used options.  See
+linkgit:git-rev-list[1] for a complete list.
+
+--all::
+
+	Show all refs (branches, tags, etc.).
 
-	Limits the number of commits to show.
+--branches[=<pattern>]::
+--tags[=<pattern>]::
+--remotes[=<pattern>]::
+
+	Pretend as if all the branches (tags, remote branches, resp.)
+	are listed on the command line as '<commit>'. If '<pattern>'
+	is given, limit refs to ones matching given shell glob. If
+	pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the
+	end is implied.
 
 --since=<date>::
 
@@ -40,9 +57,9 @@ frequently used options.
 
 	Show commits older than a specific date.
 
---all::
+--date-order::
 
-	Show all branches.
+	Sort commits by date when possible.
 
 --merge::
 
@@ -51,19 +68,37 @@ frequently used options.
 	that modify the conflicted files and do not exist on all the heads
 	being merged.
 
---argscmd=<command>::
-	Command to be run each time gitk has to determine the list of
-	<revs> to show.  The command is expected to print on its standard
-	output a list of additional revs to be shown, one per line.
-	Use this instead of explicitly specifying <revs> if the set of
-	commits to show may vary between refreshes.
+--left-right::
 
---select-commit=<ref>::
+	Mark which side of a symmetric diff a commit is reachable
+	from.  Commits from the left side are prefixed with a `<`
+	symbol and those from the right with a `>` symbol.
 
-	Automatically select the specified commit after loading the graph.
-	Default behavior is equivalent to specifying '--select-commit=HEAD'.
+--full-history::
+
+	When filtering history with '<path>...', does not prune some
+	history.  (See "History simplification" in linkgit:git-log[1]
+	for a more detailed explanation.)
+
+--simplify-merges::
 
-<revs>::
+	Additional option to '--full-history' to remove some needless
+	merges from the resulting history, as there are no selected
+	commits contributing to this merge.  (See "History
+	simplification" in linkgit:git-log[1] for a more detailed
+	explanation.)
+
+--ancestry-path::
+
+	When given a range of commits to display
+	(e.g. 'commit1..commit2' or 'commit2 {caret}commit1'), only
+	display commits that exist directly on the ancestry chain
+	between the 'commit1' and 'commit2', i.e. commits that are
+	both descendants of 'commit1', and ancestors of 'commit2'.
+	(See "History simplification" in linkgit:git-log[1] for a more
+	detailed explanation.)
+
+<revision range>::
 
 	Limit the revisions to show. This can be either a single revision
 	meaning show from the given revision and back, or it can be a range in
@@ -78,6 +113,23 @@ frequently used options.
 	avoid ambiguity with respect to revision names use "--" to separate the paths
 	from any preceding options.
 
+gitk-specific options
+~~~~~~~~~~~~~~~~~~~~~
+
+--argscmd=<command>::
+
+	Command to be run each time gitk has to determine the revision
+	range to show.  The command is expected to print on its
+	standard output a list of additional revisions to be shown,
+	one per line.  Use this instead of explicitly specifying a
+	'<revision range>' if the set of commits to show may vary
+	between refreshes.
+
+--select-commit=<ref>::
+
+	Select the specified commit after loading the graph.
+	Default behavior is equivalent to specifying '--select-commit=HEAD'.
+
 Examples
 --------
 gitk v2.6.12.. include/scsi drivers/scsi::
@@ -101,6 +153,13 @@ Files
 Gitk creates the .gitk file in your $HOME directory to store preferences
 such as display options, font, and colors.
 
+History
+-------
+Gitk was the first graphical repository browser. It's written in
+tcl/tk and started off in a separate repository but was later merged
+into the main Git repository.
+
+
 SEE ALSO
 --------
 'qgit(1)'::
-- 
1.8.4.1.810.g312044e

From: Jonas Fonseca <fonseca@diku.dk>
Subject: [ANNOUNCE] tig - text-mode interface for git
Date: Wed, 17 May 2006 14:07:33 +0200
Message-ID: <20060517120733.GA14041@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 14:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgKoi-0001oE-H4
	for gcvg-git@gmane.org; Wed, 17 May 2006 14:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWEQMHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWEQMHj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 08:07:39 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:53121 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932216AbWEQMHi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 08:07:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id ECAB677002C
	for <git@vger.kernel.org>; Wed, 17 May 2006 14:07:36 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29334-06 for <git@vger.kernel.org>; Wed, 17 May 2006 14:07:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B874477002D
	for <git@vger.kernel.org>; Wed, 17 May 2006 14:07:33 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 1CB446DF835
	for <git@vger.kernel.org>; Wed, 17 May 2006 14:04:41 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9E98E62429; Wed, 17 May 2006 14:07:33 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20193>

Hello,

I am pleased to announce tig, a simple git repository browser written
using ncurses. Basically, it just acts as a front-end for git-log and
git-show/git-diff. Additionally, you can also use it as a pager for git
commands.

Currently, it just provides a minimum support for looking through
changes. I hope to slowly extend it to also be usable as a front-end for
git-blame and for tree browsing. Also, it doesn't do any fancy revision
graph rendering, but I want to at least give it a shot at some point. :)

Following is the man page. I've attached the tig.c file if you want to
try it out. Compile it with:

	$ cc -o tig tig.c -lncurses

More project files (including a Makefile) can be found at:

	http://jonas.nitro.dk/tig/

Obligatory screenshots at:

	http://jonas.nitro.dk/tig/screenshots/

---

NAME

   tig - text-mode interface for git

SYNOPSIS

   tig [options]
   tig [options] [--] [git log options]
   tig [options] log  [git log options]
   tig [options] diff [git diff options]
   tig [options] show [git show options]
   tig [options] <    [git command output]

DESCRIPTION

   Browse changes in a git repository. Additionally, tig(1) can also act
   as a pager for output of various git commands.

   When browsing repositories, tig(1) uses the underlying git commands
   to present the user with various views, such as summarized commit log
   and showing the commit with the log message, diffstat, and the diff.

   Using tig(1) as a pager, it will display input from stdin and try to
   colorize it.

OPTIONS

   -l
           Start up in log view using the internal log command.

   -d
           Start up in diff view using the internal diff command.

   -n[INTERVAL], --line-number[=INTERVAL]
           Prefix line numbers in log and diff view. Optionally, with
           interval different than each line.

   -t[NSPACES], --tab-size[=NSPACES]
           Set the number of spaces tabs should be expanded to.

   -v, --version
           Show version and exit.

   --
           End of tig(1) options. Useful when specifying command options
           for the main view. Example:

		$ tig -- --since=1.month

   log [git log options]
           Open log view using the given git log options.

   diff [git diff options]
           Open diff view using the given git diff options.

   show [git show options]
           Open diff view using the given git show options.

   [git log options]
           tig(1) will stop the option parsing when the first command
           line parameter not starting with "-" is encountered. All
           options including this one will be passed to git log when
           loading the main view. This makes it possible to say:

		$ tig tag-1.0..HEAD

  Pager mode

   If stdin is a pipe, any log or diff options will be ignored and the
   pager view will be opened loading data from stdin. The pager mode can
   be used for colorizing output from various git commands.

   Example on how to colorize the output of git-show(1):

	$ git show | tig

  Git command options

   All git command options specified on the command line will be passed
   to the given command and all will be shell quoted before they are
   passed to the shell.

        If you specify options for the main view, you should not use the
   Note --pretty option as this option will be set automatically to the
        format expected by the main view.

   Example on how to open the log view and show both author and
   committer information:

	$ tig log --pretty=fuller

   See the "Specifying revisions" section below for an introduction to
   revision options supported by the git commands. For details on
   specific git command options, refer to the man page of the command in
   question.

ENVIRONMENT VARIABLES

   Several options related to the interface with git can be configured
   via environment options.

  Repository references

   Commits that are referenced by tags and branch heads will be marked
   by the reference name surrounded by [ and ]:

	2006-03-26 19:42 Petr Baudis       | [cogito-0.17.1] Cogito 0.17.1

   If you want to filter out certain directories under .git/refs/, say
   tmp you can do it by setting the following variable:

	$ TIG_LS_REMOTE="git ls-remote . | sed /\/tmp\//d" tig

   Or set the variable permanently in your environment.

   TIG_LS_REMOTE

           Set command for retrieving all repository references. The
           command should output data in the same format as
           git-ls-remote(1).

  View commands

   It is possible to alter which commands are used for the different
   views. If for example you prefer commits in the main view to be
   sorted by date and only show 500 commits, use:

	$ TIG_MAIN_CMD="git log --date-order -n500 --pretty=raw %s" tig

   Or set the variable permanently in your environment.

   Notice, how %s is used to specify the commit reference. There can be
   a maximum of 5 %s ref specifications.

   TIG_DIFF_CMD

           The command used for the diff view. By default, git show is
           used as a backend.

   TIG_LOG_CMD

           The command used for the log view. If you prefer to have both
           author and committer shown in the log view be sure to pass
           --pretty=fuller to git log.

   TIG_MAIN_CMD

           The command used for the main view. Note, you must always
           specify the option: --pretty=raw since the main view parser
           expects to read that format.

The viewer

   tig(1) presents various views of a repository. Each view is based on
   output from an external command, most often git log, git diff, or git
   show.

   The main view
           Is the default view, and it shows a one line summary of each
           commit in the chosen list of revisions. The summary includes
           commit date, author, and the first line of the log message.
           Additionally, any repository references, such as tags, will
           be shown.

   The log view
           Presents a more rich view of the revision log showing the
           whole log message and the diffstat.

   The diff view
           Shows either the diff of the current working tree, that is,
           what has changed since the last commit, or the commit diff
           complete with log message, diffstat and diff.

   The pager view
           Is used for displaying both input from stdin and output from
           git commands entered in the internal prompt.

   The help view
           Displays the information from the tig(1) man page. For the
           help view to work you need to have the tig(1) man page
           installed.

KEYS

   Below the default key bindings are shown.

  View switching

   m       Switch to main view.
   d       Switch to diff view.
   l       Switch to log view.
   p       Switch to pager view.
   h       Show man page.
   Return  If on a commit line show the commit diff. Additionally, if in
           main or log view this will split the view. To open the commit
           diff in full size view either use d or press Return twice.
   Tab     Switch to next view.

  Cursor navigation

   Up      Move cursor one line up.
   Down    Move cursor one line down.
   k       Move cursor one line up and enter. When used in the main view
           this will always show the diff of the current commit in the
           split diff view.
   j       Move cursor one line down and enter.
   PgUp    Move cursor one page up.
   PgDown  Move cursor one page down.
   Home    Jump to first line.
   End     Jump to last line.

  Scrolling

   Insert  Scroll view one line up.
   Delete  Scroll view one line down.
   w       Scroll view one page up.
   s       Scroll view one page down.

  Misc

   q       Quit
   r       Redraw screen.
   z       Stop all background loading. This can be useful if you use
           tig(1) in a repository with a long history without limiting
           the revision log.
   v       Show version.
   n       Toggle line numbers on/off.
   :       Open prompt. This allows you to specify what git command to
           run. Example:

		:log -p

Revision specification

   This section describes various ways to specify what revisions to
   display or otherwise limit the view to. tig(1) does not itself parse
   the described revision options so refer to the relevant git man pages
   for futher information. Relevant man pages besides git-log(1) are
   git-diff(1) and git-rev-list(1).

   You can tune the interaction with git by making use of the options
   explained in this section. For example, by configuring the
   environment variables described in the "View commands" section.

  Limit by path name

   If you are interested only in those revisions that made changes to a
   specific file (or even several files) list the files like this:

	$ tig log Makefile

   To avoid ambiguity with repository references such as tag name, be
   sure to separate file names from other git options using "--". So if
   you have a file named master it will clash with the reference named
   master, and thus you will have to use:

	$ tig log -- master

        For the main view, avoiding ambiguity will in some cases require
   Note you to specify two "--" options. The first will make tig(1) stop
        option processing and the latter will be passed to git log.

  Limit by date or number

   To speed up interaction with git, you can limit the amount of commits
   to show both for the log and main view. Either limit by date using
   e.g. --since=1.month or limit by the number of commits using -n400.

   If you are only interested in changed that happened between two dates
   you can use:

	$ tig -- --after=May.5th --before=2006-05-16.15:44

        The dot (".") is used as a separator instead of a space to avoid
   Note having to quote the option value. If you prefer use --after="May
        5th" instead of --after="May 5th".

  Limiting by commit ranges

   Alternatively, commits can be limited to a specific range, such as
   "all commits between tag-1.0 and tag-2.0". For example:

	$ tig log tag-1.0..tag-2.0

   This way of commit limiting makes it trivial to only browse the
   commits which haven't been pushed to a remote branch. Assuming origin
   is your upstream remote branch, using:

	$ tig log origin..HEAD

   will list what will be pushed to the remote branch. Optionally, the
   ending HEAD can be left out since it is implied.

  Limiting by reachability

   Git interprets the range specifier "tag-1.0..tag-2.0" as "all commits
   reachable from tag-2.0 but not from tag-1.0". Where reachability
   refers to what commits are ancestors (or part of the history) of the
   branch or tagged revision in question.

   If you prefer to specify which commit to preview in this way use the
   following:

	$ tig log tag-2.0 ^tag-1.0

   You can think of ^ as a negation operator. Using this alternate
   syntax, it is possible to further prune commits by specifying
   multiple branch cut offs.

  Combining revisions specification

   Revisions options can to some degree be combined, which makes it
   possible to say "show at most 20 commits from within the last month
   that changed files under the Documentation/ directory."

	$ tig -- --since=1.month -n20 -- Documentation/

  Examining all repository references

   In some cases, it can be useful to query changes across all
   references in a repository. An example is to ask "did any line of
   development in this repository change a particular file within the
   last week". This can be accomplished using:

	$ tig -- --all --since=1.week -- Makefile

BUGS

   Known bugs and problems:

     * If the screen width is very small the main view can draw outside
       the current view causing bad wrapping. Same goes for title and
       status windows.

TODO

   Features that should be explored.

     * Searching.

     * Locale support.

COPYRIGHT

   Copyright (c) Jonas Fonseca <fonseca@diku.dk>, 2006

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or (at
   your option) any later version.

SEE ALSO

   git(7),
   cogito(7)
   gitk(1): git repository browser written using tcl/tk,
   gitview(1): git repository browser written using python/gtk.

-- 
Jonas Fonseca

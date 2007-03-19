From: Junio C Hamano <junkio@cox.net>
Subject: GIT v1.5.1-rc1
Date: Mon, 19 Mar 2007 03:53:47 -0700
Message-ID: <7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
	<7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 11:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTFUt-0006aP-9y
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 11:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXCSKxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 06:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbXCSKxu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 06:53:50 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46623 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXCSKxs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 06:53:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319105349.WDRQ321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 06:53:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id catn1W00T1kojtg0000000; Mon, 19 Mar 2007 06:53:48 -0400
In-Reply-To: <7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 06 Mar 2007 02:53:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42605>

Some 1000 messages ago, I sent out a short-term release plan and
listed the topics that we would want to have in 1.5.1.  As of
last week, all of them have been cooked enough in 'next' and now
are in 'master'.

The last round to reach 1.5.0 took painfully long.  While it was
worth it, considering that 1.5.0 is a big departure from 1.4.4
series and satisfied our "usability and teachability" goal, I
think we should slow down and make smaller releases a bit more
often.  So I tagged the tip of the 'master' with -rc1 tag, after
fixing one issue that has been nagging me while it was in 'next'.

So from now on until the final, which I am hoping to do before
the end of month, please concentrate on fixes and "obviously
low-impact" improvements.

With the system we have in place that uses two primary
integration branches to manage git.git project, earth-shattering
enhancements or new commands could still be cooked in 'pu', or
theoretically even in 'next' without causing problems to the
stabilization effort, but I'd rather see people's attention on
perfecting what will be in 1.5.1 before starting anything new.
I expect to spend much less time looking at any material that
are not meant for 'master' until the end of the month, so please
consider that the chance of getting things in 'next' is very
slim from now on.  I might queue new stuff in 'pu' only to give
a distribution point that is easier to access for everybody to
test, but I won't guarantee that the branch will even compile.

Having said that, there always are exceptions to the rule.

Some of the things we have reviewed and discussed on the list
for the past several days might have been good for 'next' (or
even 'master').  I did not have enough time to look at them
fully, I might have missed them, and/or I commented on them with
intention to cook them in 'next' but might have forgotten to
apply.  If they are reasonably well isolated new features
(e.g. "remote show showing push entries") I would not mind
applying them, but please make convincing sales talk to explain
why your new feature is useful to users.  If it is something so
commonly useful to be placed on "Everyday GIT", or tutorial,
adding a paragraph to these documents to show why it is a *must*
*have* is a good way to sell your ware, for example.

Also I might have dropped a handful patches to non-core area,
e.g. contrib/emacs/ and cvs interface.  Please remind me of them
if they should be in 1.5.1 by cheering them on with your Acks,
resends, and follow-up patches.

Even though it is rather core area, I suspect that it wouldn't
be a change with huge impact to exploit what Linus did today to
allow optimizing pathspec pruning in tree_entry_interesting().
If such a change is done obviously correctly, I think it is Ok
to have it in 'next' and make it graduate to 'master' before
1.5.1 final.

Although we've talked about it for a while, the more I look at
the current code, the more I feel that resolving the issue of
"read-tree -m" gotcha that causes switching between branches
that have file (or symlink) A and a directory A would be quite
high impact, so unless there is an obviously correct fix, I'd
like to defer it post 1.5.1.

Finally, here is to review what we have so far to be in the
upcoming 1.5.1.  Patches to Documentation/RelNotes-1.5.1.txt to
fill items I missed, older than ceb8442a, are very much
appreciated.


GIT v1.5.1 Release Notes (draft)
========================

Updates since v1.5.0
--------------------

* Deprecated commands and options.

  - git-diff-stages and git-resolve have been removed.

* New commands and options.

  - "git log" and friends take --reverse.  This makes output
    that typically goes reverse order in chronological order.
    "git shortlog" usually lists commits in chronological order,
    but with "--reverse", they are shown in reverse
    chronological order.

  - "git diff" learned --ignore-space-at-eol.  This is a weaker
    form of --ignore-space-change.

  - "git diff --no-index pathA pathB" can be used as diff
    replacement with git specific enhancements.

  - "git diff --pretty=format:<string>" to allow more flexible
    custom log output.

  - "git diff --no-index" can read from '-' (standard input).

  - "git diff" also learned --exit-code to exit with non-zero
    status when it found differences.  In the future we might
    want to make this the default but that would be a rather big
    backward incompatible change; it will stay as an option for
    now.

  - "git branch --track" can be used to set up configuration
    variables to help it easier to base your work on branches
    you track from a remote site.

  - "git format-patch --attach" now emits attachments.  Use
    --inline to get an inlined multipart/mixed.

  - "git name-rev" learned --refs=<pattern>, to limit the tags
    used for naming the given revisions only to the ones
    matching the given pattern.

  - "git remote update" is to run "git fetch" for defined remotes
    to update tracking branches.

  - "git cvsimport" can now take '-d' to talk with a CVS
    repository different from what are recorded in CVS/Root
    (overriding it with environment CVSROOT does not work).

  - "git bundle" can help sneaker-netting your changes between
    repositories.

  - "git mergetool" can help 3-way file-level conflict
    resolution with your favorite graphical merge tools.

  - A new configuration "core.symlinks" can be used to disable
    symlinks on filesystems that do not support them; they are
    checked out as regular files instead.


* Updated behaviour of existing commands.

  - "git fsck" does not barf on corrupt loose objects.

  - "git archimport" allows remapping when coming up with git
    branch names from arch names.

  - git-svn got almost a rewrite.

  - core.autocrlf configuration, when set to 'true', makes git
    to convert CRLF at the end of lines in text files to LF when
    reading from the filesystem, and convert in reverse when
    writing to the filesystem.  The variable can be set to
    'input', in which case the conversion happens only while
    reading from the filesystem but files are written out with
    LF at the end of lines.  Currently, which paths to consider
    'text' (i.e. be subjected to the autocrlf mechanism) is
    decided purely based on the contents, but the plan is to
    allow users to explicitly override this heuristic based on
    paths.

  - The behaviour of 'git-apply', when run in a subdirectory,
    without --index nor --cached were inconsistent with that of
    the command with these options.  This was fixed to match the
    behaviour with --index.  A patch that is meant to be applied
    with -p1 from the toplevel of the project tree can be
    applied with any custom -p<n> option.  A patch that is not
    relative to the toplevel needs to be applied with -p<n>
    option with or without --index (or --cached).

  - "git diff" outputs a trailing HT when pathnames have embedded
    SP on +++/--- header lines, in order to help "GNU patch" to
    parse its output.  "git apply" was already updated to accept
    this modified output format since ce74618d (Sep 22, 2006).

  - "git cvsserver" runs hooks/update and honors its exit status.

  - "git cvsserver" can be told to send everything with -kb.

  - "git diff --check" also honors the --color output option.

  - "git name-rev" used to stress the fact that a ref is a tag too
    much, by saying something like "v1.2.3^0~22".  It now says
    "v1.2.3~22" in such a case (it still says "v1.2.3^0" if it does
    not talk about an ancestor of the commit that is tagged, which
    makes sense).

  - "git rev-list --boundary" now shows boundary markers for the
    commits omitted by --max-age and --max-count condition.

  - The configuration mechanism now reads $(prefix)/etc/gitconfig.

  - "git apply --verbose" shows what preimage lines were wanted
    when it couldn't find them.

  - "git status" in a read-only repository got a bit saner.

  - "git fetch" (hence "git clone" and "git pull") are less
    noisy when the output does not go to tty.

  - "git fetch" between repositories with many refs were slow
    even when there are not many changes that needed
    transferring.  This has been sped up by partially rewriting
    the heaviest parts in C.

  - "git mailinfo" which splits an e-mail into a patch and the
    metainformation was rewritten, thanks to Don Zickus.  It
    handles nested multipart better.

  - send-email learned configurable bcc and chain-reply-to.

  - Using objects from packs is now seriouly optimized by clever
    use of a cache.  This should be most noticeable in git-log
    family of commands that involve reading many tree objects.
    In addition, traversing revisions while filtering changes
    with pathspecs is made faster by terminating the comparison
    between the trees as early as possible.


* Hooks

  - The sample update hook to show how to send out notification
    e-mail was updated to show only new commits that appeared in
    the repository.  Earlier, it showed new commits that appeared
    on the branch.


* Others

  - git-revert, git-gc and git-cherry-pick are now built-ins.

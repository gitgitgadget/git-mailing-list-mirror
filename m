From: Yann Dirson <ydirson@altern.org>
Subject: List of bugs and suggestions
Date: Tue, 18 Sep 2007 00:54:41 +0200
Message-ID: <20070917225441.GA32647@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPVg-0001Gm-Si
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759059AbXIQWzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759052AbXIQWzW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:55:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45435 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758983AbXIQWzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:55:20 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BAD058B3A
	for <git@vger.kernel.org>; Tue, 18 Sep 2007 00:55:18 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 958378385
	for <git@vger.kernel.org>; Tue, 18 Sep 2007 00:55:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 3D9711F024; Tue, 18 Sep 2007 00:54:41 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58491>

Here are a list of issues I wrote down while using git and friends at
work, but did not take time to report of fix myself before.  They are
relative to git 1.5.3.

BUGS

	gitk:

- when selecting again a "local changes" pseudo-patch, gitk re-reads
the diff, and the results can be confusing if HEAD changed since last
full reload (eg. git-commit or stg/guilt push/pop).  Should detect the
HEAD change and propose a reload.

- clicking in diff-contents or file-list panes does not move focus out
of text fields (must click eg. between fields instead).  I remember
routinely click in diff-contents to focus out of the search field.

- if a file that is modified and copied in the same commit, clicking
on the original in file-list pane jumps to the "copy" entry.  This can
easily cause overlooking of changes to the original file.


	stash:

- "git stash show junk" acts like "git stash show"

- changes stashed in the index are unstashed only in workdir.  If
that's intended, a note in the "stash apply" doc would be useful; but
then I am left puzzled as to the usefulness of storing the index state
in the stash branch: it could surely be applied by a variant of "stash
apply", but such a command does not seem to exist yet ?


	misc git:

- git has problems with cascaded alternates that use relative paths.
	"git clone -s A B && git clone -s B C" puts absolute paths in
	info/alternates - there is probably a good reason, but it will
	obviously hurt when moving the clone.  Further more,
	Documentation/repository-layout.txt says scary things about
	using absolute paths there.  But if one manually sets up
	alternates in a set of repositories (easily reproduced by
	hand-editing the alternates files in the B clone
	described above), one ends with commits from A not being seen,
	and the following error message on each command run with C,
	even when no object lookup from A is required:

| $ git fsck
| error: .git/objects/../../../B/.git/objects: ignoring relative alternate object store ../../../A/.git/objects


- repack -a -l (after transitionning a repo to alternates) does not
detect that old packs including objects now in alternate.
	I had 2 branches in a single repo and changed the setup to 2
	repos (initialize by "cp -al" and removing unwanted refs from
	each repo), A finally referencing B as remote and alternate.
	"git repack -a -l" in A seems to correctly only include only
	local objects in the pack, but all the old packs containing
	objects now in B are kept.


SUGGESTIONS

git-diff*:

- could allow to declare word separators for --color-words

- could print hunk number in header (a la filterdiff --annotate)


gitk:

- on-demand loading of additional revs (eg. ancestors from reflogs)

- non-printable keystrokes could be made available from within text
fields (F5, PgUp, etc)

- large commits would be made easier to navigate with some additionnal
highlighting/coloring.  Eg:
 - coloring of add/remove (and copy/move ?) in patch file list
 - move selection in patch file list according to currently selected
   search match when there is one, or according to the file(s) whose
   diff currently appears
 - highlight search matches in patch file list
 - highlight search matches, and the file selected from the patch file
   list, in/beside the patch display slider

- file list could have its own focus history

- for large commits, it takes time to get the full diff.  Showing the
progress (nfiles processed / nfiles in commit) would be nice

- a "goto prev file" binding to reverse 'f' key (or quickly find in
which file a search match occured) would be great

- a "scroll diff view to next hunk" key binding ('h' ?)

- search backwards, and case-insensitively

- a list of known heads to jump to would be useful to quickly navigate
in multiple-head display mode.

- selecting a file in file list xould put filename in paste buffer,
like what's done for commit ids in history pane.

- "lock selected diff" toggle, to avoid losing a particular diff by
error (esp. useful when getting an expensive diff relatively to
selected commit)


stgit:

- derive a stack-log from patch logs
	The ordering information provided by patchlogs and starck
	reflog could be used to present a history of what happenned in
	a stack (eg. when coming back from holiday wondering what one
	was doing before leaving).


stgit contrib scripts (mostly reminders to myself ;):

- stg-whatchanged does not identify conflicts caused by "stg pick --fold"

- stg-fold-files-from cannot fold binary files (filterdiff limitation)
      =>  the following only works for filenames with no special char
	  (would need --zero):
            git show --binary $(stg id occ53) -- $(stg files --bare occ53|grep '^doc/') | stg fold
      => the following does not work either:
            git show --binary $(stg id occ53) -- $(git-ls-tree --name-only $(stg id occ53) doc/)

- stg-fold-files-from using non-git-aware filterdiff causes git-apply to
mistake a "add content to an empty file" hunk for a "create file" hunk

From: Junio C Hamano <gitster@pobox.com>
Subject: 1.5.3 plans and preparations
Date: Thu, 02 Aug 2007 00:22:20 -0700
Message-ID: <7vfy32z9hv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 09:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGV0s-0002Uj-05
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 09:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbXHBHWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 03:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbXHBHWW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 03:22:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54397 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbXHBHWV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 03:22:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802072219.HQQG14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 03:22:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WvNL1X0031kojtg0000000; Thu, 02 Aug 2007 03:22:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54522>

I'll be pushing out tonight's update and head to bed in about an
hour now.

The changes since -rc3 is rather large, as it contains a large
fixups to one of the topics that is new to 1.5.3 as well as
updates to gitk, git-gui, and gitweb.

I would say this should be pretty much what will be in -rc4 this
weekend.

Please test it thouroughly and send in obviously correct fixes.

---

GIT v1.5.3 Release Notes (draft)
========================

Updates since v1.5.2
--------------------

* The commit walkers other than http are officially deprecated,
  but still supported for now.

* The submodule support has Porcelain layer.

* There are a handful pack-objects changes to help you cope better
  with repositories with pathologically large blobs in them.

* For people who need to import from Perforce, a front-end for
  fast-import is in contrib/fast-import/.

* Comes with git-gui 0.8.0.

* Comes with updated gitk.

* New commands and options.

  - "git log --date=<format>" can use more formats: iso8601, rfc2822.

  - The hunk header output from "git diff" family can be customized
    with the attributes mechanism.  See gitattributes(5) for details.

  - "git stash" allows you to quickly save away your work in
    progress and replay it later on an updated state.

  - "git rebase" learned an "interactive" mode that let you
    pick and reorder which commits to rebuild.

  - "git fsck" can save its findings in $GIT_DIR/lost-found, without a
    separate invocation of "git lost-found" command.  The blobs stored by
    lost-found are stored in plain format to allow you to grep in them.

  - $GIT_WORK_TREE environment variable can be used together with
    $GIT_DIR to work in a subdirectory of a working tree that is
    not located at "$GIT_DIR/..".

  - Giving "--file=<file>" option to "git config" is the same as
    running the command with GIT_CONFIG=<file> environment.

  - "git log" learned a new option "--follow", to follow
    renaming history of a single file.

  - "git-filter-branch" lets you rewrite the revision history of
    the current branch, creating a new branch. You can specify a
    number of filters to modify the commits, files and trees.

  - "git-cvsserver" learned new options (--base-path, --export-all,
    --strict-paths) inspired by git-daemon.

  - "git daemon --base-path-relaxed" can help migrating a repository URL
    that did not use to use --base-path to use --base-path.

  - "git-commit" can use "-t templatefile" option and commit.template
    configuration variable to prime the commit message given to you in the
    editor.

  - "git-submodule" command helps you manage the projects from
    the superproject that contain them.

  - In addition to core.compression configuration option,
    core.loosecompression and pack.compression options can
    independently tweak zlib compression levels used for loose
    and packed objects.

  - "git-ls-tree -l" shows size of blobs pointed at by the
    tree entries, similar to "/bin/ls -l".

  - "git-rev-list" learned --regexp-ignore-case and
    --extended-regexp options to tweak its matching logic used
    for --grep fitering.

  - "git-describe --contains" is a handier way to call more
    obscure command "git-name-rev --tags".

  - "git gc --aggressive" tells the command to spend more cycles
    to optimize the repository harder.

  - "git repack" learned a "window-memory" limit which
    dynamically reduces the window size to stay within the
    specified memory usage.

  - "git repack" can be told to split resulting packs to avoid
    exceeding limit specified with "--max-pack-size".

  - "git fsck" gained --verbose option.  This is really really
    verbose but it might help you identify exact commit that is
    corrupt in your repository.

  - "git format-patch" learned --numbered-files option.  This
    may be useful for MH users.

  - "git format-patch" learned format.subjectprefix configuration
    variable, which serves the same purpose as "--subject-prefix"
    option.

  - "git tag -n -l" shows tag annotations while listing tags.

  - "git cvsimport" can optionally use the separate-remote layout.

  - "git blame" can be told to see through commits that change
    whitespaces and indentation levels with "-w" option.

  - "git send-email" can be told not to thread the messages when
    sending out more than one patches.

  - "git config" learned NUL terminated output format via -z to
    help scripts.

  - "git init -q" makes the command quieter.

* Updated behavior of existing commands.

  - "gitweb" can offer multiple snapshot formats.

    ***NOTE*** Unfortunately, this changes the format of the
    $feature{snapshot}{default} entry in the per-site
    configuration file 'gitweb_config.perl'.  It used to be a
    three-element tuple that describe a single format; with the
    new configuration item format, you only have to say the name
    of the format ('tgz', 'tbz2' or 'zip').  Please update the
    your configuration file accordingly.

  - "git diff" (but not the plumbing level "git diff-tree") now
    recursively descends into trees by default.

  - The editor to use with many interactive commands can be
    overridden with GIT_EDITOR environment variable, or if it
    does not exist, with core.editor configuration variable.  As
    before, if you have neither, environment variables VISUAL
    and EDITOR are consulted in this order, and then finally we
    fall back on "vi".

  - "git rm --cached" does not complain when removing a newly
    added file from the index anymore.

  - Options to "git log" to affect how --grep/--author options look for
    given strings now have shorter abbreviations.  -i is for ignore case,
    and -E is for extended regexp.

  - "git svn dcommit" retains local merge information.

  - "git config" to set values also honors type flags like --bool
    and --int.

  - core.quotepath configuration can be used to make textual git
    output to emit most of the characters in the path literally.

  - "git mergetool" chooses its backend more wisely, taking
    notice of its environment such as use of X, Gnome/KDE, etc.

  - "gitweb" shows merge commits a lot nicer than before.  The
    default view uses more compact --cc format, while the UI
    allows to choose normal diff with any parent.

  - snapshot files "gitweb" creates from a repository at
    $path/$project/.git are more useful.  We use $project part
    in the filename, which we used to discard.

  - "git cvsimport" creates lightweight tags; there is no
    interesting information we can record in an annotated tag,
    and the handcrafted ones the old code created was not
    properly formed anyway.

  - "git-push" pretends that you immediately fetched back from
    the remote by updating corresponding remote tracking
    branches if you have any.

  - The diffstat given after a merge (or a pull) honors the
    color.diff configuration.

  - "git commit --amend" is now compatible with various message source
    options such as -m/-C/-c/-F.

  - "git-apply --whitespace=strip" removes blank lines added at
    the end of the file.

  - "git-fetch" over git native protocols with "-v" option shows
    connection status, and the IP address of the other end, to
    help diagnosing problems.

  - We used to have core.legacyheaders configuration, when
    set to false, allowed git to write loose objects in a format
    that mimicks the format used by objects stored in packs.  It
    turns out that this was not so useful.  Although we will
    continue to read objects written in that format, we do not
    honor that configuration anymore and create loose objects in
    the legacy/traditional format.

  - "--find-copies-harder" option to diff family can now be
    spelled as "-C -C" for brevity.

  - "git-mailsplit" (hence "git-am") can read from Maildir
    formatted mailboxes.

  - "git-cvsserver" does not barf upon seeing "cvs login"
    request.

  - "pack-objects" honors "delta" attribute set in
    .gitattributes.  It does not attempt to deltify blobs that
    come from paths with delta attribute set to false.

  - "new-workdir" script (in contrib) can now be used with a
    bare repository.

  - "git-mergetool" learned to use gvimdiff.

  - "gitview" (in contrib) has a better blame interface.

  - "git log" and friends did not handle a commit log message
    that is larger than 16kB; they do now.

  - "--pretty=oneline" output format for "git log" and friends
    deals with "malformed" commit log messages that have more
    than one lines in the first paragraph better.  We used to
    show the first line, cutting the title at mid-sentence; we
    concatenate them into a single line and treat the result as
    "oneline".

  - "git p4import" has been demoted to contrib status.  For
    a superior option, checkout the git-p4 front end to
    git-fast-import (also in contrib).  The man page and p4
    rpm have been removed as well.

  - "git mailinfo" (hence "am") now tries to see if the message
    is in utf-8 first, instead of assuming iso-8859-1, if
    incoming e-mail does not say what encoding it is in.

* Builds

  - old-style function definitions (most notably, a function
    without parameter defined with "func()", not "func(void)")
    have been eradicated.

* Performance Tweaks

  - git-pack-objects avoids re-deltification cost by caching
    small enough delta results it creates while looking for the
    best delta candidates.

  - git-pack-objects learned a new heuristcs to prefer delta
    that is shallower in depth over the smallest delta
    possible.  This improves both overall packfile access
    performance and packfile density.

  - diff-delta code that is used for packing has been improved
    to work better on big files.

  - when there are more than one pack files in the repository,
    the runtime used to try finding an object always from the
    newest packfile; it now tries the same packfile as we found
    the object requested the last time, which exploits the
    locality of references.

  - verifying pack contents done by "git fsck --full" got boost
    by carefully choosing the order to verify objects in them.


Fixes since v1.5.2
------------------

All of the fixes in v1.5.2 maintenance series are included in
this release, unless otherwise noted.

* Bugfixes

  - "gitweb" had trouble handling non UTF-8 text with older
    Encode.pm Perl module.

--
exec >/var/tmp/1
O=v1.5.3-rc3-119-g50cff52
echo O=`git describe refs/heads/master`
git shortlog --no-merges $O..refs/heads/master ^refs/heads/maint

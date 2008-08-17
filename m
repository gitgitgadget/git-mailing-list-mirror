From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0
Date: Sun, 17 Aug 2008 14:16:33 -0700
Message-ID: <7v7iafpcjy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 23:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUpdm-0001bl-4H
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 23:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYHQVQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYHQVQv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 17:16:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbYHQVQr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 17:16:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AE72166027;
	Sun, 17 Aug 2008 17:16:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 284C066026; Sun, 17 Aug 2008 17:16:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CBE0B4E8-6CA1-11DD-8687-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92666>

The latest feature release GIT 1.6.0 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/*-1.6.0-1.fc9.$arch.rpm		(RPM)

GIT v1.6.0 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

User visible changes
--------------------

With the default Makefile settings, most of the programs are now
installed outside your $PATH, except for "git", "gitk" and
some server side programs that need to be accessible for technical
reasons.  Invoking a git subcommand as "git-xyzzy" from the command
line has been deprecated since early 2006 (and officially announced in
1.5.4 release notes); use of them from your scripts after adding
output from "git --exec-path" to the $PATH is still supported in this
release, but users are again strongly encouraged to adjust their
scripts to use "git xyzzy" form, as we will stop installing
"git-xyzzy" hardlinks for built-in commands in later releases.

An earlier change to page "git status" output was overwhelmingly unpopu=
lar
and has been reverted.

Source changes needed for porting to MinGW environment are now all in t=
he
main git.git codebase.

By default, packfiles created with this version uses delta-base-offset
encoding introduced in v1.4.4.  Pack idx files are using version 2 that
allows larger packs and added robustness thanks to its CRC checking,
introduced in v1.5.2 and v1.4.4.5.  If you want to keep your repositori=
es
backwards compatible past these versions, set repack.useDeltaBaseOffset
to false or pack.indexVersion to 1, respectively.

We used to prevent sample hook scripts shipped in templates/ from
triggering by default by relying on the fact that we install them as
unexecutable, but on some filesystems, this approach does not work.
They are now shipped with ".sample" suffix.  If you want to activate
any of these samples as-is, rename them to drop the ".sample" suffix,
instead of running "chmod +x" on them.  For example, you can rename
hooks/post-update.sample to hooks/post-update to enable the sample
hook that runs update-server-info, in order to make repositories
friendly to dumb protocols (i.e. HTTP).

GIT_CONFIG, which was only documented as affecting "git config", but
actually affected all git commands, now only affects "git config".
GIT_LOCAL_CONFIG, also only documented as affecting "git config" and
not different from GIT_CONFIG in a useful way, is removed.

The ".dotest" temporary area "git am" and "git rebase" use is now moved
inside the $GIT_DIR, to avoid mistakes of adding it to the project by
accident.

An ancient merge strategy "stupid" has been removed.


Updates since v1.5.6
--------------------

(subsystems)

* git-p4 in contrib learned "allowSubmit" configuration to control on
  which branch to allow "submit" subcommand.

* git-gui learned to stage changes per-line.

(portability)

* Changes for MinGW port have been merged, thanks to Johannes Sixt and
  gangs.

* Sample hook scripts shipped in templates/ are now suffixed with
  *.sample.

* perl's in-place edit (-i) does not work well without backup files on =
Windows;
  some tests are rewritten to cope with this.

(documentation)

* Updated howto/update-hook-example

* Got rid of usage of "git-foo" from the tutorial and made typography
  more consistent.

* Disambiguating "--" between revs and paths is finally documented.

(performance, robustness, sanity etc.)

* index-pack used too much memory when dealing with a deep delta chain.
  This has been optimized.

* reduced excessive inlining to shrink size of the "git" binary.

* verify-pack checks the object CRC when using version 2 idx files.

* When an object is corrupt in a pack, the object became unusable even
  when the same object is available in a loose form,  We now try harder=
 to
  fall back to these redundant objects when able.  In particular, "git
  repack -a -f" can be used to fix such a corruption as long as necessa=
ry
  objects are available.

* Performance of "git-blame -C -C" operation is vastly improved.

* git-clone does not create refs in loose form anymore (it behaves as
  if you immediately ran git-pack-refs after cloning).  This will help
  repositories with insanely large number of refs.

* core.fsyncobjectfiles configuration can be used to ensure that the lo=
ose
  objects created will be fsync'ed (this is only useful on filesystems
  that does not order data writes properly).

* "git commit-tree" plumbing can make Octopus with more than 16 parents=
=2E
  "git commit" has been capable of this for quite some time.

(usability, bells and whistles)

* even more documentation pages are now accessible via "man" and "git h=
elp".

* A new environment variable GIT_CEILING_DIRECTORIES can be used to sto=
p
  the discovery process of the toplevel of working tree; this may be us=
eful
  when you are working in a slow network disk and are outside any worki=
ng tree,
  as bash-completion and "git help" may still need to run in these plac=
es.

* By default, stash entries never expire.  Set reflogexpire in [gc
  "refs/stash"] to a reasonable value to get traditional auto-expiratio=
n
  behaviour back

* Longstanding latency issue with bash completion script has been
  addressed.  This will need to be backmerged to 'maint' later.

* pager.<cmd> configuration variable can be used to enable/disable the
  default paging behaviour per command.

* "git-add -i" has a new action 'e/dit' to allow you edit the patch hun=
k
  manually.

* git-am records the original tip of the branch in ORIG_HEAD before it
  starts applying patches.

* git-apply can handle a patch that touches the same path more than onc=
e
  much better than before.

* git-apply can be told not to trust the line counts recorded in the in=
put
  patch but recount, with the new --recount option.

* git-apply can be told to apply a patch to a path deeper than what the
  patch records with --directory option.

* git-archive can be told to omit certain paths from its output using
  export-ignore attributes.

* git-archive uses the zlib default compression level when creating
  zip archive.

* git-archive's command line options --exec and --remote can take their
  parameters as separate command line arguments, similar to other comma=
nds.
  IOW, both "--exec=3Dpath" and "--exec path" are now supported.

* With -v option, git-branch describes the remote tracking statistics
  similar to the way git-checkout reports by how many commits your bran=
ch
  is ahead/behind.

* git-branch's --contains option used to always require a commit parame=
ter
  to limit the branches with; it now defaults to list branches that
  contains HEAD if this parameter is omitted.

* git-branch's --merged and --no-merged option used to always limit the
  branches relative to the HEAD, but they can now take an optional comm=
it
  argument that is used in place of HEAD.

* git-bundle can read the revision arguments from the standard input.

* git-cherry-pick can replay a root commit now.

* git-clone can clone from a remote whose URL would be rewritten by
  configuration stored in $HOME/.gitconfig now.

* "git-clone --mirror" is a handy way to set up a bare mirror repositor=
y.

* git-cvsserver learned to respond to "cvs co -c".

* git-diff --check now checks leftover merge conflict markers.

* "git-diff -p" learned to grab a better hunk header lines in
  BibTex, Pascal/Delphi, and Ruby files and also pays attention to
  chapter and part boundary in TeX documents.

* When remote side used to have branch 'foo' and git-fetch finds that n=
ow
  it has branch 'foo/bar', it refuses to lose the existing remote track=
ing
  branch and its reflog.  The error message has been improved to sugges=
t
  pruning the remote if the user wants to proceed and get the latest se=
t
  of branches from the remote, including such 'foo/bar'.

* fast-export learned to export and import marks file; this can be used=
 to
  interface with fast-import incrementally.

* fast-import and fast-export learned to export and import gitlinks.

* "gitk" left background process behind after being asked to dig very d=
eep
  history and the user killed the UI; the process is killed when the UI=
 goes
  away now.

* git-rebase records the original tip of branch in ORIG_HEAD before it =
is
  rewound.

* "git rerere" can be told to update the index with auto-reused resolut=
ion
  with rerere.autoupdate configuration variable.

* git-rev-parse learned $commit^! and $commit^@ notations used in "log"
  family.  These notations are available in gitk as well, because the g=
itk
  command internally uses rev-parse to interpret its arguments.

* git-rev-list learned --children option to show child commits it
  encountered during the traversal, instead of showing parent commits.

* git-send-mail can talk not just over SSL but over TLS now.

* git-shortlog honors custom output format specified with "--pretty=3Df=
ormat:".

* "git-stash save" learned --keep-index option.  This lets you stash aw=
ay the
  local changes and bring the changes staged in the index to your worki=
ng
  tree for examination and testing.

* git-stash also learned branch subcommand to create a new branch out o=
f
  stashed changes.

* git-status gives the remote tracking statistics similar to the way
  git-checkout reports by how many commits your branch is ahead/behind.

* "git-svn dcommit" is now aware of auto-props setting the subversion u=
ser
  has.

* You can tell "git status -u" to even more aggressively omit checking
  untracked files with --untracked-files=3Dno.

* Original SHA-1 value for "update-ref -d" is optional now.

* Error codes from gitweb are made more descriptive where possible, rat=
her
  than "403 forbidden" as we used to issue everywhere.

(internal)

* git-merge has been reimplemented in C.


=46ixes since v1.5.6
------------------

All of the fixes in v1.5.6 maintenance series are included in
this release, unless otherwise noted.

 * git-clone ignored its -u option; the fix needs to be backported to
   'maint';

 * git-mv used to lose the distinction between changes that are staged
   and that are only in the working tree, by staging both in the index
   after moving such a path.

 * "git-rebase -i -p" rewrote the parents to wrong ones when amending
   (either edit or squash) was involved, and did not work correctly
   when fast forwarding.



----------------------------------------------------------------

Changes since v1.5.6 are as follows:

Abhijit Menon-Sen (13):
      git-gui: Move on to the next filename after staging/unstaging a c=
hange
      git-gui: Don't select the wrong file if the last listed file is s=
taged.
      Implement "git stash branch <newbranch> <stash>"
      Add a test for "git stash branch"
      git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
      Clarify that "git log x.c y.h" lists commits that touch either fi=
le
      `git submodule add` now requires a <path>
      Make it clear that push can take multiple refspecs
      Make the DESCRIPTION match <x>... items in the SYNOPSIS
      Git.pm: localise $? in command_close_bidi_pipe()
      Fix hash slice syntax error
      Fix typo in perl/Git.pm
      Fix typos in INSTALL

Adam Brewster (2):
      Move read_revisions_from_stdin from builtin-rev-list.c to revisio=
n.c
      Teach git-bundle to read revision arguments from stdin like git-r=
ev-list.

Alex Riesen (5):
      Fix use of "perl -i" on Windows
      git-clone: remove leftover debugging fprintf().
      Allow pager of diff command be enabled/disabled
      Make use of stat.ctime configurable
      Fix t3700 on filesystems which do not support question marks in n=
ames

Alexander Gavrilov (18):
      Fix quadratic performance in rewrite_one.
      Avoid rescanning unchanged entries in search for copies.
      Do not try to detect move/copy for entries below threshold.
      Fix pre-commit hooks under MinGW/MSYS
      Add options to control the search for copies in blame.
      Kill the blame back-end on window close.
      Add a menu item to invoke full copy detection in blame.
      Support gitlinks in fast-import.
      git-gui: Fix the Remote menu separator.
      git-gui: Preserve scroll position on reshow_diff.
      Support copy and rename detection in fast-export.
      gitk: Kill back-end processes on window close
      gitk: Arrange to kill diff-files & diff-index on quit
      gitk: On Windows, use a Cygwin-specific flag for kill
      gitk: Fixed broken exception handling in diff
      gitk: Fixed automatic row selection during load
      gitk: Fallback to selecting the head commit upon load
      gitk: Allow safely calling nukefile from a run queue handler

Anand Kumria (14):
      Create a specific version of the read_pipe_lines command for p4 i=
nvocations
      Utilise the new 'p4_read_pipe_lines' command
      Have a command that specifically invokes 'p4' (via system)
      Utilise the new 'p4_system' function.
      Add a single command that will be used to construct the 'p4' comm=
and
      If we are in verbose mode, output what we are about to run (or re=
turn)
      Switch to using 'p4_build_cmd'
      If the user has configured various parameters, use them.
      Consistently use 'git-p4' for the configuration entries
      Move git-p4.syncFromOrigin into a configuration parameters sectio=
n
      Put some documentation in about the parameters that have been add=
ed
      Put in the two other configuration elements found in the source
      Add p4 read_pipe and write_pipe wrappers
      Utilise our new p4_read_pipe and p4_write_pipe wrappers

Anders Melchiorsen (5):
      Documentation: fix diff.external example
      Advertise the ability to abort a commit
      Documentation: fix diff.external example
      Flush output in start_async
      Add output flushing before fork()

Avery Pennarun (4):
      git-svn: avoid filling up the disk with temp files.
      Reword "your branch has diverged..." lines to reduce line length
      Teach "git diff -p" Pascal/Delphi funcname pattern
      git-svn: Abort with an error if 'fetch' parameter is invalid.

Bj=C3=B6rn Steinbrink (3):
      git cat-file: Fix memory leak in batch mode
      index-pack.c: correctly initialize appended objects
      rev-parse: Add support for the ^! and ^@ syntax

Brad King (1):
      git-svn: teach dcommit about svn auto-props

Brandon Casey (17):
      git-merge.sh: fix typo in usage message: sucesses --> succeeds
      t7502-commit.sh: test_must_fail doesn't work with inline environm=
ent variables
      t7701-repack-unpack-unreachable.sh: check timestamp of unpacked o=
bjects
      t/: Replace diff [-u|-U0] with test_cmp to allow compilation with=
 old diff
      t4116-apply-reverse.sh: use $TAR rather than tar
      t3200,t7201: replace '!' with test_must_fail
      t7502-commit.sh: rearrange test to make more portable
      t/t4202-log.sh: add newline at end of file
      Teach fsck and prune about the new location of temporary objects
      perl/Makefile: update NO_PERL_MAKEMAKER section
      t/t4202-log.sh: add newline at end of file
      Teach fsck and prune that tmp_obj_ file names may not be 14 bytes=
 long
      perl/Makefile: handle paths with spaces in the NO_PERL_MAKEMAKER =
section
      Makefile: set SHELL to value of SHELL_PATH
      Makefile: add a target which will abort compilation with ancient =
shells
      test-parse-options: use appropriate cast in length_callback
      t5304-prune: adjust file mtime based on system time rather than f=
ile mtime

Brian Gernhardt (5):
      Fix t4017-diff-retval for white-space from wc
      Add test results directory to t/.gitignore
      Documentation: Point to gitcli(7) from git(1)
      Documentation: mention ORIG_HEAD in am, merge, and rebase
      Documentation: Remove mentions of git-svnimport.

Brian Hetro (5):
      builtin-log.c: Use 'git_config_string' to get 'format.subjectpref=
ix' and 'format.suffix'
      convert.c: Use 'git_config_string' to get 'smudge' and 'clean'
      diff.c: Use 'git_config_string' to get 'diff.external'
      http.c: Use 'git_config_string' to clean up SSL config.
      builtin-commit.c: Use 'git_config_string' to get 'commit.template=
'

Cesar Eduardo Barros (2):
      Documentation/git-submodule.txt: fix doubled word
      Documentation/git-rev-parse.txt: update for new git-describe outp=
ut format

Christian Couder (5):
      help: check early if we have a command, if not try a documentatio=
n topic
      Fix "config_error_nonbool" used with value instead of key
      Fix "config_error_nonbool" used with value instead of key
      merge-base: die with an error message if not passed a commit ref
      documentation: user-manual: update "using-bisect" section

Christian Stimming (2):
      git-gui: Update German translation
      gitk: Updated German translation

Ciaran McCreesh (2):
      Make git-add -i accept ranges like 7-
      Make git-add -i accept ranges like 7-

Cristian Peraferrer (1):
      Print errno upon failure to open the COMMIT_EDITMSG file

Dan McGee (1):
      completion: add --graph to log command completion

Daniel Barkalow (2):
      Only use GIT_CONFIG in "git config", not other programs
      In perforce, RCS keywords are case-sensitive

David D. Kilzer (1):
      Fix race condition in t9119-git-svn-info.sh

David Reiss (4):
      Implement normalize_absolute_path
      Fold test-absolute-path into test-path-utils
      Add support for GIT_CEILING_DIRECTORIES
      Eliminate an unnecessary chdir("..")

Dmitry Kakurin (1):
      Fixed text file auto-detection: treat EOF character 032 at the en=
d of file as printable

Dmitry Potapov (9):
      fix update-hook-example to work with packed tag references
      update-hook-example: optionally allow non-fast-forward
      shrink git-shell by avoiding redundant dependencies
      completion.bash: add 'skip' and 'run' to git-bisect
      Fix buffer overflow in git-grep
      Fix buffer overflow in git diff
      Fix buffer overflow in prepare_attr_stack
      git-svn: fix git svn info to work without arguments
      correct access right for git-svn-dcommit test

Don Zickus (1):
      git-apply: handle a patch that touches the same path more than on=
ce better

Eric Blake (1):
      Makefile: building git in cygwin 1.7.0

Eric Hanchrow (2):
      user-manual: typo and grammar fixes
      Documentation: fix broken "linkgit" links

Eric Raible (4):
      Documentation: tweak use case in "git stash save --keep-index"
      completion: add branch options --contains --merged --no-merged
      Teach lookup_prog not to select directories
      bash completion: 'git apply' should use 'fix' not 'strip'

Eric Wong (6):
      git-svn: don't sanitize remote names in config
      t/lib-git-svn: fix SVN_HTTPD tests to work with "trash directory"
      git-svn: properly set path for "info" command
      t9119: conditionally re-enable test depending on svn(1) version
      git-svn: add ability to specify --commit-url for dcommit
      git-svn: wrap long lines in a few places

=46abian Emmes (2):
      Testsuite: Unset CVS_SERVER
      testsuite for cvs co -c

=46rancis Moreau (1):
      git-bisect: fix wrong usage of read(1)

=46rederik Schwarzer (1):
      git-svn: typofix

Gerrit Pape (1):
      git-svn.perl: workaround assertions in svn library 1.5.0

Giuseppe Bilotta (2):
      diff: add ruby funcname pattern
      diff: chapter and part in funcname for tex

Gustaf Hendeby (2):
      gitattributes: Document built in hunk header patterns
      Teach git diff about BibTeX head hunk patterns

Ian Katz (1):
      tutorial: use prompt with user names in example, to clarify who i=
s doing what

Ivan Stankovic (1):
      Documentation: fix invalid reference to 'mybranch' in user manual

Jakub Narebski (5):
      gitweb: Separate filling list of projects info
      gitweb: Separate generating 'sort by' table header
      t/README: Add 'Skipping Tests' section below 'Running Tests'
      gitweb: Describe projects_index format in more detail
      gitweb: More about how gitweb gets 'owner' of repository

Jan Kr=C3=BCger (2):
      Documentation: fix formatting in git-svn
      git-svn: make rebuild respect rewriteRoot option

Jeff King (18):
      fix whitespace violations in test scripts
      mask necessary whitespace policy violations in test scripts
      avoid whitespace on empty line in automatic usage message
      avoid trailing whitespace in zero-change diffstat lines
      enable whitespace checking of test scripts
      clone: create intermediate directories of destination repo
      for-each-ref: implement missing tag values
      clone: create intermediate directories of destination repo
      improve for-each-ref test script
      fetch: report local storage errors in status table
      doc/rev-parse: clarify reflog vs --until for specifying revisions
      fetch: give a hint to the user when local refs fail to update
      Allow per-command pager config
      make deleting a missing ref more quiet
      avoid null SHA1 in oldest reflog
      init: handle empty "template" parameter
      Compact commit template message
      init: handle empty "template" parameter

Jim Meyering (1):
      git-cvsimport.perl: Print "UNKNOWN LINE..." on stderr, not stdout=
=2E

Jing Xue (1):
      Add 'git-p4.allowSubmit' to git-p4

Jochen Voss (1):
      avoid off-by-one error in run_upload_archive

Joey Hess (1):
      fix git config example syntax

Johan Herland (4):
      Incorporate fetched packs in future object traversal
      Move pack_refs() and friends into libgit
      Prepare testsuite for a "git clone" that packs refs
      Teach "git clone" to pack refs

Johannes Schindelin (31):
      Windows: always chmod(, 0666) before unlink().
      clone: respect url.insteadOf setting in global configs
      commit-tree: lift completely arbitrary limit of 16 parents
      Allow git-apply to recount the lines in a hunk (AKA recountdiff)
      clone: respect the settings in $HOME/.gitconfig and /etc/gitconfi=
g
      Add another fast-import example, this time for .zip files
      Teach "git apply" to prepend a prefix with "--root=3D<root>"
      git fetch-pack: do not complain about "no common commits" in an e=
mpty repo
      git daemon: avoid calling syslog() from a signal handler
      run_command(): respect GIT_TRACE
      Allow cherry-picking root commits
      Convert CR/LF to LF in tag signatures
      Add pretty format %aN which gives the author name, respecting .ma=
ilmap
      Move MERGE_RR from .git/rr-cache/ into .git/
      git-gui: MERGE_RR lives in .git/ directly with newer Git versions
      shortlog: support --pretty=3Dformat: option
      Rename ".dotest/" to ".git/rebase" and ".dotest-merge" to "rebase=
-merge"
      git fetch-pack: do not complain about "no common commits" in an e=
mpty repo
      Rename .git/rebase to .git/rebase-apply
      Rename path_list to string_list
      Fix two leftovers from path_list->string_list
      Ignore dirty submodule states in "git pull --rebase"
      Add test to show that show-branch misses out the 8th column
      sort_in_topological_order(): avoid setting a commit flag
      builtin-commit: Two trivial style-cleanups
      git daemon: avoid waking up too often
      Avoid chdir() in list_commands_in_dir()
      sort_in_topological_order(): avoid setting a commit flag
      clone: Add an option to set up a mirror
      clone --bare: Add ".git" suffix to the directory name to clone in=
to
      clone --mirror: avoid storing repeated tags

Johannes Sixt (52):
      Add compat/regex.[ch] and compat/fnmatch.[ch].
      Compile some programs only conditionally.
      Add target architecture MinGW.
      Windows: Use the Windows style PATH separator ';'.
      setup.c: Prepare for Windows directory separators.
      Windows: Treat Windows style path names.
      Windows: Handle absolute paths in safe_create_leading_directories=
().
      Windows: Strip ".exe" from the program name.
      Windows: Implement a wrapper of the open() function.
      Windows: A minimal implemention of getpwuid().
      Windows: Work around misbehaved rename().
      Make my_mktime() public and rename it to tm_to_time_t()
      Windows: Implement gettimeofday().
      Windows: Fix PRIuMAX definition.
      Windows: Implement setitimer() and sigaction().
      Windows: Wrap execve so that shell scripts can be invoked.
      Windows: A pipe() replacement whose ends are not inherited to chi=
ldren.
      Windows: Implement start_command().
      Windows: A rudimentary poll() emulation.
      Windows: Disambiguate DOS style paths from SSH URLs.
      Windows: Implement asynchronous functions as threads.
      Windows: Work around incompatible sort and find.
      Windows: Implement wrappers for gethostbyname(), socket(), and co=
nnect().
      Windows: Implement a custom spawnve().
      Windows: Add a custom implementation for utime().
      Windows: Use a customized struct stat that also has the st_blocks=
 member.
      Turn builtin_exec_path into a function.
      Windows: Compute the fallback for exec_path from the program invo=
cation.
      Windows: Use a relative default template_dir and ETC_GITCONFIG
      When installing, be prepared that template_dir may be relative.
      Windows: Make the pager work.
      Windows: Work around an oddity when a pipe with no reader is writ=
ten to.
      Windows: Make 'git help -a' work.
      Windows: TMP and TEMP environment variables specify a temporary d=
irectory.
      git-gui: Implement "Stage/Unstage Line"
      t4127-apply-same-fn: Avoid sed -i
      Provide fallback definitions of PRIu32 and PRIx32
      t7600-merge: Use test_expect_failure to test option parsing
      builtin-clone: rewrite guess_dir_name()
      rebase -i: When an 'edit' stops, mention the commit
      Makefile: Do not install a copy of 'git' in $(gitexecdir)
      Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
      Record the command invocation path early
      Fix relative built-in paths to be relative to the command invocat=
ion
      Allow the built-in exec path to be relative to the command invoca=
tion path
      Allow add_path() to add non-existent directories to the path
      Windows: Make $(gitexecdir) relative
      Windows: Make sure argv[0] has a path
      Windows: Do not compile git-shell
      git-gui: Fix "Stage/Unstage Line" with one line of context.
      git-gui: "Stage Line": Treat independent changes in adjacent line=
s better
      git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'

Jon Jensen (1):
      Fix reference to Everyday Git, which is an HTML document and not =
a man page.

Jonathan Nieder (29):
      Documentation: don't assume git-sh-setup and git-parse-remote are=
 in PATH
      Documentation: fix links to tutorials and other new manual pages
      whitespace fix in Documentation/git-repack.txt
      Documentation: complicate example of "man git-command"
      git-daemon(1): don't assume git-daemon is in /usr/bin
      Documentation: prepare to be consistent about "git-" versus "git =
"
      Documentation: be consistent about "git-" versus "git "
      Documentation formatting and cleanup
      git-format-patch(1): fix stray \ in output
      Documentation: fix gitlinks
      manpages: fix bogus whitespace
      git(1): add comma
      git-commit(1): depersonalize description
      Documentation: rewrap to prepare for "git-" vs "git " change
      Documentation: more "git-" versus "git " changes
      gitdiffcore(7): fix awkward wording
      manpages: italicize command names in synopses
      manpages: italicize command names
      manpages: italicize git command names (which were in teletype fon=
t)
      manpages: italicize gitk's name (where it was in teletype font)
      manpages: italicize nongit command names (if they are in teletype=
 font)
      manpages: italicize git subcommand names (which were in teletype =
font)
      manpages: use teletype font for sample command lines
      fix usage string for git grep
      git-diff(1): "--c" -> "--cc" typo fix
      document that git-tag can tag more than heads
      t6030 (bisect): work around Mac OS X "ls"
      git-diff(1): "--c" -> "--cc" typo fix
      Documentation: user-manual: "git commit -a" doesn't motivate .git=
ignore

Jo=C3=A3o Abecasis (1):
      git-svn: find-rev and rebase for SVN::Mirror repositories

Junio C Hamano (131):
      revision traversal: --children option
      rev-list --children
      builtin-blame.c: move prepare_final() into a separate function.
      builtin-blame.c: allow more than 16 parents
      git-blame --reverse
      diff -c/--cc: do not include uninteresting deletion before leadin=
g context
      rerere: rerere_created_at() and has_resolution() abstraction
      git-rerere: detect unparsable conflicts
      rerere: remove dubious "tail_optimization"
      t4200: fix rerere test
      rerere.autoupdate
      git-shell: accept "git foo" form
      Prepare execv_git_cmd() for removal of builtins from the filesyst=
em
      pre-rebase hook update
      Ship sample hooks with .sample suffix
      Keep some git-* programs in $(bindir)
      GIT 1.5.6.1
      Allow "git-reset path" when unambiguous
      Start draft release notes for 1.6.0
      diff --check: do not discard error status upon seeing a good line
      git-shell: accept "git foo" form
      GIT 1.5.4.6
      GIT 1.5.5.5
      diff --check: explain why we do not care whether old side is bina=
ry
      check_and_emit_line(): rename and refactor
      checkdiff: pass diff_options to the callback
      Teach "diff --check" about new blank lines at end
      diff --check: detect leftover conflict markers
      Update sample pre-commit hook to use "diff --check"
      Document the double-dash "rev -- path" disambiguator
      Per-ref reflog expiry configuration
      Make default expiration period of reflog used for stash infinite
      t9700: skip when Test::More is not available
      Update draft release notes for 1.6.0
      Introduce get_merge_bases_many()
      Introduce reduce_heads()
      Start draft release notes for 1.5.6.2
      Update draft release notes for 1.6.0
      apply --root: thinkofix.
      Refactor "tracking statistics" code used by "git checkout"
      git-status: show the remote tracking statistics
      git-branch -v: show the remote tracking statistics
      fast-export --export-marks: fix off by one error
      stat_tracking_info(): clear object flags used during counting
      Work around gcc warnings from curl headers
      Fix executable bits in t/ scripts
      GIT 1.5.6.2
      attribute documentation: keep EXAMPLE at end
      clone -q: honor "quiet" option over native transports.
      branch -r -v: do not spit out garbage
      git-apply --directory: make --root more similar to GNU diff
      mailinfo: feed the correct line length to decode_transfer_encodin=
g()
      Update draft release notes for 1.6.0
      Teach "am" and "rebase" to mark the original position with ORIG_H=
EAD
      Tone down warning about GNU Interactive Tools
      Documentation: update sections on naming revisions and revision r=
anges
      Start preparing release notes for 1.5.6.3
      branch --contains: default to HEAD
      branch --merged/--no-merged: allow specifying arbitrary commit
      apply: fix copy/rename breakage
      Teach merge.log to "git-merge" again
      t0004: fix timing bug
      GIT 1.5.6.3
      Update draft release notes for 1.6.0
      reduce_heads(): protect from duplicate input
      git-rebase: report checkout failure
      tutorial: clarify "pull" is "fetch + merge"
      Update draft release notes to 1.6.0
      t/aggregate-results: whitespace fix
      Start preparing 1.5.6.4 release notes
      Update draft release notes for 1.6.0
      read-cache.c: typofix
      mailinfo: off-by-one fix for [PATCH (foobar)] removal from Subjec=
t: line
      rerere.autoupdate: change the message when autoupdate is in effec=
t
      builtin-remote.c: fix earlier "skip_prefix()" conversion
      rev-list: honor --quiet option
      http-fetch: do not SEGV after fetching a bad pack idx file
      GIT 1.5.6.4
      t9001 (send-email): Do not use hardcoded /bin/sh in test
      .mailmap update
      Getting closer to 1.6.0-rc0
      builtin-add.c: restructure the code for maintainability
      git-add --all: add all files
      git-add --all: tests
      git-add --all: documentation
      refresh-index: fix bitmask assignment
      Link shell with compat layer functions
      Move read_in_full() and write_in_full() to wrapper.c
      "needs update" considered harmful
      Update my e-mail address
      Revert "make git-status use a pager"
      tests: do not rely on external "patch"
      stash save: fix parameter handling
      builtin-branch.c: remove unused code in append_ref() callback fun=
ction
      builtin-branch.c: optimize --merged and --no-merged
      Documentation: clarify diff --cc
      ignore non-existent refs in dwim_log()
      tests: propagate $(TAR) down from the toplevel Makefile
      Makefile: fix shell quoting
      Documentation: clarify how to disable elements in core.whitespace
      make sure parsed wildcard refspec ends with slash
      GIT 1.6.0-rc1
      Allow building without any git installed
      Allow installing in the traditional way
      ls-tree documentation: enhance notes on subdirectory and pathspec=
 behaviour
      Documentation: clarify what is shown in "git-ls-files -s" output
      t7001: fix "git mv" test
      Teach gitlinks to ie_modified() and ce_modified_check_fs()
      Fix merge name generation in "merge in C"
      Fix test-parse-options "integer" test
      Teach --find-copies-harder to "git blame"
      make sure parsed wildcard refspec ends with slash
      Documentation: clarify diff --cc
      Update my e-mail address
      Start 1.5.6.5 RelNotes to describe accumulated fixes
      builtin-name-rev.c: split deeply nested part from the main functi=
on
      RelNotes 1.5.6.5 updates
      fix diff-tree --stdin documentation
      Files given on the command line are relative to $cwd
      GIT 1.5.6.5
      GIT 1.6.0-rc2
      asciidoc markup fixes
      GIT-VERSION-GEN: mark the version 'dirty' only if there are modif=
ied files
      mailinfo: fix MIME multi-part message boundary handling
      Update draft RelNotes for 1.6.0
      Fix deleting reflog entries from HEAD reflog
      Re-fix rev-list-options documentation
      diff --check: do not unconditionally complain about trailing empt=
y lines
      Do not talk about "diff" in rev-list documentation.
      GIT 1.6.0-rc3
      GIT 1.6.0

Karl Hasselstr=C3=B6m (2):
      Clean up builtin-update-ref's option parsing
      Make old sha1 optional with git update-ref -d

Kevin Ballard (3):
      git-send-email: Accept fifos as well as files
      format-patch: Produce better output with --inline or --attach
      Fix escaping of glob special characters in pathspecs

Lars Hjemli (3):
      builtin-branch: remove duplicated code
      builtin-branch: factor out merge_filter matching
      builtin-branch: fix -v for --[no-]merged

Lars Noschinski (4):
      git-cvsserver: fix call to nonexistant cleanupWorkDir()
      cvsserver: Add support for packed refs
      cvsserver: Add cvs co -c support
      cvsserver: Add testsuite for packed refs

Lea Wiemann (6):
      test-lib.sh: add --long-tests option
      t/test-lib.sh: add test_external and test_external_without_stderr
      Git.pm: add test suite
      gitweb: standarize HTTP status codes
      test-lib.sh: show git init output when in verbose mode
      GIT-VERSION-GEN: do not fail if a 'HEAD' file exists in the worki=
ng copy

Lee Marlow (15):
      bash completion: Add long options for 'git rm'
      bash completion: Add completion for 'git help'
      bash completion: remove unused function _git_diff_tree
      bash completion: Add more long options for 'git log'
      bash completion: Add completion for 'git grep'
      bash completion: Add completion for 'git clone'
      bash completion: Add completion for 'git clean'
      bash completion: Add completion for 'git init'
      bash completion: Add completion for 'git revert'
      bash completion: More completions for 'git stash'
      bash completion: Add completion for 'git archive'
      bash completion: Add completion for 'git ls-files'
      bash completion: Add completion for 'git mv'
      bash completion: Add completion for 'git mergetool'
      bash completion: Add '--merge' long option for 'git log'

Linus Torvalds (8):
      Split up default "core" config parsing into helper routine
      Split up default "user" config parsing into helper routine
      Split up default "i18n" and "branch" config parsing into helper r=
outines
      Add config option to enable 'fsync()' of object files
      racy-git: an empty blob has a fixed object name
      Make git_dir a path relative to work_tree in setup_work_tree()
      Shrink the git binary a bit by avoiding unnecessary inline functi=
ons
      diff.renamelimit is a basic diff configuration

Lukas Sandstr=C3=B6m (6):
      Add a helper script to send patches with Mozilla Thunderbird
      git-mailinfo: document the -n option
      Make some strbuf_*() struct strbuf arguments const.
      Add some useful functions for strbuf manipulation.
      git-mailinfo: Fix getting the subject from the in-body [PATCH] li=
ne
      git-mailinfo: use strbuf's instead of fixed buffers

Marcus Griep (7):
      Fix multi-glob assertion in git-svn
      git-svn: Allow deep branch names by supporting multi-globs
      Git.pm: Add faculties to allow temp files to be cached
      git-svn: Make it incrementally faster by minimizing temp files
      git-svn: Reduce temp file usage when dealing with non-links
      bash-completion: Add non-command git help files to bash-completio=
n
      Git.pm: Make File::Spec and File::Temp requirement lazy

Marius Storm-Olsen (4):
      Add an optional <mode> argument to commit/status -u|--untracked-f=
iles option
      Add argument 'no' commit/status option -u|--untracked-files
      Add configuration option for default untracked files mode
      Windows: Add a new lstat and fstat implementation based on Win32 =
API.

Mark Levedahl (4):
      install-doc-quick - use git --exec-path to find git-sh-setup
      git-submodule - Fix bugs in adding an existing repo as a module
      git-submodule - make "submodule add" more strict, and document it
      git-submodule - register submodule URL if adding in place

Matt McCutchen (1):
      git format-patch documentation: clarify what --cover-letter does

Matthew Ogilvie (1):
      Documentation cvs: Clarify when a bare repository is needed

Michele Ballabio (6):
      parse-options.c: fix documentation syntax of optional arguments
      t9301-fast-export.sh: Remove debug line
      builtin-merge.c: Fix option parsing
      builtin-push.c: Cleanup - use OPT_BIT() and remove some variables
      git-gui: update po/it.po
      git-gui: add a part about format strings in po/README

Mikael Magnusson (3):
      Fix grammar in git-rev-parse(1).
      git-gui: Update swedish translation.
      gitk: Update swedish translation.

Mike Hommey (4):
      Catch failures from t5540-http-push
      Fix http-push test
      Skip t5540-http-push test when USE_CURL_MULTI is undefined
      Avoid apache complaining about lack of server's FQDN

Mike Pape (1):
      We need to check for msys as well as Windows in add--interactive.

Mike Ralphson (2):
      Documentation: typos / spelling fixes in older RelNotes
      Documentation: typos / spelling fixes

Miklos Vajna (31):
      A simple script to parse the results from the testcases
      Move split_cmdline() to alias.c
      Move commit_list_count() to commit.c
      Move parse-options's skip_prefix() to git-compat-util.h
      Add new test to ensure git-merge handles pull.twohead and pull.oc=
topus
      Move read_cache_unmerged() to read-cache.c
      git-fmt-merge-msg: make it usable from other builtins
      Introduce get_octopus_merge_bases() in commit.c
      Add new test to ensure git-merge handles more than 25 refs.
      Add new test case to ensure git-merge reduces octopus parents whe=
n possible
      Retire 'stupid' merge strategy
      INSTALL: Update section about git-frotz form.
      hg-to-git: avoid raising a string exception
      hg-to-git: abort if the project directory is not a hg repo
      hg-to-git: rewrite "git-frotz" to "git frotz"
      hg-to-git: use git init instead of git init-db
      Add new test case to ensure git-merge prepends the custom merge m=
essage
      git-commit-tree: make it usable from other builtins
      Fix t7601-merge-pull-config.sh on AIX
      Build in merge
      t0001-init.sh: change confusing directory name
      t1007-hash-object.sh: use quotes for the test description
      git-bisect: use dash-less form on git bisect log
      make remove-dashes: apply to scripts and programs as well, not ju=
st to builtins
      t6021: add a new test for git-merge-resolve
      Add a new test for git-merge-resolve
      Teach 'git merge' that some merge strategies no longer exist
      builtin-merge: give a proper error message for invalid strategies=
 in config
      t7601: extend the 'merge picks up the best result' test
      Documentation: document the pager.* configuration setting
      t9300: replace '!' with test_must_fail

Nanako Shiraishi (8):
      environment.c: remove unused function
      config.c: make git_env_bool() static
      gitcli: Document meaning of --cached and --index
      cache-tree.c: make cache_tree_find() static
      builtin-describe.c: make a global variable "pattern" static
      parse-options.c: make check_typos() static
      git am --abort
      git-gui: update Japanese translation

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
      Move all dashed-form commands to libexecdir
      Fix typo in comments of longest_ancestor_length()

Nicolas Pitre (11):
      call init_pack_revindex() lazily
      implement some resilience against pack corruptions
      test case for pack resilience against corruptions
      refactor pack structure allocation
      optimize verify-pack a bit
      move show_pack_info() where it belongs
      verify-pack: check packed object CRC when using index version 2
      verify-pack: test for detection of index v2 object CRC mismatch
      repack.usedeltabaseoffset config option now defaults to "true"
      pack.indexversion config option now defaults to 2
      restore legacy behavior for read_sha1_file()

Nikolaj Schumacher (1):
      Don't cut off last character of commit descriptions.

Nikolaus Schulz (1):
      Documentation: be precise about which date --pretty uses

Olivier Marin (9):
      Documentation: remove {show,whatchanged}.difftree config options
      show_stats(): fix stats width calculation
      builtin-rerere: more carefully find conflict markers
      builtin-rm: fix index lock file path
      git-am: remove dash from help message
      parse-options: fix segmentation fault when a required value is mi=
ssing
      git am --skip: clean the index while preserving local changes
      update test case to protect am --skip behaviour
      builtin-verify-tag: fix -v option parsing

P. Christeas (1):
      svnimport: newer libsvn wants us to ask for the root with "", not=
 "/"

Patrick Higgins (2):
      Remove the use of '--' in merge program invocation
      Workaround for AIX mkstemp()

Pavel Roskin (1):
      t9600: allow testing with cvsps 2.2, including beta versions

Peter Harris (1):
      Add ANSI control code emulation for the Windows console

Peter Valdemar M=C3=B8rch (1):
      send-email: find body-encoding correctly

Petr Baudis (14):
      Git.pm: Add remote_refs() git-ls-remote frontend
      Fix backwards-incompatible handling of core.sharedRepository
      Documentation/git-cherry-pick.txt et al.: Fix misleading -n descr=
iption
      Documentation/git-submodule.txt: Add Description section
      Documentation/RelNotes-1.6.0.txt: Expand on the incompatible pack=
files
      Documentation/git-submodule.txt: Further clarify the description
      Documentation: How to ignore local changes in tracked files
      Documentation/git-merge.txt: Partial rewrite of How Merge Works
      git-filter-branch.sh: Allow running in bare repositories
      Documentation/git-filter-branch: teach "rm" instead of "update-in=
dex --remove"
      git-mv: Remove dead code branch
      git-mv: Keep moved index entries inact
      Fail properly when cloning from invalid HTTP URL
      Adjust for the new way of enabling the default post-update hook

Philippe Bruhat (1):
      mailinfo: better parse email adresses containg parentheses

Pierre Habouzit (19):
      parse-opt: have parse_options_{start,end}.
      parse-opt: Export a non NORETURN usage dumper.
      parse-opt: create parse_options_step.
      parse-opt: do not print errors on unknown options, return -2 inte=
ad.
      parse-opt: fake short strings for callers to believe in.
      parse-opt: add PARSE_OPT_KEEP_ARGV0 parser option.
      revisions: split handle_revision_opt() from setup_revisions()
      git-blame: migrate to incremental parse-option [1/2]
      git-blame: migrate to incremental parse-option [2/2]
      parse-options: add PARSE_OPT_LASTARG_DEFAULT flag
      git-blame: fix lapsus
      git-shortlog: migrate to parse-options partially.
      revisions: refactor handle_revision_opt into parse_revision_opt.
      builtin-merge: add missing structure initialization
      git-submodule: move ill placed shift.
      git-checkout: fix command line parsing.
      git-checkout: improve error messages, detect ambiguities.
      Allow "non-option" revision options in parse_option-enabled comma=
nds
      git-submodule: move ill placed shift.

Pieter de Bie (4):
      builtin-fast-export: Add importing and exporting of revision mark=
s
      git-name-rev: allow --name-only in combination with --stdin
      builtin-rm: Add a --force flag
      reflog test: add more tests for 'reflog delete'

Rafael Garcia-Suarez (1):
      gitweb: remove git_blame and rename git_blame2 to git_blame

Ramsay Allan Jones (4):
      Fix some warnings (on cygwin) to allow -Werror
      t9113-*.sh: provide user feedback when test skipped
      t9100-git-svn-basic.sh: Fix determination of utf-8 locale
      git-request-pull: replace call to deprecated peek-remote

Ren=C3=A9 Scharfe (16):
      Teach new attribute 'export-ignore' to git-archive
      archive: remove args member from struct archiver
      add context pointer to read_tree_recursive()
      archive: add baselen member to struct archiver_args
      archive: centralize archive entry writing
      archive: unify file attribute handling
      archive: remove extra arguments parsing code
      archive: make zip compression level independent from core git
      archive: remove unused headers
      archive: add write_archive()
      archive: move parameter parsing code to archive.c
      archive: define MAX_ARGS where it's needed
      archive: declare struct archiver where it's needed
      archive: allow --exec and --remote without equal sign
      archive: allow --exec and --remote without equal sign
      git-name-rev: don't use printf without format

Richard Quirk (1):
      git-gui: Fix accidental staged state toggle when clicking top pix=
el row

Robert Blum (1):
      git-p4: chdir now properly sets PWD environment variable in msysG=
it

Robert Shearman (1):
      git-send-email: Fix authenticating on some servers when using TLS=
=2E

SZEDER G=C3=A1bor (5):
      stash: introduce 'stash save --keep-index' option
      bash: offer only paths after '--'
      checkout: mention '--' in the docs
      bash: offer only paths after '--' for 'git checkout'
      bash: remove redundant check for 'git stash apply' options

Shawn O. Pearce (18):
      Correct documentation for git-push --mirror
      Fix describe --tags --long so it does not segfault
      Remove unnecessary pack-*.keep file after successful git-clone
      Correct pack memory leak causing git gc to try to exceed ulimit
      bash completion: Improve responsiveness of git-log completion
      bash completion: Don't offer "a.." as a completion for "a."
      bash completion: Append space after file names have been complete=
d
      bash completion: Resolve git show ref:path<tab> losing ref: porti=
on
      bash completion: Remove dashed command completion support
      index-pack: Refactor base arguments of resolve_delta into a struc=
t
      index-pack: Chain the struct base_data on the stack for traversal
      index-pack: Track the object_entry that creates each base_data
      index-pack: Honor core.deltaBaseCacheLimit when resolving deltas
      git-gui: Correct 'Visualize Branches' on Mac OS X to start gitk
      fsck: Don't require tmp_obj_ file names are 14 bytes in length
      git-gui: Fix gitk search in $PATH to work on Windows
      git-gui: Update git-gui.pot for 0.11 nearing release
      git-gui 0.11

Soeren Finster (1):
      git-gui: Exit shortcut in MacOSX repaired

Steffen Prohaska (11):
      Windows: Fix ntohl() related warnings about printf formatting
      compat/pread.c: Add a forward declaration to fix a warning
      Move code interpreting path relative to exec-dir to new function =
system_path()
      help.c: Add support for htmldir relative to git_exec_path()
      help (Windows): Display HTML in default browser using Windows' sh=
ell API
      Refactor, adding prepare_git_cmd(const char **argv)
      run-command (Windows): Run dashless "git <cmd>"
      git-gui: Correct installation of library to be $prefix/share
      git-gui (Windows): Switch to relative discovery of oguilib
      git-gui (Windows): Change wrapper to execdir 'libexec/git-core'
      Modify mingw_main() workaround to avoid link errors

Stephan Beyer (28):
      api-builtin.txt: update and fix typo
      t3404: stricter tests for git-rebase--interactive
      git-rebase.sh: Add check if rebase is in progress
      api-builtin.txt: update and fix typo
      api-parse-options.txt: Introduce documentation for parse options =
API
      Extend parse-options test suite
      rerere: Separate libgit and builtin functions
      git-am: Do not exit silently if committer is unset
      t/test-lib.sh: exit with small negagive int is ok with test_must_=
fail
      t/: Use "test_must_fail git" instead of "! git"
      Make usage strings dash-less
      git-am/git-mailsplit: correct synopsis for reading from stdin
      t3404: test two "preserve merges with -p" cases
      Make rebase--interactive use OPTIONS_SPEC
      rebase-i: keep old parents when preserving merges
      api-run-command.txt: typofix
      Link git-shell only to a subset of libgit.a
      git-am: Add colon before the subject that is printed out as being=
 applied
      am --abort: Add to bash-completion and mention in git-rerere docu=
mentation
      Make non-static functions, that may be static, static
      Move launch_editor() from builtin-tag.c to editor.c
      editor.c: Libify launch_editor()
      git-am: Mention --abort in usage string part of OPTIONS_SPEC
      git-reset: Let -q hush "locally modified" messages
      builtin-revert.c: typofix
      git-am: ignore --binary option
      git-stash: improve synopsis in help and manual page
      Improve error output of git-rebase

Stephen R. van den Berg (1):
      git-daemon: SysV needs the signal handler reinstated.

Steve Haslam (3):
      Propagate -u/--upload-pack option of "git clone" to transport.
      Remove references to git-fetch-pack from "git clone" documentatio=
n.
      Propagate -u/--upload-pack option of "git clone" to transport.

Steven Grimm (1):
      Optimize sha1_object_info for loose objects, not concurrent repac=
ks

SungHyun Nam (1):
      t/Makefile: use specified shell when running aggregation script

Sverre Hvammen Johansen (1):
      reduce_heads(): thinkofix

Sverre Rabbelier (2):
      Modify test-lib.sh to output stats to t/test-results/*
      Hook up the result aggregation in the test makefile.

Ted Percival (1):
      Don't use dash commands (git-foo) in tutorial-2

Teemu Likonen (3):
      bash: Add more option completions for 'git log'
      Add target "install-html" the the top level Makefile
      bash: Add long option completion for 'git send-email'

Thomas Rast (18):
      git-send-email: add support for TLS via Net::SMTP::SSL
      git-send-email: prevent undefined variable warnings if no encrypt=
ion is set
      Fix 'git show' on signed tag of signed tag of commit
      git-add--interactive: replace hunk recounting with apply --recoun=
t
      git-add--interactive: remove hunk coalescing
      git-add--interactive: manual hunk editing mode
      git-send-email: Do not attempt to STARTTLS more than once
      Fix apply --recount handling of no-EOL line
      git-completion.bash: provide completion for 'show-branch'
      bash completion: Add long options for 'git describe'
      Documentation: commit-tree: remove 16 parents restriction
      Documentation: filter-branch: document how to filter all refs
      filter-branch: be more helpful when an annotated tag changes
      Documentation: rev-list-options: Fix -g paragraph formatting
      Documentation: rev-list-options: Fix a typo
      Documentation: rev-list-options: Rewrite simplification descripti=
ons for clarity
      rebase -i -p: handle index and workdir correctly
      rebase -i -p: fix parent rewriting

Todd Zullinger (1):
      Replace uses of "git-var" with "git var"

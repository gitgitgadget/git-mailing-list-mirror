From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [ANNOUNCE] tig-2.0
Date: Wed, 30 Apr 2014 00:59:55 -0400
Message-ID: <CAFuPQ1JL_tXhVR1CPoGgy442PoYuzORVXROLMm3nSizU76NhhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:00:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfMdE-0007BV-V6
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 07:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886AbaD3FAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 01:00:19 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:58535 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbaD3FAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 01:00:16 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so1389181oag.11
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LHdG4WUFe0tv3UUSmVxQzLTLtdevX1b2FGEOrsiCJPg=;
        b=wVARrRnkMCFu4gbKboZIrGUbCkE37JLBYK6UNpMJ5pQ+z9lvOAQd431nZt+YwH4sJS
         pMFk9kGFPrnffaSIhWkoROrbhji1xBgXscUyerWthI7+npWfb6yDsgoi+lW3tVUxmvJ7
         l79K4lsTLniIcNJECvxJR4DNa5C5tg8PJTi8lJ+1G9x7VOa8BkME17rUHpAg0utrmVMS
         8igyaiOlYhvKyzTMl51U+cJYIJOwax+u/h4fGKWBsKajWi5wbrmRfuqcYDTyJ0OjCYnY
         cNPAvfRB1FvLbDZOh9P5ER6BlQcHZU8Z2OynRcnJu8S0PijYychYNoKStH4rQUq4drrr
         4MCw==
X-Received: by 10.182.112.231 with SMTP id it7mr1929256obb.8.1398834015583;
 Tue, 29 Apr 2014 22:00:15 -0700 (PDT)
Received: by 10.76.8.3 with HTTP; Tue, 29 Apr 2014 21:59:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247675>

A little over 8 years ago the first version of Tig was released. To
celebrate the many years with this cursed Git interface, here is a fresh
new installment. Version 2.0 of Tig brings several configuration
improvements, some of which unfortunately also breaks backwards
compatibility with respect to the configuration file. Among view related
changes, the branch view has been renamed to the refs view and now
also shows tags, the log view now highlights diff stats and supports
--graph, and the new grep view allows to quickly jump between matching
files. This release also adds mouse support, improvements to the graph
rendering, and readline support in the prompt. Please read the release
notes below for more information and upgrade instructions.

Thanks to everybody who contributed to this release.

What is Tig?
------------
Tig is an ncurses-based text-mode interface for git. It functions mainly
as a Git repository browser, but can also assist in staging changes for
commit at chunk level and act as a pager for output from various Git
commands.

 - Homepage: http://jonas.nitro.dk/tig/
 - Manual: http://jonas.nitro.dk/tig/manual.html
 - Tarballs: http://jonas.nitro.dk/tig/releases/
 - Git URL: git://github.com/jonas/tig.git
 - GitHub: https://github.com/jonas/tig
 - Q&A: http://stackoverflow.com/questions/tagged/tig

Release notes
-------------
Note to packagers:

 - Add `.adoc` extension to AsciiDoc files so they show correctly on GitHub.
   This includes `README`, `INSTALL`, and `NEWS` and files in `doc/` directory.
 - `BUGS` file has been merged into `README.adoc`.
 - Default keybindings have been moved to a system-level `tigrc` file, which is
   installed to ${sysconfdir} by default. The content of the `tigrc` file is
   included inside the binary as a fall-back. Pass `NO_BUILTIN_TIGRC=y` to not
   include the system `tigrc` content and reduce the size of the binary.
 - The example `contrib/tigrc` file (made obsolete by `tigrc`) has been removed.
 - Source files have been moved to `src` and `include` and `tig.c` was split up.
 - Build output is less verbose by default; use `make V=1` for old output.

Incompatibilities:

 - In preparation for key combo support, key mappings for symbolic keys (e.g.
   `Up` and `Down`) must now start with `<` and end with `>`, e.g. `<Up>` and
   `<Down>`. Furthermore, escape key combos must now use `<Esc>key` instead of
   `^[key`, and control key mappings must now use `<Ctrl-key>` instead of
   `^key`.
 - Only use 'diff-options' for the diff view and introduce '%(cmdlineargs)' to
   hold non-file and non-revision flags passed on the command line. Affects all
   user-defined commands that expect '%(diffargs)' to hold both 'diff-options'
   arguments and those passed on the command line. (GH #228)
 - Remove built-in keybinding for `git gc`. Add the following line to `~/.tigrc`
   to restore it: `bind generic G ?git gc`.
 - To support view specific colors, '.' can no longer be used interchangeably
   with '-' and '_' in settings names and in particular color names.
 - Replace 'stage-next' action with prompt command using a predefined search
   (see below) and add binding (`@` by default) to also work in the diff view.
 - Most view display options must now be set via the new `*-view` options in
   tigrc. Existing options are no longer recognized, but a warning is shown.
 - Remap default bindings to have more consistent convention: use lower-case
   keys primarily for view switching and non-destructive actions, use upper-case
   keys for view-specific actions including user-defined commands. To preserve
   old default key bindings see `contrib/bindings-v1.x.tigrc`. (GH #257)

Improvements:

 - Add mouse support: scroll view, click line to move cursor, double click line
   (or click again) to "Enter" cursor line, e.g. open commit diff. Disabled by
   default, since it makes text selection less intuitive. If you enable this
   remember to hold down Shift (or Option on Mac) when selecting text.
 - Rewrite and improve the rendering of the commit graph. (GH #144, #46)
 - Add completion and history support to the prompt via readline. (GH #185)
 - Options can be configured and toggled individually for each view. Use the new
   view settings to configure the order and display options for each view
   columns. See system tigrc and tigrc(5) for examples. (GH #89, #222)
 - Add grep view as a front-end to git-grep(1): `tig grep -p strchr`. From
   within Tig, the key for switching or grepping is bound to 'g' by default.
 - Rename 'branch' view to 'refs' view and show tags. (GH #134)
 - Add main view pager mode that reads git-log's '--pretty=raw' data
   from stdin, e.g. `git reflog --pretty=raw | tig --pretty=raw`.
 - Add support for `--graph` and highlight diff stats in the log view.
 - Add default command bindings: `!` to delete branch, `!` to drop stash.
 - Add 'stage-split-chunk' action for splitting chunks in the stage view.
   Bound to '\' by default. (GH #107)
 - Add 'back' action bound to '<' by default, which will return the blame view
   to the previous revision and line after moving e.g. to the parent. (GH #124)
 - Auto-refresh views based on watched repository changes. Configure by setting
   `refresh-mode` to 'manual', 'auto', 'after-command', or 'periodic'. (GH #190)
 - All default settings are in well-documented system `tigrc`.
 - Add `:toggle` prompt command to manipulate options using keybindings. For
   example: `bind diff D :toggle diff-options --patience --notes`. (GH #69)
 - Add a new "auto" value for the 'vertical-split' option to let Tig choose the
   split orientation (this is the new default behavior). Can be toggled.
 - Make it possible to toggle the display of files in untracked directories.
 - Allow Tig to be started with no default configuration by specifying an
   alternative system `tigrc` file, e.g.: `TIGRC_SYSTEM=~/.tigrc.safe tig`. Set
   `TIGRC_SYSTEM` to the empty string to use built-in configuration instead of
 - Key mappings can contain UTF-8 multibyte unicode keys.
 - Warn about conflicting keybindings using Ctrl, e.g. `<Ctrl-f>` and
   `<Ctrl-F>`. (GH #218)
 - Extend key bindings for prompt commands (ie. `bind <keymap> <key> :<prompt>`)
   to support predefined searches, eg.: `bind stage 2 :?^@@`.
 - Git color mappings can be configured in tigrc.
 - More informative configuration error messages.
 - Make reference label formatting configurable, for example:
   `set reference-format = (branch) <tags> remote`. (GH #201)
 - Adjust author width and other view columns automatically. (GH #49)
 - Support view specific colors: `color stage.diff-add yellow default`.
 - Copy `-S`, `-G` and `--grep=` pattern to search buffer so 'find-next' and
   'find-prev' work as expected.
 - Optionally specify custom prompt for `%(prompt)` in shell commands, e.g.
   `bind main B ?git checkout -b "%(prompt Enter new branch name: )"`.
 - Add `%(remote)` and `%(tag)` symbols to complement `%(branch)`.
 - User-defined commands can now be prefixed with any of the supported flags,
   e.g. `?git checkout -b %(branch)`.
 - Open editor at line number for combined diffs e.g. diffs of unmerged files.
 - Add build configuration for Cygwin (OS name: CYGWIN_NT-6.1). (GH #92)
 - Document the Git commands supported by the pager mode.  (GH #1)
   system `tigrc` configuration. (GH #235)

Bug fixes:

 - Fix stash diff display when reloading the stash view after a deleting.
 - Set the commit reference when opening the blame view from the blob view.
 - Correctly identify and highlight the remote branch tracked by HEAD.
 - Pass --no-color after user defined arguments to ensure that colors do not
   break the output parsing. (GH #191)
 - Close stdin when pager mode is not supported.
 - Show newly created branches in the main view. (GH #196)
 - File with 0 changes breaks diffstat highlighting (GH #215)
 - Update %(branch) variable in the main view. (GH #223)
 - Disable graph rendering when either of `--reverse`, `-S`, `-G`, and `--grep`
   are passed to the main view. (GH #127)
 - Only refresh views that support it.
 - Fix author and date annotation of renamed entries in the tree view.
 - Fix use of unsafe methods in the signal handler. (GH #245)
 - Fix rendering in non-UTF8 terminals.
 - Fix stage-update-line by rewriting the diff chunk containing the line instead
   of using `--unidiff-zero` and a diff context of zero. (GH #130)
 - Fix status-update to work for untracked directories. (GH #236)
 - Don't pass log parameters given on the command line to the diff view.

Change summary
--------------
The diffstat and log summary for changes made in this release.

 .gitignore                                         |   26 +-
 .travis.yml                                        |   18 +
 BUGS                                               |    8 -
 INSTALL => INSTALL.adoc                            |   15 +-
 Makefile                                           |  241 +-
 NEWS => NEWS.adoc                                  |  118 +
 README                                             |   24 -
 README.adoc                                        |   40 +
 autogen.sh                                         |    8 +-
 compat/ansidecl.h                                  |  313 +
 compat/compat.h                                    |    3 +-
 compat/hashtab.c                                   | 1001 +
 compat/hashtab.h                                   |  209 +
 compat/mkstemps.c                                  |    2 +-
 compat/setenv.c                                    |    2 +-
 config.make.in                                     |    3 +-
 configure.ac                                       |   10 +-
 contrib/bindings-v1.x.tigrc                        |   23 +
 contrib/config.make                                |   11 +-
 contrib/config.make-CYGWIN_NT-6.1                  |   19 +
 contrib/config.make-Darwin                         |    8 +
 contrib/tig-completion.bash                        |    9 +-
 contrib/tig.spec.in                                |   10 +-
 contrib/tigrc                                      |   76 -
 doc/{manual.asciidoc => manual.adoc}               |   30 +-
 doc/{tig.1.asciidoc => tig.1.adoc}                 |  107 +-
 doc/{tigmanual.7.asciidoc => tigmanual.7.adoc}     |    2 +-
 doc/tigrc.5.adoc                                   |  963 +
 doc/tigrc.5.asciidoc                               |  757 -
 graph.c                                            |  412 -
 include/tig/argv.h                                 |   73 +
 contrib/header.h => include/tig/blame.h            |   18 +-
 contrib/header.h => include/tig/blob.h             |   18 +-
 include/tig/diff.h                                 |   43 +
 include/tig/display.h                              |   62 +
 include/tig/draw.h                                 |   45 +
 git.h => include/tig/git.h                         |   26 +-
 graph.h => include/tig/graph.h                     |   41 +-
 contrib/header.h => include/tig/grep.h             |   13 +-
 contrib/header.h => include/tig/help.h             |   18 +-
 io.h => include/tig/io.h                           |   46 +-
 include/tig/keys.h                                 |   84 +
 include/tig/line.h                                 |  130 +
 contrib/header.h => include/tig/log.h              |   18 +-
 include/tig/main.h                                 |   56 +
 include/tig/options.h                              |  194 +
 include/tig/pager.h                                |   34 +
 include/tig/parse.h                                |   67 +
 include/tig/prompt.h                               |   47 +
 refs.h => include/tig/refdb.h                      |   36 +-
 contrib/header.h => include/tig/refs.h             |   18 +-
 include/tig/repo.h                                 |   37 +
 include/tig/request.h                              |  116 +
 contrib/header.h => include/tig/stage.h            |   16 +-
 contrib/header.h => include/tig/stash.h            |   18 +-
 include/tig/status.h                               |   53 +
 include/tig/string.h                               |  123 +
 include/tig/tig.h                                  |  151 +
 include/tig/tree.h                                 |   30 +
 include/tig/types.h                                |  165 +
 include/tig/util.h                                 |  126 +
 include/tig/view.h                                 |  356 +
 include/tig/watch.h                                |   58 +
 refs.c                                             |  250 -
 src/argv.c                                         |  487 +
 src/blame.c                                        |  518 +
 src/blob.c                                         |  133 +
 src/diff.c                                         |  440 +
 src/display.c                                      |  527 +
 src/draw.c                                         |  661 +
 src/graph.c                                        |  999 +
 src/grep.c                                         |  263 +
 src/help.c                                         |  301 +
 io.c => src/io.c                                   |  373 +-
 src/keys.c                                         |  438 +
 src/line.c                                         |  208 +
 src/log.c                                          |  156 +
 src/main.c                                         |  514 +
 src/options.c                                      | 1067 +
 src/pager.c                                        |  233 +
 src/parse.c                                        |  330 +
 src/prompt.c                                       |  892 +
 src/refdb.c                                        |  398 +
 src/refs.c                                         |  202 +
 src/repo.c                                         |  136 +
 src/request.c                                      |   69 +
 src/stage.c                                        |  562 +
 src/stash.c                                        |   57 +
 src/status.c                                       |  748 +
 src/string.c                                       |  372 +
 src/tig.c                                          |  735 +
 src/tree.c                                         |  486 +
 src/types.c                                        |  116 +
 src/util.c                                         |  325 +
 src/view.c                                         | 1488 ++
 src/watch.c                                        |  276 +
 test/builtin-config.sh                             |   18 +
 .../10_shorter_merge_than_branch.in                |   22 +
 .../10_shorter_merge_than_branch.out               |   11 +
 test/test-graph-samples/11_new_branch_in_middle.in |   18 +
 .../test-graph-samples/11_new_branch_in_middle.out |    9 +
 test/test-graph-samples/12_cross_over_collapse.in  |   18 +
 test/test-graph-samples/12_cross_over_collapse.out |    9 +
 ...rallel_branches_with_different_middle_branch.in |   20 +
 ...allel_branches_with_different_middle_branch.out |   10 +
 test/test-graph-samples/14_long_collapse_line.in   |   40 +
 test/test-graph-samples/14_long_collapse_line.out  |   20 +
 test/test-graph-samples/16_changes.in              |    8 +
 test/test-graph-samples/16_changes.out             |    4 +
 test/test-graph-samples/1_merge_from_left.in       |   10 +
 test/test-graph-samples/1_merge_from_left.out      |    5 +
 test/test-graph-samples/2_duplicate_parent.in      |   18 +
 test/test-graph-samples/2_duplicate_parent.out     |    9 +
 test/test-graph-samples/3_octo_merge.in            |   10 +
 test/test-graph-samples/3_octo_merge.out           |    5 +
 test/test-graph-samples/4_missing_bar.in           |   14 +
 test/test-graph-samples/4_missing_bar.out          |    7 +
 test/test-graph-samples/5_extra_pipe.in            |   12 +
 test/test-graph-samples/5_extra_pipe.out           |    6 +
 test/test-graph-samples/6_extra_bars.in            |  115 +
 test/test-graph-samples/6_extra_bars.out           |   57 +
 test/test-graph-samples/7_multi_collapse.in        |   16 +
 test/test-graph-samples/7_multi_collapse.out       |    8 +
 test/test-graph-samples/8_multi_collapse_2.in      |   18 +
 test/test-graph-samples/8_multi_collapse_2.out     |    9 +
 test/test-graph-samples/9_parallel_siblings.in     |   18 +
 test/test-graph-samples/9_parallel_siblings.out    |    9 +
 test/test-graph-samples/many_merges.in             |   65 +
 test/test-graph-samples/many_merges.out            |   20 +
 test/test-graph-samples/more.in                    |   72 +
 test/test-graph-samples/more.out                   |   36 +
 test/test-graph-samples/simple.in                  |   22 +
 test/test-graph-samples/simple.out                 |    6 +
 test/test-graph-samples/tig-all-long.in            |14986 ++++++++++++
 test/test-graph-samples/tig-all-long.out           | 1517 ++
 test/test-graph-samples/tig-all.in                 |  286 +
 test/test-graph-samples/tig-all.out                |   35 +
 test/test-graph-samples/tig.in                     |   28 +
 test/test-graph-samples/tig.out                    |    8 +
 test-graph.c => test/test-graph.c                  |   23 +-
 test/unit-test-graph.sh                            |   19 +
 tig.c                                              | 9043 -------
 tig.h                                              |  622 -
 tigrc                                              |  386 +
 {contrib => tools}/announcement.sh                 |    8 +-
 {contrib => tools}/aspell.dict                     |   16 +-
 tools/ax_lib_readline.m4                           |  223 +
 {contrib => tools}/ax_with_curses.m4               |    0
 tools/doc-gen.c                                    |   84 +
 {contrib => tools}/header.h                        |    2 +-
 tools/install.sh                                   |   49 +
 tools/make-builtin-config.sh                       |   40 +
 {contrib => tools}/release.sh                      |   11 +-
 {contrib => tools}/update-release-docs.sh          |    2 +-
 154 files changed, 38086 insertions(+), 11640 deletions(-)

     1 Andreas Schlick
     1 Beat Bolli
     1 Benjamin Bergman
     1 Ciro Santilli
     1 Dmitry Malikov
     1 Ed Bruck
     3 Jeff King
   399 Jonas Fonseca
     3 Kumar Appaiah
     1 LCD 47
     1 Lau Ching Jun
     1 Michael Barlow
     1 Oliver Chang
     1 Pat Tullmann
     4 Sven Wegener
     3 Vivien Didelot
     1 hasufell

-- 
Jonas Fonseca

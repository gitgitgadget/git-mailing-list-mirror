From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v2 1/3] git help: group common commands by theme
Date: Sat, 02 May 2015 01:01:41 +0200
Message-ID: <554405D5.9080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 01:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJwi-0001GY-1w
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbEAXCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 19:02:08 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38286 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbEAXCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 19:02:06 -0400
Received: by wiun10 with SMTP id n10so60121866wiu.1
        for <git@vger.kernel.org>; Fri, 01 May 2015 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ZgQ3nS2iZGOBHY6hJdZEUhMNfs9mOaupceb8IRw5HU0=;
        b=j5v0pSr5NuTf8oatS0aVgy5H0dzgZGlJM3EFFLnud5irUpv8hEUgTqIjP/B0Uk+fht
         HSAgLcfamksA17RlU5DfRytfr69D2os10wJPWLUnD+ktErpY/66pTSKfYn6ngrheUMUE
         c6YUb2xMd59v0j6HtU2ua7qwT2qUU9LIILZvo6JO7UOkw/9sSClE74KopwSMjUSWJ4e8
         S1yC9ntTmhQ5POZK7U74+jClwMElK3x4L1YlIflbdDYT0cGjD6bVCblPvAgUa/PBVhLt
         IlHy4PAbYLrdY3ws+xCHijTQEQvnbtuG7+6dV83yZg3HkAEI/b9Jtc6E1ihWs4kTHle0
         W7hw==
X-Received: by 10.180.100.194 with SMTP id fa2mr621033wib.8.1430521325209;
        Fri, 01 May 2015 16:02:05 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id hu1sm8512953wib.6.2015.05.01.16.02.03
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 16:02:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268198>

This v2 contains exactly the same patches but this time they are=20
properly formatted using format-patch.

Group the common commands printed by 'git help' (or 'git' without any=20
options) a beginner's friendly themes. To achieve this, the file=20
command-list.txt receives an additional information for all 'common'=20
commands, in the form of an indexed group suffix.

Group suffixes are in the form: 'x_group', where x is a number used to=20
order (ascending) commands in the displayed help:

[...]

git-add                                 mainporcelain common-3_worktree
git-bisect                              mainporcelain common-7_search
git-branch                              mainporcelain common-6_branchin=
g
git-checkout                            mainporcelain common-6_branchin=
g

[...]

Note: the proposed layout comprises:

1_init
2_info
3_worktree
4_remote
5_history
6_branching
7_search

But they can be easily modified by just changing command-list.txt

command-list.txt is then parsed by generate-cmdlist.sh to generate=20
common-cmds.h with the additional group name being a 'group' field in=20
the cmdname_help struct:

[...]

   {"add", N_("Add file contents to the index"), "3_worktree"},
   {"bisect", N_("Find by binary search the change that introduced a=20
bug"), "7_search"},
   {"branch", N_("List, create, or delete branches"), "6_branching"},
   {"checkout", N_("Checkout a branch or paths to the working tree"),=20
"6_branching"},

[...]

=46inally, list_common_cmds_help() prints those common commands by grou=
ps,=20
skipping a line between each group:

[...]

The most commonly used git commands are:
    clone      Clone a repository into a new directory
    init       Create an empty Git repository or reinitialize an=20
existing one

    log        Show commit logs
    show       Show various types of objects
    status     Show the working tree status

    add        Add file contents to the index
    mv         Move or rename a file, a directory, or a symlink
    reset      Reset current HEAD to the specified state
    rm         Remove files from the working tree and from the index

    fetch      Download objects and refs from another repository
    pull       Fetch from and integrate with another repository or a=20
local branch
    push       Update remote refs along with associated objects

    commit     Record changes to the repository
    diff       Show changes between commits, commit and working tree, e=
tc
    rebase     Forward-port local commits to the updated upstream head
    tag        Create, list, delete or verify a tag object signed with =
GPG

[...]


Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>

---
  command-list.txt | 42 +++++++++++++++++++++---------------------
  1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index f1eae08..b0730a2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,29 +1,29 @@
  # List of known git commands.
  # command name                category [deprecated] [common]
-git-add                                 mainporcelain common
+git-add                                 mainporcelain common-3_worktre=
e
  git-am                                  mainporcelain
  git-annotate                            ancillaryinterrogators
  git-apply                               plumbingmanipulators
  git-archimport                          foreignscminterface
  git-archive                             mainporcelain
-git-bisect                              mainporcelain common
+git-bisect                              mainporcelain common-7_search
  git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain common
+git-branch                              mainporcelain common-6_branchi=
ng
  git-bundle                              mainporcelain
  git-cat-file                            plumbinginterrogators
  git-check-attr                          purehelpers
  git-check-ignore                        purehelpers
  git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain common
+git-checkout                            mainporcelain common-6_branchi=
ng
  git-checkout-index                      plumbingmanipulators
  git-check-ref-format                    purehelpers
  git-cherry                              ancillaryinterrogators
  git-cherry-pick                         mainporcelain
  git-citool                              mainporcelain
  git-clean                               mainporcelain
-git-clone                               mainporcelain common
+git-clone                               mainporcelain common-1_init
  git-column                              purehelpers
-git-commit                              mainporcelain common
+git-commit                              mainporcelain common-5_history
  git-commit-tree                         plumbingmanipulators
  git-config                              ancillarymanipulators
  git-count-objects                       ancillaryinterrogators
@@ -35,14 +35,14 @@ git-cvsimport foreignscminterface
  git-cvsserver                           foreignscminterface
  git-daemon                              synchingrepositories
  git-describe                            mainporcelain
-git-diff                                mainporcelain common
+git-diff                                mainporcelain common-5_history
  git-diff-files                          plumbinginterrogators
  git-diff-index                          plumbinginterrogators
  git-diff-tree                           plumbinginterrogators
  git-difftool                            ancillaryinterrogators
  git-fast-export                ancillarymanipulators
  git-fast-import                ancillarymanipulators
-git-fetch                               mainporcelain common
+git-fetch                               mainporcelain common-4_remote
  git-fetch-pack                          synchingrepositories
  git-filter-branch                       ancillarymanipulators
  git-fmt-merge-msg                       purehelpers
@@ -51,7 +51,7 @@ git-format-patch mainporcelain
  git-fsck                            ancillaryinterrogators
  git-gc                                  mainporcelain
  git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain common
+git-grep                                mainporcelain common-7_search
  git-gui                                 mainporcelain
  git-hash-object                         plumbingmanipulators
  git-help                ancillaryinterrogators
@@ -60,17 +60,17 @@ git-http-fetch synchelpers
  git-http-push                           synchelpers
  git-imap-send                           foreignscminterface
  git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain common
+git-init                                mainporcelain common-1_init
  git-instaweb                            ancillaryinterrogators
  git-interpret-trailers                  purehelpers
  gitk                                    mainporcelain
-git-log                                 mainporcelain common
+git-log                                 mainporcelain common-2_info
  git-ls-files                            plumbinginterrogators
  git-ls-remote                           plumbinginterrogators
  git-ls-tree                             plumbinginterrogators
  git-mailinfo                            purehelpers
  git-mailsplit                           purehelpers
-git-merge                               mainporcelain common
+git-merge                               mainporcelain common-6_branchi=
ng
  git-merge-base                          plumbinginterrogators
  git-merge-file                          plumbingmanipulators
  git-merge-index                         plumbingmanipulators
@@ -79,7 +79,7 @@ git-mergetool ancillarymanipulators
  git-merge-tree                          ancillaryinterrogators
  git-mktag                               plumbingmanipulators
  git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain common
+git-mv                                  mainporcelain common-3_worktre=
e
  git-name-rev                            plumbinginterrogators
  git-notes                               mainporcelain
  git-p4                                  foreignscminterface
@@ -90,11 +90,11 @@ git-parse-remote synchelpers
  git-patch-id                            purehelpers
  git-prune                               ancillarymanipulators
  git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain common
-git-push                                mainporcelain common
+git-pull                                mainporcelain common-4_remote
+git-push                                mainporcelain common-4_remote
  git-quiltimport                         foreignscminterface
  git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain common
+git-rebase                              mainporcelain common-5_history
  git-receive-pack                        synchelpers
  git-reflog                              ancillarymanipulators
  git-relink                              ancillarymanipulators
@@ -103,28 +103,28 @@ git-repack ancillarymanipulators
  git-replace                             ancillarymanipulators
  git-request-pull                        foreignscminterface
  git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain common
+git-reset                               mainporcelain common-3_worktre=
e
  git-revert                              mainporcelain
  git-rev-list                            plumbinginterrogators
  git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain common
+git-rm                                  mainporcelain common-3_worktre=
e
  git-send-email                          foreignscminterface
  git-send-pack                           synchingrepositories
  git-shell                               synchelpers
  git-shortlog                            mainporcelain
-git-show                                mainporcelain common
+git-show                                mainporcelain common-2_info
  git-show-branch                         ancillaryinterrogators
  git-show-index                          plumbinginterrogators
  git-show-ref                            plumbinginterrogators
  git-sh-i18n                             purehelpers
  git-sh-setup                            purehelpers
  git-stash                               mainporcelain
-git-status                              mainporcelain common
+git-status                              mainporcelain common-2_info
  git-stripspace                          purehelpers
  git-submodule                           mainporcelain
  git-svn                                 foreignscminterface
  git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain common
+git-tag                                 mainporcelain common-5_history
  git-unpack-file                         plumbinginterrogators
  git-unpack-objects                      plumbingmanipulators
  git-update-index                        plumbingmanipulators
--=20
2.4.0

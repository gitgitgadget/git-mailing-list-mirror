From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/45] "struct pathspec" conversion and :(glob)
Date: Sun,  9 Jun 2013 13:25:33 +0700
Message-ID: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ3i-0007t9-QT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3FIGYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:24:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58816 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3FIGYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:24:53 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so723229pab.36
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9xhXVJ77RFO2Snf0jyCO/QtO76z7HYOlhXDE6/53w4A=;
        b=USUhOKsYQE7FBZkikD/HEWJ62SUADL3zDzeVyxX970+iO4POlwVnJ792DsRVeL1TgV
         nTUhqOY9KwgLyJqGoXkhhNB1F2v5/cMIzFx3B3PTSZHUVoN/DYT+Cs3WXfkvcyD8c0SY
         3NoLv53ys7OVs1AoRdFruU4PlhP+QaU3t3i72cqiYITwWSVfhBLvisOBzYHgY5ntvtA5
         +B4WRbJjdlLlHOQiMO5IdD4mqvTcZXHhY52dhl726TbcXPGymjk7XDFzdLdJoIr7kipr
         MQRGcVYoUFg0durw6et5Uw3Wc/9ohAukxcmeEZiIksyiWvT1s9hb2Rb+oWhRuqH7eUzH
         v8/g==
X-Received: by 10.68.204.98 with SMTP id kx2mr5175805pbc.26.1370759092507;
        Sat, 08 Jun 2013 23:24:52 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id nt6sm5552762pbb.4.2013.06.08.23.24.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:24:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:26:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226892>

This series finishes off "struct pathspec" conversion that was started
2 years ago when this struct was added. In the end we can pass more
information down the callchain than simply a series of strings. This
makes it possible to add more pathspec "magic", the :(glob) in the end
of this series is an example. This also changes --literal-pathspecs
slightly, to not just make the pathspec literal, but to disable all
magic.

Next step: introduction of :(icase) magic for case-insensitive
matching (definitely won't take another 2 years as the groundwork is
pretty much done).

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (45):
  clean: remove unused variable "seen"
  Move struct pathspec and related functions to pathspec.[ch]
  pathspec: i18n-ize error strings in pathspec parsing code
  pathspec: add copy_pathspec
  Add parse_pathspec() that converts cmdline args to struct pathspec
  parse_pathspec: save original pathspec for reporting
  parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
  Convert some get_pathspec() calls to parse_pathspec()
  parse_pathspec: a special flag for max_depth feature
  parse_pathspec: support stripping submodule trailing slashes
  parse_pathspec: support stripping/checking submodule paths
  parse_pathspec: support prefixing original patterns
  Guard against new pathspec magic in pathspec matching code
  clean: convert to use parse_pathspec
  commit: convert to use parse_pathspec
  status: convert to use parse_pathspec
  rerere: convert to use parse_pathspec
  checkout: convert to use parse_pathspec
  rm: convert to use parse_pathspec
  ls-files: convert to use parse_pathspec
  archive: convert to use parse_pathspec
  check-ignore: convert to use parse_pathspec
  add: convert to use parse_pathspec
  reset: convert to use parse_pathspec
  line-log: convert to use parse_pathspec
  Convert read_cache_preload() to take struct pathspec
  Convert run_add_interactive to use struct pathspec
  Convert unmerge_cache to take struct pathspec
  checkout: convert read_tree_some to take struct pathspec
  Convert report_path_error to take struct pathspec
  Convert refresh_index to take struct pathspec
  Convert {read,fill}_directory to take struct pathspec
  Convert add_files_to_cache to take struct pathspec
  Convert common_prefix() to use struct pathspec
  Remove diff_tree_{setup,release}_paths
  Remove init_pathspec() in favor of parse_pathspec()
  Remove match_pathspec() in favor of match_pathspec_depth()
  tree-diff: remove the use of pathspec's raw[] in follow-rename codepa=
th
  parse_pathspec: make sure the prefix part is wildcard-free
  parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
  Kill limit_pathspec_to_literal() as it's only used by parse_pathspec(=
)
  pathspec: support :(literal) syntax for noglob pathspec
  pathspec: make --literal-pathspecs disable pathspec magic
  pathspec: support :(glob) syntax
  Rename field "raw" to "_raw" in struct pathspec

 Documentation/git.txt                 |  23 +-
 Documentation/glossary-content.txt    |  49 +++-
 Documentation/technical/api-setup.txt |  38 ++-
 archive.c                             |  18 +-
 archive.h                             |   4 +-
 builtin/add.c                         | 164 ++++++-------
 builtin/blame.c                       |  14 +-
 builtin/check-ignore.c                |  35 ++-
 builtin/checkout.c                    |  40 +--
 builtin/clean.c                       |  24 +-
 builtin/commit.c                      |  37 ++-
 builtin/diff-files.c                  |   2 +-
 builtin/diff-index.c                  |   2 +-
 builtin/diff.c                        |   6 +-
 builtin/grep.c                        |  10 +-
 builtin/log.c                         |   2 +-
 builtin/ls-files.c                    |  75 +++---
 builtin/ls-tree.c                     |  13 +-
 builtin/mv.c                          |  13 +-
 builtin/rerere.c                      |   8 +-
 builtin/reset.c                       |  33 ++-
 builtin/rm.c                          |  24 +-
 builtin/update-index.c                |   6 +-
 cache.h                               |  34 +--
 commit.h                              |   2 +-
 diff-lib.c                            |   3 +-
 diff.h                                |   3 +-
 dir.c                                 | 261 +++++---------------
 dir.h                                 |  18 +-
 git.c                                 |   8 +
 line-log.c                            |   2 +-
 merge-recursive.c                     |   2 +-
 notes-merge.c                         |   4 +-
 path.c                                |  15 +-
 pathspec.c                            | 442 ++++++++++++++++++++++++++=
+++++---
 pathspec.h                            |  68 +++++-
 preload-index.c                       |  21 +-
 read-cache.c                          |   5 +-
 rerere.c                              |   7 +-
 rerere.h                              |   4 +-
 resolve-undo.c                        |   4 +-
 resolve-undo.h                        |   2 +-
 revision.c                            |  11 +-
 setup.c                               | 173 ++-----------
 t/t0008-ignores.sh                    |   8 +-
 t/t6130-pathspec-noglob.sh            |  87 +++++++
 tree-diff.c                           |  48 ++--
 tree-walk.c                           |  21 +-
 tree.c                                |   4 +-
 tree.h                                |   2 +-
 wt-status.c                           |  16 +-
 wt-status.h                           |   2 +-
 52 files changed, 1140 insertions(+), 777 deletions(-)

--=20
1.8.2.83.gc99314b

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/21] nd/parse-pathspec reroll
Date: Fri, 11 Jan 2013 18:20:54 +0700
Message-ID: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:21:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttcg2-0006NZ-7A
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab3AKLVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:21:05 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:50336 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3AKLVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:21:02 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so910661pbc.41
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wEPJdd/IyknkOhMWVutX57PW6I7RAHJzw/CwxGyflpQ=;
        b=UzAesq2OKGLSL7x7pG/BzmcgYaTds/tFEUETnK7lvrHDHGY2WQgyQPDHvOK6R8LNSY
         YfY5Z6iCeJdSznmse7kqenMtL148Gv1XZxGyTu2HAORg8Ubn6JRtkDaq6FfuKKQlowNR
         Sv1IZWWrkTVOT3sFTn0JCe6BpKC9R+yZUUao5sc4vh9EvL1fo1DqC7kDrG7Ek+zw54k8
         OA8jpYxT8Q4e1ypOf+MQ2InytFwZ55Hm8EQOUV32I1UXVzjLqwk++MiEPiSLN6ihPSfu
         /pKjuWlX159bKGRmZx5nt5sKv8NLompjLPOyqtTffa5h8swU3VAkXuZb5LTrSJR8C0Xe
         ZDHw==
X-Received: by 10.68.117.145 with SMTP id ke17mr30970802pbb.52.1357903262409;
        Fri, 11 Jan 2013 03:21:02 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id n10sm2941919pav.18.2013.01.11.03.20.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:21:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:21:16 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213193>

Changes:

- The incorrect patch 'pathspec: make sure the prefix part is
  wildcard-clean' is removed. I want to keep this series simple.
  Complex pathspec manipulation will have its own series later.

- Fix t7400.38 failure when core.ignorecase is on. We should exercise
  core.ignorecase codepath more in the test suite, but that should be
  in a separate series.

- parse_pathspec() learns PATHSPEC_EMPTY_MATCH_ALL flag to support
  "no pathspec means match everything", which is used by some commands
  like commit/status

- rename 'raw' to '_raw' to catch new access sites

I also checked if we still have similar faults to t7400.38 (modifying
pathspec directly leading to inconsistencies) and I think we're safe.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21):
  pathspec: save the non-wildcard length part
  Add parse_pathspec() that converts cmdline args to struct pathspec
  Export parse_pathspec() and convert some get_pathspec() calls
  clean: convert to use parse_pathspec
  commit: convert to use parse_pathspec
  status: convert to use parse_pathspec
  rerere: convert to use parse_pathspec
  checkout: convert to use parse_pathspec
  rm: convert to use parse_pathspec
  ls-files: convert to use parse_pathspec
  archive: convert to use parse_pathspec
  add: convert to use parse_pathspec
  Convert read_cache_preload() to take struct pathspec
  Convert unmerge_cache to take struct pathspec
  checkout: convert read_tree_some to take struct pathspec
  Convert report_path_error to take struct pathspec
  Convert refresh_index to take struct pathspec
  Convert {read,fill}_directory to take struct pathspec
  Convert add_files_to_cache to take struct pathspec
  Convert more init_pathspec() to parse_pathspec()
  Rename field "raw" to "_raw" in struct pathspec

 archive.c              |  12 +++---
 archive.h              |   2 +-
 builtin/add.c          | 102 ++++++++++++++++++-----------------------=
--------
 builtin/checkout.c     |  37 ++++++++----------
 builtin/clean.c        |  20 +++++-----
 builtin/commit.c       |  39 +++++++++----------
 builtin/diff-files.c   |   2 +-
 builtin/diff-index.c   |   2 +-
 builtin/diff.c         |   4 +-
 builtin/grep.c         |   6 +--
 builtin/log.c          |   2 +-
 builtin/ls-files.c     |  64 +++++++++++--------------------
 builtin/ls-tree.c      |   6 +--
 builtin/rerere.c       |   6 +--
 builtin/rm.c           |  16 ++++----
 builtin/update-index.c |   3 +-
 cache.h                |  25 +++++++++---
 diff-lib.c             |   2 +-
 dir.c                  |  72 +++++++++++++++++++++++++++++-----
 dir.h                  |   5 ++-
 merge-recursive.c      |   2 +-
 preload-index.c        |  20 +++++-----
 read-cache.c           |   5 ++-
 rerere.c               |   6 +--
 rerere.h               |   4 +-
 resolve-undo.c         |   4 +-
 resolve-undo.h         |   2 +-
 revision.c             |   8 ++--
 setup.c                | 102 +++++++++++++++++++++++++++++++++++++----=
--------
 tree-diff.c            |   8 ++--
 tree-walk.c            |   4 +-
 tree.c                 |   4 +-
 tree.h                 |   2 +-
 wt-status.c            |  17 ++++-----
 wt-status.h            |   2 +-
 35 files changed, 339 insertions(+), 278 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df

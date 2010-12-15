From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/21] nd/struct-pathspec v2
Date: Wed, 15 Dec 2010 22:02:35 +0700
Message-ID: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSstZ-0008VW-MV
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab0LOPDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:03:53 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:43085 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LOPDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:03:52 -0500
Received: by gwb20 with SMTP id 20so1537127gwb.1
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=0G7+TFHsrc4SsQn5HERdQ12+IeMfjVKk6zVcjgqA+YI=;
        b=R9sc5R2SsIrUngTcxzN8ZXfiZCHz3yB5BFj9bPMAXHciazOq0sp4oWEFs7AWho3gLm
         qh5cTrW6Nfl1Ju2RfkM6IwtEdG33vFiANXxr7AfiqkmvxRSeuD9BmIM+sO2KaucA/on4
         qwmXULqFHckpOU2SXRmG6k0kCI7aVHsQpj/Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=EHpCKhhxU8Uj2Xv4K+wpaW3bImBc+hfMs9fOYV62v1BIh959vHqAAFdd4Xs7TEWfDz
         /fcn651wDzdC7CEwFy5ZquXS3FW3dVIq6qlD0SEdq8QcXGLnPvOqpKWckRnBED7PejXZ
         FHHUEUFunZcKzizCzTVPR4SSxvnN1PRj78eF0=
Received: by 10.42.171.201 with SMTP id k9mr5954792icz.212.1292425431384;
        Wed, 15 Dec 2010 07:03:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id he5sm842984icb.22.2010.12.15.07.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:03:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:02:58 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163757>

Changes from previous version [1]

 - fixes depth limit and overlapping pathspecs, by checking deepest
   pathspecs first. struct pathspec is now sorted (raw[] untouched)

 - match_pathspec_depth depends on new match_pathspec_item() (a
   clone of match_one(), but takes advantage of struct pathspec)

 - ce_path_match uses struct pathspec

 - strbuf is used instead of fixed length "base" buffer. This
   introduces the weird strbuf_offset() function.

 - never_interesting is disabled if any wildcards is present

 - struct pathspec * =3D=3D NULL is unacceptable, callers must pass
   non-NULL.

 - a bit more tests

[1] http://mid.gmane.org/1292233616-27692-1-git-send-email-pclouds@gmai=
l.com

Jonathan Nieder (1):
  glossary: define pathspec

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
  Add struct pathspec
  diff-no-index: use diff_tree_setup_paths()
  Convert struct diff_options to use struct pathspec
  tree_entry_interesting(): remove dependency on struct diff_options
  Move tree_entry_interesting() to tree-walk.c and export it
  diff-tree: convert base+baselen to writable strbuf
  tree_entry_interesting(): refactor into separate smaller functions
  tree_entry_interesting(): support depth limit
  tree_entry_interesting(): fix depth limit with overlapping pathspecs
  tree_entry_interesting(): support wildcard matching
  tree_entry_interesting(): optimize wildcard matching when base is mat=
ched
  pathspec: add match_pathspec_depth()
  Convert ce_path_match() to use struct pathspec
  Convert ce_path_match() to use match_pathspec_depth()
  grep: convert to use struct pathspec
  grep: use match_pathspec_depth() for cache/worktree grepping
  strbuf: allow "buf" to point to the middle of the allocated buffer
  grep: use writable strbuf from caller for grep_tree()
  grep: drop pathspec_matches() in favor of tree_entry_interesting()
  t7810: overlapping pathspecs and depth limit

 Documentation/glossary-content.txt |   23 +++
 builtin/diff-files.c               |    2 +-
 builtin/diff.c                     |    4 +-
 builtin/grep.c                     |  197 +++++++-------------------
 builtin/log.c                      |    2 +-
 builtin/update-index.c             |    8 +-
 cache.h                            |   17 ++-
 diff-lib.c                         |   12 ++-
 diff-no-index.c                    |   13 +-
 diff.h                             |    4 +-
 dir.c                              |  151 ++++++++++++++++++++
 dir.h                              |    4 +
 preload-index.c                    |    5 +-
 read-cache.c                       |   25 +---
 revision.c                         |   11 +-
 strbuf.c                           |   36 ++++--
 strbuf.h                           |   10 +-
 t/t4010-diff-pathspec.sh           |   32 ++++
 t/t7810-grep.sh                    |   18 +++
 tree-diff.c                        |  277 +++++++++-------------------=
--------
 tree-walk.c                        |  180 +++++++++++++++++++++++
 tree-walk.h                        |    2 +
 wt-status.c                        |    5 +-
 23 files changed, 615 insertions(+), 423 deletions(-)

--=20
1.7.3.3.476.g10a82

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 00/10] Fancy pathspec stuff
Date: Sun, 13 Jan 2013 19:49:29 +0700
Message-ID: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN0g-0000jJ-PB
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab3AMMt1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:49:27 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51197 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3AMMt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:49:27 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so1703218pbb.15
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=qd24pAqk54KYO8lAdVbvOwU2TmT3XLaTfV4lLbnXBsI=;
        b=Tk6RaKdP3ofFlj27YWasPDNefQKhoBJXTMM8KVYhv1rc3YVv/to7CA9TN6Ea879aKo
         6i0T9RRdZxgPm5/TfGwTyJyjeJ6zhhmH5DqV9atOCZE6NbkV09Og2v0KXCQRoq4qmB2J
         d8f0S2i7BGm1p8arw7hfGMtrOn874dMIujuvKluF0zx7bINN8EnfoIsaFuRYwkR6PrfJ
         zj6T21P1659xa6byOuDRXBPCvHHdKcnqRa+AF35cuPa5fFNhiNRPbXyyreeehBrdJxOY
         Ff3RYyIQuhwIL5ZEovzhVgC82IlHy3hbUnaMVKVh5t53UmixTX6ANYJZQlxWiaWSZ0xz
         b/bw==
X-Received: by 10.66.82.162 with SMTP id j2mr223407061pay.13.1358081366590;
        Sun, 13 Jan 2013 04:49:26 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id th10sm3354201pbc.76.2013.01.13.04.49.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:49:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:49:40 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213373>

I wanted to see how new pathspec feature can be implemented after
nd/parse-pathspec, mainly to see if nd/parse-pathspec needs fixing.
It's nowhere near 'pu' quality but may be interesting for some people.

It does:

- introduce :q/.../ syntax in addition to :(...), which always
  requires quoting in bash

- separate prefix part from the rest of pathspec, allowing it to be
  treated differently (e.g. prefix is matched exactly regardless
  pathspec magic)

- implement :(glob) using wildmatch (i.e. incompatible with the
  wildcards that current pathspec uses)

- implement :(icase) -- with bugs

- implement :(literal), similar to --literal-pathspecs

That's all my spam for today.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  pathspec: allow to use alternate char for quoting long magic mnemonic
  parse_pathspec: make sure the prefix part is wildcard-free
  pathspec: support :(literal) syntax for noglob pathspec
  parse_pathspec: save prefix information
  pathspec: prepare for :(glob)path syntax
  Enable :(glob)path syntax for a lot of commands
  parse_pathspec: accept :(icase)path syntax
  common_prefix/read_directory: treat PATHSPEC_ICASE like wildcards
  pathspec: support icase in match_pathspec_depth and
    tree_entry_interesting
  Enable ls-files and ls-tree for testing PATHSPEC_ICASE

 archive.c                  |  4 ++-
 builtin/add.c              | 19 +++++++++++---
 builtin/checkout.c         |  6 ++++-
 builtin/clean.c            |  6 ++++-
 builtin/commit.c           | 10 +++++--
 builtin/diff.c             |  2 +-
 builtin/grep.c             |  6 ++++-
 builtin/ls-files.c         |  6 ++++-
 builtin/ls-tree.c          |  7 ++++-
 builtin/rerere.c           |  6 ++++-
 builtin/reset.c            |  6 ++++-
 builtin/rm.c               |  6 ++++-
 builtin/update-index.c     |  6 ++++-
 cache.h                    | 23 +++++++++++++++-
 dir.c                      | 60 ++++++++++++++++++++++++++++----------=
----
 dir.h                      |  8 +++---
 path.c                     | 15 ++++++++++-
 revision.c                 |  7 +++--
 setup.c                    | 65 +++++++++++++++++++++++++++++++++-----=
--------
 t/t6130-pathspec-noglob.sh | 18 +++++++++++++
 t/t6131-pathspec-prefix.sh | 47 +++++++++++++++++++++++++++++++++
 tree-diff.c                |  2 +-
 tree-walk.c                | 39 +++++++++++++++++-----------
 23 files changed, 295 insertions(+), 79 deletions(-)
 create mode 100755 t/t6131-pathspec-prefix.sh

--=20
1.8.0.rc2.23.g1fb49df

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] nd/resolve-ref v2
Date: Thu, 17 Nov 2011 16:32:07 +0700
Message-ID: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyH2-0002SV-G5
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab1KQJ2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:28:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1KQJ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:28:41 -0500
Received: by iage36 with SMTP id e36so1839093iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Z6KwocvKNmioQStAphcLp9dv2jyYPxla4XS97lxulK0=;
        b=kocLFg4N/f0HTjBWw9X1C4HTQKhUPbDGSdtlfEtkMbqefAt6D3KKzHhOGe52qU98aM
         OjW0Dc7ZCnbpueyoQTNbU8P5BhYxGUGtqI7oV1YitmTXz/be/Gm14+9ud2DTwq7uv0v+
         9IpY2BDHgkiXBXbfyEcw81hHSbdnmQuTHxO3k=
Received: by 10.231.5.225 with SMTP id 33mr9347486ibw.3.1321522120708;
        Thu, 17 Nov 2011 01:28:40 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id jm11sm55744017ibb.1.2011.11.17.01.28.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:28:39 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:32:16 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185580>

The first part of actually nd/resolve-ref v2.

The last two patches are an attempt to catch overwriting faults in
future. git_pathname() and resolve_ref_unsafe() are guarded.

(Un)fortunately I ran "make memcheck" but found no new segfaults.
Either test coverage is insufficient, or we have done a very good
job of reviewing/testing git.git

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  Convert many resolve_ref() calls to read_ref*() and ref_exists()
  Rename resolve_ref() to resolve_ref_unsafe()
  Re-add resolve_ref() that always returns an allocated buffer
  cmd_merge: convert to single exit point
  Use resolve_ref() instead of resolve_ref_unsafe()
  Convert resolve_ref_unsafe+xstrdup to resolve_ref
  Guard memory overwriting in resolve_ref_unsafe's static buffer
  Enable GIT_DEBUG_MEMCHECK on git_pathname()

 Makefile                |    3 ++
 branch.c                |    2 +-
 builtin/branch.c        |   11 +++----
 builtin/checkout.c      |   17 ++++++------
 builtin/commit.c        |    3 +-
 builtin/fmt-merge-msg.c |    8 ++++-
 builtin/for-each-ref.c  |    7 +---
 builtin/fsck.c          |    2 +-
 builtin/merge.c         |   56 +++++++++++++++++++++++++--------------=
--
 builtin/notes.c         |    8 ++++-
 builtin/receive-pack.c  |    5 ++-
 builtin/remote.c        |   10 +++----
 builtin/replace.c       |    4 +-
 builtin/show-branch.c   |    6 +---
 builtin/show-ref.c      |    2 +-
 builtin/symbolic-ref.c  |    2 +-
 builtin/tag.c           |    4 +-
 bundle.c                |    2 +-
 cache.h                 |   17 +++++++++---
 git-compat-util.h       |    9 ++++++
 notes-merge.c           |    2 +-
 path.c                  |   28 ++++++++++++++------
 reflog-walk.c           |   13 +++++----
 refs.c                  |   63 +++++++++++++++++++++++++++++++--------=
-------
 remote.c                |   10 +++---
 transport.c             |    2 +-
 wrapper.c               |   21 +++++++++++++++
 wt-status.c             |    4 +--
 28 files changed, 203 insertions(+), 118 deletions(-)

--=20
1.7.4.74.g639db

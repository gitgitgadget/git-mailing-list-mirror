From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/12] Hard coded string length cleanup
Date: Wed, 18 Dec 2013 21:53:45 +0700
Message-ID: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIVo-00030m-H2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab3LROyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:07 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:55384 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab3LROyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:02 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so8307555pde.35
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Q9F26dqR22+2mmYiMHV2jknxIALCOkbetFEYETWGvOc=;
        b=abhgr16sD5uhgYtUr1fQxayDfrYxe1lxFL7op1E3PK2B0bOhLrV4AHxlBAinPV1p3E
         6CPKcbJ0NU9HQxwCvo2ar5VkWgAlRZ3x0bSsfHL0E9zoapWk40ltmFjQScAK37wuPx24
         k0GeeIBvOjDm996ambYEtd2NcqHzEqSrG+wTStkZJ1x4yGdLg+GXcP74N1BFmCnq+F6p
         nnTk3cK4XF26sf9mzo0hmEBvK3qv9PtVKKhtqyIKUHjarJu0K4ihudOMc4wQi+bIfLmD
         NsIlmEVe6/2tPddSiZLaAjUce5VG4w4T0w4j+8RD1b+B8+bvqXuERyARn/2TVanN1PRn
         ctCg==
X-Received: by 10.66.216.129 with SMTP id oq1mr34047276pac.75.1387378442361;
        Wed, 18 Dec 2013 06:54:02 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id nw11sm675386pab.13.2013.12.18.06.53.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:53:58 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239438>

I reimplemented skip_prefix() again just to realize this function
already exists. Which reminds me there are a bunch of places that
could benefit from this function, the same reason that I wanted to
reimplement it.

So this is series to make it more popular (so hopefully I'll see it
used somewhere and know that it exists) and the code cleaner. The
pattern "compare a string, then skip the compared part by a hard coded
string length" is almost killed. I left a few in places for those who
want to contribute :)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  Make starts_with() a wrapper of skip_prefix()
  Convert starts_with() to skip_prefix() for option parsing
  Add and use skip_prefix_defval()
  Replace some use of starts_with() with skip_prefix()
  Convert a lot of starts_with() to skip_prefix()
  fetch.c: replace some use of starts_with() with skip_prefix()
  connect.c: replace some use of starts_with() with skip_prefix()
  refs.c: replace some use of starts_with() with skip_prefix()
  diff.c: reduce code duplication in --stat-xxx parsing
  environment.c: replace starts_with() in strip_namespace() with skip_p=
refix()
  diff.c: convert diff_scoreopt_parse to use skip_prefix()
  refs.c: use skip_prefix() in prune_ref()

 builtin/branch.c         |   3 +-
 builtin/checkout.c       |   6 +-
 builtin/fast-export.c    |   3 +-
 builtin/fetch-pack.c     |  13 ++--
 builtin/fetch.c          |  16 ++---
 builtin/for-each-ref.c   |   9 +--
 builtin/index-pack.c     |  17 +++---
 builtin/ls-remote.c      |   9 +--
 builtin/mailinfo.c       |  11 ++--
 builtin/merge.c          |  12 ++--
 builtin/reflog.c         |   9 +--
 builtin/remote.c         |   3 +-
 builtin/rev-parse.c      |  41 ++++++-------
 builtin/send-pack.c      |  18 +++---
 builtin/show-branch.c    |  14 ++---
 builtin/unpack-objects.c |   5 +-
 builtin/update-ref.c     |  21 +++----
 commit.c                 |   5 +-
 connect.c                |   6 +-
 daemon.c                 |  75 +++++++++++------------
 diff.c                   | 153 +++++++++++++++++++++------------------=
--------
 environment.c            |   4 +-
 fetch-pack.c             |   9 +--
 git-compat-util.h        |  15 ++++-
 git.c                    |  16 ++---
 http-backend.c           |   5 +-
 http-push.c              |   6 +-
 http.c                   |   5 +-
 log-tree.c               |   5 +-
 merge-recursive.c        |  13 ++--
 notes.c                  |   6 +-
 pager.c                  |   2 +-
 pathspec.c               |   5 +-
 pretty.c                 |   3 +-
 refs.c                   |  20 ++++---
 revision.c               |  60 +++++++++----------
 setup.c                  |   3 +-
 sha1_name.c              |  12 +---
 strbuf.c                 |   9 ---
 tag.c                    |   7 +--
 transport-helper.c       |  15 +++--
 transport.c              |  14 +++--
 upload-pack.c            |   5 +-
 wt-status.c              |  15 ++---
 44 files changed, 334 insertions(+), 369 deletions(-)

--=20
1.8.5.1.208.g019362e

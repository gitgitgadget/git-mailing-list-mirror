From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 0/3] Bye bye fnmatch()
Date: Wed, 19 Dec 2012 20:08:05 +0700
Message-ID: <1355922488-20976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 14:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJk9-0006pG-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab2LSNbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 08:31:12 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41629 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab2LSNbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:31:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1319774pad.19
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 05:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WZlAhkKggWfsEyopyC2hObZLPeeEVV6KBdNSuFJSGDk=;
        b=u4oQ4SLtiJaLzupx+5nmEjNSubU+E1dNNvw3c0ALR2iwebh88gdeEym4NQ4hpytJO3
         9iUfP3/HW27XBJURWSaRofB7kdWeabZSF8IUCDwePia8C6BOcYKS0XI1BYJwxWMIcq9m
         ILIECDJgxJvc/QBgYxSiNLQpEQKZZF/pZx5OI76mWG+Q0d1x8GBEZZI7ethHdcfQtY6a
         KVild+IqeSW6kllnXeHMriClp7JMtVAyagws80fcHa3Jla3JVCIKMD9kEMrjJFdgGcJW
         gcYMimdcdagKgEoHF/l2RmYFdLvIzNHj/phHhzR45ngCscGKyOc7FuMDl3HNW0zE5EoW
         2dbA==
X-Received: by 10.66.73.230 with SMTP id o6mr17175924pav.57.1355922452017;
        Wed, 19 Dec 2012 05:07:32 -0800 (PST)
Received: from lanh ([115.74.42.11])
        by mx.google.com with ESMTPS id vx2sm3098404pbc.33.2012.12.19.05.07.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Dec 2012 05:07:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Dec 2012 20:08:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211823>

=46or those who have not followed, nd/wildmatch brings another
fnmatch-like implementation which can nearly replace fnmatch.
System fnmatch() seems to behave differently in some cases. It's
better to stay away and use one implementation for all.

I just wanted to see how much work there may be if we go this way. It
turns out not much. I haven't checked my dowild() changes carefully.
I may have left a bug in '[]' code. There are some minor issues I
like dependency on FNM_* macros or wildmatch.h should be incorporated
back to git-compat-util.h. But the test suite passes for me. So it's
promising.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
  wildmatch: make dowild() take arbitrary flags
  wildmatch: support "no FNM_PATHNAME" mode
  Convert all fnmatch() calls to wildmatch()

 builtin/apply.c        |  3 ++-
 builtin/branch.c       |  3 ++-
 builtin/describe.c     |  3 ++-
 builtin/for-each-ref.c |  3 ++-
 builtin/ls-remote.c    |  3 ++-
 builtin/name-rev.c     |  3 ++-
 builtin/reflog.c       |  3 ++-
 builtin/replace.c      |  3 ++-
 builtin/show-branch.c  |  3 ++-
 builtin/tag.c          |  3 ++-
 diffcore-order.c       |  3 ++-
 dir.c                  |  6 +++---
 refs.c                 |  3 ++-
 t/t3070-wildmatch.sh   | 27 +++++++++++++++++++++++++++
 test-wildmatch.c       |  4 +++-
 tree-walk.c            |  5 +++--
 wildmatch.c            | 25 ++++++++++++++-----------
 17 files changed, 74 insertions(+), 29 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df

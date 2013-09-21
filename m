From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/17] np/pack-v4 updates
Date: Sat, 21 Sep 2013 20:57:46 +0700
Message-ID: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:54:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeA-0007mY-Gk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab3IUNyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:54:43 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38361 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:54:43 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1480320pdi.19
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=BID3JZHQBzlmRywtXu3zTgTJGld23w28+FikOB8TuPM=;
        b=CYknLMUdKJO4KFfvBipMyr0MK/+KW7A+o18wJSHmdsBOmkILZn8wdyzDoNGtKleoLs
         WgTyRAy6wfrjDh2K9dGCwc9ACEY564jRbW82hCG+dCemwy4siuhrXGwvQ+lp/bpRwWZq
         9hiBtyrAmIfPaT4lFQvi0593l0A4w59/DYrjalBbD5SGWtznk/qC+amQHNFh3zE1SUAP
         99rf+CIK//WdBjjC5bx5NOrb0OLEhaV13EEhiodvAJRyw63Htmw1s0W3DAirDMqPIf3b
         FDk5mPpKyswttRjbg2Uhs4//h3iUJ8xS19RbblS4qa+Hw9HydVhnpf/20rjawRVMGc/k
         0qUA==
X-Received: by 10.66.248.161 with SMTP id yn1mr14822886pac.0.1379771682442;
        Sat, 21 Sep 2013 06:54:42 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id yh1sm22177641pbc.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:54:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235101>

This contains many bug fixes or cleanups. Also you can now run the
test suite with v4 by setting GIT_TEST_OPTS=3D--packv4. The test suite
passes now. pack size limit is not officially not supported with v4.
index-pack also learns to convert appended trees to v4 for completing
thin packs (still need to convert commits though)

PS. Nico do you still take patches and then send pull requests to
Junio occasionally, or should I start to CC Junio?

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (17):
  fixup! index-pack: record all delta bases in v4 (tree and ref-delta)
  fixup! packv4-parse.c: add tree offset caching
  fixup! pack-objects: support writing pack v4
  fixup! pack-objects: recognize v4 as pack source
  fixup! index-pack: support completing thin packs v4
  fixup! pack v4: move packv4-create.c to libgit.a
  fixup! index-pack, pack-objects: allow creating .idx v2 with .pack v4
  fixup! pack v4: code to obtain a SHA1 from a sha1ref
  fixup! pack-objects: add --version to specify written pack version
  test-lib.sh: add --packv4 for running the tests with pack v4 as defau=
lt
  packv4-parse: accept ref-delta as base of pv4-tree
  pack-objects: do not add type OBJ_NONE to objects[] in pack v4
  index-pack: encode appended trees using v4 format in pack v4
  t5302: disable sealth corruption tests when run with --packv4
  t5300: avoid testing ofs-delta with --packv4
  pack-objects: disable pack size limit feature on pack v4
  t5303: adapt the tests to run with --packv4

 .gitignore                            |  1 +
 Documentation/git-pack-objects.txt    |  4 +++
 builtin/index-pack.c                  | 49 +++++++++++++++++++++++++++=
+++-----
 builtin/pack-objects.c                | 35 ++++++++++++++++++++-----
 packv4-create.c                       | 20 ++++++++++++++
 packv4-create.h                       |  2 ++
 packv4-parse.c                        | 25 +++++++++++-------
 sha1_file.c                           |  4 ++-
 t/t5300-pack-object.sh                | 47 ++++++++++++++++++---------=
------
 t/t5302-pack-index.sh                 | 24 ++++++++---------
 t/t5303-pack-corruption-resilience.sh | 16 ++++++------
 t/test-lib.sh                         | 10 +++++++
 12 files changed, 173 insertions(+), 64 deletions(-)

--=20
1.8.2.83.gc99314b

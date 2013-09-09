From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/16] pack v4 support in pack-objects
Date: Mon,  9 Sep 2013 20:57:51 +0700
Message-ID: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1w0-0001v9-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427Ab3IINzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:12 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:55353 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3IINzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so6288659pad.32
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ctCe1kChjdi/kjf/DDpBcnIOGEuuCWBMZbyEuu9GQ6s=;
        b=LoiBHP9/cLd3aK3zI5Ze6TX9nJsNA+Tjdj7VcLk/eBkvDKoz1BzYJcYSL8+qMOgmNw
         T93Ydc4Ns2xbOBsjK4ZHMASZ+7rt4+lu1j11MVK6d1kaoGRs2YHH+CNJmzcjvTHe/xY+
         1+TdWmwB/YzYjNbMAYlw2AcZL3fV/w6sxV70X2lUHb3DMrcUWD3tab3iRws8sra8UlmD
         ksU1NIDSnOVoT7vjiEKNX9gywqKMyViHtSu4cjHKo8386U4n3knJ2i+VphY+bsl+qn1a
         W3g/4FZI1BdPu16cM5mPKzUYQYTB0pzHKv5p68p7YHlpVhhzD+QTxvm6mFuz3dSfD9+w
         2YdQ==
X-Received: by 10.68.218.163 with SMTP id ph3mr19340087pbc.19.1378734910169;
        Mon, 09 Sep 2013 06:55:10 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id gg10sm16399861pbc.46.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:58:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234328>

This version supports thin pack. I could clone from git.git with only
master, then fetch the rest and fsck did not complain anything. I did
not check if I broke --max-pack-size though.

Interesting patches are the ones near the end: "prepare SHA-1 table",
"support writing pack v4" and "support completing thin packs"

Still rough edges. If I don't find any new problems, I'll try to run
the test suite. My vacation days are over, so I will work at a much
slower pace than the last couple days.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
  pack v4: allocate dicts from the beginning
  pack v4: stop using static/global variables in packv4-create.c
  pack v4: move packv4-create.c to libgit.a
  pack v4: add version argument to write_pack_header
  pack_write: tighten valid object type check in
    encode_in_pack_object_header
  pack-write.c: add pv4_encode_object_header
  pack-objects: add --version to specify written pack version
  list-objects.c: add show_tree_entry callback to traverse_commit_list
  pack-objects: do not cache delta for v4 trees
  pack-objects: exclude commits out of delta objects in v4
  pack-objects: create pack v4 tables
  pack-objects: prepare SHA-1 table in v4
  pack-objects: support writing pack v4
  pack v4: support "end-of-pack" indicator in index-pack and
    pack-objects
  index-pack: use nr_objects_final as sha1_table size
  index-pack: support completing thin packs v4

 Makefile               |   4 +-
 builtin/index-pack.c   |  95 ++++++---
 builtin/pack-objects.c | 230 ++++++++++++++++++++--
 builtin/rev-list.c     |   4 +-
 bulk-checkin.c         |   2 +-
 list-objects.c         |   9 +-
 list-objects.h         |   3 +-
 pack-write.c           |  51 ++++-
 pack.h                 |   6 +-
 packv4-create.c        | 523 ++++-------------------------------------=
--------
 packv4-create.h (new)  |  39 ++++
 test-packv4.c (new)    | 476 +++++++++++++++++++++++++++++++++++++++++=
+++
 upload-pack.c          |   2 +-
 13 files changed, 901 insertions(+), 543 deletions(-)
 create mode 100644 packv4-create.h
 create mode 100644 test-packv4.c

--=20
1.8.2.83.gc99314b

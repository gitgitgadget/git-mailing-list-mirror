From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/11] Large blob fixes
Date: Mon,  5 Mar 2012 10:43:37 +0700
Message-ID: <1330919028-6611-1-git-send-email-pclouds@gmail.com>
References: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 04:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4OqS-0003PI-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab2CEDoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:44:16 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52615 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2CEDoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 22:44:15 -0500
Received: by dadp12 with SMTP id p12so4472065dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:44:15 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.238.136 as permitted sender) client-ip=10.68.238.136;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.238.136 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.238.136])
        by 10.68.238.136 with SMTP id vk8mr44413969pbc.143.1330919055560 (num_hops = 1);
        Sun, 04 Mar 2012 19:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YMiWYh5JNhg9CQauYbInJECq+szVTKJ0B5wTAyoXY84=;
        b=dwFEWMLyUAwiggSnf0wB7f+/gWPBD8IZ+1Y35Kte2VSwKwffeORJUVBO0MZmqu8fuD
         3N6N+3OYk7Rlq62Le/aNPWmoMr+eWdhxW6MM/otB9vwgq7ggw8pd7rWvyPrixgVHiF2L
         5yXqdEbVVi87+uBGsvSEjezycKb3HPRJdhUEVZtBD4wOrW63pJsn42e4yyemLlSUhbGB
         RYrbpsVpcAmaGZ5Kgc1wHtxgS4vg7+1hWDbOWGfB9U+UodBb9lbKxy32KscG+NE2wr59
         45ebTEoJitJ1uKj/YNiklseY7Vt/gYrUvvfArhGkk+Ryog+AeBLhZg4V2dHJzq+NbTM0
         Y+Ag==
Received: by 10.68.238.136 with SMTP id vk8mr38007613pbc.143.1330919055509;
        Sun, 04 Mar 2012 19:44:15 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q1sm12085810pbq.68.2012.03.04.19.44.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 19:44:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 05 Mar 2012 10:43:49 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192193>

Changes from v2:

 - set core.bigfilethreshold globally in t1050 to make git-clone happy
   because there's currently no way to specify this in git-clone (or
   is there?)
 - fix the bad coding taste in builtin/cat-file.c
 - make update-server-info respect core.bigfilethreshold,
   which makes repack pass on repositories that have tags

Junio C Hamano (1):
  streaming: make streaming-write-entry to be more reusable

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  Add more large blob test cases
  cat-file: use streaming interface to print blobs
  parse_object: special code path for blobs to avoid putting whole
    object in memory
  show: use streaming interface for showing blobs
  index-pack: split second pass obj handling into own function
  index-pack: reduce memory usage when the pack has large blobs
  pack-check: do not unpack blobs
  archive: support streaming large files to a tar archive
  fsck: use streaming interface for writing lost-found blobs
  update-server-info: respect core.bigfilethreshold

 archive-tar.c                |   35 ++++++++++++---
 archive-zip.c                |    9 ++--
 archive.c                    |   51 +++++++++++++++-------
 archive.h                    |   11 ++++-
 builtin/cat-file.c           |   24 +++++++++++
 builtin/fsck.c               |    8 +---
 builtin/index-pack.c         |   95 ++++++++++++++++++++++++++++++----=
-------
 builtin/log.c                |   34 +++++++++------
 builtin/update-server-info.c |    1 +
 cache.h                      |    2 +-
 entry.c                      |   53 ++---------------------
 fast-import.c                |    2 +-
 object.c                     |   11 +++++
 pack-check.c                 |   21 +++++++++-
 sha1_file.c                  |   78 +++++++++++++++++++++++++++++-----
 streaming.c                  |   55 ++++++++++++++++++++++++
 streaming.h                  |    2 +
 t/t1050-large.sh             |   63 +++++++++++++++++++++++++++-
 wrapper.c                    |   27 +++++++++++-
 19 files changed, 439 insertions(+), 143 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty

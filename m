From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/10] Large file support for git-archive
Date: Wed,  2 May 2012 20:25:12 +0700
Message-ID: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:29:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZc4-0000S2-N5
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab2EBN24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:28:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab2EBN2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:28:55 -0400
Received: by pbbrp8 with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=IflvQGUYYFt/s8x0YUjLIdKyu/6t6bbfrs1VgQ6U5oE=;
        b=ReEdvh/Yr/C2eX/uCo1z5AT7D/654TqLYJGWJP/PrnwlVpPkYLFC3xZ8lHSIGtaRQ9
         cdmv/BT6dAC+qbhrnoxU5AWLJBMCClmHhcN8QgJhumudoZkdfPSnUVOPzSF+YN8jjGoo
         F8B5A/TM+fzNf9hvy5aB3WA19vOglStnmHNhsYXyIADsgbdKVZRlZr6xJrUf+srmbYHJ
         o7rt33cQVM/cMRwApWq6JXMjLIHAkMYleP9k/RglnG0fW+ajRb9ERU8ikAAEOMhT9XkP
         YQJZr4e6o0ATWx3GIo4OUQxntPCagxBYcKFdT0z5cC0e0dXW3xH9jcXBXJiTckWTCmbL
         5aGg==
Received: by 10.68.202.167 with SMTP id kj7mr147855pbc.9.1335965334718;
        Wed, 02 May 2012 06:28:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id vq9sm1993888pbc.18.2012.05.02.06.28.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:28:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:25:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196803>

v2 incorporates Ren=C3=A9's zip streaming support, fixes broken tar out=
put
on large files and adds more tests for verification.

v1 is at http://thread.gmane.org/gmane.comp.version-control.git/196535

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  archive-tar: turn write_tar_entry into blob-writing only
  archive-tar: unindent write_tar_entry by one level
  archive: delegate blob reading to backend
  archive-tar: allow to accumulate writes before writing 512-byte block=
s
  archive-tar: stream large blobs to tar file

Ren=C3=A9 Scharfe (5):
  streaming: void pointer instead of char pointer
  archive-zip: remove uncompressed_size
  archive-zip: factor out helpers for writing sizes and CRC
  archive-zip: streaming for stored files
  archive-zip: streaming for deflated files

 archive-tar.c       |  201 +++++++++++++++++++++++++++++++++++--------=
--------
 archive-zip.c       |  200 +++++++++++++++++++++++++++++++++++++++++++=
++------
 archive.c           |   28 +++-----
 archive.h           |   10 +++-
 streaming.c         |    2 +-
 streaming.h         |    2 +-
 t/t1050-large.sh    |   12 +++
 t/t5000-tar-tree.sh |   22 ++++++
 8 files changed, 372 insertions(+), 105 deletions(-)

--=20
1.7.8.36.g69ee2

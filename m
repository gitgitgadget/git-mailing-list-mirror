From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/9] Large file support for git-archive
Date: Thu,  3 May 2012 08:50:59 +0700
Message-ID: <1336009868-7411-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 03:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPlDz-0007AG-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 03:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab2ECBwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 21:52:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55696 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2ECBwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 21:52:17 -0400
Received: by pbbrp8 with SMTP id rp8so1813971pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=34bP9nQXnOsFoAQeKFTghg4dNEDyLMuAeMKc1/swj5Q=;
        b=s0OB37UHu4OzPgOpI1Sj4rzzPayoie7WBcDz2GXdvruM04NjZHhelRnQQUX6gaG7+9
         bLTJx1DSB6kzNAAaX7rhFLR+E5TizDsvtpvNy6I5mDJJ/3A6CXZu4dyoUHvmbK8O7ioo
         nfr25JpQSTDFhwPu+0BaLMxiUJcoJ4OvLwEdD8iQwbYTTd+Puv372Zijs2OVofCFvePp
         2KKalvTe1zWvuu7upwn9wxfpWs1DjGbFApDoCWfFXhHiQADQqE2a3plL5mfZMn0xuXtK
         z+8FI5Lz1IbXyMVTtxKzw+/+t0THhzVMDOLUKQuNMVmW5zuQdBJ92fx2jdAzbeOB4S2k
         E2og==
Received: by 10.68.194.227 with SMTP id hz3mr2723643pbc.23.1336009937339;
        Wed, 02 May 2012 18:52:17 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id hp1sm3615488pbc.67.2012.05.02.18.52.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 18:52:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 03 May 2012 08:51:20 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196874>

Compared to v2 [1], this series reworks the large file support patch
for tar and makes use of test_config.

[1] http://thread.gmane.org/gmane.comp.version-control.git/196803

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  archive-tar: turn write_tar_entry into blob-writing only
  archive-tar: unindent write_tar_entry by one level
  archive: delegate blob reading to backend
  archive-tar: stream large blobs to tar file

Ren=C3=A9 Scharfe (5):
  streaming: void pointer instead of char pointer
  archive-zip: remove uncompressed_size
  archive-zip: factor out helpers for writing sizes and CRC
  archive-zip: streaming for stored files
  archive-zip: streaming for deflated files

 archive-tar.c       |  207 +++++++++++++++++++++++++++++++++++--------=
-------
 archive-zip.c       |  200 +++++++++++++++++++++++++++++++++++++++++++=
------
 archive.c           |   28 +++----
 archive.h           |   10 ++-
 streaming.c         |    2 +-
 streaming.h         |    2 +-
 t/t1050-large.sh    |   12 +++
 t/t5000-tar-tree.sh |   19 +++++
 8 files changed, 375 insertions(+), 105 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty

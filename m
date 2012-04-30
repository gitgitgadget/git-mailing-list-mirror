From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Large file support for git-archive
Date: Mon, 30 Apr 2012 11:57:12 +0700
Message-ID: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 07:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOijE-0008M0-92
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 07:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab2D3FAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 01:00:48 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33712 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2D3FAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 01:00:47 -0400
Received: by dadz8 with SMTP id z8so3584710dad.10
        for <git@vger.kernel.org>; Sun, 29 Apr 2012 22:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Bye6CUydvUVWTufLi7i6oRDzSdByA/S/ymphhBeOxPA=;
        b=byffB3A7/5RPV7owtLhL3P3wB81oEmxSq+W/8kzSm+XDeOTSvMPvG5/qDqMezwREXt
         5gWhcfMUgA8LCkNAHlKonie6I5V3HG4S3imxXke1Tu5cMrgyHN8v8cYdtoRf68Dx17Vv
         GOh7oh5viiqazCxEbdEM9ozMYiR1i/MNoN6LTgl3os3uFBEET8BbXOJe6UfGz8U9SCYc
         eM+Gxb7//zNWvXP4QsMnCD8H/WzpnN8BcUnIw3nGNOxSzg/zyN0Uw+gQhGRsx/CzT/NG
         0sYvZoDkIPVKsRnJjQR2xWb+fLliKAmlz0H/Ae9Uw8zAN9zdfVHQWkhK4HW44KJK3T70
         Otpw==
Received: by 10.68.229.37 with SMTP id sn5mr9111682pbc.29.1335762046757;
        Sun, 29 Apr 2012 22:00:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id k9sm14872568pbf.65.2012.04.29.22.00.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Apr 2012 22:00:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 30 Apr 2012 11:57:21 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196535>

This is a spin-off from the large file support series I posted some
time ago [1]. Both tar and zip format now support streaming large
blobs. Although zip will store uncompressed large blobs.

[1] http://thread.gmane.org/gmane.comp.version-control.git/191605

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  archive-tar: turn write_tar_entry into blob-writing only
  archive-tar: unindent write_tar_entry by one level
  archive: delegate blob reading to backend
  archive-tar: stream large blobs to tar file
  archive-zip: stream large blobs into zip file

 Documentation/git-archive.txt |    3 +
 archive-tar.c                 |  184 ++++++++++++++++++++++++++++-----=
--------
 archive-zip.c                 |   56 ++++++++++++-
 archive.c                     |   28 +++----
 archive.h                     |   10 ++-
 t/t1050-large.sh              |    8 ++
 6 files changed, 209 insertions(+), 80 deletions(-)

--=20
1.7.8.36.g69ee2

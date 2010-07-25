From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 4/7] Makefile: Add coverage-report-cover-db target
Date: Sun, 25 Jul 2010 19:52:42 +0000
Message-ID: <1280087565-24671-5-git-send-email-avarab@gmail.com>
References: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 21:53:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7GQ-00040o-TR
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab0GYTxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:19 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49624 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab0GYTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:09 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so646045ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ML0lfKjmovdFkngz/WU/i1D27mV7uqaJa3/dghkUtdg=;
        b=SvNZKOYFFpINOwcfU/Uk+tZvYFUfPdoE3/IP+wwYHDKUmozyMOvqzogjQJRsnwtfEE
         vPFQF/4idNJj/5uI5vhKnU2bY+YruwRNN4RI9tN5oM0SzZqhV5YJK/zaBBi7ESXYJuOh
         OscvDxabh+WOFpzB6h4wwlLqbqF0AMwZ9SQmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h6DdzwMb9oy7IwMj1M0mTfRtNHAYqau36ntg7bD+dl3FtPoex+HhqPxHAEZsY4LhDr
         R73qLexZuKPUEHFmmt6hrT3GpqhlaymCJC1ZLzYxzOtBJRne7+HUdd7BbxpjJEXOXSVT
         omziQirOCR9sGNdwLtxECI8PvxEVGclQ+9yvk=
Received: by 10.213.25.130 with SMTP id z2mr5629681ebb.12.1280087588695;
        Sun, 25 Jul 2010 12:53:08 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151784>

Add a target to convert the *.gcov files to a Devel::Cover
database. That database can subsequently be formatted by the cover(1)
tool which is included with Devel::Cover.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 Makefile   |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 57f79ef..d8bd555 100644
--- a/.gitignore
+++ b/.gitignore
@@ -185,6 +185,7 @@
 *.gcno
 *.gcov
 /coverage-untested-functions
+/cover_db/
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index 40453f1..1d721ef 100644
--- a/Makefile
+++ b/Makefile
@@ -2287,6 +2287,7 @@ coverage-clean:
 	$(RM) $(addsuffix *.gcda,$(object_dirs))
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
 	$(RM) coverage-untested-functions
+	$(RM) -r cover_db/
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
@@ -2306,3 +2307,6 @@ coverage-untested-functions: coverage-report
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		> coverage-untested-functions
+
+cover_db: coverage-report
+	gcov2perl -db cover_db *.gcov
--=20
1.7.0.4

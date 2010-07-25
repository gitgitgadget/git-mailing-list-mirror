From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 5/7] Makefile: Add coverage-report-cover-db-html target
Date: Sun, 25 Jul 2010 19:52:43 +0000
Message-ID: <1280087565-24671-6-git-send-email-avarab@gmail.com>
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
	id 1Od7GP-00040o-UB
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777Ab0GYTxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49624 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab0GYTxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:11 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so646045ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XOEDYGxdoCeKuwa+RKhoJgyjmaZ+VN0CK0U0cxJV2M4=;
        b=ZXDCh4lYtpQ2pFF7X7yY7TpavO0FElxIXozRrTXMi945JgDRT6TEjPGYuJsqZ89y9v
         2s4tcSR8JyWMkZhkwkdXHo21uJWCdDuxXwR3e9wZtMAogXCQ1g/GY5WW+Lm1ZVvSdNiX
         vqic8cfJhGlUvuvRgGSpizsWM4G+9gj75oKgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WgyAVW9zv6lwXGj7MmzV5+8XggLvCbydSg4w2GlZSE+p64IX++V6IZA++8ktHUPjF5
         chSpOeX0fc5R+bus6iGM1nkzYsHpA+Man4aVcGZVip+PkA3H+qSrNiAgXPgaKgaOHsng
         iBRWfUVcLuxp9PywI29JASr/tQiX3Hr0f+TBU=
Received: by 10.213.6.193 with SMTP id a1mr5603149eba.18.1280087590481;
        Sun, 25 Jul 2010 12:53:10 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151786>

Add a target to generate a detailed HTML report for the entire Git
codebase using Devel::Cover's cover(1) tool. Output it in
cover_db_html instead of the default cover_db, so that it isn't mixed
up with our raw report files.

The target depends on the coverage-report-cover-db target, it may be
run redundantly if it was previously run. But the HTML output won't be
affected by running gcov2perl twice, so I didn't try to avoid that
small redundancy.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 Makefile   |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index d8bd555..0a30a7e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -186,6 +186,7 @@
 *.gcov
 /coverage-untested-functions
 /cover_db/
+/cover_db_html/
 *+
 /config.mak
 /autom4te.cache
diff --git a/Makefile b/Makefile
index 1d721ef..fdfa4fe 100644
--- a/Makefile
+++ b/Makefile
@@ -2288,6 +2288,7 @@ coverage-clean:
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
+	$(RM) -r cover_db_html/
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
@@ -2310,3 +2311,6 @@ coverage-untested-functions: coverage-report
=20
 cover_db: coverage-report
 	gcov2perl -db cover_db *.gcov
+
+cover_db_html: cover_db
+	cover -report html -outputdir cover_db_html cover_db
--=20
1.7.0.4

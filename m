From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 2/7] Makefile: Include subdirectories in "make cover" reports
Date: Sun, 25 Jul 2010 19:52:40 +0000
Message-ID: <1280087565-24671-3-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jul 25 21:53:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7GQ-00040o-Df
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0GYTxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:53:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45797 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab0GYTxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:53:04 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so351985eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iyvzm82WO6UEX6s/FCKnQpIrUroMUVfBvCPsfCOXOvU=;
        b=Qj5PZPqSmHbg2nmgyteTqy0cei/j1Hzz0vnLoEekTrh6oVHYw/6YkxFz61/uCd6Zk7
         ds/9+PvgKfzatI+vhilc51rHgXXKDmc6VQBqMiN+MKWrAo4JOi9zMeUHQtWUx2dNhzhi
         p8INMFelytqaViN6Hb8y4oFdbPVVIwR/vFFyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iF5YusEo+g4xyyXX0WdYx4zDoPiDm/55ADNljT7QhPmsx0z+cB4B7036ODCA67hFBv
         eRyRLKlfgG7oja+lVEfqsWc21mSXPWK+dBK6e8XYrwdcABQL3BbF9dc25K6LT3wwJhWI
         XMzzDHCy9t397v/IgtQt71qQVftv2k43ewlYA=
Received: by 10.213.19.6 with SMTP id y6mr5771708eba.7.1280087584101;
        Sun, 25 Jul 2010 12:53:04 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151783>

We generate profiling files in all the $(OBJECTS) dirs. Aggregate
results from there, and add them to the corresponding clean target.

Also expand the gcov arguments. Generate reports for things like "x()
|| y()" using --all-blocks, and add --preserve-paths since we're
profiling in subdirectories now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index bc3c570..b791ad5 100644
--- a/Makefile
+++ b/Makefile
@@ -1485,6 +1485,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_GCOV     =3D @echo '   ' GCOV $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -2280,11 +2281,16 @@ coverage:
 	$(MAKE) coverage-build
 	$(MAKE) coverage-report
=20
+object_dirs :=3D $(sort $(dir $(OBJECTS)))
 coverage-clean:
-	rm -f *.gcda *.gcno
+	$(RM) $(addsuffix *.gcov,$(object_dirs))
+	$(RM) $(addsuffix *.gcda,$(object_dirs))
+	$(RM) $(addsuffix *.gcno,$(object_dirs))
+	$(RM) coverage-untested-functions
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
+GCOVFLAGS =3D --preserve-paths --branch-probabilities --all-blocks
=20
 coverage-build: coverage-clean
 	$(MAKE) CFLAGS=3D"$(COVERAGE_CFLAGS)" LDFLAGS=3D"$(COVERAGE_LDFLAGS)"=
 all
@@ -2292,7 +2298,9 @@ coverage-build: coverage-clean
 		-j1 test
=20
 coverage-report:
-	gcov -b *.c
+	$(QUIET_GCOV)for dir in $(object_dirs); do \
+		gcov $(GCOVFLAGS) --object-directory=3D$$dir $$dir*.c || exit; \
+	done
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
-		| tee coverage-untested-functions
+		> coverage-untested-functions
--=20
1.7.0.4

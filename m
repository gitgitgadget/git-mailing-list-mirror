From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 2/7] Makefile: Include subdirectories in "make cover" reports
Date: Sun, 25 Jul 2010 14:40:56 +0000
Message-ID: <1280068861-17701-3-git-send-email-avarab@gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OV-0001DE-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab0GYOlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0GYOlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:16 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so602412ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WevETP3spSQ9vlMiRRhtmwCqlxMuasDP2+ybPdp4dAo=;
        b=IK0DUtgm3Z++y1pKMjsKTA7ohj0jRlZ9g/LQuzUGQu/O8putNwmSpysSrm88UaiSYG
         VYwSlxN8/F2MHyrpfj3jHrILyxJz+jeY0ssBFi5LcCrQhbulhluLmXTcsqG/YOVuNERV
         +QEFvaWi2yEAsmRR4Jf4lOrjekcJ3wUeb84NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ONVVVe3yzY2KD5AXg6lNwYMyyQ9bhagDarXbkXOrrJA8ErxVT3+EOf8+sBSbZv9VvS
         K7SPd0MNprKFYZWvMtYcbKbyfgsGZ5rEUuQfxovJ+Jsivo+FiSSpIHthJc84CCs+MCxK
         xGdbPPSKOy2mnJZxzdbzo+01NekDlDhYCAGIY=
Received: by 10.213.30.15 with SMTP id s15mr5301160ebc.48.1280068875995;
        Sun, 25 Jul 2010 07:41:15 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151746>

We generate profiling files in all the $(OBJECTS) dirs. Aggregate
results from there, and add them to the corresponding clean target.

Also expand the gcov arguments. Generate reports for things like "x()
|| y()" using --all-blocks, and add --preserve-paths since we're
profiling in subdirectories now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bc3c570..a95d260 100644
--- a/Makefile
+++ b/Makefile
@@ -2280,8 +2280,11 @@ coverage:
 	$(MAKE) coverage-build
 	$(MAKE) coverage-report
=20
+object_dirs :=3D $(sort $(dir $(OBJECTS)))
 coverage-clean:
-	rm -f *.gcda *.gcno
+	$(RM) $(addsuffix *.gcov,$(object_dirs))
+	$(RM) $(addsuffix *.gcda,$(object_dirs))
+	$(RM) $(addsuffix *.gcno,$(object_dirs))
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
@@ -2292,7 +2295,9 @@ coverage-build: coverage-clean
 		-j1 test
=20
 coverage-report:
-	gcov -b *.c
+	for dir in $(object_dirs); do \
+		gcov --preserve-paths --branch-probabilities --all-blocks --object-d=
irectory=3D$$dir $$dir*.c; \
+	done
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
--=20
1.7.0.4

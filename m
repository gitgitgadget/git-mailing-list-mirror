From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/6] Makefile: Include subdirectories in "make cover" reports
Date: Sat, 24 Jul 2010 20:50:59 +0000
Message-ID: <1280004663-4887-3-git-send-email-avarab@gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:51:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OclhK-0007bl-Dv
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab0GXUvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:51:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63711 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab0GXUvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:51:44 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so496366ewy.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uRMH9/hfO+KaHlh3gTBjEGWmzUbYsjvVwAbSM1QoYwQ=;
        b=TvTkCEnXW8vxN1b/lN3pUgsqnEty52mEmOKE8lMMMIeg39Ycu1M6gloVjvRr/HRp2a
         TR3gh9iNs/nnodAOJBk2pQ5PU9ILRRVOeHee2EBkHckEyV+WwQt8izojnqZavy/jJnD8
         OsBzZvVx/YBCVdB1yHRfnPb68HnuNKkJoPgyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ap8Ovu42EWw05tZPjEm3IXuwdTt2fAa+JsC7qk14aVY55QHJ8r6E++V89T2zB63R9k
         /6ag7fHnkxn1RqPOG3ekto4WgIUV+d0iXjZiKADVnYKwWbFSOqRgrGtLShcGCqPa/ZKQ
         /E3IL7nV4vEJbfRWD++ekwG1yFAW+8p6pmXP4=
Received: by 10.213.19.6 with SMTP id y6mr1977534eba.96.1280004704222;
        Sat, 24 Jul 2010 13:51:44 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm2701243eei.6.2010.07.24.13.51.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:51:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151670>

The buildin/, xdiff/ and compat/ subdirectories weren't being included
in the gcov aggregation, nor were the files there being cleaned up.

Changed rm -f to the $(RM) variable while I was at it.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index bc3c570..63f3f84 100644
--- a/Makefile
+++ b/Makefile
@@ -2281,7 +2281,10 @@ coverage:
 	$(MAKE) coverage-report
=20
 coverage-clean:
-	rm -f *.gcda *.gcno
+	$(RM) *.gcov *.gcda *.gcno
+	$(RM) builtin/*.gcov
+	$(RM) builtin/*.gcda
+	$(RM) builtin/*.gcno
=20
 COVERAGE_CFLAGS =3D $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS =3D $(CFLAGS)  -O0 -lgcov
@@ -2293,6 +2296,9 @@ coverage-build: coverage-clean
=20
 coverage-report:
 	gcov -b *.c
+	gcov -b -o builtin builtin/*.c
+	gcov -b -o xdiff xdiff/*.c
+	gcov -b -o compat compat/*.c
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
--=20
1.7.0.4

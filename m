From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/6] Makefile: Add coverage-report-cover-db-html target
Date: Sat, 24 Jul 2010 20:51:02 +0000
Message-ID: <1280004663-4887-6-git-send-email-avarab@gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OclhW-0007iw-Ir
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab0GXUwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:52:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63711 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0GXUwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:52:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so496366ewy.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HJBko7zEFD69fgoL3F4Y7MrVPiePVczXLA6VQoEqoNo=;
        b=r5qHy+eGYcBDjA3TZM10QiZFT/FNK8VLjAYYWmuJVE01fW4tzBJ5NRi2W+gXr2Gq7y
         RrFu0/PYb/YRGmkc8HiUUlWDXnlSdJVsTdomQhb/W8Xo/74T0RVGDBtb1KV3N//8fj5r
         2RdYsGs3+HA5NZCY9aVSvNyNwct82rFhA9dbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dDP/fj29OBK0LmuzY49oCRAa4KIvoYlWKvtVrgMUREI1jNeOTzBawfvpi6Zh87oJtj
         83W2GeBzdh6uwFdUqyageRsAN9FJNAPpOGJjgtMeFrzYwHb7H+6J6RAHqFOthwlQUwNf
         w/4E1CatMU8gxlb+p+8iqyvXZMId7l0Xqs0Uk=
Received: by 10.213.114.67 with SMTP id d3mr4493664ebq.73.1280004719884;
        Sat, 24 Jul 2010 13:51:59 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm2701243eei.6.2010.07.24.13.51.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:51:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151674>

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
 Makefile   |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5e24b0b..e02f1f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -218,3 +218,4 @@
 /compat/*.gcov
 /coverage-untested-functions
 /cover_db
+/cover_db_html
diff --git a/Makefile b/Makefile
index b15c894..c35c348 100644
--- a/Makefile
+++ b/Makefile
@@ -2307,3 +2307,6 @@ coverage-report-untested-functions:
=20
 coverage-report-cover-db:
 	gcov2perl -db cover_db *.gcov
+
+coverage-report-cover-db-html: coverage-report-cover-db
+	cover -report html -outputdir cover_db_html cover_db
--=20
1.7.0.4

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/6] Makefile: Add coverage-report-cover-db target
Date: Sat, 24 Jul 2010 20:51:01 +0000
Message-ID: <1280004663-4887-5-git-send-email-avarab@gmail.com>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:52:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OclhW-0007iw-33
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab0GXUv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 16:51:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42551 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0GXUv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:51:57 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so268827eya.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gLh7qCbmCgPjjkxkfuKe5rQCCv+4j/y0SV4OA8avFRc=;
        b=luiJNrN3ilHXERbW577gWpTIqQ7A+hVVwpL8qLJxM74Hf1dT5ev5i0O0lH0a9OM9vm
         TjvKPrfvqnW9aOBfG2OP/HzxPyFrdG59HsuQyQmEYHYLrFpu9Vq4R73Hodj3dc3BnVeF
         bFPYBLkYv6LhsPf1zi2frLpJEYQ1TlYnPWFhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=a1OLD4F5oshgdzwzVaJf2/On7GpzYD6hH4GlEvzTIZf+SqZbMN/HeRYewGJWf6HaD0
         SfWIiprEuP+nRQ3qtfzXKhuSbHd1Dd7ej+ECjC90aB3wII8dXLn962uFbrtGX10x+r5d
         vMSKZsZzc1yDa2DIU48C0hNIDZVdBZIdowhOI=
Received: by 10.213.30.15 with SMTP id s15mr1983757ebc.56.1280004716950;
        Sat, 24 Jul 2010 13:51:56 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm2701243eei.6.2010.07.24.13.51.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:51:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280004663-4887-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151673>

Add a target to convert the *.gcov files to a Devel::Cover
database. That database can subsequently be formatted by the cover(1)
tool which is included with Devel::Cover.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 Makefile   |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index f836a45..5e24b0b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -217,3 +217,4 @@
 /compat/*.gcno
 /compat/*.gcov
 /coverage-untested-functions
+/cover_db
diff --git a/Makefile b/Makefile
index 5e9a6a2..b15c894 100644
--- a/Makefile
+++ b/Makefile
@@ -2304,3 +2304,6 @@ coverage-report-untested-functions:
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
+
+coverage-report-cover-db:
+	gcov2perl -db cover_db *.gcov
--=20
1.7.0.4

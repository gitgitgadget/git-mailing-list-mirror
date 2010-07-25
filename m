From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/7] Makefile: Add coverage-report-cover-db target
Date: Sun, 25 Jul 2010 14:40:58 +0000
Message-ID: <1280068861-17701-5-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OW-0001DE-V5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0GYOlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0GYOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:21 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so602412ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lgwvVSz+8YqeQw3x2RIKYMx+X1axnoJTC3BI1oN9Wc4=;
        b=ZL93I74IeLgZb3JmAlU2hoCxrSkNI1OqCDCzFP9AwxxjSeHZzdtrvdw1LfoV7G1lHY
         vnqdP7BvsU2FZQyVIUyJDy0lZWa9jWAkzww2nlQSreSppVFkJF0hSkaS50V+tJluPbqr
         ZV49kfzWpR2Vi/gEd6hpiczIS+/D724uSJdKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uAnDbCsrvjjz4bpikzpjYK5cpH9SB4WXqR/uh0O7HZSmebjqg9BPLVZmn91fB2RQrL
         tfX3OO/iLs8jMOOl6kNpLbNTHSMVUAwPwW7YOn18+yPtXB4UErUSDgTamiRaZcFnnvJ3
         xxLhw9o2Y64XXmrwJOg88O1Fvrtw/5pf0BOKY=
Received: by 10.213.16.197 with SMTP id p5mr5344391eba.65.1280068880723;
        Sun, 25 Jul 2010 07:41:20 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151748>

Add a target to convert the *.gcov files to a Devel::Cover
database. That database can subsequently be formatted by the cover(1)
tool, which is included with Devel::Cover.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore |    1 +
 Makefile   |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0e61845..bd53c02 100644
--- a/.gitignore
+++ b/.gitignore
@@ -208,3 +208,4 @@
 *.gcno
 *.gcov
 /coverage-untested-functions
+/cover_db
diff --git a/Makefile b/Makefile
index e9f8ef8..f2c680d 100644
--- a/Makefile
+++ b/Makefile
@@ -2303,3 +2303,7 @@ coverage-untested-functions: coverage-report
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
+
+coverage-report-cover-db: coverage-report
+	gcov2perl -db cover_db *.gcov
+
--=20
1.7.0.4

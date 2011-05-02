From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Mon,  2 May 2011 19:55:23 +0700
Message-ID: <1304340923-15927-1-git-send-email-pclouds@gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 14:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGshm-0003Zc-Mq
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 14:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab1EBM6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 08:58:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44216 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab1EBM6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 08:58:19 -0400
Received: by pvg12 with SMTP id 12so3162407pvg.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=X0NBuTMKsMhmhvfkULzRJ1OC9prOvkwsAgHtoXfQQio=;
        b=IKCKoFqQbu9b0bDzGIVRZL/RVQIJXE3jih6RsukJ0rZ2i/uJumJ6WGk5XI7r++hz/5
         lxwKeR6PYuCPfcgk2QpKKUlwRPqeFvhMNtjxFRjRiPSOT9x8ttUBJ9yAJx82/RkYHY6d
         1DcNRJtH9y5GXXWJL/CvbuY20fpT5cMGNGSkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WDyle3tkpIcOClqVFqXWFRWqUywdx8i6+1+oRT5ipBOoKogeSxfQeIdDo9l9m/8x/I
         Rf9jX4BRj91yF4CHnCS+Khc/H2B5U5j1j36vx/KcGKR3Nb3TzoZNLTIw9kKm5nmrmCH/
         VGKnkrWJxHnpSB5LnMQ5NvbCQjMFmN3V7mL4s=
Received: by 10.68.54.135 with SMTP id j7mr8797830pbp.390.1304341098952;
        Mon, 02 May 2011 05:58:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id w2sm3809190pbh.14.2011.05.02.05.58.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 05:58:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 02 May 2011 19:55:25 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172582>

=2Egitignore support both positive and negative patterns. One may negat=
e
the other. Current code works well if both patterns target files in
the same directory.

When a pattern targets a directory and an opposite pattern targets
some files/directories within that directory, we need to descend in
the directory until we're clear which ones are matched and which are
not.

excluded_from_list() fails to handle this case. It too eagerly decides
the fate of the whole directory without looking further in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Sorry, forgot the test name.

 t/t3700-add.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7de42fa..c9f3a28 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -295,4 +295,20 @@ test_expect_success C_LOCALE_OUTPUT 'git add --dry=
-run --ignore-missing of non-e
 	test_cmp expect.err actual.err
 '
=20
+cat >expected <<EOF
+add 'test/.gitignore'
+add 'test/out/in'
+EOF
+
+test_expect_failure C_LOCALE_OUTPUT 'positive/negative patterns at dif=
ferent dir levels' '
+	mkdir -p test/out &&
+	touch test/out/in test/out/out &&
+	cat >test/.gitignore <<EOF &&
+out
+!out/in
+EOF
+	git add --dry-run test >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.4.74.g639db

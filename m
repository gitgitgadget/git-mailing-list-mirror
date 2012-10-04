From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/6] t3001: note about expected "**" behavior
Date: Thu,  4 Oct 2012 14:39:52 +0700
Message-ID: <1349336392-1772-7-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
 <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUL-0001w8-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157Ab2JDHkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:53 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45932 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab2JDHkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:52 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so327784pbb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qfzJCxlIIz5SVPgVlBwJU/dC5RWjEpBjEejeiNwdBU4=;
        b=KlR/u07gRRv3QXMpG11KdO4EYokfksAOZvCZzAKWV4aWIiak9RLZBX+JGbXlku1Pq7
         TCsY2YafzWu2R29WvxxtQ2adbetAih7PyTVHeHbWp5ZnFJulVlGPGH4i/cfl8icfuVqo
         c+F0opuiz4OWvOoZKEXNT8dTrud9mYUe51EOV+9/DCO8Ht+EkHbaA/91cUTkWqKIMx4d
         6y7VsvImOAkVWkXw2UWMMeb85VzqiJq/BxKsQtQYgbWdT+xoq173e4XLS6n63w1oO1ro
         jSlP0yhUrtPG9IXzDGQVg9IMFdFK6+1ScT/UDvb1YfXwfdc988zICCqUNElotqDsEz8r
         etEg==
Received: by 10.66.83.8 with SMTP id m8mr11222294pay.48.1349336452322;
        Thu, 04 Oct 2012 00:40:52 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id g1sm3840105paz.18.2012.10.04.00.40.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:40:40 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206990>

"**" currently matches any characters including slashes. It's probably
too powerful. A more sensible definition may be match any characters
that the but the whole match must be wrapped by slashes. So "**" can
match none, "/", "/aaa/", "/aa/bb/" and so on but not "aa/bb".

Note it in the test suite.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3001-ls-files-others-exclude.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-othe=
rs-exclude.sh
index 6a5a4ab..99b5f5c 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -235,4 +235,12 @@ EOF
 	test_cmp expect actual
 '
=20
+# We might want ** to match at directory boundary, e.g. a**b matches
+# a/b, a/x/b, a/x/x/b... but not ax/xb.
+test_expect_failure 'ls-files with "**" patterns and no slashes' '
+	: >expect &&
+	git ls-files -o -i --exclude "o**a.1" >actual
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.12.1.405.gb727dc9

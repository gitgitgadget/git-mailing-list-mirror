From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 2/3] t4124: Add additional tests of --whitespace=fix
Date: Wed, 17 Feb 2010 08:03:26 +0100
Message-ID: <4B7B94BE.60502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 08:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhdwc-0006sq-Gc
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 08:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849Ab0BQHD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 02:03:29 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:46844 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933771Ab0BQHD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 02:03:28 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2494610ewy.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 23:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=2QgEkL4pRwUb6SzAGYKuq9qpfi0uErrABrKXvNUm2U8=;
        b=lpTM4IhqXV6hXdpSHNKr3hMYtRH7RudT/AMIJPJ3EEs2qhzpMQuH0E45qFqUof9itw
         UM0gMKFqDsDQnJAxP2hO6I8WX1Fpq2ccSvWTDfDTrmiMssUGWHD96/qfUz46czFniVOm
         870ntVuABcgKKk1NCA3ycoEc8qVMNKj00lqlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=asQqUACI+ypuCmnCOt8PL4eS1+4PCEi096E5yr90tRCL4TxXQXfb3Il8BddNc/OcZU
         HeWjjtJCT6yQrWMLmlhfkk9mvdL2Ri5WHVhvV+qhqtRSxMrUllOLWj+Jrxu9zN8DZfYx
         CdXuIkTxxY4qsDpIAwA14zrPpX/PIcXUhnG4o=
Received: by 10.213.0.148 with SMTP id 20mr4818305ebb.51.1266390207717;
        Tue, 16 Feb 2010 23:03:27 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm2025324eyd.37.2010.02.16.23.03.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 23:03:27 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140209>

"git apply --whitespace=3Dfix" must not succeed unless at least
one context line falls within the boundaries of the file.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 t/t4124-apply-ws-rule.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ca26397..3b539d8 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -261,4 +261,16 @@ test_expect_success 'blank but not empty at EOF' '
 	grep "new blank line at EOF" error
 '
=20
+test_expect_success 'tons of blanks at EOF should not apply' '
+	for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
+		echo; echo; echo; echo;
+	done >one &&
+	git add one &&
+	echo a >>one &&
+	git diff -- one >patch &&
+
+	>one &&
+	test_must_fail git apply --whitespace=3Dfix patch
+'
+
 test_done
--=20
1.7.0

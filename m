From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 2/3] t5551: make the test for extra HTTP headers more
 robust
Date: Tue, 10 May 2016 09:08:38 +0200 (CEST)
Message-ID: <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de> <cover.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:08:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01mq-0004Ll-IE
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbcEJHIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:08:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:63567 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbcEJHIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:08:46 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ltqb7-1biotf40rl-011EWO; Tue, 10 May 2016 09:08:39
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462863934.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:EhK0B7NfW1hPqq4D3Yhyh5x465n11ZkeOoIlWStetS8EOvWpUJq
 OCJviPKuIk71RfTD2tbQcyy51O4uI1UF3BfqhlZdY6M5uw+TwZD+lkflh4Vri38ZZAQbuJm
 A0U2ZjmKL9bNONJtib90VxwqEcxP/rVzZlPLO2xPQPSfYqtwe3wQFPRkLfdWlAtXh908ZBi
 9CU/CAW/hNy1V9t4EdBLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5vKyDGj/LHY=:TgXgsEQ5JKpnAINaIF4WUd
 8AW8HTKnd4h1A0SKOa5Y8BxEk+fkEc7z0AHqpQIS60p+3BM9DMQY7AhqSC8LCMdeF20cxE1MS
 4JjOsI7QrpDzPZ+HxudnXuOlG9WZtuwGYWXK1aq63Noj+jf1Yj1ccti1EBrfB4Jgq2qkcsVu5
 2xniXP8yCSm9h3iIXrNtDmwyLujCyHeciudGSyTYN14p0/zg5GXaBioAEl7B1KzZb/4m02n9S
 9MrlaNMy8WQga0PXFigYu9uMc3v7OQWWINM4u9kKILVzDCsk5PtSlVFX9OG8/uIc6uHkmgxit
 3RZZPGWxeqTRlhduTr0rkDMRKqei2xjqnBeCAJ1OZH/K4PUjnTGHQmZER9hYwwmOJsIVchPiK
 0keHIWpvoQ0Pvw99E8d8Wkr3FQf6eredcRKTZABPFf1oYtMrw9rU3F5bOBOL2h+EvkrSB6MZf
 KJ6yxfzvpjcKl49RBKbc8AbgbCwmvsbXQcayXFCaFoItgqN1SWI/8zwGLu1ArIpFv1I8hgupj
 6/d18lyycTVD780bkz8n41GiS+MQlI4r40KUPn+HTJInNZhD0GOzIYvqe566B9YXlKt1lkar4
 KHZdWhewEYUEN0jYus7fyaZBkDcn+FYEA6Js8GxLY2AfV95kQcA+aaoYxmpFHSDbVrpGXizDT
 9ZqlK2qwTSKG3e+o1DVbQw7B6epFVyD4jFaWoJU/gPuMAJazncWaWT6ob9kYu4jU/OayErngI
 orDVvJm7XY4DOiPoLA0hLwIkdKebobfBaB6VLLrc+M0GAfZ/JnDt0694ULQfNNjcRy+z63lI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294106>

To test that extra HTTP headers are passed correctly, t5551 verifies that
a fetch succeeds when two required headers are passed, and that the fetch
does not succeed when those headers are not passed.

However, this test would also succeed if the configuration required only
one header. As Apache's configuration is notoriously tricky (this
developer frequently requires StackOverflow's help to understand Apache's
documentation), especially when still supporting the 2.2 line, let's just
really make sure that the test verifies what we want it to verify.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5551-http-fetch-smart.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e44fe72..43b257e 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -283,7 +283,8 @@ test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 '
 
 test_expect_success 'custom http headers' '
-	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
+		fetch "$HTTPD_URL/smart_headers/repo.git" &&
 	git -c http.extraheader="x-magic-one: abra" \
 	    -c http.extraheader="x-magic-two: cadabra" \
 	    fetch "$HTTPD_URL/smart_headers/repo.git"
-- 
2.8.2.463.g99156ee

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 3/3] submodule: ensure that -c http.extraheader is
 heeded
Date: Tue, 10 May 2016 09:08:56 +0200 (CEST)
Message-ID: <1b3d7bde2b92da7722ae46a2f76ccedf532ce35e.1462863934.git.johannes.schindelin@gmx.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de> <cover.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:09:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01n2-0004aD-7b
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcEJHJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:09:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:54830 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbcEJHJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:09:02 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LjZhg-1bbHPc085o-00bZ2w; Tue, 10 May 2016 09:08:56
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462863934.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:kCK1TSMvbSvfyXrFtzlJgpNa3SiwVA4AipQR/qfpMz5lUrSnM6+
 Nm/tmIThGk0ERdGqb/RavfJDPTisDHlqtnIs7qYmwkWzahnoIxisPP+JIqLq4IOLHmZl3dm
 sN6Z5kiWljRv29jS7K5g0kyxEakTuLFfi1MvEKHnIPxC3w9uVST1bK3wZGc9WUMWltt32Ur
 VIw/IrkD8mnGAxx8wdspQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l9Y4/P6olY4=:pqtkP2I0AC4WBGbkKtjWUa
 7okOM6kLItBQpJWF6f54E2ABDYexrA8oWmIHfZQIzFTKmS4LhD68oP7pt8kSK98bEkoOWudjT
 /cq4iuBcNePnLX/FrNAQBt8uzxKh9ojHSG3j159X3Ze6JKic4btn2aHz096WciRGkLGVmMfv8
 WBMqFkktllR4b6yMjk9uWh5NFzvDC6CTTUR5AsXKqJ4JNoEn0JxXqIpFxKVwPcqinNE/NHT9F
 q6qXHMYt70b6dqh8FNVH3P/GACiWXaaB4kQOMz4FPC7hHj1ZTjtM3mpsgtHMxCigbfVux6ljX
 +cjk2D9cOGt+DJmqXHCUF4Mx/NV/0FIrkpVTSZSrPSGAU013vExktE3j3KJ+jnnusPlD4Zmsi
 r8v8s4y+A2lIYs/87OKAT7AlYEB+L+9KodaPM5zPEjp3OWIgMBIrCP9iYG1vNJLaykTKnqvtD
 jINSG0Q2XxOaHRfOjNSpGRuJUqhws5gowGyn2iRUvaWHx+OpcHG1/ybjxbwxpKlLo9whxbo38
 RxYhRcEha728wYXPvfN3CCs3Olh8Lygcd8E7YcaM2jo+qFseVvKP1X3B+2UY5I59KiCP1Nur6
 xUYJ1JHUK6I5ZpTqGJe4geWj1fiVoDDp2jZRdJ5XITkRICK62B7YxfZi+F19nlZJW78IIcC16
 2AjjqoiPO6eYWGgFTDpKYkILcChpouuaT2N2lch4L54ILYKCFF+2Cqdp2ZpWvOFIwHSUahfjQ
 X1z/Sxod6kpelhZjYfOSMqD8PQ/ouraIPkqt9loO0pwD2TvIbTEvQreKelczeJ+1F3ZODXar 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294107>

To support this developer's use case of allowing build agents token-based
access to private repositories, we introduced the http.extraheader
feature, allowing extra HTTP headers to be sent along with every HTTP
request.

This patch verifies that we can configure these extra HTTP headers via the
command-line for use with `git submodule update`, too. Example: git -c
http.extraheader="Secret: Sauce" submodule update --init

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5551-http-fetch-smart.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 43b257e..2f375eb 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -287,7 +287,16 @@ test_expect_success 'custom http headers' '
 		fetch "$HTTPD_URL/smart_headers/repo.git" &&
 	git -c http.extraheader="x-magic-one: abra" \
 	    -c http.extraheader="x-magic-two: cadabra" \
-	    fetch "$HTTPD_URL/smart_headers/repo.git"
+	    fetch "$HTTPD_URL/smart_headers/repo.git" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	git config -f .gitmodules submodule.sub.path sub &&
+	git config -f .gitmodules submodule.sub.url \
+		"$HTTPD_URL/smart_headers/repo.git" &&
+	git submodule init sub &&
+	test_must_fail git submodule update sub &&
+	git -c http.extraheader="x-magic-one: abra" \
+	    -c http.extraheader="x-magic-two: cadabra" \
+		submodule update sub
 '
 
 stop_httpd
-- 
2.8.2.463.g99156ee

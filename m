Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232E9207F8
	for <e@80x24.org>; Wed,  3 May 2017 21:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdECVuU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 17:50:20 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35649 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbdECVuT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 17:50:19 -0400
Received: by mail-wm0-f43.google.com with SMTP id w64so2118310wma.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Q7R+3KwHxmZleOKhsgLHzz22FnW1TnJTJsXPkeCoh0=;
        b=ivUQ9HzRyiUQtYC9QBSTyGI5sliEj9v4/LuD2LHqTFZaGc9b/wvllQsiQV3GxieBpD
         LmwAervZz1Xt61vyFTsaHRL5ZuEzQrBqyO/jUcgr+BnDRXwe7SNmcd3ndXOPAdO98f/a
         AIA5QI2G0dtgOBDshxBSXglSS6rCtRT/bg9663Y7aynR1fs7VyHKEZIMPVNEvzuppby3
         608577WDb/bK3cCqu4o0Kob8bFZZZLy7wNIZyTw/0GUJecj5EqTawnbhdKxWR/crbKy+
         dJhSlmoNT/EXkXIdRZ5YyxBTuGlHVIPeVMFNk8562P6wOXFZEAfVCHuOu80kQv49o7Ur
         DSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Q7R+3KwHxmZleOKhsgLHzz22FnW1TnJTJsXPkeCoh0=;
        b=qQTK5oPe0pG+D43Ok4ALGhK9RO4cj/Vx+mRqMWobZcdtvUNSJgv2jC+GpWc/J3qRvg
         z78pgM94n0xHQIQHi+kUdgd0nzx7X+P4uewkaqO2z3H7HTQyo5yIbmrOjyIqlZX8ThQ7
         erBKNFglvwjER5OvCmwUSpPPykqWEME9gRRpmlyRBBhdrO33pglIt3J7/07Rtghkiv7C
         5TqAxhpRYK9mB2qY4D6WDR/TW8hlmuI3qqZYCGid7y0PvszaaAXMq2x7I5MX4JSj1l+B
         A2pkIP5ylkv2Jf472UG3FzM6n99nVXpewzDxKfYEQUWVttv8LvoEZxM6ZU+f4OtwR5NI
         e0AQ==
X-Gm-Message-State: AODbwcANE/IwLd8McaIc5Cgs4SF4/OucdD3zgVjpZpfU2yTecMy9j2oc
        zHo3b/zwILAhxQ==
X-Received: by 10.28.86.65 with SMTP id k62mr543695wmb.78.1493848217449;
        Wed, 03 May 2017 14:50:17 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB75AC.dip0.t-ipconnect.de. [93.219.117.172])
        by smtp.gmail.com with ESMTPSA id 4sm231836wry.31.2017.05.03.14.50.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 14:50:16 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
Date:   Wed,  3 May 2017 23:50:15 +0200
Message-Id: <20170503215015.17949-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git for Windows CI web app sometimes returns HTTP errors of
"502 bad gateway" or "503 service unavailable" [1]. We also need to
check the HTTP content because the GfW web app seems to pass through
(error) results from other Azure calls with HTTP code 200.
Wait a little and retry the request if this happens.

[1] https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi Junio,

I can't really test this as my TravisCI account does not have the
extended timeout and I am unable to reproduce the error.

It would be great if we could test this is a little bit in pu.

Thanks,
Lars

Notes:
    Base Ref: next
    Web-Diff: https://github.com/larsxschneider/git/commit/af0f0f0eb8
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-retry-v2 && git checkout af0f0f0eb8

    Interdiff (v1..v2):

    diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
    index 7a9aa9c6a7..3e5a0abee0 100755
    --- a/ci/run-windows-build.sh
    +++ b/ci/run-windows-build.sh
    @@ -14,26 +14,33 @@ COMMIT=$2

     gfwci () {
     	local CURL_ERROR_CODE HTTP_CODE
    -	exec 3>&1
    +	CONTENT_FILE=$(mktemp -t "git-windows-ci-XXXXXX")
     	while test -z $HTTP_CODE
     	do
     	HTTP_CODE=$(curl \
     		-H "Authentication: Bearer $GFW_CI_TOKEN" \
     		--silent --retry 5 --write-out '%{HTTP_CODE}' \
    -		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3) \
    +		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >$CONTENT_FILE) \
     		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
     	)
     	CURL_ERROR_CODE=$?
     		# The GfW CI web app sometimes returns HTTP errors of
     		# "502 bad gateway" or "503 service unavailable".
    -		# Wait a little and retry if it happens. More info:
    +		# We also need to check the HTTP content because the GfW web
    +		# app seems to pass through (error) results from other Azure
    +		# calls with HTTP code 200.
    +		# Wait a little and retry if we detect this error. More info:
     		# https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503
    -		if test $HTTP_CODE -eq 502 || test $HTTP_CODE -eq 503
    +		if test $HTTP_CODE -eq 502 ||
    +		   test $HTTP_CODE -eq 503 ||
    +		   grep "502 - Web server received an invalid response" $CONTENT_FILE >/dev/null
     		then
     			sleep 10
     			HTTP_CODE=
     		fi
     	done
    +	cat $CONTENT_FILE
    +	rm $CONTENT_FILE
     	if test $CURL_ERROR_CODE -ne 0
     	then
     		return $CURL_ERROR_CODE

    \0

 ci/run-windows-build.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index e043440799..3e5a0abee0 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -14,14 +14,33 @@ COMMIT=$2

 gfwci () {
 	local CURL_ERROR_CODE HTTP_CODE
-	exec 3>&1
+	CONTENT_FILE=$(mktemp -t "git-windows-ci-XXXXXX")
+	while test -z $HTTP_CODE
+	do
 	HTTP_CODE=$(curl \
 		-H "Authentication: Bearer $GFW_CI_TOKEN" \
 		--silent --retry 5 --write-out '%{HTTP_CODE}' \
-		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >cat >&3) \
+		--output >(sed "$(printf '1s/^\xef\xbb\xbf//')" >$CONTENT_FILE) \
 		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
 	)
 	CURL_ERROR_CODE=$?
+		# The GfW CI web app sometimes returns HTTP errors of
+		# "502 bad gateway" or "503 service unavailable".
+		# We also need to check the HTTP content because the GfW web
+		# app seems to pass through (error) results from other Azure
+		# calls with HTTP code 200.
+		# Wait a little and retry if we detect this error. More info:
+		# https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503
+		if test $HTTP_CODE -eq 502 ||
+		   test $HTTP_CODE -eq 503 ||
+		   grep "502 - Web server received an invalid response" $CONTENT_FILE >/dev/null
+		then
+			sleep 10
+			HTTP_CODE=
+		fi
+	done
+	cat $CONTENT_FILE
+	rm $CONTENT_FILE
 	if test $CURL_ERROR_CODE -ne 0
 	then
 		return $CURL_ERROR_CODE

base-commit: 1ea7e62026c5dde4d8be80b2544696fc6aa70121
--
2.12.2


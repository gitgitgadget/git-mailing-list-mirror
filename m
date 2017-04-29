Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80BAD1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 18:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035309AbdD2SsZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 14:48:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36186 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031957AbdD2SsY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 14:48:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so16829211wmu.3
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vzX++Wqvs4XXsuFiihT6xsVB7yKP9+9e1cX0bBLCaa8=;
        b=s8O/1Bie3j59BAGpHpgakrkrhiSHYdH667pK6MZg/KCoNnfmNpuy3wdcBvLu5yAbDq
         LobldxKcWC22KhdB/FFpq62EPKn5nLcojEZeIpf5+E9IKANWseN2qmzRV8AVJbp4CpoG
         Pd+8bxL+mjrpDnHxRzmHHR8MzMgMxuGS1U6VSmN7JyAiguykyKpveFBBtHhCJnZdGofw
         y562kxnGMubE77oskoDLK+bYZlFJxAUZUVV6Q4VT9NWiP4rvWCd6TO1JPdbTdV54EilP
         5ZNmEsDjjLLhV920LdmvipWhhONSejkXp2dJcljaNtlMBM44iv/DW6vP8ncOWUoLv4bR
         SvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vzX++Wqvs4XXsuFiihT6xsVB7yKP9+9e1cX0bBLCaa8=;
        b=hZi1nPUsvMgOGt8WSaBqVVTiHcJVH0Sp/gdYwKzQTHijxJJibPWMxBQ62Ebx8lOc/A
         AGhI0UgBDnfSKCEQqUvLJGED1svKuX6XwpUoTNDFUZeNPGzztY1mLCBujtwiH6wF7rxC
         hC7WRvigl7fNOFH9/0osbVC0iNzGOTcfTFLVgKSceFJlR2+5YKmam8Ghxw4dRuoS+TDa
         isz8S4/RPLfM4GIAeaZ5qVveZKLenjxAlywJK7AP0b8TpcMKWb3c9L2dv79UEMeWBop/
         z2+zGdWjLdVyDSXN/to6YI1PmoB8xzx7QnP9yjlMVj8ly7dZvCtjHkPAuHifH8cSlNMg
         DsXA==
X-Gm-Message-State: AN3rC/5aCO3hBtYxcDoM/Rs1TIORDp2bFklbyiqEG3ibRgpmqhQKVxV5
        fYPdDW4S2h16dg==
X-Received: by 10.28.68.134 with SMTP id r128mr2410786wma.60.1493491703349;
        Sat, 29 Apr 2017 11:48:23 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB6C59.dip0.t-ipconnect.de. [93.219.108.89])
        by smtp.gmail.com with ESMTPSA id t124sm8654767wma.10.2017.04.29.11.48.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 29 Apr 2017 11:48:22 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v1] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
Date:   Sat, 29 Apr 2017 20:48:22 +0200
Message-Id: <20170429184822.10128-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git for Windows CI web app sometimes returns HTTP errors of
"502 bad gateway" or "503 service unavailable" [1]. Wait a little and
retry the request if this happens.

[1] https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

this should make the Git for Windows build a bit more stable. We saw
a few 502's recently. E.g. https://travis-ci.org/git/git/jobs/226669324

I did not add any checks to avoid an endless loop because TravisCI would
shutdown the worker if there is no output for more than 10min. Therefore
I think we don't need to handle this case ourselves.

Cheers,
Lars

Notes:
    Base Ref: next
    Web-Diff: https://github.com/larsxschneider/git/commit/b57ebf31ab
    Checkout: git fetch https://github.com/larsxschneider/git travisci/win-retry-v1 && git checkout b57ebf31ab

 ci/run-windows-build.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index e043440799..7a9aa9c6a7 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -15,6 +15,8 @@ COMMIT=$2
 gfwci () {
 	local CURL_ERROR_CODE HTTP_CODE
 	exec 3>&1
+	while test -z $HTTP_CODE
+	do
 	HTTP_CODE=$(curl \
 		-H "Authentication: Bearer $GFW_CI_TOKEN" \
 		--silent --retry 5 --write-out '%{HTTP_CODE}' \
@@ -22,6 +24,16 @@ gfwci () {
 		"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
 	)
 	CURL_ERROR_CODE=$?
+		# The GfW CI web app sometimes returns HTTP errors of
+		# "502 bad gateway" or "503 service unavailable".
+		# Wait a little and retry if it happens. More info:
+		# https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-troubleshoot-http-502-http-503
+		if test $HTTP_CODE -eq 502 || test $HTTP_CODE -eq 503
+		then
+			sleep 10
+			HTTP_CODE=
+		fi
+	done
 	if test $CURL_ERROR_CODE -ne 0
 	then
 		return $CURL_ERROR_CODE

base-commit: 1ea7e62026c5dde4d8be80b2544696fc6aa70121
--
2.12.2


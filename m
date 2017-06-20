Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0559320401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbdFTH5u (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34831 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdFTH4S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21284863wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+Bo6OZZAGUXnOyeYW9JoHf+VKYbjPrWvXVkQuJ4OaE=;
        b=KM5up6APZIqVwf7MdS9A0Qdwp0/uksXcmIOqarlqctjqUbQIqRZxoLw9cTPGsr1ctW
         avIYt+j+Lm5NZvwpWApKwbV1urK+R3JREGWwcMHnaQwk9yxem9k6bi7muiHEBzp9xg06
         MvqRSaoNwTWU5uH+NRSdoTgizVpgRB1uNi1O1HLLykw8mc4gjU/4yVpjSWUt85spLyal
         k3G4Ju6BoMcyaHZ7gRHntqELrt8KuKubvXlKD+9ExLQ40IYUWxd6zuCU2LKME4tZMVsS
         Zr/2I10hMl5OUmxz74q4+KS12K0eXx8C1Ew0w4At9rcxF6Z9NSGQaQRpSCnfn4h62yqU
         aK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+Bo6OZZAGUXnOyeYW9JoHf+VKYbjPrWvXVkQuJ4OaE=;
        b=MEoKPo2oArkTs1DqJRYneXEd2aksd5GMDAE8pDbgHBqjw2U5l3OGnn803173Bw4zA2
         twJ1ZMNPgG0PajPvBGIyQFD/E6DuPpme+PS/OolUH5gB39aR6nFLfMKouGbOgOF6SXX9
         zUKxdQUEwOSyjrDrxOzFRAyIFECcs8Ypb9elMGz6vKjspS5P2CxeTD6Rd0Qdy9uM4FvX
         2qjI37dM0G9oJS/5uoef44VhT0Ez3G5wtWg/CRtK7uNwqhmlb2LirYD+NhrTDgA17rWp
         gvgfkHbwIhcbvnNHHMtex2QB26tL/0kWLNe5376Rbty0GuHoX6wpePa26p9gMy3vPMo/
         dOfA==
X-Gm-Message-State: AKS2vOyVmh/TMJbPEeqMpg1gv/Fskw1UmnkrGS6AQ+6d1CmHNSaccW6H
        b2aEZngeWm7pYBve
X-Received: by 10.28.147.148 with SMTP id v142mr2701400wmd.1.1497945371778;
        Tue, 20 Jun 2017 00:56:11 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 17/49] lib-httpd: pass config file to start_httpd()
Date:   Tue, 20 Jun 2017 09:54:51 +0200
Message-Id: <20170620075523.26961-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to start an apache web server with different
config files.

This will be used in a later patch to pass a config file that makes
apache store external objects.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465a..2e659a8ee2 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -171,12 +171,14 @@ prepare_httpd() {
 }
 
 start_httpd() {
+	APACHE_CONF_FILE=${1-apache.conf}
+
 	prepare_httpd >&3 2>&4
 
 	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
+		-f "$TEST_PATH/$APACHE_CONF_FILE" $HTTPD_PARA \
 		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
 		>&3 2>&4
 	if test $? -ne 0
@@ -191,7 +193,7 @@ stop_httpd() {
 	trap 'die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
-		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
+		-f "$TEST_PATH/$APACHE_CONF_FILE" $HTTPD_PARA -k stop
 }
 
 test_http_push_nonff () {
-- 
2.13.1.565.gbfcd7a9048


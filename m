Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B9D1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758885AbcK3WBg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:01:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36372 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758644AbcK3WBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:01:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so31380837wma.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f42WjAc+EVGj8RoqscW/TDN9IjfaLCauYF4JEQ6JvfQ=;
        b=WvUZenChuqsJ4v2FtRx0LsGouyEtN8XQA6g2QAO4z2Z6AFzcbnpWql+DiqzNtydvcE
         JrGVE9OIXMtjGr7lRRlOUAULzP+SOfR3/O6uupb5ty0yEvDBH82oawADggxb1dH1jlib
         REnZHt350tWFP2+ALdH6j1dw2/F5kgVKW4vGgFTx1r0NcJgi3rnezYw2EGbXehZADFDA
         DwF5O17Vv/ynAKBEg1Yv1MZSEZRn4IA+LeMG9tKbXgDmfQR4X7RvJoNPYjhrreZXNJX0
         U1vpuY/kyqTWzGfXQ39WlI5GJCCRXcf815TBzkRyM7nREcPEJW+Iwl6e2d8vJ4C9aJYD
         xMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f42WjAc+EVGj8RoqscW/TDN9IjfaLCauYF4JEQ6JvfQ=;
        b=SxvSn9uf/h2Mh3NpIz/wU4yI5jFzN0rn/hUbGm1Ve5NZGoAWDKx7lNRpXcUzZROI4i
         WyCts8rgT967stAwbUVLUHoYo0O2FSGXOrQ1L412Cw7k2v9y/hOvMbwtTaw1guXsm9lk
         D9pqBZxbS6RUxq8xttdX64F4Oz+uQCO7NtazOGjBU7YjUm+766Pc8Uizaqu0TUmpzSFR
         hX5spdA6b4AdW9P8j/Sjh2Lz+Qp6dHQTfv14SzTXLHOdOomqhepbKo2B9Hh+DxijgzE1
         spHzxQi86pVcHwnXFfrkD/mA1HAbg+sO3ai8y8XlPWFrX+s0A4ZHP3gjQgj7rc44RmlI
         n8Fg==
X-Gm-Message-State: AKaTC02kKkBMSoZMkXxBNSc8Xln+0aMKd69DsmBLGxdg9k4UKPvlH+1xLSoFhO3AV8ZYrA==
X-Received: by 10.28.105.194 with SMTP id z63mr28911726wmh.78.1480539906863;
        Wed, 30 Nov 2016 13:05:06 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:06 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 11/16] lib-httpd: pass config file to start_httpd()
Date:   Wed, 30 Nov 2016 22:04:15 +0100
Message-Id: <20161130210420.15982-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
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
2.11.0.rc2.37.geb49ca6


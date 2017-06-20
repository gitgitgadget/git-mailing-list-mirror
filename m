Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181B620D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbdFTH4U (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34089 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdFTH4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id f134so3645472wme.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fe4XKmKCCCAeuLDuUKiq2AcK7x/WFKcKSn3PlrQcVWQ=;
        b=mbAnyc/GWTEMgHZ+oao1tBS/5esX2VIbcuBTYQKiXAlik9s45E4aHdZSpnnD4ytSv7
         sCCWv/aYo4f/GxOEOBUGtz4c9FZM5pZiE0Vu6LAQm9+Z7DD41FG1wk0JvoeWHHxFRsiy
         l52bN+xLzCaBhG32LLIGvDgL1mpeTkZB9q8p5uqUX7V6HvHCJhPb/Zhzs9g6PgNcpkTo
         uCmNV6QOIBvQZ2HrnzmYMymAE3tcEADKR+gB9m/B6rco0sORFIrNsa5oTQUmQvum/odj
         J3HBzUCEvAQVKFwYJ97Oxqa5S3XDE2ODHk94mtb2QPnd5cpOjw7y7T1xa8OB+GD3kptM
         Mo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fe4XKmKCCCAeuLDuUKiq2AcK7x/WFKcKSn3PlrQcVWQ=;
        b=R2giQmYrvr8L2jE1hQNvvIOjIHUWYUqFSMdWKo6yT54oSf7RxbswGw2lo/Dohwae4l
         UD5UtKrin8NsMVr77YUlr8CXUYvHK/++HRJzOXv/QEjt7xbE5sYgY2u33QcXTrSpcGdj
         vo6zMv22Aa7nJkkKQJs5QTuE4wVCINgVM/GmRAO0/HppZoKsVEWbtcItDt7izZe2NDiZ
         OGQExP7PdOfd602agSamINoIx53GxUKHzivuDYl9AaVO4nQXNQWBWTsPghSyIzr9vC+5
         48oQgIVyTE8cvThoPOoxkuWz1yPtMknpqVBohP4BjZb8YyufbJCpBfqzu79uweh6i+X0
         wbBA==
X-Gm-Message-State: AKS2vOwm+11LpJ6EGIb5H4KsQa+BSrDYORwoZJpWT2UCVNaoHZbVoXV+
        3v25abGN1oaivtx7
X-Received: by 10.28.208.207 with SMTP id h198mr1715352wmg.40.1497945373000;
        Tue, 20 Jun 2017 00:56:13 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:12 -0700 (PDT)
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
Subject: [RFC/PATCH v4 18/49] lib-httpd: add upload.sh
Date:   Tue, 20 Jun 2017 09:54:52 +0200
Message-Id: <20170620075523.26961-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cgi will be used to upload objects to, or to delete
objects from, an apache web server.

This way the apache server can work as an external object
database.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh        |  1 +
 t/lib-httpd/upload.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 t/lib-httpd/upload.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2e659a8ee2..d80b004549 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
 	install_script error.sh
+	install_script upload.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/upload.sh b/t/lib-httpd/upload.sh
new file mode 100644
index 0000000000..172be0f73f
--- /dev/null
+++ b/t/lib-httpd/upload.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+# In part from http://codereview.stackexchange.com/questions/79549/bash-cgi-upload-file
+
+FILES_DIR="www/files"
+
+OLDIFS="$IFS"
+IFS='&'
+set -- $QUERY_STRING
+IFS="$OLDIFS"
+
+while test $# -gt 0
+do
+    key=${1%=*}
+    val=${1#*=}
+
+    case "$key" in
+	"sha1") sha1="$val" ;;
+	"type") type="$val" ;;
+	"size") size="$val" ;;
+	"delete") delete=1 ;;
+	*) echo >&2 "unknown key '$key'" ;;
+    esac
+
+    shift
+done
+
+case "$REQUEST_METHOD" in
+  POST)
+    if test "$delete" = "1"
+    then
+	rm -f "$FILES_DIR/$sha1-$size-$type"
+    else
+	mkdir -p "$FILES_DIR"
+	cat >"$FILES_DIR/$sha1-$size-$type"
+    fi
+
+    echo 'Status: 204 No Content'
+    echo
+    ;;
+
+  *)
+    echo 'Status: 405 Method Not Allowed'
+    echo
+esac
-- 
2.13.1.565.gbfcd7a9048


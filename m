Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B061F208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbdHCJV6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38176 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbdHCJUA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id g32so571377wrd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sfJo+DTir6rCyDaCvZmUbRgVOwUbKUaQfZjhk1e0eOM=;
        b=emhzEyA0kHV+58kE4exEI36YQGj60xjHWZZujOG42Jwn4mY9fZy5/B8tbw/NuHAEcJ
         S4IOJebpfqNmayYSvCdYl3NviHWjOK+Dz2AuNUYc4K/1CfsYvloGqR8Tcghun7Ghcdz8
         /CN5kf6YnleEvkVfVexMHDl3xXYmv+YStQICRPJtGzLs/oJY/SGePpZhvuEC9dRRxylf
         RWW/NGEllAIVMXy+LQLi+DLWVx+UAZc/x+vPIi8au3lCpi2zE4ss6JvC2kUFNst+cNFz
         zcQAGnqcM6LEC97hXoLyYM38VssIA4abKpsimXNnqR+57lBRujq/sbOQJdgCBboEYmpW
         WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sfJo+DTir6rCyDaCvZmUbRgVOwUbKUaQfZjhk1e0eOM=;
        b=hzxZOHt2TXZrRzAAWs7U+2c7ULmkT5/aSsUE8pRZscpZp+XEUV0DmhyOPp7zIEL/+n
         15H6qqFC/gAAbidBe/UzTE/8Pid3PqaZRTZnb23PYoRIZaQvEqFEovI4R1vj05WHZqgo
         sbBsCAbxSdNPpzqWORy3YWL6mAR9awboIdU7e8gh9oY1ZLApFqYTymK0BwWBMEC016No
         cgwPGJJWhcr7uiqbu3QDe77nbSkFpUqu8AIjJW/GYtYFDRO5LgIswd7cUF0xRu24bID5
         Dy4R67czMDONeFysW6pC8BvQqSoz2H/a/8Y2dSH7k9yfp2uOVLTvLcwNe8TX02ylKcvv
         SQIQ==
X-Gm-Message-State: AIVw110QFXVd98sWtnhkj/TDY6LHuQnCblxbTVopFuTbnFJLQ302EL4L
        q8NqYH3vm74PYoax
X-Received: by 10.223.130.202 with SMTP id 68mr811647wrc.46.1501751999600;
        Thu, 03 Aug 2017 02:19:59 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 18/40] lib-httpd: pass config file to start_httpd()
Date:   Thu,  3 Aug 2017 11:19:04 +0200
Message-Id: <20170803091926.1755-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
2.14.0.rc1.52.gf02fb0ddac.dirty


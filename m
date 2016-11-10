Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE8520229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965705AbcKJUgC (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:36:02 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33050 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbcKJUeq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:46 -0500
Received: by mail-pf0-f178.google.com with SMTP id d2so152088580pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ek7CWytQW1decQuPdZzbnX4kcKs4YMviilOoUaNimyI=;
        b=gLmgnmnRMfWYRmnJikzGAvCM7WQUGFWi0kPADgwXt4sYXTWfmOzhtO1hMBJnY3J/Rl
         wjlWNzRPPSr01onQY+qRE5DTYbV3FDzaH8DE2hBpWRsJ0tmzIKPjUiqgIVXZznyPsbrF
         ACV/07Rf3S/W1/gEQB4oh/S9/p0fmkv26AfsJ/FSs+OWHV3WuwGHVok/SybEx/SuVW3m
         RT+6K4HUlxETIEBhauvSaus40x16NE6pvYpl6VFNnorTFoDl53NdunI7qB0YSB+KXlDn
         bxa2ekpt97bGS5LCZiiSk3vWj2eOk2jCz9m1XpRPpcBCLw3q1tYUTJcyQHgnthcEJ0m+
         gjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ek7CWytQW1decQuPdZzbnX4kcKs4YMviilOoUaNimyI=;
        b=GpxOKCak37I7mWZE1HsZ/6x2kv9j+E7xgmYiVQiiDnbDFXfw9owrG+8I+tgQewnyoA
         Di9NrHPZ1NSEOWy/xtNjiaecvc4wGCuny2EqjK7KOTlDYOuQ4ZYbLb8mLkKR1MDtw8OT
         R+q8XBqvl2CCs9K0IpvlrPlkr5iRORMwzJ5h3ET5jhmm+Cq4SA0TyuxGh2LuDXRS2rDR
         4NVYxj9LzpgiTmnfMklnv7FN0ffS6B0hnPGNq0zVrAV/S+lN+em9AFMxXAqi5IruRUEc
         t8l1IosF6VEohuR3ufAZERxjzZX1mvZbRAvv1miBSTrb/L5d29re+1EI4jqxb/aAkQuD
         TiiA==
X-Gm-Message-State: ABUngveayyKC3X+O/XFgIrILLki1xERpHplkl3vGrrZH3AtfTtIV7D5Y00DqA7I25zCnxoxE
X-Received: by 10.99.65.65 with SMTP id o62mr14803363pga.73.1478810085420;
        Thu, 10 Nov 2016 12:34:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id d1sm9271013pfb.76.2016.11.10.12.34.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/35] attr.c: tighten constness around "git_attr" structure
Date:   Thu, 10 Nov 2016 12:34:01 -0800
Message-Id: <20161110203428.30512-9-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 7bfeef3..5c35d42 100644
--- a/attr.c
+++ b/attr.c
@@ -43,7 +43,7 @@ static int cannot_trust_maybe_real;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
-char *git_attr_name(struct git_attr *attr)
+const char *git_attr_name(const struct git_attr *attr)
 {
 	return attr->name;
 }
diff --git a/attr.h b/attr.h
index 8b08d33..00d7a66 100644
--- a/attr.h
+++ b/attr.h
@@ -25,7 +25,7 @@ extern const char git_attr__false[];
  * Unset one is returned as NULL.
  */
 struct git_attr_check {
-	struct git_attr *attr;
+	const struct git_attr *attr;
 	const char *value;
 };
 
@@ -34,7 +34,7 @@ struct git_attr_check {
  * return value is a pointer to a null-delimited string that is part
  * of the internal data structure; it should not be modified or freed.
  */
-char *git_attr_name(struct git_attr *);
+extern const char *git_attr_name(const struct git_attr *);
 
 int git_check_attr(const char *path, int, struct git_attr_check *);
 
-- 
2.10.1.469.g00a8914


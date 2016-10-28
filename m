Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328BA2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966269AbcJ1Szn (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:43 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34331 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966226AbcJ1Sze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:34 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so41588057pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mkad8caqqlaWeZQpJw6x+x711anZBeJltPYa0SWJLNk=;
        b=Jp201ctPYw7p7NIrJFUmbATG4thWXEyI2VdI6MmqKc4uJilUxovaNoecwEuAU/xod3
         zCKmYYpHh4GDzJYd3f2lMKUZ/WLB/lAoAuvmc7r/mkQGJrkfsfKdkebV6lldEizqhUOS
         OWV0ACDcb+DxtFaP5vFbrVoAo7nteyuy8AxO4tbW4IxOnrH4PVJkBe2uk/sKWjLpPxfq
         MpD2ffBj7s9w5CXMpADdalGzduB511Rglph7OEsXUn/HsEap5J0HZX9eoBx/Va3RnBhA
         1yzdxu++aU1lA+wGohuVnjyjaWbiLwQr6HzMo31zyql7sEy/i3w3IoUtD7A2gp5hMLtM
         4iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mkad8caqqlaWeZQpJw6x+x711anZBeJltPYa0SWJLNk=;
        b=LeVDEL6htxZDRB6FoK7FCV3jGhIpYYeFiRd7E6ydgejtZXZ2QSCRUAFx6LEQhLTkR2
         1tq3bzE+trDUT2OT2cXeQuQCukJM2YKEV+o6aT7H+b+koJDxwD9EUC9QmPxRmXy2u54n
         94qM0OSl2OJdLQ9Up/1Fg7mbS0LEzRWvIKGwDoZ7P1JDykUBx7ha56DfE3fECbavuF1K
         VK2tVvuhitKsMxwWD4a6gdgCQSUhKa/ZDQxEL9o7XCibiXRTNot5L3uwiMb1+jDrLVen
         kc0KWd8QJ1t7KDkqgEj9wlWwdRXa5PZtBRSPWyTIinObcSHRF+pfURidhyg5hVThYRey
         /I2g==
X-Gm-Message-State: ABUngvcJ1RwVRaNtqLV0GAY6Gvnk48PGWUJIxmg6IsVZYfnEF/HntwbHTi0wmuvcXoJQyXW1
X-Received: by 10.98.20.146 with SMTP id 140mr27489724pfu.51.1477680933235;
        Fri, 28 Oct 2016 11:55:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id v84sm20513205pfd.91.2016.10.28.11.55.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 08/36] attr.c: tighten constness around "git_attr" structure
Date:   Fri, 28 Oct 2016 11:54:34 -0700
Message-Id: <20161028185502.8789-9-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index e42f931b35..f7cf7ae306 100644
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
index 8b08d33af8..00d7a662c9 100644
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
2.10.1.714.ge3da0db


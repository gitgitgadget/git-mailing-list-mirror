Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE5C20759
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965555AbcKJUfL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:11 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33116 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbcKJUfF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:05 -0500
Received: by mail-pf0-f171.google.com with SMTP id d2so152092108pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=taluHgeheDOO6shhgdNJoVWoTnCEEVqR7s7aLVWeg1I=;
        b=pvVf5iFGJjqfTY0RySDAOfp8BbWhqR1UinieVY6QVqh38nPZJ9t5S5MFd4AqUVC7VD
         PeCXfV7Kb2Nb00S9TNkpnI1VOlfww/sMUepuNquyThsEIY8WbldCAX8u7h87e3201Bw9
         7cUxSqZTZEuR47qhvSbj10D8z+G6/OvRNPoEhw/RiyKxLQL7Pz8uMEauXegWYkCvIgKg
         kuqN+GHVWrRGAwYtAjAQyRy5UK7y0hUCtQhX9605GojW+bo6aQpwEYO+GMimLJe8SaHl
         mijllyyi8H4qKzIeGM1FHFtKQAP8O+DyWQli3YcOVOOKdPWGc9iL0Unk948PCy0pBaHf
         olpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=taluHgeheDOO6shhgdNJoVWoTnCEEVqR7s7aLVWeg1I=;
        b=ZnaiKu1Hb7XemV502mZprDQiFWWeLvE4ig2Y8Tu6MhCuict+4LfngQdvldzuNACk9j
         6qXcEDpJShi+a6mzrN2IIDTR9If5NDd0GyRgB0OMh7klCJpgpDBpuial/cn7UTdhwkrW
         ubrKI/pNtS7w4jrsM4XtypVeSc1v9I93Ko4et9H96qUMkhX1139/Zrit0U2tn9xkF3RN
         LZedASyIiIdQ9VqGLhxdFj8k0TxZYb6JBSoY0/7tRiybkuCtALOns1GeY8r4ibhjSN2T
         +Zq2loOneezshrCjQ4r3TAhYt2FqzVB3LhWjpawefAXHY/WjccXFU6sDftObTg8C41eO
         +/zw==
X-Gm-Message-State: ABUngve756P6K2KcyiB77EUCoVl5uC3cq5cba1dHfZ8z9Pdm3KeSuA6cx0pzJqqSTArDzMjO
X-Received: by 10.99.4.213 with SMTP id 204mr38545233pge.77.1478810104923;
        Thu, 10 Nov 2016 12:35:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id f81sm8194085pfd.71.2016.11.10.12.35.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 22/35] attr.c: introduce empty_attr_check_elems()
Date:   Thu, 10 Nov 2016 12:34:15 -0800
Message-Id: <20161110203428.30512-23-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

One codepath needs to just empty the git_attr_check_elem array in
the git_attr_check structure, without releasing the entire resource.
Introduce a helper to do so and rewrite git_attr_check_clear() using
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 48460d2..5bb925d 100644
--- a/attr.c
+++ b/attr.c
@@ -746,6 +746,14 @@ static int attr_check_is_dynamic(const struct git_attr_check *check)
 	return (void *)(check->check) != (void *)(check + 1);
 }
 
+static void empty_attr_check_elems(struct git_attr_check *check)
+{
+	if (!attr_check_is_dynamic(check))
+		die("BUG: emptying a statically initialized git_attr_check");
+	check->check_nr = 0;
+	check->finalized = 0;
+}
+
 /*
  * Collect attributes for path into the array pointed to by
  * check_all_attr.  If check is not NULL, only attributes in
@@ -912,12 +920,11 @@ struct git_attr_check_elem *git_attr_check_append(struct git_attr_check *check,
 
 void git_attr_check_clear(struct git_attr_check *check)
 {
+	empty_attr_check_elems(check);
 	if (!attr_check_is_dynamic(check))
 		die("BUG: clearing a statically initialized git_attr_check");
 	free(check->check);
-	check->check_nr = 0;
 	check->check_alloc = 0;
-	check->finalized = 0;
 }
 
 void git_attr_check_free(struct git_attr_check *check)
-- 
2.10.1.469.g00a8914


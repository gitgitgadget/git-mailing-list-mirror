Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2846A1FB2E
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdA1CCu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:50 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35201 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdA1CCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:41 -0500
Received: by mail-pf0-f182.google.com with SMTP id f144so77054478pfa.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tt7MhDHHSAVSwo2c2rHrpsjiQ0AGGMCrUS9IV5aRSKw=;
        b=hlx7Tn32QcTBtACJ1PQccUPV7mgStWAJ0opLLLPwXo4Wzttw61/6Oda06pbABo5+sD
         ua4S19XnIPH2w5tD0f2ULaB5AeyFLUvOQ3iUpNqkPYZOCcZpFSuVDJeM5eEUafKurHX9
         psU29B9FsyXfDZS2gnEiInd/ClJyrJm+RwccfO8FD+UycC4GYQio8wkserq+m0TtLG+h
         U733Y8PvOe7MTUeuU9wMFpbrzmhHARrdO/BmzQbfXEUfsBcGiTK9QI59fTezXBmeicU3
         GIgdYFW5ImfJHUTmYZkoMkg8pMdcLXlf4Pxtmjp7MKvXFjNiCzPv1Tp+Hb+SumMsjnMI
         ZymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tt7MhDHHSAVSwo2c2rHrpsjiQ0AGGMCrUS9IV5aRSKw=;
        b=b7YuSVxfPoyD2ONaN57e6/ifD1TeLtRXgQ2X3+gnrbLPQPuZqEUe7jwP0SupUFopY3
         Eqq9iCelfY3o89UP6w7k61Ybg8JCheWG3iOC5yz3vvwwkSimWlqu1pf8MmHJST4Ih84I
         VFkERels9jvmrSVpHJO+WzGgz50gRLfywGgZW3gHh3g5uwDERweQpmamx4lpvIBD7uon
         cZGurWbs2nZ4yOEYYeGbV99m6dWWSYu53vlf9gtXg4Gh6VdNOEOCXdg2GH3+7T3BlrX5
         /YAVKrICqHNno7t71f6avbzPhQ4GtCmPktuMn9ccYY7cCF9Z//lf6ZrXgCF67R0kag2w
         wA+A==
X-Gm-Message-State: AIkVDXJ4BTym2qT4Ll5E9WbAwwtwMAGyOFY2lJvK9W7UvHSFm5aPxoV0zv/X9U91bkrpAU8d
X-Received: by 10.99.142.65 with SMTP id k62mr12350956pge.157.1485568960257;
        Fri, 27 Jan 2017 18:02:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:39 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 08/27] attr.c: tighten constness around "git_attr" structure
Date:   Fri, 27 Jan 2017 18:01:48 -0800
Message-Id: <20170128020207.179015-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

It holds an interned string, and git_attr_name() is a way to peek
into it.  Make sure the involved pointer types are pointer-to-const.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 attr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index e42f931b3..f7cf7ae30 100644
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
index 8b08d33af..00d7a662c 100644
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
2.11.0.483.g087da7b7c-goog


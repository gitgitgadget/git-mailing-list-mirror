Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7187B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBFAcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42002 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBFAc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:28 -0500
Received: by mail-pg0-f67.google.com with SMTP id m28so181200pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2Ya4dS8evsb4XgWm16pmj2WTSzgddrAyTLwHqLuSr8=;
        b=KsOGqWjfu1IhNPzKIQigwNwM4eF7zXHdulUZ0q9SgIFS1KnDNfQaIDdn//JEBAXyki
         k1vIjsId48gxA9hNngtfutDAYyzbcKgJPGxewUJhNoKblkMYjWZ9fwTojNl+X3GAQ2gJ
         47IjZFpkQTxeuBZw9OE/wMKaosGbLgNGCMNYHwYLVqVn0bDaQTr6LGOAJrQVeuISwMoi
         jK6/1yPBQ6aTecEyr2m5BL7HW0x5TnqZAKhKkn74p61r1TGufLD685CQUsv2Fwzg7Xvu
         l8oNayex95rZbzNt5EQpNKYiIlWm5V5e95aTZL57vRso4HIkZQoQ9dHKkMF2tBfEy6yi
         lURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2Ya4dS8evsb4XgWm16pmj2WTSzgddrAyTLwHqLuSr8=;
        b=fBVp+FmmQ6UE1aNGGHPBAup7oClIYVK2yPFVkDLTOwJHfB5H5MfMzqnCCI8t0d6G09
         7O4yVn8YNc89fbzdRDJ2yohOHAohmvS4wHqvaw4CTdI2BGzsfXdzmytg5xc0gFQ7YBxm
         7TKTst3pSs3xml+z75FIxQE3Px4rGHxt4hJRBOEEoe0qyFJ3u1lLidGyNERpw2WazDQl
         vGqFXSHkF3LyfZ6qi6YRxTo28PxyegNOWQD/vdRZcbynJrtI9RiFrXEG7fv0yMN/BPgp
         COkOCFWbJmCz0iX2mtc2iiLM7hoZxfmVba4nZ+fp9025IbY86Oore8BVLUuwet3uDaLN
         YdVA==
X-Gm-Message-State: APf1xPCkdGeFbLnHzDDHBELzmu4NYzUNbedSFPjYlrDzM/pRkTT+ICGk
        IeLDg/VoI9KCo5iuJWlQ8TmunGXHbPI=
X-Google-Smtp-Source: AH8x224ne1OhKgcXnX0LtTZxPZ6c5Nucz0KM8WhhIeZnCobKdhsm0EZ89z3VrGUUH5coFw5mDrjswA==
X-Received: by 10.98.35.14 with SMTP id j14mr590393pfj.62.1517877147157;
        Mon, 05 Feb 2018 16:32:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id k195sm13760389pgc.61.2018.02.05.16.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 191/194] pretty: allow format_commit_message to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:46 -0800
Message-Id: <20180206001749.218943-93-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pretty.c | 6 +++---
 pretty.h | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6dce4bb3c0..ed1b778c92 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1503,7 +1503,7 @@ void userformat_find_requirements(const char *fmt, struct userformat_want *w)
 	strbuf_release(&dummy);
 }
 
-void format_commit_message_the_repository(const struct commit *commit,
+void format_commit_message(struct repository *r, const struct commit *commit,
 			   const char *format, struct strbuf *sb,
 			   const struct pretty_print_context *pretty_ctx)
 {
@@ -1519,7 +1519,7 @@ void format_commit_message_the_repository(const struct commit *commit,
 	 * convert a commit message to UTF-8 first
 	 * as far as 'format_commit_item' assumes it in UTF-8
 	 */
-	context.message = logmsg_reencode(the_repository, commit,
+	context.message = logmsg_reencode(r, commit,
 					  &context.commit_encoding,
 					  utf8);
 
@@ -1545,7 +1545,7 @@ void format_commit_message_the_repository(const struct commit *commit,
 	}
 
 	free(context.commit_encoding);
-	unuse_commit_buffer(the_repository, commit, context.message);
+	unuse_commit_buffer(r, commit, context.message);
 }
 
 static void pp_header(struct pretty_print_context *pp,
diff --git a/pretty.h b/pretty.h
index 14af7df4e8..c5fc07005f 100644
--- a/pretty.h
+++ b/pretty.h
@@ -99,9 +99,7 @@ void pp_remainder(struct pretty_print_context *pp, const char **msg_p,
  * Put the result to "sb".
  * Please use this function for custom formats.
  */
-#define format_commit_message(r, c, f, s, p) \
-	format_commit_message_##r(c, f, s, p)
-void format_commit_message_the_repository(const struct commit *commit,
+void format_commit_message(struct repository *r, const struct commit *commit,
 			const char *format, struct strbuf *sb,
 			const struct pretty_print_context *context);
 
-- 
2.15.1.433.g936d1b9894.dirty


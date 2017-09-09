Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC40420286
	for <e@80x24.org>; Sat,  9 Sep 2017 06:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757378AbdIIG5y (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:57:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38490 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756177AbdIIG5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:57:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id x17so3007830wmd.5
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLwed2ioNrCgKa/AK00zw+EUShFetwSLjOwb+6Vx0I4=;
        b=LvTOs0WcjUDjbu3VyT1Q85aFN6R5tZRmi2LEYPrtjmGux4wkhs5Jac00DttzKP9hgZ
         s5PqhznYozREGNmo6AOd2thjlpxZM0vscKhDnpuHb+S5rXQwB8aMEK1T2Y8iK3HIf+pF
         /5v7d4Dx4xWWJ+hY7ehVTHgK+s3d/AVFr36hg1I5Yfk4awlA4/5RGNjzmnAptdhYtXsL
         ua2leRUoU8Ro32XyM9hOW6Yj8sj3YAVt1NPM7AQujWEVoGdzuYrYcKdpvDgtPU2RfWvr
         /mJ0ZGLgxu7rdUdjnMLp0MGMsXvvREyYW+4CwjwDeVY/DxNA/ZQnzm+mEJgdYBFTJyK7
         TvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLwed2ioNrCgKa/AK00zw+EUShFetwSLjOwb+6Vx0I4=;
        b=naBbvbNh3DiydPzzYjEMCfrOBNqrZf3RgfYRKV54M9qUd/BYNCD6zn/WDTXHqPMUKf
         2AeLAH22WqlU7VrKCQycWC4gbWzVRTkClvR1s0eJtb8CoyC+cVlDe7/jCMWp4q60q/ly
         AonAOwpxKVmtbb+Ren4nAq17jGm3YEMHfP090d+JqdjJdPXX1HVGajM6jr977mkv0HaU
         0rbLRXGE7TdXSIKwhLv0LH8zV+0zpHdnAbsM9uobq0ojrojVFjxO/QdiYGdnY2LDwrnX
         enBUKWEbPwUdF8vMcdK7YWTRfImkiAmQqBp5cNz29XoQpbAC7fas+L4462EvGDr4bRt5
         ikcg==
X-Gm-Message-State: AHPjjUg/kLVyaw+vdD00SCeUo6pNL6Tkz9LPMC7sieDjn/aQ61wtRHjG
        aj9F5NqlqYkYBvuj
X-Google-Smtp-Source: AOwi7QCDEov+CLGIivWoCD4/iN7dSLEX/wdNdmRoDGJ6KUTb6lEZuaTjCFDp/dGMAEXT1kr6uSluXg==
X-Received: by 10.28.193.5 with SMTP id r5mr3702822wmf.153.1504940272694;
        Fri, 08 Sep 2017 23:57:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id v82sm4269403wmd.44.2017.09.08.23.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Sep 2017 23:57:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 4/4] refs/files-backend: add `refname`, not "HEAD", to list
Date:   Sat,  9 Sep 2017 08:57:18 +0200
Message-Id: <6a050265f2439217c7cf6107149f7d6ef30f64a3.1504939825.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
In-Reply-To: <cover.1504939825.git.martin.agren@gmail.com>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com> <cover.1504939825.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier patch rewrote `split_symref_update()` to add a copy of a
string to a string list instead of adding the original string. That was
so that the original string could be freed in a later patch, but it is
also conceptually cleaner, since now all calls to `string_list_insert()`
and `string_list_append()` add `update->refname`. --- Except a literal
"HEAD" is added in `split_head_update()`.

Restructure `split_head_update()` in the same way as the earlier patch
did for `split_symref_update()`. This does not correct any practical
problem, but makes things conceptually cleaner. The downside is a call
to `string_list_has_string()`, which should be relatively cheap.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 03df00275..926f87b94 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2589,11 +2589,10 @@ static int split_head_update(struct ref_update *update,
 
 	/*
 	 * First make sure that HEAD is not already in the
-	 * transaction. This insertion is O(N) in the transaction
+	 * transaction. This check is O(lg N) in the transaction
 	 * size, but it happens at most once per transaction.
 	 */
-	item = string_list_insert(affected_refnames, "HEAD");
-	if (item->util) {
+	if (string_list_has_string(affected_refnames, "HEAD")) {
 		/* An entry already existed */
 		strbuf_addf(err,
 			    "multiple updates for 'HEAD' (including one "
@@ -2608,6 +2607,14 @@ static int split_head_update(struct ref_update *update,
 			update->new_oid.hash, update->old_oid.hash,
 			update->msg);
 
+	/*
+	 * Add "HEAD". This insertion is O(N) in the transaction
+	 * size, but it happens at most once per transaction.
+	 * Add new_update->refname instead of a literal "HEAD".
+	 */
+	if (strcmp(new_update->refname, "HEAD"))
+		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
+	item = string_list_insert(affected_refnames, new_update->refname);
 	item->util = new_update;
 
 	return 0;
-- 
2.14.1.460.g848a19d64


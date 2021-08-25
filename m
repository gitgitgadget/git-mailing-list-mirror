Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D06AC4320A
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C14C6127B
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhHYCWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhHYCWy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:22:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDF4C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y23so21611937pgi.7
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osyt+1YtfCPmJML6Js9+aETSUzA98PVwdKrLEsDt8+A=;
        b=mCEM/Oc5AYlhIqsLuEyZGYQujUiuSLb9O7is9exzmwFzAM/jICrXnuZky73AWdS7Bl
         KvvN/yo7hACSHeoPSwqMOy4MfzUjzdnZF1TGsSPuOwFyY2VDc0QaYoCifGJ7U8Mxb9nA
         hZUrYN2MTpFpbcT8OUqcf1cGInDTlTZisAig+BKFyJVYzuWVeNGrswwMyYMnAdy2r/C2
         V0sC/OlXPFNZeVGzQJK83qn5h2nOaDwcCKG2P289uIJsQyaJXzvV/4D5+YP6SxQhwvBr
         EeTg5aVnZvgfSyU90X/a4y/aktHvojW8j8rMR90k9Na+YEE0AWtMsARC5WcI6wDRWKIs
         udCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osyt+1YtfCPmJML6Js9+aETSUzA98PVwdKrLEsDt8+A=;
        b=FJ6xyiXVlI+2iUk1ehLndFwaoHma8njx6w9e1pCWThSaH1G/0Iup9J10zpvYNLTu1x
         vFhot5jEXD+lRSTm+jeE11WCf25Ce+43rFe97r7DUTwHc0YXci6gh6btcnaVMtb4M70w
         aUOgqCy/On8/0g1E8iDb15+Vaa2iNzC+QKtsADp4sFIqtJ4HQezXjFkPwsbbuSFAARi+
         dUc6dD6qa2d9rP2ADCJqjzw1Kkgb4FsAlKg/hrjxPDQyORMOuxn3EJy32MigG+uUqqwD
         8dldHARckuCK3eZs+0kmKbpNY6kHAmDbZJSIAiL/yFp053PtSnMBWkyOGQLE9YL3KX+I
         ee4A==
X-Gm-Message-State: AOAM533aRzCwB7Au+g//zMHemxMhWZMiiQIKiiU5HjT+OZWUTwTkbaIS
        sYwCV+GkeeD52N3GGs/BDko=
X-Google-Smtp-Source: ABdhPJwIRSQqV+AMsXLqWoWFHA7jAMgWEKQ8WpJGUqIOYPwgnj+6WY+trW3hYX3egxjOWSgxHx7i3g==
X-Received: by 2002:a05:6a00:91:b0:3ef:90cd:162d with SMTP id c17-20020a056a00009100b003ef90cd162dmr828438pfj.8.1629858129358;
        Tue, 24 Aug 2021 19:22:09 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 01/14] pack-objects.c: introduce new method `match_packfile_uri_exclusions`
Date:   Wed, 25 Aug 2021 10:21:45 +0800
Message-Id: <73a5b4ccc11b8b0604dc3414129069ab41be45d0.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..31556e7396 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1188,6 +1188,24 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
+static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
+{
+	int i;
+	const char *p;
+
+	if (ex) {
+		for (i = 0; i < uri_protocols.nr; i++) {
+			if (skip_prefix(ex->uri,
+					uri_protocols.items[i].string,
+					&p) &&
+			    *p == ':')
+				return 1;
+
+		}
+	}
+	return 0;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
 			     struct packed_git *p)
 {
@@ -1335,19 +1353,10 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (uri_protocols.nr) {
 		struct configured_exclusion *ex =
 			oidmap_get(&configured_exclusions, oid);
-		int i;
-		const char *p;
 
-		if (ex) {
-			for (i = 0; i < uri_protocols.nr; i++) {
-				if (skip_prefix(ex->uri,
-						uri_protocols.items[i].string,
-						&p) &&
-				    *p == ':') {
-					oidset_insert(&excluded_by_config, oid);
-					return 0;
-				}
-			}
+		if (ex && match_packfile_uri_exclusions(ex)) {
+			oidset_insert(&excluded_by_config, oid);
+			return 0;
 		}
 	}
 
-- 
2.31.1.456.gec51e24953


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCDD20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeLOAKB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:01 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:43807 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:00 -0500
Received: by mail-it1-f202.google.com with SMTP id 128so7659315itw.8
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sid1qn/jq/oUHvTRU2d5Rfs9v0w1WFTSzjuvcuydNW4=;
        b=TWQIhzojQlFZ+7Dyn6SdW+eefOT3+Grqp2JQoiYpGAzGjrzymfeDxy6iZ9/mklBIZr
         rKenTOs42zKWha2wGmpta5U/atfsrGS6VOL6KuiSh8YXAFZDjXyKqJLjCYhLj3TO2j6L
         KOSBfR4CVC7R/WBMVsIH/5urZMmfU6IwDiq6YQYy7N6pKj8zOPcLyjW7p8Yawjwp4+Rg
         4vrGGtL64IoYEP2TjT8WKZagF3kIDNyorHlBnm/2+8dfs4QreqB9Y32B9exsEnrd5H8Y
         Lc9nbzJlel9aSfckXjNX0Zc+ojxcCMXWwnfAzpQWdyWSVdpU67ZaLGh/cyVDCl06GOUd
         Ua2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sid1qn/jq/oUHvTRU2d5Rfs9v0w1WFTSzjuvcuydNW4=;
        b=ofifFCmNDcr9n/OuoP3HylL1FrO5XNVtVV2skM8y22Gkrfm42An8fc2/8GVewCSsvC
         0k+qgaDb4kylHtPzxvboG/D6WCdiLsPYeaPAzVY38Hnr57IoNwVrSuid8AhmNajkCjnP
         qF4lPhme1DPu7x1AWGj2t4jGVFYeslFvcoogurkr3XygesKwrg8MBwUkW/19IZ4BmGSE
         yw6DqAQKHhgezAriqXDCG+HYI0htjjt12IL5LzNJY8+pS/kHeClzD8VFt2g7xYkRz80a
         nACOVdZoxaE+DaDXgBq5mj3PDvu/XAEQZCRBp4YS857bFul8nJKEWnVzO1CyE2kZTHeR
         JIzg==
X-Gm-Message-State: AA+aEWZUAOYeFuGo5l+ZUHpt5CTO+hzNTClYonbrHj53NokvkgcXZDEx
        anj2H0TBC1VFZyIBMRcSKUbra8lHexnl4HlC+m6HrCTefynTOwWuzfYrPQjtg4G7MF+9JIaqCw0
        XQYnfkq2FenAxM43nkvDC0BQJ4bju6kxfb36DZu5i2gQr0GHkKu9Xg6knEqaA
X-Google-Smtp-Source: AFSGD/XYYNGPzLzZ8oqRZ6SEEZY8IJ2THif6LU/QofwD2OyuEVVHEhcYNdHTbHAjKQ26JNcsKK/RMkfwhqzM
X-Received: by 2002:a24:42c3:: with SMTP id i186mr4662677itb.2.1544832599705;
 Fri, 14 Dec 2018 16:09:59 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:25 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-7-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 06/23] object: parse_object to honor its repository argument
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e4b0b6047 (object.c: allow parse_object to handle
arbitrary repositories, 2018-06-28), we forgot to pass the
repository down to the read_object_file.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object.c b/object.c
index e54160550c..003f870484 100644
--- a/object.c
+++ b/object.c
@@ -259,8 +259,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if (obj && obj->parsed)
 		return obj;
 
-	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
-	    (!obj && has_object_file(oid) &&
+	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
+	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error(_("sha1 mismatch %s"), oid_to_hex(oid));
@@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_object_file(oid, &type, &size);
+	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-- 
2.20.0.405.gbc1bbc6f85-goog


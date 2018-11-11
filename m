Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404E91F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeKKQLE (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44012 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id j202-v6so4745459oih.10
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogRkULu7I4a0e+eE8rK6ZT9RsXgWCpT/fWyGvrK7fZk=;
        b=RZCe0Wj98yLBi9YOf+l7ev9k+APpsBGxh97NyrI9SNBJtoy1vJ9fX3eskvfn5s0/43
         VYV+Tu7SBPkAysRXNjs7/IY1zsVcrkAZYmj49dwwSOHHaVGpScQURG6q8c4y+5/QGMxv
         19Dy6nlqRGLgzv/UIpHg/Ph0fEegmbDJD8vK7uLTjRgG4nL5BxcOeYwLul6+oOrmonBc
         3ZPK0JoOKFy+VEE0TUjhvtJtNAMdHJm9qODmqs+WmX7pJge3+YOaVS+kqdN+8lUpbIUk
         7gunoZFshozTTotKgDFqYe6mR+iBbxivJy4fsL3F+WSKs5KSIOm8pYhS+mnPrVQEMaWP
         d/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogRkULu7I4a0e+eE8rK6ZT9RsXgWCpT/fWyGvrK7fZk=;
        b=OLlzGvVBNjzJGCKGOYcgAyJgNg/J3RRtSJw3kOYD9iq0zMZdPRQkfXLELCvpp2sP+p
         sYp4AOzlvJ8vTdKNsHmr4vuJy/BRUrrgLaH970JNtpsrw9VAe6puS9aQcmt7vYfhwImv
         d0dOTP/Pwb8RXHx/KJyNIx4aDfDhnmwM9yb/EqbxbF9xEB4+Cop3vDawHwQ4B7wUD8Gd
         AMAY2Osjq/EgZScZoREkeo3H49jmr/NGqFUu/3siS7vcrKudRPUUHdYGEIHCi/OWCM//
         qkQ/RGSd3nJXrKv4yWkeA5KkXZVCunfegKxFeWEQ3QFXjJMzAjTixihsdAyRfGrsEYJ+
         xF4w==
X-Gm-Message-State: AGRZ1gI6f3fdN6ELfbcmVA4rMFQjD2wvx8vOj82WQ53wXStP3E0/8BDN
        4nlO1+hyphykOHVmpns2O1bcMCQv
X-Google-Smtp-Source: AJdET5fFEeEA6Cj4+a9ZYDpjiICN4OGb8OwlhoAMICf8+b67ahfCvUxebTCdvjwcRsA8L0t9pV+hew==
X-Received: by 2002:aca:4543:: with SMTP id s64-v6mr2086789oia.278.1541917405184;
        Sat, 10 Nov 2018 22:23:25 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:24 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 05/10] fast-export: move commit rewriting logic into a function for reuse
Date:   Sat, 10 Nov 2018 22:23:07 -0800
Message-Id: <20181111062312.16342-6-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logic to replace a filtered commit with an unfiltered ancestor is useful
elsewhere; put it into a function we can call.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 89de9d6400..a3c044b0af 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -187,6 +187,22 @@ static int get_object_mark(struct object *object)
 	return ptr_to_mark(decoration);
 }
 
+static struct commit *rewrite_commit(struct commit *p)
+{
+	for (;;) {
+		if (p->parents && p->parents->next)
+			break;
+		if (p->object.flags & UNINTERESTING)
+			break;
+		if (!(p->object.flags & TREESAME))
+			break;
+		if (!p->parents)
+			return NULL;
+		p = p->parents->item;
+	}
+	return p;
+}
+
 static void show_progress(void)
 {
 	static int counter = 0;
@@ -766,21 +782,12 @@ static void handle_tag(const char *name, struct tag *tag)
 				    oid_to_hex(&tag->object.oid),
 				    type_name(tagged->type));
 			}
-			p = (struct commit *)tagged;
-			for (;;) {
-				if (p->parents && p->parents->next)
-					break;
-				if (p->object.flags & UNINTERESTING)
-					break;
-				if (!(p->object.flags & TREESAME))
-					break;
-				if (!p->parents) {
-					printf("reset %s\nfrom %s\n\n",
-					       name, sha1_to_hex(null_sha1));
-					free(buf);
-					return;
-				}
-				p = p->parents->item;
+			p = rewrite_commit((struct commit *)tagged);
+			if (!p) {
+				printf("reset %s\nfrom %s\n\n",
+				       name, sha1_to_hex(null_sha1));
+				free(buf);
+				return;
 			}
 			tagged_mark = get_object_mark(&p->object);
 		}
-- 
2.19.1.866.g82735bcbde


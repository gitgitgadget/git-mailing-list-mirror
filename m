Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274DC2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D98E20747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcBXGuSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGWLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:11:55 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:35487 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGWLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:11:55 -0400
Received: by mail-pj1-f74.google.com with SMTP id nk12so858553pjb.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SfiPv0d5hANtFtTTJf19/5S09fI2BAcLImCQQ0YC5GM=;
        b=dcBXGuSNyjjHz9aFZFOlQgFL+VnvxkFBbBaHcj31Ig19KQrsR5juFiGfBN5RNUVrUE
         29xWDIKozn2K3BGFvQOgmJJ3fSp9bHwm5GmJ2FMkD95kZpwuzZvGrWA7vwH7rjKsqU97
         1gt5KqMIVdRrd4e0zbzsGDUUdHTm4oxSoDTwGb8DJyHF4eTcFXkH7zmpOoCi7dGS4Ry0
         uXzhm3X7SmpydLnqT9nyvkT6+Cx490tVBSP63HgI8of8KQYJ8aV2Hn5tBdKpovSswvd4
         GVi0IbYD5Ot7cyhjEoW5oAViiWLLY4ysd8/O0KLEoh7D/h4cOX1QkNOYoYSXhAcF8BOw
         uFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SfiPv0d5hANtFtTTJf19/5S09fI2BAcLImCQQ0YC5GM=;
        b=WgijeYBt2BPk5eZN52SJEAqTBo/wO+4Ikk9HjekKKEcARVvbi5J+Y+ZljPqz5mb13h
         R1V90blHmtnZz51QaDwPRlT4U6umTr7XZKX/sjvi6TW+d1eNfeHZWcTC//4ANjEkeshL
         0464EObVvom5PaXzpLn1/yPettLYLOoMK1HZQbs1nsdvgRC0ccpsGqe1elelWaeH6Ouq
         YAzAQOeRGzQuBTsc/exevZFjzegkhvtJHTaU3D29pM0XCnlToaV6MXZe/B+K3aMc1Xaa
         EVs10uCSVAHaixW5VsJGvKqlGpwY5FlTiX96zomPZInWXFD+atFRwPIl8S7ImN8MNHML
         STBQ==
X-Gm-Message-State: AGi0PubMnLk2Htr7D4ArmegCunqh6xOyIj6MjpT5s4fAUUPg2B0JBlKr
        XslUBOzl8Pob3dwp7yFwwm69YhCfEM0lHvb77UzGxqwE5NCKnirr9XVHUFw/X4rDJ7Zqnh56SAD
        mCcmYK0WVVUyybcodQgTkWm13NSUC1uvoJobGhBt36RX2bBQlUKBGKs2z7ytTfliAzNA9XcnNOQ
        NE
X-Google-Smtp-Source: APiQypLh/AJZ5jPcCaQbyiqfOEm6YndU3tukd6o2rfsM/nZT5KuYp6qPjuuAQiBk9YBJGyZdWvhXBM8Cq7CaL52dtu1+
X-Received: by 2002:a63:8041:: with SMTP id j62mr3809263pgd.273.1586297513173;
 Tue, 07 Apr 2020 15:11:53 -0700 (PDT)
Date:   Tue,  7 Apr 2020 15:11:42 -0700
In-Reply-To: <cover.1586296510.git.jonathantanmy@google.com>
Message-Id: <34c239aa07233d5fc71c1e3cc2ea0ad32ad2bf78.1586296510.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200331020418.55640-1-jonathantanmy@google.com> <cover.1586296510.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v3 3/4] diff: refactor object read
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, garimasigit@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the object reads in diff_populate_filespec() to have the first
object read not be in an if/else branch, because in a future patch, a
retry will be added to that first object read.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index f337d837ac..8db981b906 100644
--- a/diff.c
+++ b/diff.c
@@ -4023,12 +4023,22 @@ int diff_populate_filespec(struct repository *r,
 		}
 	}
 	else {
-		enum object_type type;
+		struct object_info info = {
+			.sizep = &s->size
+		};
+
+		if (!(size_only || check_binary))
+			/*
+			 * Set contentp, since there is no chance that merely
+			 * the size is sufficient.
+			 */
+			info.contentp = &s->data;
+
+		if (oid_object_info_extended(r, &s->oid, &info,
+					     OBJECT_INFO_LOOKUP_REPLACE))
+			die("unable to read %s", oid_to_hex(&s->oid));
+
 		if (size_only || check_binary) {
-			type = oid_object_info(r, &s->oid, &s->size);
-			if (type < 0)
-				die("unable to read %s",
-				    oid_to_hex(&s->oid));
 			if (size_only)
 				return 0;
 			if (s->size > big_file_threshold && s->is_binary == -1) {
@@ -4036,9 +4046,12 @@ int diff_populate_filespec(struct repository *r,
 				return 0;
 			}
 		}
-		s->data = repo_read_object_file(r, &s->oid, &type, &s->size);
-		if (!s->data)
-			die("unable to read %s", oid_to_hex(&s->oid));
+		if (!info.contentp) {
+			info.contentp = &s->data;
+			if (oid_object_info_extended(r, &s->oid, &info,
+						     OBJECT_INFO_LOOKUP_REPLACE))
+				die("unable to read %s", oid_to_hex(&s->oid));
+		}
 		s->should_free = 1;
 	}
 	return 0;
-- 
2.26.0.292.g33ef6b2f38-goog


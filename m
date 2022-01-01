Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97007C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiAANvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiAANvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:51:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1EC06173E
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:51:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so27905916pjq.4
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWcu7CCENPShF+BVcZHyonlcE44FDHbDsXvHqum5v4w=;
        b=VRtHbqzjh4otSnSjdMGUT5DNzQt31lkpQ//3ydwqp8VdU4vVptXIme8gJkUjAPUwYa
         tGBKvyx67BlOm7+dvroyqoIEpxYLUQ9wyBY8DLJkqhrZ25vpF78Wci01TlqwLV89T402
         rwe5jlkKOSyLDKEgPPFVnx/j1pnRi4lindJ8Ec7I7wG/5qpOxDpSvMeKCTJYsq9fl/Dt
         CjkV9NTNc3HHa6bvBGT6nPIQzFlyh0LpLZYIYAX+FnGGvbOyDOVxzlKYxgGGOEBaPrLk
         nrb/vucbMWgNcZXqWnruwIaXqf7ZmIe5lHaXV4i0bagSjT4q3We9wsn8CEAjbq/xb48h
         nKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWcu7CCENPShF+BVcZHyonlcE44FDHbDsXvHqum5v4w=;
        b=jO/9aGWGnTPKpbyQ3op29JxsjQGyUHXsk/v7oRDu1yHG1qNzVkJATIEtsJehgqm6GI
         mSgmEunyX3WZ8wLEASCyyjiZEaL4lNhnjGCY4e6RlXjitAe0Sx3t8rYsByElEjHTIf4F
         6o0ApcKtGW969/lhABslXS6Lk7kI6yiu42g/X9N4noBezQS3GivIQHjwfPzEKwo8E3M0
         kj4G6jxh7rn9AtXHdwWVgxkmGjoE01TVxFDFhFyAJ1169xWO3wd+ODJgrfs3AjFUeQrv
         4bPrIENQoLUUyKXLzQ5rZKjbdJkuVkTC/FiFV1UcbFjn/KmMnySQnFVW2YaaKn82YW4R
         PzMQ==
X-Gm-Message-State: AOAM532wVS6Hyg6PKCidHYJNTRkoQBYwQ0369Fr04qwlha99rBU4aqIj
        Ka7RJ247iMIptWmG+5csKpE=
X-Google-Smtp-Source: ABdhPJyxowUgkIHc0MPUWxkgAbAP5RyvzXeI+Eqw8FLNGBcdX11cRy7kd4CZlGc0Rvtu1puXJCrfSQ==
X-Received: by 2002:a17:902:ab97:b0:149:8662:1736 with SMTP id f23-20020a170902ab9700b0014986621736mr24385681plr.174.1641045070485;
        Sat, 01 Jan 2022 05:51:10 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:51:10 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 4/8] ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
Date:   Sat,  1 Jan 2022 21:50:27 +0800
Message-Id: <2637464fd8f6b8bae6c681f20c10c9fc76dc6d6c.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1641043500.git.dyroneteng@gmail.com>
References: <cover.1641043500.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The "struct strbuf"'s "len" member is a "size_t", not an "int", so
let's change our corresponding types accordingly. This also changes
the "len" and "speclen" variables, which are likewise used to store
the return value of strlen(), which returns "size_t", not "int".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3f0225b097..eecc7482d5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,7 +31,7 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
-static int show_recursive(const char *base, int baselen, const char *pathname)
+static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
 
@@ -43,7 +43,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 
 	for (i = 0; i < pathspec.nr; i++) {
 		const char *spec = pathspec.items[i].match;
-		int len, speclen;
+		size_t len, speclen;
 
 		if (strncmp(base, spec, baselen))
 			continue;
@@ -65,7 +65,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
 	int retval = 0;
-	int baselen;
+	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
 	if (S_ISGITLINK(mode)) {
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty


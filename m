Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391871F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162432AbeBPRrS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:47:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35380 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758986AbeBPRqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:46 -0500
Received: by mail-pg0-f65.google.com with SMTP id l131so2968094pga.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7j0z1T1MKzhg3bnyjXBl4GMBnEzaHgu2Gsi0sUUyspU=;
        b=UDObATsv1j8nvUqdPzY2bsHjZD+am/b0pXEcWPs21b+Owc9izKM+OYWpjXhzzzas7A
         dDyXsWrS1vWzyUCxS9A51qZI2Ysilnd26L2ctxaokt0WIJJ7KUQyFX80NFj9ZfBxpt8L
         b4v1/UptfDDGvdfUP+teGHZl811FNhu0HC3O6z/SI7wve0Cl3LJ8yYd4TiYVBleH9VyB
         pe9km9ryoDRBeP+Pyv0ObmCzw/j2H6m/bgdB2Arz9qEjtrYbAw4dWjRUvYPuXBiLUrn1
         yIpaZU2a1Wo78A8LAIMkHv2j5cYg1FFN8INPQM/rNsJj8FAxDII8qbvt8wpGMWe+cNNh
         yYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7j0z1T1MKzhg3bnyjXBl4GMBnEzaHgu2Gsi0sUUyspU=;
        b=HfxwHjD74IVcj6208hF6rtIlC+J8mvoVCaje6vs1Y5mX0nxBo+5Ap8Z7ZcVpeMe+6I
         RwRWugtfzKGaZns7BFL2d8T22ZygAIWLt6HZrGYYSfaRkgQwxpnDXKq2ORTKr2rPaD08
         TTpKjDj1r5nQfggdBRVlE/di+clAHHSXGHnHDDAX7LxeemIG/q4yPq8Lb1xqZisDT0S4
         e3N6psxvSOpM1akmDAM7Zqh9kKIBxdAMA0xTqRHgQHc0J589fHmw8fYoPb1lTrZKULOJ
         kMWgNrU+CSmtl4da1jscSah9Esha1Uvy1xWpBXVMPyiH4LhoVv94LV66CT1Ta49G40sf
         dD9A==
X-Gm-Message-State: APf1xPBr0dYBKsfj+tb93kkkAHhny2QOqiumwVxbqcJvdwqkm+TmSJjs
        UjzeFTuV5xYtgO+5NJUBtorT803G+Pk=
X-Google-Smtp-Source: AH8x227jvahcNUfUs2k9edK0IgeJ7d/YmFitUI/13n7HqMxxLXyOA8sT9Gfw1KNX+3HgW9+xB10xBg==
X-Received: by 10.98.69.93 with SMTP id s90mr6904140pfa.31.1518803206021;
        Fri, 16 Feb 2018 09:46:46 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m9sm44704089pff.59.2018.02.16.09.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 08/16] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Fri, 16 Feb 2018 09:46:18 -0800
Message-Id: <20180216174626.24677-9-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180216174626.24677-1-sbeller@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1348dce68f..a8e23bd2f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -346,7 +346,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -362,7 +364,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -414,7 +416,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.16.1.291.g4437f3f132-goog


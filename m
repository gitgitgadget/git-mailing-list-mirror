Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DACC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC5120748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abtj+B3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHUSwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgHUSwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:52:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E3C061755
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t14so2780365wmi.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kkaPjl9wusTTa7slj9B8jUG/++0w8k/jaaFOQ+MQnzI=;
        b=abtj+B3zCJYtmdy85Gz6EfqDQM5AKolnrK5UcC8UNHkeeQdpt3ogXZUzGb1ASAfkb5
         lpxJeWzfG1VLew80TlOxMhHWcjHGSZBX877QuFVmU2QgCKk1v93rsbz58R7YJa+gxp9L
         Dp4iBoXyuZ2uGGPbJKLiK879bmJS1SRQJHaPhHSaQzA4F1meK9I1abIMpq4/UfGUotvE
         iWd3mz7MqrP8huZRgtmFRrs3sx9CGzCaoD53MdPgCcX382iuLxYCLk2GNrEvHg6Y/l6M
         wfGybyjVbI9Hjkd5SeRUMXgd6gCOwk9Wj6EMShPEdW+uUFGmzDswRpTtVoWGCj+uXTRR
         Uhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kkaPjl9wusTTa7slj9B8jUG/++0w8k/jaaFOQ+MQnzI=;
        b=Ve69cn16vm3/38OCd+ytDM1KJ5wxPmMZufPUzGPcipfkJTAhcnYRL6oFRKJUVBK3ZG
         ZMfIjFElOCXr0T1E/qqDX8utSxwpkn1Dd8mKriQzL15Z4PCqiH+ggM7QADtYVGwjIVAP
         OIofsAoCyDmw6kQO3orbNgUKPHrNnlIV1bBNIDBjZkVGOIqZl0o186JlAr0fxplcSvq1
         IvQEuK8oHbrLEpzHc2EwRLKsr6I1tAGIW0EckmeIlozn8rbTulrWgpE6QNTH37fHJIa0
         Y032b6HeO/WO41CC2CfNuFfdf7ttPR/WPr8Lo5xoCrsjSA8XXpIXZPHFgDB5BHd5j/IU
         FPgA==
X-Gm-Message-State: AOAM531ok1Ag53TPKrkaGd3RzLHjvt4PtMPjGXZIpeEg07Oz5UCYx0nI
        MBlgye+ahF75KpeX7uz7vfGAA5W5PEI=
X-Google-Smtp-Source: ABdhPJy/xz+w8SiMeXvTf2GiE6Wjys165l0Zw0sj/NSa1K4ZfB8HBiFBZSsKJz1oqGCiX9ywrGFo/A==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr5404727wme.189.1598035954970;
        Fri, 21 Aug 2020 11:52:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7sm6378713wrs.25.2020.08.21.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:52:34 -0700 (PDT)
Message-Id: <418975b46039f63476852a868ca6221244b5d88e.1598035949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 18:52:29 +0000
Subject: [PATCH 5/5] strmap: add functions facilitating use as a string->int
 map
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Although strmap could be used as a string->int map, one either had to
allocate an int for every entry and then deallocate later, or one had to
do a bunch of casting between (void*) and (intptr_t).

Add some special functions that do the casting.  Also, rename put->set
for such wrapper functions since 'put' implied there may be some
deallocation needed if the string was already found in the map, which
isn't the case when we're storing an int value directly in the void*
slot instead of using the void* slot as a pointer to data.

A note on the name: strintmap looks and sounds pretty lame to me, but
after trying to come up with something better and having no luck, I
figured I'd just go with it for a while and then at some point some
better and obvious name would strike me and I could replace it.  Several
months later, I still don't have a better name.  Hopefully someone else
has one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 11 +++++++++++
 strmap.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/strmap.c b/strmap.c
index 03eb6af45d..cbb99f4030 100644
--- a/strmap.c
+++ b/strmap.c
@@ -113,3 +113,14 @@ void strmap_remove(struct strmap *map, const char *str, int free_util)
 		free(ret->item.util);
 	free(ret);
 }
+
+void strintmap_incr(struct strmap *map, const char *str, intptr_t amt)
+{
+	struct str_entry *entry = find_str_entry(map, str);
+	if (entry) {
+		intptr_t *whence = (intptr_t*)&entry->item.util;
+		*whence += amt;
+	}
+	else
+		strintmap_set(map, str, amt);
+}
diff --git a/strmap.h b/strmap.h
index 28a98c5a4b..5d9dd3ef58 100644
--- a/strmap.h
+++ b/strmap.h
@@ -88,4 +88,36 @@ static inline unsigned int strmap_get_size(struct strmap *map)
 		var = hashmap_iter_next_entry_offset(iter, \
 						OFFSETOF_VAR(var, ent)))
 
+/*
+ * Helper functions for using strmap as map of string -> int, using the void*
+ * field to store the int instead of allocating an int and having the void*
+ * member point to the allocated int.
+ */
+
+static inline int strintmap_get(struct strmap *map, const char *str,
+				int default_value)
+{
+	struct string_list_item *result = strmap_get_item(map, str);
+	if (!result)
+		return default_value;
+	return (intptr_t)result->util;
+}
+
+static inline void strintmap_set(struct strmap *map, const char *str, intptr_t v)
+{
+	strmap_put(map, str, (void *)v);
+}
+
+void strintmap_incr(struct strmap *map, const char *str, intptr_t amt);
+
+static inline void strintmap_clear(struct strmap *map)
+{
+	strmap_clear(map, 0);
+}
+
+static inline void strintmap_free(struct strmap *map)
+{
+	strmap_free(map, 0);
+}
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

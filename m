Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3D5C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiJZPgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiJZPgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA63A120EEE
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so18358352wrh.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11L7QHXASbcJQWfdTU2dm4xZChgsJ6GjlkxUUJWQhmo=;
        b=XDh4WWExM1FjsdeJeNEY0sFwhC0zvkzMdAz4fCnmEeOH2dyjnlecN7Oc45/CevlnLy
         CccBGmAH05GGc4BE9rZ/pu7e0z+nrLZXtlJb85GkKQby/OYxSr2OCBLxHMr1JP3Bhuzy
         jDJqHME1kAUIeh0vgzGmN07bEbVRlgvBBHa5JDtzcU04y27X5WSvW6e077FQSsrV+xdX
         pc3m20pIowSca8Y9+yePCypY/ASA+S+ofXFHzppCs5zdWsv+0lUTACanRvsRty6zgLAX
         ET2nY2+d4J7Sef0JB/T3IrxsypqNifeJX7WxhDp9SX0IBb40Ttyyi6aWUVS8JkwF4k8t
         715g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11L7QHXASbcJQWfdTU2dm4xZChgsJ6GjlkxUUJWQhmo=;
        b=ZZCNijRHIDXH0CkQV2u21dKUOzKAE+hcgJLQUKV/cmN8DAAZH+u/YqMsUmqMXzL3WL
         jc+ipTZ+P9Uk9jr++8OpMBHiMHHK/kKf2a0UlxyRSKCwO8uis3kzvv2PDB/MOVNV0kSk
         SN7epuOiRNM2yB9jmo4mPR8tZZzzdrKvFZn0Wbwprr5XEt7+QNb4Gm1frQ+OVh7a2fnX
         ZGewbRzCGDveHm04/mOsMkz9sQ1nJrn2ZnVDkb2f1icZi1GOCo7k3tBrBWrdO6WO/R2A
         lmHkWLrmyKXFIbM5lq8rDxzS6wgVDQgdVBFRSJbLOG4vNhGZmnKdHh2d89r5hMU8aug8
         vOFw==
X-Gm-Message-State: ACrzQf24S/Hf899kLif8cS82KqGhBBv6o8gHQkXY5mTZZjeJxhxHbmzW
        MKrCGQTvOtU5NCULRcfwPIpVNwRQEg4q+w==
X-Google-Smtp-Source: AMsMyM5OgI+b4c+1uonMO9nnxlNAOY7cxrbIOjFMOasIU1xcfcBrqVLbBwp0+4y6iD7d5qwNYxwx+Q==
X-Received: by 2002:a05:6000:2c1:b0:22e:7b7e:de28 with SMTP id o1-20020a05600002c100b0022e7b7ede28mr28408316wry.123.1666798601052;
        Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] string-list API: make has_string() and list_lookup() "const"
Date:   Wed, 26 Oct 2022 17:35:18 +0200
Message-Id: <patch-05.10-b32b2e99aba-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since these were added in the "path_list" predecessor of this API
in 6d297f81373 (Status update on merge-recursive in C, 2006-07-08)
they haven't been "const", but as the compiler validates for us adding
that attribute to them is correct.

Note that they will return a non-const "struct string_list_item *",
but the "struct string_list *" itself that's passed in can be marked
"const".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 string-list.c | 4 ++--
 string-list.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index d8957466d25..d97a8f61c02 100644
--- a/string-list.c
+++ b/string-list.c
@@ -245,7 +245,7 @@ void string_list_sort(struct string_list *list)
 	QSORT_S(list->items, list->nr, cmp_items, &sort_ctx);
 }
 
-struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
+struct string_list_item *unsorted_string_list_lookup(const struct string_list *list,
 						     const char *string)
 {
 	struct string_list_item *item;
@@ -257,7 +257,7 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 	return NULL;
 }
 
-int unsorted_string_list_has_string(struct string_list *list,
+int unsorted_string_list_has_string(const struct string_list *list,
 				    const char *string)
 {
 	return unsorted_string_list_lookup(list, string) != NULL;
diff --git a/string-list.h b/string-list.h
index 7153cb79154..3589afee2ee 100644
--- a/string-list.h
+++ b/string-list.h
@@ -227,13 +227,13 @@ void string_list_sort(struct string_list *list);
  * Like `string_list_has_string()` but for unsorted lists. Linear in
  * size of the list.
  */
-int unsorted_string_list_has_string(struct string_list *list, const char *string);
+int unsorted_string_list_has_string(const struct string_list *list, const char *string);
 
 /**
  * Like `string_list_lookup()` but for unsorted lists. Linear in size
  * of the list.
  */
-struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
+struct string_list_item *unsorted_string_list_lookup(const struct string_list *list,
 						     const char *string);
 /**
  * Remove an item from a string_list. The `string` pointer of the
-- 
2.38.0.1251.g3eefdfb5e7a


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D306C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E6A610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhIHAjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhIHAjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:39:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C9AC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:38:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z4so580175wrr.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nBy4/aoyqoYntf/S7KMkKeLOU/XPNj1ixlMSq3cKa4=;
        b=ALbhQvJxVpM1qhGRl+MQ99EtzetClEofQ7Mgg4FYMSMmnH7SLnmTxhtcls+g1Hyl2i
         D08HJJWRVOF+FZZYMtgxpXKeDMAkKJWyr8cin8ClqzDwACA1qrYrau3ZPYSdzgNCR+z1
         tZNo98SI7FvjLowLVUlg9vi9mSGkY8CaqSj8UkTB4EevpGRt29dgViig0NMlsJk18RWC
         Nfo6Q0RU4gU6vqgDUm6HdPLGHjtVHmeZJOS+MwULCLICU1YhP2llfwc5BB85i8tvIozB
         PQd7YbsYI/IEkzaXu2WQi2rqH9AlKHnjZrK4DItWZ6toh7r87QJtpjivmvMA8MD1lBvb
         0Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nBy4/aoyqoYntf/S7KMkKeLOU/XPNj1ixlMSq3cKa4=;
        b=W/XCYALUSWSuMOLgbvgZGCvF9oRnZPh2Gr/+k8wNBF3MdQU12fD4EuYQ4LxRNGxXCD
         63Bs4loY+oGY1m1z4F8v6sTHFi3IdWOtxjetkaEaYHYmWcbaQWmnSfaz3emLNt73wZP3
         zkJbp10Q4lcb7JTLyanmbx9bvwvqY1aGHVK2KR66uCcB5rpmmxR4UexY00u5/Nt8jbOT
         FWzj7Jiwtbj9VS/dLc1yzsFcecYYGV1S9OWmIPHtYowfroUfo56JIe/Nh8XTBSfspEfi
         XNTl95Q5VLbpOy56PECZR1PLq93zICZnLZZ8O1S6xHy+ULTdOOSJq8DW9nhCwcTV7lOM
         k8+A==
X-Gm-Message-State: AOAM5321Oo58JHrw/iqsUFUOU/hNT8R8CWSIm1SaxpD3EAygJI/XzLW9
        iZOYgM0wpQJgdrRh0DShk+rR5ElNx4xvwA==
X-Google-Smtp-Source: ABdhPJwDyoARrlAAwrxRl32bhyIOgfvQkPfIm80w2kFM7uHtBacAlRXkNjIPy6fYgBIy4Ah5mEbdCw==
X-Received: by 2002:adf:c510:: with SMTP id q16mr942045wrf.203.1631061511033;
        Tue, 07 Sep 2021 17:38:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm548962wmf.4.2021.09.07.17.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 17:38:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] pack.h: line-wrap the definition of finish_tmp_packfile()
Date:   Wed,  8 Sep 2021 02:38:25 +0200
Message-Id: <patch-v2-1.4-29f5787651-20210908T003631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
References: <cover.1630461918.git.me@ttaylorr.com> <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Line-wrap the definition of finish_tmp_packfile() to make subsequent
changes easier to read. See 0e990530ae (finish_tmp_packfile(): a
helper function, 2011-10-28) for the commit that introduced this
overly long line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pack.h b/pack.h
index fa13954526..1c17254c0a 100644
--- a/pack.h
+++ b/pack.h
@@ -110,6 +110,11 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 int read_pack_header(int fd, struct pack_header *);
 
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+void finish_tmp_packfile(struct strbuf *name_buffer,
+			 const char *pack_tmp_name,
+			 struct pack_idx_entry **written_list,
+			 uint32_t nr_written,
+			 struct pack_idx_option *pack_idx_opts,
+			 unsigned char sha1[]);
 
 #endif
-- 
2.33.0.819.gea1b153a43c


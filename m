Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0633C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiESUJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbiESUJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:09:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD00A5AB6
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r23so8671174wrr.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cvOawsrHKZ549ig5YIMxqHUCJpvMrWq0Q5eB2cFS3Rw=;
        b=dn6H5EODg9j2GXSX5RUYvqAZdmCTvDdFxvg8mnX7gQCtC+vKveNSpdIMhxMJuBFuLY
         3xC5V+PjtAT+OOq6DHju7Wgd7xJJgSjn/LJlisabYxOG97tYyrdwSEnOBMrcZOuAyGze
         N62FOyYljJEKwGu1w30ayo+bRvCBYZS9zcIz542tHZj+NdJhNmstlrT7LEruD0dh0nTc
         TyNGk6taSWb6oV/4u/4bZf8SxwZMGowBfto2URvqfbr5CfUjjRrhkDlXXMZlV+qV1BHD
         syRXKVWWbuGTJ+tg114JKPdZc4oImxyZUECccDS7huILsnzsCuEQAms2MUJ9285AXkfk
         NoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cvOawsrHKZ549ig5YIMxqHUCJpvMrWq0Q5eB2cFS3Rw=;
        b=VR/VKcAsEsUql1mI2SqEOkxPv8MhBltHXtLv5QCa0eZ1fCu2/Fk4RdBlOEE61u9hW8
         laQ+P87DK7Bjm7CRMoULYvgOdT+uTcYVNjNkIXX99QdI23l3k7ajWe7U8n2UUTIsD/JF
         Y1dAnDrYooU/2uziZuoIGkzJKwbpzQS7KI/ms2wWuZGoWOL1lWJW2dHnNULD6ANWKMo1
         t60fl7TI6DLuTE36yVp+NsNUmgUywqOVQ9wbngXLgGP7mE/oRxai1gAaxsnKrTN+pLFY
         jq4RTVnNoE6k9jcDhbLJk2A9lKGnHIIdsk8kZs0Qf3+vPvw30CBeAnxLN+e39TMDuaNc
         cbMg==
X-Gm-Message-State: AOAM5300ZyMxFk3kaX+3vAoR5bIjrNII8PjPuJQy9eFsWUcVgPBvhStK
        tv9KdSYYeUdQVvTLejeZeclMY27y3E96Tg==
X-Google-Smtp-Source: ABdhPJwCyKdttG9ZNayxtEW2aayuX89pF3YRdxRM+XfHYVckiBtlSlK9ORThctR4RhaK6KKV8aKQ2g==
X-Received: by 2002:a5d:47c8:0:b0:20c:630f:7df5 with SMTP id o8-20020a5d47c8000000b0020c630f7df5mr5353307wrc.689.1652990973033;
        Thu, 19 May 2022 13:09:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm428152wmb.2.2022.05.19.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:09:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] object-file API: fix obscure unpack_loose_header() return
Date:   Thu, 19 May 2022 22:09:16 +0200
Message-Id: <RFC-patch-1.2-297bea05118-20220519T195055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
References: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com> <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an obscure unpack_loose_header() return value. In my
5848fb11acd (object-file.c: return ULHR_TOO_LONG on "header too long",
2021-10-01) this API learned to return ULHR_TOO_LONG, but should not
have done so in the case of parsing a long header where the
terminating \0 cannot be found. We should return a ULHR_BAD in that
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 3 +--
 object-file.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 595582becc8..aa24d5a609f 100644
--- a/cache.h
+++ b/cache.h
@@ -1342,8 +1342,7 @@ int git_open_cloexec(const char *name, int flags);
  * "hdrbuf" argument is non-NULL. This is intended for use with
  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
  * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), ULHR_TOO_LONG will still be returned
- * from this function to indicate that the header was too long.
+ * with parse_loose_header().
  */
 enum unpack_loose_header_result {
 	ULHR_OK,
diff --git a/object-file.c b/object-file.c
index b5d1d12b68a..1babe9791f6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1301,7 +1301,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return ULHR_TOO_LONG;
+	return ULHR_BAD;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
-- 
2.36.1.957.g2c13267e09b


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E89CC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5433F60EE5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhKLJpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhKLJpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:45:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C2C061205
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5862039pjj.0
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZzKSZv5O8h9jfyAeawQu6Dcrc3fav1gznXiBqvBhNM=;
        b=PsKcEWB/zU0gOBsAHd60dG3AlUY7GfXutCrUmi6Jm9DOJnNceWS/YALV27Vxr/jrkE
         k3hKEDZTSQvyvq/S1Okrz0F1ZFgkhg68GDh0Wce+xed+iNMKZFBwlK41nTF9d2TZjgUJ
         aldUKHVkhHeN6Nerz2sddrokngmpdNpaBg9uJ7nnMKpkYKiaf+YDjlmsjdZQi1oj6G2G
         wYv0xYVNeqJnk+8jy2/tI+F/Uf23bRB4lKY1n/xrBZ1EaZX6HA4T4+mGuhsu588GxfHs
         G7IMxmuYmHXtulbfsbePTS+8kfvl6V6Cuj67Q5ntn4OlPJ7HDbi4FU/sk89bm7+7MDgD
         /PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZzKSZv5O8h9jfyAeawQu6Dcrc3fav1gznXiBqvBhNM=;
        b=bSSxnBOrJHJm240ERfaBWVwkskHxhXafHwueusNz3AvQGgm5JmxoWfpvntWPWsGkUD
         sERpIHqcl75rrI4R8VxoR9ALnrIlvOYa/fEFWGzq1DLEuL6qiugHvT3Be8w/iFNGbK57
         NUHmNZR5Z9JTPgDigW7GoQD5niqhdMhE2t8lwZW+weYyPsHE6trg4Ry3JPXQebjba28u
         mfk1ipuv0NcuKHU6p/K6QZ9HB3QK6xTFE+FiZmxdeC1C+gBxx44mB//BRcKpdwKx9tRh
         o+T33FygqTESCmMi3NXABcDwlYhwAfdNClNzGRoqz1TifUr1khDwLekJCtbFZt6UUm/u
         lEAw==
X-Gm-Message-State: AOAM5316oEdPKPC5pilLsTNwPrVcdzZmZ/7LB0Mi6CcmSjBQ3spr3vw0
        z3kN14x5Z9sm/pPetj/7oHw=
X-Google-Smtp-Source: ABdhPJzP79t3qgXyH5cuJVLE89ZGPSjw+NNVs9qtLS4c4n7YOAkhrXn6pkQKRGGHwtBj2y/3hQEopw==
X-Received: by 2002:a17:90a:2e16:: with SMTP id q22mr16569701pjd.156.1636710127636;
        Fri, 12 Nov 2021 01:42:07 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:42:07 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 5/6] object-store.h: add write_loose_object()
Date:   Fri, 12 Nov 2021 17:40:09 +0800
Message-Id: <20211112094010.73468-5-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

For large loose object files, that should be possible to stream it
direct to disk with "write_loose_object()".
Unlike "write_object_file()", you need to implement an "input_stream"
instead of giving void *buf.

Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c  | 8 ++++----
 object-store.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index e333448c54..60eb29db97 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1878,10 +1878,10 @@ static const char *read_input_stream_from_buffer(void *data, unsigned long *len)
 	return input->buf;
 }
 
-static int write_loose_object(const struct object_id *oid, char *hdr,
-			      int hdrlen, struct input_stream *in_stream,
-			      int dry_run,
-			      time_t mtime, unsigned flags)
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       int dry_run,
+		       time_t mtime, unsigned flags)
 {
 	int fd, ret = 0;
 	unsigned char compressed[4096];
diff --git a/object-store.h b/object-store.h
index f1b67e9100..f6faa8d6d3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -228,6 +228,11 @@ int hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		     unsigned long len, const char *type,
 		     struct object_id *oid);
 
+int write_loose_object(const struct object_id *oid, char *hdr,
+		       int hdrlen, struct input_stream *in_stream,
+		       int dry_run,
+		       time_t mtime, unsigned flags);
+
 int write_object_file_flags(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid,
 			    unsigned flags);
-- 
2.33.1.44.g9344627884.agit.6.5.4


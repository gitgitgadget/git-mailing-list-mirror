Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C37E94133
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjJFWB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJFWB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:01:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB28BF
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:01:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65b0c9fb673so13711416d6.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696629714; x=1697234514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eTbKEnYSDWnQAp/MCV495EbAoblSj6tsRoXYxx8eTA=;
        b=CbQV3v2LImOnbb4/HwA2Z1ci3z86EWmGIT3+VhuDWBnN/ZMZ3LPugQOmGShyopSSOx
         FeO6Vr4rQBNOAoP9NnZfU8eUW/zpcza4dJYLBdfr1svp7q4lZ7KzLkRhkzOrwmniGuz6
         OqFE1xkrFiX67cn1dQfybiVi9JYctG+X5EeBvWXAUZwsw0gz1Kgc4U4klQW4fCPcfE10
         FmA8LqnbtyhRJrXxhCeVF7euT8A2ben01clQS5PpEfm+RyDjTQzJnoyzRWjCz4bvai4d
         MyhxXU77ztphbZP5YKj/EUxSeVCYjiX2Zjr43CISL8ZfO6XD5b1jvcj6Kq2NnpuaHkib
         h0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696629714; x=1697234514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eTbKEnYSDWnQAp/MCV495EbAoblSj6tsRoXYxx8eTA=;
        b=OrHbRuKXF08qjeWINtuqgPEq7y5DGmkz9sWuiYRb8R59DoOVCAJGi92Lx9+mzPb617
         +bRPw9vZbJzE/6Tfc/khku+BtbTx6HUykJdUhrd6lHWhX3HVBTuj+OgW1X9JRYu0wf9T
         /skeG14N8eRECvA68RWULGuERiWXmzLuIILUwfRuD6mrX/jLLhA4GudCW/6JembmuGXc
         6qywT2JYKFEpzSgSSk9ZvtupUn55WeVfSMcBzATzeMC0y1sXAqyUKstv6MOe+7hujfE2
         1Fz2lsdxHmfP47Ea5QJOfeRfnmnlWrwbQ8/jrqpP9WyGIJpcrX9WPPdWOy31ScOMzkiZ
         d7Tg==
X-Gm-Message-State: AOJu0Yz4SJeEu7xX0WnaIpwFn0sNNiPwkdgOqJKz/b+6seaRkb6FVgOn
        BViyFjwcSnbxMmfuFVI2E2ZBhqMmvwvZjXB5FugYFA==
X-Google-Smtp-Source: AGHT+IFhhPL5IeOT6a5P+Z2xa2DHMP9QDtH06CpfxceSJGthVYFR33I6/BUPcUab6s6RPNubtu21oA==
X-Received: by 2002:a0c:dd90:0:b0:65b:177b:a430 with SMTP id v16-20020a0cdd90000000b0065b177ba430mr9894044qvk.47.1696629714281;
        Fri, 06 Oct 2023 15:01:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x20-20020a0cda14000000b0064f53943626sm1697966qvj.89.2023.10.06.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:01:54 -0700 (PDT)
Date:   Fri, 6 Oct 2023 18:01:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] bulk-checkin: factor out `prepare_checkpoint()`
Message-ID: <9cc1f3014abe7fec997a99b6ac93d8ebb5455fa6.1696629697.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696629697.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as the previous commit, factor out the routine to
prepare streaming into a bulk-checkin pack into its own function. Unlike
the previous patch, this is a verbatim copy and paste.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bulk-checkin.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0aac3dfe31..377c41f3ad 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -260,6 +260,19 @@ static void format_object_header_hash(const struct git_hash_algo *algop,
 	algop->update_fn(ctx, header, header_len);
 }
 
+static void prepare_checkpoint(struct bulk_checkin_packfile *state,
+			       struct hashfile_checkpoint *checkpoint,
+			       struct pack_idx_entry *idx,
+			       unsigned flags)
+{
+	prepare_to_stream(state, flags);
+	if (idx) {
+		hashfile_checkpoint(state->f, checkpoint);
+		idx->offset = state->offset;
+		crc32_begin(state->f);
+	}
+}
+
 static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				struct object_id *result_oid,
 				int fd, size_t size,
@@ -283,12 +296,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	already_hashed_to = 0;
 
 	while (1) {
-		prepare_to_stream(state, flags);
-		if (idx) {
-			hashfile_checkpoint(state->f, &checkpoint);
-			idx->offset = state->offset;
-			crc32_begin(state->f);
-		}
+		prepare_checkpoint(state, &checkpoint, idx, flags);
 		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
 					 fd, size, path, flags))
 			break;
-- 
2.42.0.8.g7a7e1e881e.dirty


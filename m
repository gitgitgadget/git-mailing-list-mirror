Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341DC07E9E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36322613B9
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhGJNkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhGJNk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61275C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o22so8073770wms.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LsBWol6+Hg8fOUR73ix2I7C0wS0aT2ZWxxwIiWuxig=;
        b=e9vi1gRpGgkojfmfBFelwGz4O961MMAInBXjm1ZvV92tvwWW9oxv7qFuVd2LGuK+tN
         hfL+QN/6hfT/IthJlN6ggUdmDEQumwDwmdWsHQjz+vYZHOzkx/GqIU3abWawdOA2Wodu
         DivbXUu6LIpHLLI6soOWYN9c8jkslX0kOpPucNTrfZh939wU75wDCpKR0IaQV99/UThu
         nZ40fJfYKAL6HDo3xKenV20UtIe3ZfuvlMglxN3AjpiuqiDL+8kTa/6QK8m4pqDtOYnj
         DkZcuUIVSMJDwbMYGD8zuGSqiBAp/eBf+TZGmmRNFAWyhTa8aQN6JXGmrWK5XWsjm+1G
         VL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LsBWol6+Hg8fOUR73ix2I7C0wS0aT2ZWxxwIiWuxig=;
        b=VqRaWmtL1/qPvpsiw/Xz7a82giOuI6uchmrhAEX8A7swD4zDCQigtQ3OcbddgKmvLz
         c/kel0pZF9C9/Y7c90nawRiB2xJjlgBh2uYhDCO1DtpvGMuog0UxPD7xhv5CZ0ZD0HK5
         I6A/4Cvjhzj/cMA7Ziypva94zAgwa1ijMcf4vm15iXLT/jLiofc28btW+Dk7cdLOGhrp
         c8oKymmRtXtJAI8KajpDxlFmYm23ez6FK/owsOgPl7xlE80n5pRedf3Bzzy0ccquF6UA
         PcD8vDX89Pc5/wIWqkZkjQgsxVnRtnjwSAl77gjunIsbzxx1Ekkvn1xLX3ryPih1tvgk
         1uhw==
X-Gm-Message-State: AOAM5315qR4+EC45sH9RrbNTySoeqJCsffA5dXs4K5SBWb+Uk/5jjEbz
        Qh1U5TEyBkjMCzBMlnjX+n4yvAlMSJKBzg==
X-Google-Smtp-Source: ABdhPJwdqF+a4/DzzuK6OcRRtx2UYlbWXr/dapbBoRnyEew8BMobbtK+dzc4OZpvKy71ZB9HN0kRtA==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr28472988wml.168.1625924261801;
        Sat, 10 Jul 2021 06:37:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/21] object-file.c: guard against future bugs in loose_object_info()
Date:   Sat, 10 Jul 2021 15:37:18 +0200
Message-Id: <patch-15.21-13d4141a21b-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier version of the preceding commit had a subtle bug where our
"type_scratch" (later assigned to "oi->typep") would be uninitialized
and used in the "!allow_unknown" case, at which point it would contain
a nonsensical value if we'd failed to call parse_loose_header().

The preceding commit introduced "parsed_header" variable to check for
this case, but I think we can do better, let's carry a "oi_header"
variable initially set to NULL, and only set it to "oi" once we're
past parse_loose_header().

This is functionally the same thing, but hopefully makes it even more
obvious in the future that we must not access the "typep" and
"sizep" (or "type_name") unless parse_loose_header() succeeds, but
that accessing other fields set earlier (such as the "disk_sizep" set
earlier) is OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 31263335af9..d41f444e6cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1393,7 +1393,7 @@ static int loose_object_info(struct repository *r,
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
 	enum object_type type_scratch;
-	int parsed_header = 0;
+	struct object_info *oi_header = NULL;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1441,18 +1441,20 @@ static int loose_object_info(struct repository *r,
 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
 			/*
 			 * oi->{sizep,typep} are meaningless unless
-			 * parse_loose_header() returns >= 0.
+			 * parse_loose_header() returns >= 0. Let's
+			 * access them as "oi_header" (just an alias
+			 * for "oi") below to make that intent clear.
 			 */
-			parsed_header = 1;
+			oi_header = oi;
 		else
 			status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
-	if (!allow_unknown && parsed_header && *oi->typep < 0)
+	if (!allow_unknown && oi_header && *oi_header->typep < 0)
 		die(_("invalid object type"));
 
-	if (parsed_header && oi->contentp) {
+	if (oi_header && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
-						  *oi->sizep, oid);
+						  *oi_header->sizep, oid);
 		if (!*oi->contentp) {
 			git_inflate_end(&stream);
 			status = -1;
-- 
2.32.0.636.g43e71d69cff


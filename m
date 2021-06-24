Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC4C49EA7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9E6610C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhFXT1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhFXT0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183BC061756
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so6959931wme.3
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufzbliajM7KlKQ4cOrixx+YKlorU02nkRazDKN1Yykk=;
        b=LROzoeD9bmU+pLB5XuL/DJk8hEHZehDl527gpg/dWsKKIOnHJAwuf14T9FxMxoMe3h
         j9+2t1plDuYScgXI/VwViQMWVoi1L9evUGJIlLIbSHDiWuuU6AUuVQrBuXSsWoTFZG7Q
         ZzZ33HLuilndEoAIDrm60PmoKB9zQZxmQs3wMEnzLJ+RqvjjNSpqWLqWJ1AHFtbCGm70
         JvAJOwvxLkWStOdj5rFtDenk0ZT53PDfcEyn36OBvxbN+ady5Js9vfgJ27/mT0q8Y8Yr
         CU2j+eTf6/zjzbCChtCTgEgO04oSSStOcZjAHeueVVNnx/LhioGXKj1p0MU8O+LxbtzU
         c8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufzbliajM7KlKQ4cOrixx+YKlorU02nkRazDKN1Yykk=;
        b=iirOv2lr9akHnqynMnAh88ZT9R4bbK4ibCqUHSLL7A7oQvhshHK7jfAxg9GH0/LTUn
         K0wMYPtQrDJPu4IuGcApcmJRcygrvLDPmNI738fIkDz/oL2jzcY1WVdQN3v8qPO4HQ/x
         tNf7oLJH4iW/1/iAPqo8UVmSuSUQCnQpufAOgdihJl4yYP1VJ7kVBYMPnSSVof+IYdbS
         WCqawHDg/mhyhJ9XvxG+cIeXOROYeGppPIcsJMxCqkHTm4bWzHNhDyz/4xKg83GfAIEn
         Vz/VZK61pyRXNJOulBSJGkPu4HQcpCrr4dSjUhaQi6xKE/jflVwnDgN/YJxZqpyLcRhM
         RbQQ==
X-Gm-Message-State: AOAM532i83AU0lDP9m1S9U03HAT2X4ZM+pEoPa8/6IPO0O16h9H2mMFb
        62T/Zksg8KRcsXruAFiPlHJSg2I/8HTg9A==
X-Google-Smtp-Source: ABdhPJwOyvRuclOIpbHKW1hZArQa5t/ZjetycWKK8HBgNW8wV3Ps83UkFGKsL+A63ecpMcbn0TTrDA==
X-Received: by 2002:a05:600c:19d3:: with SMTP id u19mr6222212wmq.100.1624562657280;
        Thu, 24 Jun 2021 12:24:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/21] object-file.c: guard against future bugs in loose_object_info()
Date:   Thu, 24 Jun 2021 21:23:53 +0200
Message-Id: <patch-15.21-aacef784eab-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
2.32.0.606.g2e440ee2c94


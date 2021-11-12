Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C7C433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B6060F6B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhKLWX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbhKLWXw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0FC061203
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:21:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso5729474wmr.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga+2W/G685Y7M+GQDhpSMR2hp41krOck1KJMfEbKrjk=;
        b=byj+Gs6QI7UYxFZfX8VX3DvorFe691ZmV2ygVMqFypYft1FRL7P6IUDeGM8Ekun9k8
         JpQPzZ5cogI5zUod86TvKknB+XdWZlrn50WNMCyGc0TfQXcjQMh3y2S16GFjfA0TQYtI
         VAo1y79q1M+4TVgDdnwb6D7vYBZXnQkRnMSya4LMzHJ5meKG+VX3wEZtGf8smg0Djyrc
         +gQiA16sqevjPVFa6sxTzYdTPIlRxGktaG6shiofWeTJvs44VDS0/If1fwpeMnKMQQzY
         vggk/23zkTjGblpRunc+FEFegUgazRcnhvVM0QqmrXmRNYJaHYhKQH4QM0QEJrLTulqm
         Isfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga+2W/G685Y7M+GQDhpSMR2hp41krOck1KJMfEbKrjk=;
        b=wGoJff/dYAmHHvlt/oteeqsE5ANliZM5XQWQ4Idv0HdovfJVFoArq0vtdLCCKDPC4O
         W57B2h8MbhMSPjiQHKr4X5to21GSFJlq+Yar/2k5roif/NF28IlG7jjcIk5NOEAf/8Lr
         Jg+HuXzJQulCkjTTjy2d5y7peFlLlqk1a+WC+tcjEWVakoxh8IgmAn8gpGg2XN42GCPi
         kvtdB/HPf2w43bCjvQuBlXQ4Fl/CYVcZbCdVEgwA5iaydShK7bPUbjyj7MWHQdq5mT1d
         Vdl7OT5CZeb+HvrewCEy9drTBnUR9/nJXUoTY65ha4Kup2TIIlQN8jnGVVvk1RPAuz37
         P/6A==
X-Gm-Message-State: AOAM530aCWAWySl+20GPbkOq4MeuKj10OLnOglSYCgGPv0T4JY06EzYv
        NSPFRR+jvdyltmr9L4HVQ1XwnQPX7taMxA==
X-Google-Smtp-Source: ABdhPJxJ9PnO8qkH3bx0obiow3eHoK1saiWuF2tAraqV1/MrdoeMYzbyBDmtgURv75qBs9CQiC48yQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr20520243wms.81.1636755659048;
        Fri, 12 Nov 2021 14:20:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Fri, 12 Nov 2021 23:20:07 +0100
Message-Id: <patch-v2-09.10-6642b57c6fe-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop having GET_OID_ONLY_TO_DIE imply GET_OID_QUIETLY in
get_oid_with_context_1().

The *_DIE flag was added in 33bd598c390 (sha1_name.c: teach lookup
context to get_sha1_with_context(), 2012-07-02), and then later
tweaked in 7243ffdd78d (get_sha1: avoid repeating ourselves via
ONLY_TO_DIE, 2016-09-26).

Everything in that commit makes sense, but only for callers that
expect to fail in an initial call to get_oid_with_context_1(), e.g. as
"git show 0017" does via handle_revision_arg(), and then would like to
call get_oid_with_context_1() again via this
maybe_die_on_misspelt_object_name() function.

In the subsequent commit we'll add a new caller that expects to call
this only once, but who would still like to have all the error
messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
regular errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..d44a8f3a7ca 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1795,9 +1795,6 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	const char *cp;
 	int only_to_die = flags & GET_OID_ONLY_TO_DIE;
 
-	if (only_to_die)
-		flags |= GET_OID_QUIETLY;
-
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
@@ -1932,7 +1929,7 @@ void maybe_die_on_misspelt_object_name(struct repository *r,
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE | GET_OID_QUIETLY,
 			       prefix, &oid, &oc);
 }
 
-- 
2.34.0.rc2.795.g926201d1cc8


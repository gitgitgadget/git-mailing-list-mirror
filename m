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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A8C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A719600CD
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhGZXEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhGZXEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D9C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so1081298wmq.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+CvTZLf7aDDfTGU5YGydguI2YFS+ZhRmZGRIYFq17M=;
        b=hHAzd/WNjyxkARufP9z6xFc3crDkUiCll7LB0n7bHmWs4uoWWtS5/d6U9wRFNCO0pf
         2sXlbdrNjqQRe3ioHqoFUqst3iOq/zPwxVNVAmHj3S8NYZmD+EcxOwS9jugViYmvMYTw
         kIbD9Zof4QbeC1R0zMHrqZUngavPDtOLT0cVkLZnWAKjcEiKi/XmmAqPsVmV7h88be8l
         TzKJ9XN6+8SAi5pfgQqlZYfxuTqlDsMWfnFhxkdarFpPStVPGQqFYEk3uPN6I2b45lJw
         qYvqgswqKlY3YMnlptGbhp5McmxzbQnBssTmnnKNOTfktgl6zUPdBeDTWgFagBM9dZ53
         GsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+CvTZLf7aDDfTGU5YGydguI2YFS+ZhRmZGRIYFq17M=;
        b=HEUDGlrZyP4WA2AsDrULgQ9OqcEk+742g2P3KLrFHL+atagaq7ISMy9uW2yHnwm5pl
         GPFA718XGiKHc31/PmBh9G3WKfmo0DV8Dg5rXbg6ubvCjzDjCj1t5SxENwSjAG1SS2sM
         6Jj6cdmWW6n73ihqrU2qRWJEqJpMP0zdhNTKVSBkR3HqJHVlban1HkBsybhHbjqBwM1B
         yCfHdUfiulY2o2DOQoumIumg2G2veZjE4WxRdSy2IeR5Tpd16eIzBJc2cERFeRlyJCVl
         je1Y+9nTJvXqYmIBRGOKigK3UlXJzetV2lajjskBah33CBhN/FZPeJaw5JJbZmC7uhhK
         eTCw==
X-Gm-Message-State: AOAM530BuAqtFjrutiSWdBH6IMfm9zXkOPEscIDBQ6IeJIOHAyp8hZzw
        JLaLazVq0teD9Q+spz/qEIucWTN8uHLvjA==
X-Google-Smtp-Source: ABdhPJzE9UCv8e833LnaCKzg11yAJ9w9rF3EAVnEZPNT43ylCrZKHC0R77Kl6BlNw7oHwCU8PI8HFg==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr1188526wmi.67.1627343079988;
        Mon, 26 Jul 2021 16:44:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/11] refs/files: remove unused "errno != ENOTDIR" condition
Date:   Tue, 27 Jul 2021 01:44:27 +0200
Message-Id: <patch-11.11-acb131cc1c-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to the preceding commit where we removed the adjacent
"errno == EISDIR" condition in the same function, remove the
"last_errno != ENOTDIR" condition here.

It's not possible for us to hit this condition added in
5b2d8d6f218 (lock_ref_sha1_basic(): improve diagnostics for ref D/F
conflicts, 2015-05-11). Since a1c1d8170db (refs_resolve_ref_unsafe:
handle d/f conflicts for writes, 2017-10-06) we've explicitly caught
these in refs_resolve_ref_unsafe() before returning NULL:

	if (errno != ENOENT &&
	    errno != EISDIR &&
	    errno != ENOTDIR)
		return NULL;

We'd then always return the refname from refs_resolve_ref_unsafe()
even if we were in a broken state as explained in the preceding
commit. The elided context here is a call to refs_resolve_ref_unsafe().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 28cd8853f5..5d12003471 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -894,8 +894,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 				     RESOLVE_REF_NO_RECURSE,
 				     &lock->old_oid, type)) {
 		last_errno = errno;
-		if (last_errno != ENOTDIR ||
-		    !refs_verify_refname_available(&refs->base, refname,
+		if (!refs_verify_refname_available(&refs->base, refname,
 						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
-- 
2.32.0.956.g6b0c84ceda8


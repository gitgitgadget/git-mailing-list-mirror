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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2437EC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E09E61361
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhHWLh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhHWLhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2FCC061760
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so13848098wme.1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvPGQ33S4qFAznPr6D20ZOrMiJZvRBK5c5WslOpBaEM=;
        b=VsejhdZtaA0BY56UKUZZTq6g+Rky4piqS+z8D3+wmFjWlntkm4fY+j2aC7nVSSDcZz
         JkWxmeHZNZnWFVR5+C4Ax7BokNsKg4H26K75o90O83+gOoBP9hr6PxNEh37VN+sSnkfA
         AcRF5KR2qGuj6oGFexigbQfa4g4eGVqgxXD+nbGirgZPtfpKagPSV68APTFV5LYxIsES
         wr5jHafklGMdtf6AC65Ivc7gFIMiUInXbCybqXK6RHpjLYmkSVg0P1O7iB5qAdtCPP58
         VYAPN1LDbyPmw2+0O+SMIRtkiuWgJP+enGgHHxin1R1J1NmHS9Ie6EBD1qAC4cfu/Zay
         vI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvPGQ33S4qFAznPr6D20ZOrMiJZvRBK5c5WslOpBaEM=;
        b=be9j3jnMSYbTUiLXWOOkrJTgKXBg3esDAF5mTUzJdmIhocGUtCNwLQy3ywZ2YJ6t1C
         Ig7x5i7q1eL6JzxHh05YBjLRqqFyQa2km8/6BYgQCR9NGZJpuXMAKODOKl0S7tQV3DTy
         rQ58zvWIa43CVb8wTLTGnTwQroXmEnJ/IkG0mZKk1fDWkDYWz/2ZquJzpemm1l+k05FY
         i1myFn5h6omSfp+W4RPPHDxF0UNF2udAEwJzC+81A5w5tO7L+tbxWNJpzLZ3S9xWLmK/
         q1qKnFMlkScmLP4AEs3YoJ3PBLll3OCxX9FJlt8SJJdLOKmez/USCZUoJgWDLgGEs8qd
         /vZQ==
X-Gm-Message-State: AOAM532Q2bESncX8vI1Lb9GOoqo+48HIGdHGzVDvG6vbjAZGgtodgBMk
        K4dU4or/1NgBprp1Oa4nzjgtbIqunXIJ0Lhf
X-Google-Smtp-Source: ABdhPJwfQ6DMVzqnUYt2caDmhG2dXi/hitxA74FETRFPll2scr/F6nEIVDKFFidwNT/kpvNOLbW55A==
X-Received: by 2002:a1c:ed13:: with SMTP id l19mr16052813wmh.48.1629718587593;
        Mon, 23 Aug 2021 04:36:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/13] refs/files: remove unused "errno != ENOTDIR" condition
Date:   Mon, 23 Aug 2021 13:36:14 +0200
Message-Id: <patch-v5-13.13-2e30ee04edb-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
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
index bed2ab25c3a..ab666af4b75 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -893,8 +893,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
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
2.33.0.662.g438caf9576d


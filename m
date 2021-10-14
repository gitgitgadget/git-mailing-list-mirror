Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1082C433FE
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A2161164
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhJNAIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNAIq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:08:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E1C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r10so13703614wra.12
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSMzc+cuX/2Zad5LAVhzbvvAM3bkvavdRPxJJTEKn+0=;
        b=bRaD6MGKfSrRJL8qmGa4IGU8Dzo9HgNJcgIn/GWQptJnvmarbQWyECn0Ul2iqLsIMd
         5wVVD6m+AQ8tId+CMYVetmUvuSyEItLiLoAjN4aGp/yF2SW0KcNK7BwrzOP9wAMuqkYx
         Mo95XLI+ehcTg3+Ta8txcgHiS8VbhgiKG6Him8/XeEOiAOkJ579yXUiYukoUKoWdDdoN
         M1YA8uatJ+wlN7wq4cdCuoazUwWa7QOC5f+f8YVCKw1H4bpTI/uvBBjLrMqAIh3j25Du
         YLfXBYTLl6c9sLCjYx6uf0Yar3MOtdy5P4sAOlbOtQGE5sloUUYrOuMmJcoCkYsf6f81
         MJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSMzc+cuX/2Zad5LAVhzbvvAM3bkvavdRPxJJTEKn+0=;
        b=oWPsalCnURDYaIv1ybQ3ANz23rUW7n12EArPU33Vn7Hjg2pP2qOhUvSA/dfkKu18sP
         GnC4tiWfaM6PO0DGSQxMrSpR+wFnScxrpqIFC9VwF7hdiy1DDZl8pHe3VsndwjngQdtp
         ZgnPZcXGR6R7QtwavUbj7qNHcE7QOF6TqbUGOqP7gQ4qaaWFGUWWLZ+rZF6FHVU+y9/s
         bn5jm489VZ3caPfE33uGghZ/M6pMUrp0+4iKkYm5xIw5FAQFmIIuJw5VOw5IKQuRaTnV
         yyLXNKcyQIfrEhirIGq/dsYbuFZ/Q8YO1hdDZyxqLQaDD0p0QnrdrCSNzUM7HqtIFLCO
         M57A==
X-Gm-Message-State: AOAM530ePLzKy+jy2356hikQjqPvF61yZhvUOQecwAg/7cR/SG0VN4LA
        jvFthmmj7LXB1XSYTnw0NE7lsUv/V9jTGg==
X-Google-Smtp-Source: ABdhPJxQBddc2fmdtsif3LvXx48sMjAi9lfNfMHhepVr+9qsKOrh5Ktmg2kIy4/FjXW5lrkwRrfNjg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr2590946wrc.209.1634170000883;
        Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/20] refs API: make resolve_gitlink_ref() not set errno
Date:   Thu, 14 Oct 2021 02:06:20 +0200
Message-Id: <patch-08.20-acb484ea547-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have carefully read the upstream callers of resolve_gitlink_ref()
and determined that they don't care about errno.

So let's move away from the errno-setting refs_resolve_ref_unsafe()
wrapper to refs_werrres_ref_unsafe(), and explicitly ignore the errno
it sets for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 08101a13318..001f54845a7 100644
--- a/refs.c
+++ b/refs.c
@@ -1790,14 +1790,15 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 {
 	struct ref_store *refs;
 	int flags;
+	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
-	    is_null_oid(oid))
+	if (!refs_werrres_ref_unsafe(refs, refname, 0, oid, &flags,
+				     &ignore_errno) || is_null_oid(oid))
 		return -1;
 	return 0;
 }
-- 
2.33.1.1346.g48288c3c089


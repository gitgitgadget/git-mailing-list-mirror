Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C692C4727E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6172223600
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twprkCyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWJjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIWJi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:38:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17AC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so2877350pjr.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKUQW6AJ67TDxeKFE8lBYlSpxope2iA8F8Iyakiw5L8=;
        b=twprkCyr64UiFz9mnWJUbN15wazHKAhU9aCbH8gQcyiUG81ULoPkAAimSRMzjZICok
         RSq4x/QzFF4eF1CDciZxQjiVBvggxD3aGSQszs22lHc56BMQa3D9iv1939F6DVeWl9Dk
         fxT/m3NbJI8yaD159mwbR5DTmxQA38rHdTTYVMw64slCW0v1xPF/Ku2lER8nGY5RjA58
         L3ZZ8pR/5PK0FNhnOB6L0uM4GFk+gfWVRhVysxKeoO9E4NHrqItrBQYKyG/UK9xDTUDt
         JeGQPxv1bpLn9tbzGE61zVu3jB44wbBb2oAORXS0a0R4quLKYRzOdIgssIIjrcNuPijp
         NLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKUQW6AJ67TDxeKFE8lBYlSpxope2iA8F8Iyakiw5L8=;
        b=ATzazv1NY8+04kJCrRNHaDmR09iHb83qKNJ28N/Q92+J53JjNc4QM6l0Ln8VE5+d5r
         u4bUHTsOWY+gjr7cTOnRdqYzO5qJyTnW28PqvCD3ludc9HFDX7+yCFqr+hJwgHC4EHy+
         3j8mi8fMi3TTv59OEHOoTIRKjQndu7UOZBNW5h9H4flASHfpEXxkT8AiWfqT2ZTVebYV
         lXDfA9SLUwosMZ/bsGPvTIox5tHvJt6hENd96NSpkKoFDOqlG/516SCkudxl+cIdxLzJ
         DjM1edFtFPH33ME172xaFAkZXA/w+hcHzDLuqjW6IJwLl/uMZNDCsOklWEgYi8Ekqtey
         QnZA==
X-Gm-Message-State: AOAM530mygNcoqtBNbWv5mtgpY/Qri+096q4OMkHjbzylKBQ1YPGTAQ6
        YHemYTh1q3fWynqTJR9WjV7Wi/CBHLA=
X-Google-Smtp-Source: ABdhPJzwhcpihm02wOafPwpxRJaO5bPbL2LecjvYWfFMkXFmJMT6hHblUqtwKv0yQhwu9gmd+M+TXA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr7434258pjb.196.1600853936923;
        Wed, 23 Sep 2020 02:38:56 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gm17sm4564464pjb.46.2020.09.23.02.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:38:56 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2 2/3] hooks--pre-push.sample: use hash-agnostic zero OID
Date:   Wed, 23 Sep 2020 02:38:44 -0700
Message-Id: <afb460d9fd6799f6362455bbe1fe476fabe401d6.1600853895.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600853895.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com> <cover.1600853895.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-push sample hook has the zero OID hardcoded as 40 zeros.
However, with the introduction of SHA-256 support, this assumption no
longer holds true. Replace the hardcoded $z40 with a call to

	git hash-object --stdin </dev/null | tr '[0-9a-f]' '0'

so the sample hook becomes hash-agnostic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--pre-push.sample | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index d0f30190ac..4ce688d32b 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -22,16 +22,16 @@
 remote="$1"
 url="$2"
 
-z40=0000000000000000000000000000000000000000
+zero=$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')
 
 while read local_ref local_oid remote_ref remote_oid
 do
-	if test "$local_oid" = $z40
+	if test "$local_oid" = "$zero"
 	then
 		# Handle delete
 		:
 	else
-		if test "$remote_oid" = $z40
+		if test "$remote_oid" = "$zero"
 		then
 			# New branch, examine all commits
 			range="$local_oid"
-- 
2.28.0.760.g8d73e04208


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96975C4727E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4837E2371F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDsdW0Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWJi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIWJi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:38:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77144C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so3232586pgi.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKj7F5cvjSGHtHmsaLdR4s9zi4yZlEC9oB4QE1NrV+M=;
        b=VDsdW0VoEwBhY6GjI+fQNBl9HXvLVJyHhvH/U+jDyV0Mi8ldEzt+CZMHx4nYwLtgen
         hto6vX2RTS+GvH22CPTvfCgGAFz0tl208vohqMoxVhJGTOjJAaS2FmHoBKjM0BWI7sxo
         UO+DAbgNfxAiQjYM+b6u+VG9AjPW+LD9OduYm06pe6fP4psoD7sFC1HflI2KBkHv4WOK
         WGvsX6LvRXufZbaVzEHe5XOg2r9SZFkqzkqCv0ev1DvHuhCTRCTggFSrUcnANQoUH4sU
         GI3vJpHKfKP4VecgFbhQAi7ZHu0cl5t2woSiVCUaowFdcw9cP4QgBEjPaP7WUG3hoGH8
         p/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKj7F5cvjSGHtHmsaLdR4s9zi4yZlEC9oB4QE1NrV+M=;
        b=RDontc6VIiIMqcq9YUhdU9rPFoP02XLTJvxGhqTKkbulgmxM+L/yYyv6xASIZBxMrH
         wfn9Xs1s3/O8kSA1qyy8n2MbbOuha7S54vO6xxbnfm0xj7LVMDQycFHSmUhd3mt7F5Bg
         TPGUCSUMTl94uayIRhI4I6NC4YseHKKZAYsOCSfB4fKCv3K5DqdFfpePGfJjqmdrv5uo
         diAYrhNjgGjZ3jXDpyePwvtdMQdYdJGvCCJ1bZkdclBXCVi+c2U/ofchUwJmGOIgRY+E
         Ea96+dOdF0+tp1Ei6T21IaM1y/kmLI5HIjTjbfbTuqGywM/DNNbqGkDQV2KmNmjz7A5G
         vNTg==
X-Gm-Message-State: AOAM5339NqiSmtbWA7AC80xGp2Ixk5BmJEs0JxsPP+teEuyL5HK9KVC5
        b38A31aqZN4nvC4mNV1oVXLIYjJTiGc=
X-Google-Smtp-Source: ABdhPJy6SVt6b8C1Gou+3IxE48aNoD2YtMNqfZNsSOBOIbfTZWoSMNwyP49f0gMzsmAtYEjEFKUWog==
X-Received: by 2002:a63:e813:: with SMTP id s19mr7145665pgh.33.1600853935827;
        Wed, 23 Sep 2020 02:38:55 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gm17sm4564464pjb.46.2020.09.23.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:38:55 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2 1/3] hooks--pre-push.sample: modernize script
Date:   Wed, 23 Sep 2020 02:38:43 -0700
Message-Id: <95dd0b19ba45ebe364235fa62e18aad932506fc9.1600853895.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600853895.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com> <cover.1600853895.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The preferred form for a command substitution is $() over ``. Use this
form for the command substitution in the sample hook.

The preferred form for conditional tests is to use `test` over [].
Replace [] with `test`.

Finally, replace all instances of "sha" with "oid".

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--pre-push.sample | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 6187dbf439..d0f30190ac 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -14,7 +14,7 @@
 # Information about the commits which are being pushed is supplied as lines to
 # the standard input in the form:
 #
-#   <local ref> <local sha1> <remote ref> <remote sha1>
+#   <local ref> <local oid> <remote ref> <remote oid>
 #
 # This sample shows how to prevent push of commits where the log message starts
 # with "WIP" (work in progress).
@@ -24,25 +24,25 @@ url="$2"
 
 z40=0000000000000000000000000000000000000000
 
-while read local_ref local_sha remote_ref remote_sha
+while read local_ref local_oid remote_ref remote_oid
 do
-	if [ "$local_sha" = $z40 ]
+	if test "$local_oid" = $z40
 	then
 		# Handle delete
 		:
 	else
-		if [ "$remote_sha" = $z40 ]
+		if test "$remote_oid" = $z40
 		then
 			# New branch, examine all commits
-			range="$local_sha"
+			range="$local_oid"
 		else
 			# Update to existing branch, examine new commits
-			range="$remote_sha..$local_sha"
+			range="$remote_oid..$local_oid"
 		fi
 
 		# Check for WIP commit
-		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
-		if [ -n "$commit" ]
+		commit=$(git rev-list -n 1 --grep '^WIP' "$range")
+		if test -n "$commit"
 		then
 			echo >&2 "Found WIP commit in $local_ref, not pushing"
 			exit 1
-- 
2.28.0.760.g8d73e04208


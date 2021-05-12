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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594AAC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249A0613DE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhELNtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhELNto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:49:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03526C0613ED
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so2543399wmk.1
        for <git@vger.kernel.org>; Wed, 12 May 2021 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzgXaOSgbNa3QKXHq8bVYuSR2MqEUvSitTGyZKnMsYk=;
        b=TBvtvckpivYaY2nS6yqo/X7fqmYlAxbul79oViRaopDG7LRWn6QG+HYxItUrKXE1iT
         B3AQSv4OERx1kR7fGXmv5MOSjDQdmDR0BEmxGub7Z+mcbRkHhBn91NjMGN02h2SzEE22
         zFLXOjipcisg1EBhpjd9kBSMW+ol6bbH2JjTw4JI2bsqpzyS71RStnIDHwyP01AZokR4
         llVxYSW5MvzPGwUQ5PqcUXcaWD4wJQwbgc0a4RTjROWbDg1iI45yneIwU2t4ShwEuoHN
         OrcuID5/+2pMj8l6uHfUcZ7qH25FZzb6vzUEop31VcLWCFh/Fug+mJ6JZrrL30azzflx
         1fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzgXaOSgbNa3QKXHq8bVYuSR2MqEUvSitTGyZKnMsYk=;
        b=Y8uRxlvAh51uwUHfauylB8E9H/AGPywVn7olxScoCjJ3bf0xUJxOpfVEIUGkaLlwQB
         GaXowAVbfIxeMFQ1wIH0fe+ojZ70tz/mmICyKx+BOoJVP/2rJDn9GOUx7n5FpzLS1fFM
         GXzDh8Rti4v8H8Is+BApjtGxNjjXETp3MHfBs4ZM1IfET/e0A+cRp0asZaCknhRCUCqm
         5I+pNxGD5NTkvLJzMWEqlKI2O7+Fh6m89v6gIna66YOl85/hGe5vxIR06PeYlEM99afD
         zdlldDYF12sEKCiM7Npna6TmGrYXz//RepehLUz2r04GS6fa0eYqfVx1X8Tq4+KUFznl
         hU4w==
X-Gm-Message-State: AOAM5332tTTISNH+pklSnNKMGIe02T1ko2vZDFEEngrTHLBAFQnx/2aj
        u6aZ80DmV2222SaWbmbuY8lklQlxYUrUUA==
X-Google-Smtp-Source: ABdhPJxlO+1qkroDJCCksAqruhrQFVFA3pm0qYtOBfFqi3cEzFJGS5cm16BvuYzzOhZ26Az1i+KVKg==
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr8691319wmf.96.1620827312459;
        Wed, 12 May 2021 06:48:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm31416612wmb.32.2021.05.12.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:48:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/9] send-email: get rid of indirect object syntax
Date:   Wed, 12 May 2021 15:48:22 +0200
Message-Id: <patch-6.9-0dde0e14ef-20210512T132955Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.909.g789bb6d90e
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change indirect object syntax such as "new X ARGS" to
"X->new(ARGS)". This allows perl to see what "new" is at compile-time
without having loaded Term::ReadLine. This doesn't matter now, but
will in a subsequent commit when we start lazily loading it.

Let's do the same for the adjacent "FakeTerm" package for consistency,
even though we're not going to conditionally load it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index da46925aa0..f9c780ceed 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -194,11 +194,11 @@ sub format_2822_time {
 my @repo = $repo ? ($repo) : ();
 my $term = eval {
 	$ENV{"GIT_SEND_EMAIL_NOTTY"}
-		? new Term::ReadLine 'git-send-email', \*STDIN, \*STDOUT
-		: new Term::ReadLine 'git-send-email';
+		? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
+		: Term::ReadLine->new('git-send-email');
 };
 if ($@) {
-	$term = new FakeTerm "$@: going non-interactive";
+	$term = FakeTerm->new("$@: going non-interactive");
 }
 
 # Behavior modification variables
-- 
2.31.1.909.g789bb6d90e


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE48208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbdHPB1r (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:27:47 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33424 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdHPB1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:27:45 -0400
Received: by mail-pg0-f52.google.com with SMTP id u5so16132687pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=l5FzkglpZHQ00zQr0RMXZdJ6SQ7/iwXhviIZLbpgLFR7sWc+CXgcvn7xScxiBvgsFA
         fWcBf5BqWTvTDIw2z1Xp6cs/3X/uJx004qgwCV805sB0hP+PvcjBPj4GjCN6fspv0rXg
         tbaKQpSaEFm7xwmN0qY09PA+fJhGbCVC0cvKKkFx4/gMFnb0bKO6pvYJ2SCQr1evFiOl
         d5nXA0PLF01yUK64ItD5pO1WxggwbdA3/iXgfvE3MIrC6sfVJaFIJ1u/XAOiBjMS2aan
         Uz9igrE1npTwGGb3OiPieRJglK8Puqj1vJFmLNx07wZTP3bYIf0KYyUMuT630bHF8LrE
         uPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VSxurodUKrct9oajmcrb/ADgbGkXeTEq4j6YCSVl7IM=;
        b=nuDDwP/c623uarxN4/k8Vxy2LKAVIP517t6NGaKLO0PWLmsVKju/dPF0GyaHaLADft
         6iZpGa/lxe9nSEL97EZDX+Z6ePI7GsTkSARObZa62zImYndtL6lVLDHfjDsPd4ykh3hM
         AZPV+1JoqX66L6kduCyzgBSkN/p/qKdnyBGC2nV+3we3e/CctM7XJHzebz+NlYs9aHs/
         welpCTkWhs6oXVRPXmJIWf0oM2uzgDel6MCSwWGYLIFdAxQ+sqEDzx5KJf6MYdX4ce8L
         Q2/GA+oUMZUsmM+v75S1EzW8lkbW+I43k5Kxvxt30CBhH2jMotux7YNiAkK0BjikDxSZ
         FJcw==
X-Gm-Message-State: AHYfb5gyruirh7cp2Yg1UERuEEqDgqicbdQWNJTGJr2mAqNZnITULRcI
        L9+MAC3Oj4jUyRAMVSe6iA==
X-Received: by 10.84.229.130 with SMTP id c2mr69044plk.215.1502846864090;
        Tue, 15 Aug 2017 18:27:44 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k8sm621845pgf.33.2017.08.15.18.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 18:27:42 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 1/3] diff: avoid redundantly clearing a flag
Date:   Tue, 15 Aug 2017 18:27:37 -0700
Message-Id: <d199b62322a29e55a8ae21636aa7076231352ad7.1502846454.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502846454.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502846454.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code in diff.c sets DIFF_SYMBOL_MOVED_LINE except in
mark_color_as_moved(), so it is redundant to clear it for the current
line. Therefore, clear it only for previous lines.

This makes a refactoring in a subsequent patch easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 4af73a7e0..23311f9c0 100644
--- a/diff.c
+++ b/diff.c
@@ -898,7 +898,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
 			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 0; i < block_length + 1; i++) {
+				for (i = 1; i < block_length + 1; i++) {
 					l = &o->emitted_symbols->buf[n - i];
 					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
 				}
-- 
2.14.1.480.gb18f417b89-goog


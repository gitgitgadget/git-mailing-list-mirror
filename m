Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7F020899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbdHKWtX (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:49:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38528 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbdHKWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:49:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id l64so20437277pge.5
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+2VA4BjSWc7Fq1wZO5OXizrn8iCQ+dcbCaKgKqgpWqE=;
        b=Mt3NRhxNpCgBUtyUhN/RzoIhkHqwPp8zlJoWtdSISuqV9Kr5OBHFu5MF5Gh04MWmJw
         cikJFay8ROzrWbjr1Kn5N0+m5eiRWCSvHPmgVy9Fk7Tajxe+Wfsn/+T7bdguHUcdp7YF
         WaB+YKk6i6exN32gryVdu7U2dFUbslizLoLuhAuRMae3Msu2pTcKUcD7VZ0O/UeqENYy
         5Ek9WDTz+Xf5MfO06VLzp+iSua63/iXCctge8pk8UVzFAbO1DR8mzP/uUbN3T2ICeOHt
         AZYjhv2Vrxm1QRfCy1hUkg9VDVxqupLRwA21W/rWdMZwr3gJipI7Aj2+zOP34aOQvDZa
         6B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+2VA4BjSWc7Fq1wZO5OXizrn8iCQ+dcbCaKgKqgpWqE=;
        b=AJd01TIH1BQsn5y1bI7Z9OuyU8Dm+R9fDUtXQkCRZo4Y6RF8vwRsoMg/IXcEgm+bZX
         tdHr54IxtVwriyBgOx7uLSbPJgYlntaOcrWThLAVxMyTah1KD38V8wuGVuKh1WNGWp/a
         XkKEjhlyckVKPlwkfgcQmmOXfJ2CWyYexEpnqOn2trRW5Xj7TJkfo9olHBw2BoxwLW/w
         70IzdN20/BCeVG717zKEVgEbOu8smja06R4C5sq2DEY8ou7GKVg9nM7BublHNAQgXvuK
         fYW4r8pXE5Lc0BmKOo39QAhPt69Z6Mah6lwmldPYcVkU6H2YSICYm7AzxTt70gMhEHX9
         h8HA==
X-Gm-Message-State: AHYfb5j4Yc/6OG0npD+KoD4tkON90kp6J2zEcXYM/g8Vox+kE2Hkm2TJ
        yupzoac7+wff8Z3ssJiiEg==
X-Received: by 10.84.217.9 with SMTP id o9mr19005915pli.62.1502491761866;
        Fri, 11 Aug 2017 15:49:21 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id j9sm3780502pfk.30.2017.08.11.15.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 15:49:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [RFC PATCH 1/3] diff: avoid redundantly clearing a flag
Date:   Fri, 11 Aug 2017 15:49:14 -0700
Message-Id: <ae81b1cf697b2d541eadd21b40ead497a0c32eb9.1502491372.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
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
index f84346b47..4965ffbc4 100644
--- a/diff.c
+++ b/diff.c
@@ -895,7 +895,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (!match) {
 			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
 			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 0; i < block_length + 1; i++) {
+				for (i = 1; i < block_length + 1; i++) {
 					l = &o->emitted_symbols->buf[n - i];
 					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
 				}
-- 
2.14.0.434.g98096fd7a8-goog


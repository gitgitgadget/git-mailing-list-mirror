Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084A720986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756210AbcJVXcg (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:36 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38719 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756164AbcJVXcf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:35 -0400
Received: by mail-it0-f46.google.com with SMTP id 66so74073880itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svopIBndLziMLuQKuR88qzKjlBHwCjP0hyBDOCy65EA=;
        b=jvU6jUa3znVMfGFUruSliuBKbZ1DVvUZzs1jS4WV10USMu3GY4tTLiIrwGTPA2CANu
         PzPj1xWudEZLJnrmKjEr+EXbNvDlUkHGsJzdNYJQhdVDIGtQW7wvrCdcCx+yumF1Ai4Z
         9KvQ2VsWvIajQ0iP0snzWUPEJ6m8mIaK9chlQzwiWvXuunoteue6BvaChb+aijs46ce3
         7bvXo6yCnP094zaADV6iFLsV1x7TjPZcyTjQ1C4ktQZUHhWbQOtJlmgf7T/s/HG32c/B
         zxAySEb92We5iCTR2pKC80C92d2u4ton9JhEcjpqU2EH7qYjoNT7CTYf7CQOMExhthIO
         f+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svopIBndLziMLuQKuR88qzKjlBHwCjP0hyBDOCy65EA=;
        b=AcWW+uIwFVuqD3em+fu2W5806ouGUAqQNGuVPi9mD+MFIDYO59wKsfm59T/I9Xqc6Y
         5XJ2WbdHmxKYOh9o4Bs0Z4r4aOrKvSdrHgydFfn+nExZlbT5jjHPsuWnfe7hxJa5ZkiZ
         LvREiuaBwZoO1j0CMw6km2nRJOAj7voNfvcHYYlNKevRk5U+SPyuloJ0fXQ/eYZcDTcC
         Ky1QesRVZYruD+EsDLGqc1OR/6kPq6k2T3umoSOBCsKre0fT7EQkmrl+AhFY4n+AUVWf
         5IwQhJ3HqbcTuwCvrULt1eaDzZ4tEyoXGzRkYehlNsmiwWLPmQLBlukFTWAEEdmB+Jzi
         /sRQ==
X-Gm-Message-State: ABUngvfFDeelF+wXzicU/DYmWsWYNb0AFVQPuZMeBf9B58j+H2mTb7NChgRFFIFFKBrGs1G/
X-Received: by 10.107.137.84 with SMTP id l81mr7365119iod.63.1477179153551;
        Sat, 22 Oct 2016 16:32:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id j76sm1973598itb.5.2016.10.22.16.32.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/36] commit.c: use strchrnul() to scan for one line
Date:   Sat, 22 Oct 2016 16:31:50 -0700
Message-Id: <20161022233225.8883-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 856fd4a..41b2fdd 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p = skip_blank_lines(p + 2);
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.10.1.508.g6572022


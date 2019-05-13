Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18821F4B6
	for <e@80x24.org>; Mon, 13 May 2019 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfEMQrh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40232 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfEMQrh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so7496897pfn.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVHQaSOJgVC/6fi+624umdLrXXhYdp2u3rHBvH1Us1M=;
        b=vMnORXPcvLLEwP4uGh8x7MTBGOhIaoC6/fgkxt9IgZ+CgOun2wktddRQP93fpvyVnR
         CWKvAjRfdL+A6CRrR6HKbZiGztuhRNlgRIZPbu7ww3bU3mtUENzZfup+bbx9zAAnXthU
         3SsqO7oXLe6T5Ofc+cidbbTTho30oJqJwmHOZnUXs5Lc4bCgfXGDM3UwBZNYXOv3+Lgz
         q95Sl0mwz9gKkfVlPStlklOT7i+yXdvwd/w03RHnMDy3xgRL/BappDLOE4isLcxJsggA
         GL0OlDT19BqHQTPhqmMK2f5TDBQtNOAeaIPC0oSK2LJiUqieFzf6HluxJqvQZ7vQQpzA
         xanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVHQaSOJgVC/6fi+624umdLrXXhYdp2u3rHBvH1Us1M=;
        b=ena87z+yeNvX2AFGICrOL+VDqKkVBUHMJP4x1cHWsfpnShODZihqRmRGKNTrBkQW/M
         BkWu7sAJAjL1NSlEM/LdJDJAfth6I3rODVYhMeoJLnIj/F7ZGFdAMjFigy5TRWdUC34j
         83yqaYpjtCrPQ3wSe3Rwicbu5/YuMIvc7v/3yPsuvixk4uBaw4WD1/BSTnSqnRiQm6cK
         Z/r5WxH6IYzabcBtKg/bVtPPiAbZ/q7DHF3JNMhHDD3V1KiHEoBCA3m3oSwtDz30nzOu
         x7HP59YlfmMi/Z+EtTnAUT2s8vsGUA6QX3KOwtU8Su3FOhK5+uDFsXgkbdkYAEPBdaqW
         ogdQ==
X-Gm-Message-State: APjAAAUMZtARt3MvmPD0FE8/EwT4Ml9WtEcQhYWD0RyLBTjSBDNQh4vY
        k4bl542qxTzEdEN7A6QRFOk=
X-Google-Smtp-Source: APXvYqwzEoaT2VZ90LhqwLcGClFcv4HxM/yupURRaftCOBdZ4c6FUNUHP8tJ2DDzvMsFqw0+Cp9+wg==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr32448982pgd.289.1557766056659;
        Mon, 13 May 2019 09:47:36 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 4/5] fast-export: differentiate between explicitly utf-8 and implicitly utf-8
Date:   Mon, 13 May 2019 09:47:21 -0700
Message-Id: <20190513164722.31534-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
 <20190513164722.31534-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The find_encoding() function returned the encoding used by a commit
message, returning a default of git_commit_encoding (usually utf-8).
Although the current code does not differentiate between a commit which
explicitly requested utf-8 and one where we just assume utf-8 because no
encoding is set, it will become important when we try to preserve the
encoding header.  Since is_encoding_utf8() returns true when passed
NULL, we can just return NULL from find_encoding() instead of returning
git_commit_encoding.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7734a9f5a5..66331fa401 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -453,7 +453,7 @@ static const char *find_encoding(const char *begin, const char *end)
 	bol = memmem(begin, end ? end - begin : strlen(begin),
 		     needle, strlen(needle));
 	if (!bol)
-		return git_commit_encoding;
+		return NULL;
 	bol += strlen(needle);
 	eol = strchrnul(bol, '\n');
 	*eol = '\0';
-- 
2.21.0.782.g571613a09e


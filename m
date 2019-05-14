Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C141F461
	for <e@80x24.org>; Tue, 14 May 2019 04:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfENEbS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 00:31:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41725 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfENEbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 00:31:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so7909775pgp.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sNKTL3Yclx+N7dLedz2C7do99iV0lPxcSw/giJB/tk=;
        b=l7ukNMaRaF1fKumE/igGCZXPEKXuWTcMPZZ0O1Q3MxhqctmaB3qONEe3l7okyCwXrF
         v44Kxy9xBHcDhXxKUpTYY/USemE0LmsAdJ9DvtAPtCc6AdJD1+21YaYROyYFt+sifk2f
         /W+pBnh7ybB7t8iqEmNzSUfoJOu5Mzsd2posKwNp+2UWC3lonp+ny9lUtvopvX+iBwna
         GrlzjDDqsS4nYNpfUnQ0cF/GPVvUexVK+vwQXQdAYBuRJEh1JhyHm9A9XLnNibGQstm1
         7hYX1y9CDqT3SxSikUvzPtOvQhhQZtTWNYCnjNpmM5U8Mh1hVOGTiKLf45Mof6sqrDO6
         +O8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sNKTL3Yclx+N7dLedz2C7do99iV0lPxcSw/giJB/tk=;
        b=YCZymRZRiZDTj65EuSFZWw0sHTXP/lKgdlIST/rFnGUZoqzz8sDy13hWEXpB3u9+2f
         hRfruFUdTJ8eYTKlZElqQh1rrtcXLXgVg1x7KPOvTFiQ/mQuPzRk6xyHlL0DF9Rb7Nm2
         sJxdo67zoXwpeJwehlMee2ZfXDKuWp000kV3n8jAF8WbLb7kqUFR4o6zJRu0AU0mAZty
         09q/1Wsk2fmmqEr4jJlpj79Cn9lZlV0ymh7+vbjqZvo/hxFAbCJY+CUlgPtGe0c2VMlW
         nmlrSkrfqwxewhKQt9TO9O+FNKM4gCo3NLtTwm1KeuPWOwjBe874t4B92lyvXtP0wQ88
         Qmpg==
X-Gm-Message-State: APjAAAWVq3ngyYxx8P6DqXCuj+yzBW50wUavDE1ZeidiumwL9955EQu7
        VHfGl/2k/UkFlYwrge/Du68=
X-Google-Smtp-Source: APXvYqwv9TAuhSB/Zi91cifE9mqO2ywPDMRPy1fsKlMgodsNCZhucVDnQAJC3lESd1X5PT8QC0iqIg==
X-Received: by 2002:a62:5cc6:: with SMTP id q189mr7516960pfb.114.1557808276545;
        Mon, 13 May 2019 21:31:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j12sm18331265pff.148.2019.05.13.21.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 21:31:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 4/5] fast-export: differentiate between explicitly UTF-8 and implicitly UTF-8
Date:   Mon, 13 May 2019 21:31:01 -0700
Message-Id: <20190514043102.31979-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd18f03d1bf
In-Reply-To: <20190514043102.31979-1-newren@gmail.com>
References: <20190513231726.16218-1-newren@gmail.com>
 <20190514043102.31979-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The find_encoding() function returned the encoding used by a commit
message, returning a default of git_commit_encoding (usually UTF-8).
Although the current code does not differentiate between a commit which
explicitly requested UTF-8 and one where we just assume UTF-8 because no
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
2.21.0.782.gd18f03d1bf


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700432070F
	for <e@80x24.org>; Wed,  7 Sep 2016 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbcIGXhG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:37:06 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35015 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcIGXhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:37:03 -0400
Received: by mail-pa0-f49.google.com with SMTP id b2so10825160pat.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPr2yQQobqfsuLJTOUxuZ7seicoq00gVx7gKjEu8Clk=;
        b=M3nXZU5LBb62FRe/5V4KgAuxhN0dhDIdW0RIi/apLJ1a6ssGWaspOCaQx2SHB1xRe2
         K/njPED3ckZTYTp8CquArFrpMlfCmqsIvt0FzigRi4PDsYhLdX9MqETbrSBW1eGrlIH0
         0jTeJzE0A29pdsuAj5/8Ll6qslY75OAQHjVOfOri9ayerPkk3MnDGivNWOo3amco3tQT
         sVwaomjaofhKeAenkTzV/G9Q900b4NbIUXZiQrj0MYsTyjVQmB7lA8T+ZgpvVQv4DZZp
         wbfk4RJ3h9MzcPZGMyHE8aCz7ZWZbZsLQkyQJmS6vRRzE+qe1nN9CXuGPj9pqiqlx60I
         tp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPr2yQQobqfsuLJTOUxuZ7seicoq00gVx7gKjEu8Clk=;
        b=clm3/owoRtkMBNSDWoT6vUhpgxEpul3+/X51gi3aw4VxUNKKdiRTt5hJxvMjOPgMbs
         QHDaiR1mGRKIyEl4CZWLErODZvZK1rQauxesEj+vXgQHN1g7mEbmcqiUTxj74eTvwC8q
         dsrgJGvGCS/jCfEoS/uEssS2D/JmvrzIp5yxSCBDQ/j2J2PgVisduXx+RY/36LYbL+Ta
         iTaNpmFGg4X9fP2SehtXOlrUMOFH6onTeVsBKARqxf8T8xqL5LIHI8404n0XBaW0bGcI
         /SVINRTx1/5yvs9wsZ3kAavHtCxHwQegdnQnEcDWL6c9U1605PhaPhHRuUJmSkKaHOYV
         kRsA==
X-Gm-Message-State: AE9vXwOOzSR7sSCRNDy4oQ/ldC65Alh+/3mKlocU138CDhzMinp7ms+PgQa5LVGsNEQgjdjJ
X-Received: by 10.66.66.203 with SMTP id h11mr87781156pat.5.1473291421937;
        Wed, 07 Sep 2016 16:37:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f111:face:c1e2:bcdc])
        by smtp.gmail.com with ESMTPSA id s63sm42529269pfb.52.2016.09.07.16.37.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:37:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] diff: remove dead code
Date:   Wed,  7 Sep 2016 16:36:48 -0700
Message-Id: <20160907233648.5162-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.2.g0676c79.dirty
In-Reply-To: <20160907233648.5162-1-sbeller@google.com>
References: <20160907233648.5162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `len < 1`, len has to be 0 or negative, emit_line will then remove the
first character and by then `len` would be negative. As this doesn't
happen, it is safe to assume it is dead code.

This continues to simplify the code, which was started in b8d9c1a66b
(2009-09-03,  diff.c: the builtin_diff() deals with only two-file
comparison).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/diff.c b/diff.c
index 79ad91d..c143019 100644
--- a/diff.c
+++ b/diff.c
@@ -1251,14 +1251,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	if (len < 1) {
-		emit_line(o, reset, reset, line, len);
-		if (ecbdata->diff_words
-		    && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
-			fputs("~\n", o->file);
-		return;
-	}
-
 	if (ecbdata->diff_words) {
 		if (line[0] == '-') {
 			diff_words_append(line, len,
-- 
2.10.0.2.g0676c79.dirty


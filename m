Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA461F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEJUxy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:53:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43946 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfEJUxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:53:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so3812354pfa.10
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XgoPfe9BTsd2ssS3FxlL008l5qRNMKHAyLFszTT4lCY=;
        b=UEsnpCpIqVOAREEfKJut6X//qMtGERrtDCa/vzuyFqXG4XMWZEF/zBKe6HLO7HWJq6
         V84I08bqX0syGCd6eSYtwVyJoL8Obop8zomMhRPMrLz9PCClFMLmlyM6Bvv2b643dyHT
         vkadu3oyb1fUN/WVgINYWimNrRBzN6lF82E/OKOcWIRHmiz+KYYPwMV5zyibuIQtMmJF
         cqGss4dWWS3lPOfdY+CVRtdJ1zUuxf+LXD5ep4UPFORrWI6dGQiZBvATRpPC9cE3YT6K
         ZjwKE1IyAowACqZD9WJBab9ZMkjL7Ne3nk2zB7cB+kfZkF1+LPcG2t1RCXCNwvFUpAUA
         i6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XgoPfe9BTsd2ssS3FxlL008l5qRNMKHAyLFszTT4lCY=;
        b=ehtL9oUxeA5cad+J+zMPAmDg81iFwOO+9Vc5Aiwyro0lAhNlEisebsff44tKPyZxqD
         R6hOzBqRNI0eTAf61III1hjzbYWwCz0tyeWTVTZduQkCcPkCXDSaRtOh/NbCXyV51KzA
         OJu/FS3o7+vWkM6A/kHax+q+mRkW5JBjkkeAJxJukPHGhRFbQwe1PekEt1BQIh8yzTYz
         HJj3PKQRnSGsmQ4dKfWAvk+HP7Dqp0dr6//l1pMdbUJb3c0arfYqw7mt388cIzUg0Vtf
         VuwYkfEs+PjfXdH1H13fCeIDkmpKMXVm7LIgf/61zUqCZwomLq/o8yESZ1UWT0FN3SV6
         +SeA==
X-Gm-Message-State: APjAAAUnQVhyaw1wRKISdUupOcT4amf9gzxqS3ChV+tK5sAfkHCg3ZMF
        gJZv0WT4eni+/EyC8pynYJU=
X-Google-Smtp-Source: APXvYqwsYxPLCRg06nnQFAEbS6K5XRRHwhh/yPaowhsCEjXdi1ieLPSYOhwABxr35Boat37qRy/gOQ==
X-Received: by 2002:a62:62c1:: with SMTP id w184mr16734023pfb.95.1557521631707;
        Fri, 10 May 2019 13:53:51 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n127sm7305142pga.57.2019.05.10.13.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 13:53:51 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 4/5] fast-export: differentiate between explicitly utf-8 and implicitly utf-8
Date:   Fri, 10 May 2019 13:53:34 -0700
Message-Id: <20190510205335.19968-5-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g2063122293
In-Reply-To: <20190510205335.19968-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
 <20190510205335.19968-1-newren@gmail.com>
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
2.21.0.782.g2063122293


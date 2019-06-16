Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1211F462
	for <e@80x24.org>; Sun, 16 Jun 2019 18:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfFPSk1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 14:40:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41154 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 14:40:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so4390093pff.8
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfNWlvJd9v1NQAHt/xI8/9rAPgz/6FgByGTt8qt+VC8=;
        b=LEQeI9/+C02j1GnRqWB3co8IW0lHYuOpKMGR1/3Y8I9aISW3KDiVHthWI27c96ocV/
         9XI4BdBjYQi3fAVKaTZuDLZW77TK03Q38hWHRhDp4buz9gQXD1VSKKTKQUe4j1zz4Bh7
         v77G2jsqhBzLKq0XKUqQ2BXXF8mmaYCU3x7jVgQi6Q3cJV6qOW0pLDrxGiRLtEsH9Hjh
         x/g8RIz3XDqLKKaQI7Lhw5ozk7O2ttBTs+Iorec1PNB7GtzdwSAd348nZmL+xpua7uyE
         4HWzt0eyVv/M1w4dZxlZkgM+x7PknNrjDtYimMLhryfdzBrMMI61reY/FV78BlHxfAUY
         5khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfNWlvJd9v1NQAHt/xI8/9rAPgz/6FgByGTt8qt+VC8=;
        b=CLockWDNPlkXiKEmfPuwqyXTCHte3vYlmZ0eFQk/rnqG10pYxVKN+E/vLQu0VSNwdL
         AlS0ClKZIrxL5A3XQXXcxdKqVtbqub8iQASwJ/7b/TUmi2/0ZKx3O7buyQtQuNdx21CG
         r7we5Y8KsPUQJmFdeEgafMsFIdBOpQjIjKl4XRTwANTJJFdIIYR+FSG9xS4ErNOcqJrI
         wM1sylGBMa+x9laD8+q9+7szoqI/NVXa5DrZUK8QlFc+d37FyAI5TkxFc4MWes5+M1Ob
         52DhhvPWFixbr0eWOb8MJZFS+nJTxjIjsg6QJJz60RFTEYJ5wiRJYi/OO8ndyJya5c7e
         L6Fg==
X-Gm-Message-State: APjAAAV5vK3CmUhoe4E9O8/9jFRB3nxeaKmesa6GR2/7C76O7yE5P86z
        o84d03NlJquewR7qni7jn2eRG4v8
X-Google-Smtp-Source: APXvYqwMYjSOZerthJpUuvGYdMt6IzfkN3gLsg5bPHEC5VlB2m9r5HXEt6+xvg2sm7KDxKIsOfwktw==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr45079091pgb.214.1560710426354;
        Sun, 16 Jun 2019 11:40:26 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 2sm9426093pff.174.2019.06.16.11.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 11:40:25 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, gitster@pobox.com
Subject: [PATCH] wrapper: avoid UB in macOS
Date:   Sun, 16 Jun 2019 11:40:03 -0700
Message-Id: <20190616184003.17236-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0620b39b3b ("compat: add a mkstemps() compatibility function", 2009-05-31)
included a function based on code from libiberty which would result in
undefined behaviour in platforms where timeval's tv_usec is a 32-bit signed
type as shown by:

wrapper.c:505:31: runtime error: left shift of 594546 by 16 places cannot be represented in type '__darwin_suseconds_t' (aka 'int')

interestingly the version of this code from gcc never had this bug and the
code had a cast that would had prevented the issue (at least in 64-bit
platforms) but was misapplied.

change the cast to uint64_t so it also works in 32-bit platforms.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index ea3cf64d4c..1e45ab7b92 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -502,7 +502,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	 * Try TMP_MAX different filenames.
 	 */
 	gettimeofday(&tv, NULL);
-	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
+	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
 	filename_template = &pattern[len - 6 - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
-- 
2.22.0


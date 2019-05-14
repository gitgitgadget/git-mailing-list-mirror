Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DD51F461
	for <e@80x24.org>; Tue, 14 May 2019 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENVVB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 17:21:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38263 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 17:21:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so217015plb.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwXy2A8FgraI2/6++7dH5O70cJFGmfHYix7jzD+aJPs=;
        b=D9OyVfU4GoKXd0JqW6791U6OOHuvlNPe2QA0Q//jFNaGY5NHuYt4tGP7yoyvIj0G7b
         Gii/i9+Q80Z6Deuzaq+OkuRDv/TsYr591LBFG4gMLQEGxEbmpJUwXbOLQgRjQj3svaxI
         qREgzjTPO4p0JgFn7XN3P6L2thEZz7JaOEaXcm+D6rMgpo7G2McY2tvA41AWDWZ4ejHK
         3shKbsPzKrg9JkMpGC0TNf2xw4DTpoaz2MuDYIpN0A+BXx9oXiCSQsoLIN6b2ZFN2ksT
         v+lKkDpzp2U/+Ch5phjTrpurs029QhfIDCkdGghGVwOiDaQXiRp1VxaAc2LOfbo/nKod
         5zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwXy2A8FgraI2/6++7dH5O70cJFGmfHYix7jzD+aJPs=;
        b=CNRkxQaifR3IsxsbeQ1NlCVbGC50ziQkcEKM1SmTmdwc57FEcFSXiZXrmqNx16WPqd
         c+/4zvm9wDsPZYWSKlJt5LgoXfwHad0ZFJqMSOEQwxKUQPF4DJdQcMOiJFpnnv6xjDdT
         3x7IY3sap+2X+sILbuWvFVmaaUm3HV8mEE5Osmhpd0z/cHiWW4oGvsxu8HNPzdBmjaK/
         77sHLHfeww9iU3djsplIEv3NtEo3gwQEKuGxp6vzTsaekqQOzmi/xZ32RhQ8ySCFgquf
         cTSfuZGhs2TPqAF2OJyw1f7MHaCHQVm+Mw+wpkyj6cSdRW80r+8pan6xxnebQ1PlmNxO
         yP5w==
X-Gm-Message-State: APjAAAXhKSoP78ZwDA282QSpa3X7V0Wb6kuKvnQStcaxeLP/SeeGDA3+
        AREYPspFrl/8xmS4SnUpZ0O1563I
X-Google-Smtp-Source: APXvYqxEUj1lfaEbN0FfpsgJD5TuZDIlyUL5vez9drUeOnjYfQ4YleMr6+SVwuSrqaWGvJobmVXH/A==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr12059796plq.306.1557868860302;
        Tue, 14 May 2019 14:21:00 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id e123sm48339pgc.29.2019.05.14.14.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 May 2019 14:20:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] http-push: prevent format overflow warning with gcc >= 9
Date:   Tue, 14 May 2019 14:11:17 -0700
Message-Id: <20190514211117.63739-1-carenas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In function 'finish_request',
    inlined from 'process_response' at http-push.c:248:2:
http-push.c:587:4: warning: '%s' directive argument is null [-Wformat-overflow=]
  587 |    fprintf(stderr, "Unable to get pack file %s\n%s",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  588 |     request->url, curl_errorstr);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

request->url is needed for the error message if there was a failure
during fetch but was being cleared unnecessarily earlier.

note that the leak is prevented by calling release_request unconditionally
at the end.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
---
 http-push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index f675a96316..e36561a6db 100644
--- a/http-push.c
+++ b/http-push.c
@@ -526,8 +526,8 @@ static void finish_request(struct transfer_request *request)
 	if (request->headers != NULL)
 		curl_slist_free_all(request->headers);
 
-	/* URL is reused for MOVE after PUT */
-	if (request->state != RUN_PUT) {
+	/* URL is reused for MOVE after PUT and used during FETCH */
+	if (request->state != RUN_PUT && request->state != RUN_FETCH_PACKED) {
 		FREE_AND_NULL(request->url);
 	}
 
-- 
2.21.0


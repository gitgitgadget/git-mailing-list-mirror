Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D590208CD
	for <e@80x24.org>; Mon,  4 Sep 2017 20:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbdIDUEn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 16:04:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38090 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbdIDUEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 16:04:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id p14so445661wrg.5
        for <git@vger.kernel.org>; Mon, 04 Sep 2017 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh4Xgzz7rdB8u1shQOipzczc7/Cn23maJIye7q1yWZ0=;
        b=i3pUfUlDu5xfRfUoPOtlZPeIdTK9/6jnqMAnFLdMEB2P3A0UpkUbPesMVpjrSGTsRS
         vLi8VwVJ8K0UWsm6sQDfHFsSBYNesfGpKddjG58fwx23DrCg74RB9CCFay5MZggmmDBT
         PpYBt8zpjYzLtx0ublkd5UZ0OZdo+SQo8pHcvZUqQui04dtAY8q1h8bbgU/6vt7t78ra
         Up/UXbSYbJnlw6t26//MuOd/UCZ6lIQGauT2XtDTdOpi5kN1RlHpy+0cZgA5tDwK6OzU
         3wF+CwtAiWOM0hNw6QiTuCHYEUpQcWI4Oi+hg4mIOvJ2zgpY4AcRRrC6Zt1EGH8bc5VN
         Visg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh4Xgzz7rdB8u1shQOipzczc7/Cn23maJIye7q1yWZ0=;
        b=GhiNLkJoDf4LF8i22NU6he4mmjNuQb+f1Jn+z5TvysIeaH9wo/uRjvLqKZWKeOSAbr
         FoPza/72tlGf66NUufN4aWWhlLQL3SRKF47QEZ2nPjNfwiDbfK+3gxtIqWCRjchyFnHt
         rwJKgfMhgos/bc3Gj7Es56OeHg0d7aithv/65A0gU3XJEMCk0a+WvoB6Y0l82QI5nze2
         bFK3aTbHlhpQqBx+YqQv18hAbEg7vv9a79cVI6D1iOlBI51ZutskvflFFYTH9rhN2w4+
         X1v+9t5SmCbckDe/TIa6eU4FBct5Wmv3gIUcyDuUBoFCpUg84ZLDOc+MiLnYn0DxzyXP
         1uBg==
X-Gm-Message-State: AHPjjUgGwSZc9Vzv/RXn/85MUqsbXwaX3FlOYuqnZobyyXEjEeEjb4nu
        nixfz5+rML1ijkts99E=
X-Google-Smtp-Source: ADKCNb4fCZ00GqkHfwXAN6CM6EH5bKPFN5xf67f8DT8Vx7EpaXkmA4mH6QpX1aTgMeqNAFpPQbqdCw==
X-Received: by 10.223.135.141 with SMTP id b13mr888405wrb.6.1504555481092;
        Mon, 04 Sep 2017 13:04:41 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id o2sm2000317wrb.78.2017.09.04.13.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Sep 2017 13:04:39 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH] refs: make sure we never pass NULL to hashcpy
Date:   Mon,  4 Sep 2017 21:05:03 +0100
Message-Id: <20170904200504.15249-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gcc on arch linux (version 7.1.1) warns that a NULL argument is passed
as the second parameter of memcpy.

In file included from refs.c:5:0:
refs.c: In function ‘ref_transaction_verify’:
cache.h:948:2: error: argument 2 null where non-null expected [-Werror=nonnull]
  memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from git-compat-util.h:165:0,
                 from cache.h:4,
                 from refs.c:5:
/usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared here
 extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
              ^~~~~~

Tracking this error down, we can track it back to
ref_transaction_add_update.  where the call to hashcpy is however
protected by the flags that are passed in.

To make sure there's no code path where the wrong flags are passed in,
and to help the compiler realize that no NULL parameter is passed as
second argument to hashcpy, add asserts that this is indeed the case.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This is based on top of ma/ts-cleanups, as that fixes another compiler
warning with gcc 7.1.1.

 refs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ba22f4acef..d8c12a9c44 100644
--- a/refs.c
+++ b/refs.c
@@ -896,10 +896,14 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	if (flags & REF_HAVE_NEW) {
+		assert(new_sha1);
 		hashcpy(update->new_oid.hash, new_sha1);
-	if (flags & REF_HAVE_OLD)
+	}
+	if (flags & REF_HAVE_OLD) {
+		assert(old_sha1);
 		hashcpy(update->old_oid.hash, old_sha1);
+	}
 	update->msg = xstrdup_or_null(msg);
 	return update;
 }
-- 
2.14.1.480.gb18f417b89


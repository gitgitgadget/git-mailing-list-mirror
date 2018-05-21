Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3E7200B9
	for <e@80x24.org>; Mon, 21 May 2018 14:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeEUOzM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:55:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50310 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeEUOzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:55:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so25913509wmt.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeuB5eHYp8B+uWy3/7d9bzzEB5THGMXbFtp7dTQbwlg=;
        b=ligr6JHVeDX19AeihebRZKFR1CXkjK1B3tZTef81q1jZ+S8z6/MIdRyd+RwfaA1NBo
         KDqZO+AvDXOGnPpel2qRTEHXmBtavD8bYWYUlvDCu7Yldj6Jy3ecn8P0p/TmPVT/Yd8n
         PkOstMTHpaeLFAIwXQEyJOrkLC9bLrF6cRUWrnAHLHbOnWf7SW3GdPF2R/ExSnzvZUOl
         DVIJX2nXloqPAfznPG0CSIkYdCR3tKdiN8fRvP/fyfPPvSJgOfflTg2UfMknUte/Ep+7
         sif1AId0ZKYVJyXfxTxcN0ueE9ylkNppUO9aLnRolu552ckXwkjNaWqYVvs4GH7GQDx2
         D27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeuB5eHYp8B+uWy3/7d9bzzEB5THGMXbFtp7dTQbwlg=;
        b=irDKfQpZsvK7nmNjiborTq+loOLINRn6jnfFQX17YUjsayYde4/rb+hfw4lfNV6k43
         toJDD6gxNEoZxeBBki1eQ4vPpESbttAi62pLsi+qrqEW8hUEadvHdHWl9feMKu3c8346
         JdH+VLL36n/UI5/3Dimqfo8761SGTJu7lOQsg/vsLR+f9zhFeP0Hs4y4r5AmgaD4aGLc
         wdCEnZrXNcc7beaUi+KcDQASw2fpINzjoeaqZ28v5cApRtfe8Vm6gayftLNTYfFTeJOo
         dQBtlRQc/7FaLCh4XakPCSE1sCv+pwwho9dY4ygcTShkYcV9DVoHsAPZNUNvDsBs7iDI
         FLqQ==
X-Gm-Message-State: ALKqPwfWj549A3GGAQ/hlssnCWnh46Atsnwu4qOeu0ViuA5q7uM1L4lL
        uiwXnnWLzsesb3h9c8Lhqsg=
X-Google-Smtp-Source: AB8JxZoTmugYElmMug3EDpB7XzjiS2zdUWvUhN05Tn52+kjuqrl6pUvovAGo0u4w7V2ORUM/JwRpSA==
X-Received: by 2002:a1c:71c4:: with SMTP id d65-v6mr10395313wmi.157.1526914509415;
        Mon, 21 May 2018 07:55:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id b10-v6sm37627460wrn.42.2018.05.21.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 07:55:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 3/4] argv-array: return the pushed string from argv_push*()
Date:   Mon, 21 May 2018 16:54:27 +0200
Message-Id: <ae7e8194c258c6fac3b5478ad914fa0287f7b62d.1526913784.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com> <cover.1526913784.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Such an API change allows us to use an argv_array this way:

	struct argv_array to_free = ARGV_ARRAY_INIT;
        const char *msg;

        if (some condition) {
		msg = "constant string message";
		... other logic ...
	} else {
		msg = argv_pushf(&to_free, "format %s", var);
	}
	... use "msg" ...
	... do other things ...
	argv_clear(&to_free);

Note that argv_array_pushl() and argv_array_pushv() are used to push
one or more strings with a single call, so we do not return any one
of these strings from these two functions in order to reduce the
chance to misuse the API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 argv-array.h | 4 ++--
 argv-array.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/argv-array.h b/argv-array.h
index 29056e49a1..715c93b246 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -12,9 +12,9 @@ struct argv_array {
 #define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
 
 void argv_array_init(struct argv_array *);
-void argv_array_push(struct argv_array *, const char *);
+const char *argv_array_push(struct argv_array *, const char *);
 __attribute__((format (printf,2,3)))
-void argv_array_pushf(struct argv_array *, const char *fmt, ...);
+const char *argv_array_pushf(struct argv_array *, const char *fmt, ...);
 LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
diff --git a/argv-array.c b/argv-array.c
index 5d370fa336..449dfc105a 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -21,12 +21,13 @@ static void argv_array_push_nodup(struct argv_array *array, const char *value)
 	array->argv[array->argc] = NULL;
 }
 
-void argv_array_push(struct argv_array *array, const char *value)
+const char *argv_array_push(struct argv_array *array, const char *value)
 {
 	argv_array_push_nodup(array, xstrdup(value));
+	return array->argv[array->argc - 1];
 }
 
-void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
+const char *argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf v = STRBUF_INIT;
@@ -36,6 +37,7 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
 	va_end(ap);
 
 	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
+	return array->argv[array->argc - 1];
 }
 
 void argv_array_pushl(struct argv_array *array, ...)
-- 
2.17.0.840.g5d83f92caf


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EA71F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeAXLMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:14 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34955 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeAXLML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:11 -0500
Received: by mail-lf0-f52.google.com with SMTP id a204so4720090lfa.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=HrjaLcmO/08wJ2XpI74CPnIdUes4iJKQT/8GcfdUFFnASvg4jMPvTlE7bceURctqh8
         mzQahG0IYQjw2lqhYEQavkpxCUfaG1lYcYbXEPY0kPZti1izi36tHSTQ+E3YtKl1ZV6K
         TqbKR8+iQqlcZCCm2qBYEYFTsuqJoCJ9sxKPCPcQyM/dm4vPE6txPhPgAi94N3b5rClT
         A+HDbajVEfCh/s3OQtKuKZoT3ZlT1RWQ8HUfijo5SZGtukcMAiQRTs0EKlqkKJEV7ts+
         7CyEP24irHFoxiASi75JKzubwS7EK71LPKwD5pwrb67tPqhEuOXaa2GH3Ms+USdPrHnL
         lY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=KPTf3aXOMAeyFmxu/3kgP65tEFZTRPqqiLaD4KSx7iwhwTXuVGJ7SUYvNsD9Tyuk3T
         TWCzBj/nBqx6HagBL0aU9ubHvvNq9RuGUTkoRD0ZHKICqTrDpsxiVMPBm/a3f25Ms1iU
         HOv414nueA6NkbtthxLNHqhdOIGc31gwOuz2imTfvjKK/41q7wXcBUd8JxdEj8NmdmOz
         xZIFg03BDHsogGKQkp6O7ssgnTQrW9SbypgCLWXPJJilx+XeFrlu1r6EU13a3qbQbLs6
         BnQilRw5aow/TgQr66mud757+y8AhizJzRZWWrYifmcd662o6nSv15X48mjQ0CtE2sam
         E6/Q==
X-Gm-Message-State: AKwxytcCb2cD6UUxlwkNJ72TalwQpPUWn/zmhGRg7HSzNpNEiV0u1KRh
        UCTg2UOt04rdeMG416t2nHQ0FtJN
X-Google-Smtp-Source: AH8x226qWVrcrsLjAa85HA2409XmA+KVJQ2UqWs414BRpzHm3wYOBeUJNKrq4gqm3I8xcccfQq9a1g==
X-Received: by 10.46.58.8 with SMTP id h8mr3225992lja.130.1516792329746;
        Wed, 24 Jan 2018 03:12:09 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:08 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 01/14] http-push: improve error log
Date:   Wed, 24 Jan 2018 12:11:53 +0100
Message-Id: <12efd87956b415fff28b18302077cd06d48a748f.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git push fails due to server-side WebDAV error, it's not easy to
point to the main culprit.  Additional information about exact cURL
error and HTTP server response is helpful for debugging purpose.

New error log helped me pinpoint failing test t5540-http-push-webdav
to a missing Apache dependency in Fedora 27:
https://bugzilla.redhat.com/show_bug.cgi?id=1491151

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 http-push.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http-push.c b/http-push.c
index 14435ab65d..0913f8ab86 100644
--- a/http-push.c
+++ b/http-push.c
@@ -915,6 +915,10 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 				lock->timeout = -1;
 			}
 			XML_ParserFree(parser);
+		} else {
+			fprintf(stderr,
+				"error: curl result=%d, HTTP code=%ld\n",
+				results.curl_result, results.http_code);
 		}
 	} else {
 		fprintf(stderr, "Unable to start LOCK request\n");
-- 
2.14.3


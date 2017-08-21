Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE58208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbdHURoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:44:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35862 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:44:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id f8so13666728wrf.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHkdwzBGdEVm/wc3Rt6dBHZlQxnaNJN6fmpFKpMnzbk=;
        b=KnOUbQ3orrL1n6BaGxdusEZOKALK4tuAP8jMV+wCTENDJWdLDu7k0q0t0JQuXRs6K2
         ZL4SQUUp+/C36Vjz8a9yLZYa02dkhYuapAhBpH1qjsS73sfMWgkDEXEj28f0yR2ud1YX
         11QmFocA+fg3/Qmhz+wiPCWlGBuK3cRnebI8aAb7TeVgVonfrakQRRgGHqFj9O3Nu+8o
         5mw37kwiK15oVJc97ifi60Smv7PNIOX7v04cHnD2tutClFUqIs8dokmZh6pSGTtEnxlU
         A6ECPL5cVv6ehlZcqFxK7GYo6NSgtSkAOblKrxwEQTkBnaFCSqQrFQ3EqqaArup5zfLP
         p+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHkdwzBGdEVm/wc3Rt6dBHZlQxnaNJN6fmpFKpMnzbk=;
        b=ZEPKOs1EJ6oFNeCLMI0thzkKjf67Csyxe9zsFkTN9smS1eP3G4Yjs5cBHVfX5bapSb
         REif9WD53vZVGHLU2eyo3ANf7+eG4pfOwQT43kaHpxhC+cb1C5r5XOj6666hWxeJLNyi
         UR8X7An8OsP4j4pudo4cBSggqdYiyodir+ukSQPDcTLPKamEQZeNxTUbuHXyuC7yeN3i
         GZ4JHeekZl+y7YSykJHDy5EdDspCl6iWwuEGD/8ZYjUVfD3Jx5Qyq5I4dMxxPU8nmxhL
         4ZLQEyS1ibafWJKWm0KDm3XDAcVm/0nB3Yk1ac5fHsxgkEFniniZ12CBUrhy2c3r9Sv4
         SozA==
X-Gm-Message-State: AHYfb5jTzZ553tTFW7EK/eGiv0Nz3RDxI0diUYO5mik87Xh8IZhpomJq
        0jnm5DZ4u20MpQnx
X-Received: by 10.223.163.20 with SMTP id c20mr12459615wrb.173.1503337445191;
        Mon, 21 Aug 2017 10:44:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id y8sm5942458wmg.12.2017.08.21.10.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 10:44:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/4] pack-objects: take lock before accessing `remaining`
Date:   Mon, 21 Aug 2017 19:43:46 +0200
Message-Id: <6b50c193fdf441349809c01b2eb63b484e8d89ab.1503323391.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1503323390.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checking the conditional of "while (me->remaining)", we did not
hold the lock. Calling find_deltas would still be safe, since it checks
"remaining" (after taking the lock) and is able to handle all values. In
fact, this could (currently) not trigger any bug: a bug could happen if
`remaining` transitioning from zero to non-zero races with the evaluation
of the while-condition, but these are always separated by the
data_ready-mechanism.

Make sure we have the lock when we read `remaining`. This does mean we
release it just so that find_deltas can take it immediately again. We
could tweak the contract so that the lock should be taken before calling
find_deltas, but let's defer that until someone can actually show that
"unlock+lock" has a measurable negative impact.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: unchanged from v1

 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c753e9237..bd391e97a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2170,7 +2170,10 @@ static void *threaded_find_deltas(void *arg)
 {
 	struct thread_params *me = arg;
 
+	progress_lock();
 	while (me->remaining) {
+		progress_unlock();
+
 		find_deltas(me->list, &me->remaining,
 			    me->window, me->depth, me->processed);
 
@@ -2192,7 +2195,10 @@ static void *threaded_find_deltas(void *arg)
 			pthread_cond_wait(&me->cond, &me->mutex);
 		me->data_ready = 0;
 		pthread_mutex_unlock(&me->mutex);
+
+		progress_lock();
 	}
+	progress_unlock();
 	/* leave ->working 1 so that this doesn't get more work assigned */
 	return NULL;
 }
-- 
2.14.1.151.gdfeca7a7e


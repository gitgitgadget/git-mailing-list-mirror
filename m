Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD9E208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbdHOMxg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37267 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbdHOMxf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so1357498wmt.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqBoG0gV1/8b3vJBqgJWJP+m8VwTNiPAMK99M3JFrvc=;
        b=baoeghzmdbHjup6FSy5lOyv+V1XsJ+OEsmYspG11jeAMN1QJmo0ZSV0p1iI9O3hXn1
         dXuP3GFcFGD3oYRPB8Ef85Xag98Tel2aPtb5TKutSIF4YcHEIU09M3PXqivXLfZsihjQ
         rtHtRowp1aatoCQbEiKiPKz3Duv7aZBgXlLME31dutKCo+ftudtj5JLDWtpo/zt556RK
         4WYihHCwvGdkTC7ANRxuTI54mkmZSNQcGIAfkLdx84Gc6d137cJOyT2QmviDWCfoDPcw
         o+aYZJs6XrHEb1QmBHP/UoalJhLqFXMU0ZjsLwvH+8WSjhmkT2vetgXTt5ay+VhydNi7
         EACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqBoG0gV1/8b3vJBqgJWJP+m8VwTNiPAMK99M3JFrvc=;
        b=cLDs162yj00DmYC6e0ohrVP2O9QoScbQusX0YjuIFzGYK88c0M+lKPWfeCrdu4/GRX
         D0pWZnQ6gYZzztj+N8RCXG1rJDemZGqGWIGO202CWQ5kKlWh1AxvfO3zJUrT5RDK5Akl
         bnKeMIwU1HnNZsYODSsLiuohE3yegHCfsOItCYN9ZJaKOpeqluD+KzDb/ajMD6YOI+nK
         gp1xj/bNHhKYmYXiRjMFLWWaz1TvzNA/FCtq9oKzvkSX7bRgVYaW3Vqa0tO7Bf+/nY2C
         z7UA0ePifN7F0o6dGnhvGyORHcfj6wyVMLBxKSxWatEIlkKfSgwXetE5DOZaAnbQTKU0
         xUwg==
X-Gm-Message-State: AHYfb5gkTWq+mnnGX/Ua6m17abaMuLsOm9e6L/Ny8BvFT7kb5s0amSn0
        Ke7lfEBdkEAH0xKQ
X-Received: by 10.28.107.144 with SMTP id a16mr1180079wmi.178.1502801613780;
        Tue, 15 Aug 2017 05:53:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/5] pack-objects: take lock before accessing `remaining`
Date:   Tue, 15 Aug 2017 14:53:02 +0200
Message-Id: <5815ea4f27226b604751961c8b70355a8925f0c5.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
I don't think this corrects any real error. The benefits of this patch
would be "future-proofs things slightly" and "silences tsan, so that
other errors don't drown in noise". Feel free to tell me those benefits
are negligible and that this change actually hurts.

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


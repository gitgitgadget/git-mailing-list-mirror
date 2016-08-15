Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3461F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbcHOSkb (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:40:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36165 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcHOSka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:40:30 -0400
Received: by mail-pa0-f46.google.com with SMTP id pp5so18238996pac.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 11:40:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyucD8sH/adm8Ju+u+H5YdLpnYyt+YydVZ2EIIqgoDU=;
        b=Xh12Odr0nrC4m7PSQYtJVSwMbrerIFSJNL6n0NA2rEHY6yRdtYBXLpy1YJJrr/JQHa
         AdzFxW9xy2VnPWxP4ACtbXYKOXbzGhYPCoJuMX1d3rSHXquM2ZJsBYMG88e9g/KM4OY3
         gauuEgwEZWw7NiJRAyeK9nyBykB7pwKG5fGGj/zVzwTwDC7MZafBUc33Nu6JowJ1oXP6
         JCh8hOkQfFjeqQadzWXOaCY6MRPJv3IzZ7rngmYeykikqo0RoD8gjUTggMtjZllptEeq
         zI0vQ+KKeM35hgwZ8AKQRLgfvHY4Dsefqh5MYa3Q6uCbMLFi6H+/qmGCyj5wAMJbcro3
         OA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyucD8sH/adm8Ju+u+H5YdLpnYyt+YydVZ2EIIqgoDU=;
        b=lsGCCgsO+ZOj9Tlxjs92dNvzqUase8N9zlBquvsuiMBfzvqxg6zMJ0r8zQmyXJbuAr
         2oyVHBRPF/54LOwGHpAubmFSmYQGuQ+o8yk56D9a3c+6sFu5UJur7L9DVgWxzSF6110q
         t46WGen2v92/Q/M2Jpz9lIW/Loh/udEEns12E2Js2DEbN7PmFLsx/DobANk8ojiJBBb0
         gE580yDGdiS6qXaQEDWyi41Bkl/E1kb/FR+0sGYiGyrKcLWV94EQOLWJfi9f9pjtf0/q
         Tr7OAvg6jGJdcFNWld0GNZafWup2nlJTd8ixmtMXRRfln0zCylDBLVqBwDWwCaibnTqB
         6hFg==
X-Gm-Message-State: AEkoouveIf8x3JLrrHZHXLtveYqniRZfV/FTGwn0werMA4sK+PJay4jfBgM3ug/UPOemRvHV
X-Received: by 10.66.155.129 with SMTP id vw1mr56047940pab.148.1471286429264;
        Mon, 15 Aug 2016 11:40:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id s12sm33130058pfj.73.2016.08.15.11.40.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 11:40:28 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	jrnieder@gmail.com, peff@peff.net,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] checkout: do not mention detach advice for explicit --detach option
Date:	Mon, 15 Aug 2016 11:40:21 -0700
Message-Id: <20160815184021.12396-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815184021.12396-1-sbeller@google.com>
References: <20160815184021.12396-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a user asked for a detached HEAD specifically with `--detach`,
we do not need to give advice on what a detached HEAD state entails as
we can assume they know what they're getting into as they asked for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Junio writes:
 > It might be controversial how the second from the last case should
 > behave, though.
 
 I agree. I think if the advice is configured explicitly we can still give it.
 That makes the code a bit more complicated though.
 
 Also note I added stderr to stdout redirections as suggested by Peff.
 
 Thanks,
 Stefan
 
 builtin/checkout.c         |  4 +++-
 t/t2020-checkout-detach.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4866111..6196b40 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -658,7 +658,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path && advice_detached_head)
+			if (old->path &&
+			    (advice_detached_head == 1 ||
+			     (advice_detached_head == -1 && !opts->force_detach)))
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 5d68729..fe311a1 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -163,4 +163,32 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	test_i18ncmp expect stdout
 '
 
+test_expect_success 'no advice given for explicit detached head state' '
+	# baseline
+	test_config advice.detachedHead true &&
+	git checkout child && git checkout HEAD^0 >expect.advice 2>&1 &&
+	test_config advice.detachedHead false &&
+	git checkout child && git checkout HEAD^0 >expect.no-advice 2>&1 &&
+	test_unconfig advice.detachedHead &&
+	# without configuration, the advice.* variables default to true
+	git checkout child && git checkout HEAD^0 >actual 2>&1 &&
+	test_cmp expect.advice actual &&
+
+	# with explicit --detach
+	# no configuration
+	test_unconfig advice.detachedHead &&
+	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
+	test_cmp expect.no-advice actual &&
+
+	# explicitly ask advice
+	test_config advice.detachedHead true &&
+	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
+	test_cmp expect.advice actual &&
+
+	# explicitly decline advice
+	test_config advice.detachedHead false &&
+	git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
+	test_cmp expect.no-advice actual
+'
+
 test_done
-- 
2.9.2.730.g525ad04.dirty


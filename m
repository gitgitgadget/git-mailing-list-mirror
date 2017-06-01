Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BD620D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdFAAbD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:31:03 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33224 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFAAbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:31:02 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so21630662pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BdDdgDJg4u3AfSraEOaAXu82jnvABq+jK5J4w/oLHPU=;
        b=CDgPX/AHfWYrsVUqk8nW93JtayfbFquwdJbN14UQFcfAXQo1Qb0Xsi2qXo6RgRO/8a
         zgqX9Su8YMA4p9sYEQWETHAhrPAC9w66bCIAigBY7YR9G8PZd0+SjpWLl464gaPQKc82
         ZAyYzj5ORAATTYY1eJsai+EBRqxaGSIOWBDIDRqlZcuQYjQURnDFCaLLb3GcalxYTL+J
         wmh6TXY0sP+NRNnFwMCe+aQUW08bWzIxRxX1kFcONgaaoy/nkduKbJtXG6fcEopaf8+P
         JKeMOBAVyuzdce+eMaTR/UIOcCqvc/AuLKc/xzNrxix+vyoUA7Q8KXxf/E5/NeCqp/Mj
         abJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BdDdgDJg4u3AfSraEOaAXu82jnvABq+jK5J4w/oLHPU=;
        b=t7HCUv3fyKGqD1CSO6vDzoSiLtQDz82TnMdLktR3hKek1JMbz+visywQ96MpsdP6b1
         Wi+g7DB2D/uIo+LHV6sQ+Ro/4NmzWl37RtZnt40Fs69Gc+XcAxSZVM5811wUzYS1Otcp
         XHYzAf4Avb6B+TplJb0EV7R0L+koVgXb9reMfEFG4DRYaLtHMZUvEo8XzqHIM2i4c8Mj
         NkSVua4vxVNkvvQtcT/OshRo7fWxT6trxJPdsMdTTb0SQAwTYR8q8NOokfSfSUrAeqqK
         uFg2nef8bCtVYK4CGyXh4DRyGkwIXnb8AmqfgS+rwicQbJSaEW+thPTYPram8HI3y36k
         9YNg==
X-Gm-Message-State: AODbwcANGu2fatdPAw23rx7q2LJdbPz2PDHMujs0196tpiYLdBmPF42U
        SkeNe7XyEMmUFEOq
X-Received: by 10.99.160.17 with SMTP id r17mr36521763pge.95.1496277061397;
        Wed, 31 May 2017 17:31:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7872:b8ac:87ee:2203])
        by smtp.gmail.com with ESMTPSA id c63sm28914055pfd.8.2017.05.31.17.31.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:31:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv3 3/4] builtin/push.c: respect 'submodule.recurse' option
Date:   Wed, 31 May 2017 17:30:49 -0700
Message-Id: <20170601003050.4221-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gab62347cd9
In-Reply-To: <20170601003050.4221-1-sbeller@google.com>
References: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
 <20170601003050.4221-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closest mapping from the boolean 'submodule.recurse' set to "yes"
to the variety of submodule push modes is "on-demand", so implement that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c                 |  4 ++++
 t/t5531-deep-submodule-push.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index a597759d8f..258648d5fd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -498,6 +498,10 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		const char *value;
 		if (!git_config_get_value("push.recursesubmodules", &value))
 			recurse_submodules = parse_push_recurse_submodules_arg(k, value);
+	} else if (!strcmp(k, "submodule.recurse")) {
+		int val = git_config_bool(k, v) ?
+			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
+		recurse_submodules = val;
 	}
 
 	return git_default_config(k, v, NULL);
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 57ba322628..712c595fd8 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -126,6 +126,27 @@ test_expect_success 'push succeeds if submodule commit not on remote but using o
 	)
 '
 
+test_expect_success 'push succeeds if submodule commit not on remote but using auto-on-demand via submodule.recurse config' '
+	(
+		cd work/gar/bage &&
+		>recurse-on-demand-from-submodule-recurse-config &&
+		git add recurse-on-demand-from-submodule-recurse-config &&
+		git commit -m "Recurse submodule.recurse from config junk"
+	) &&
+	(
+		cd work &&
+		git add gar/bage &&
+		git commit -m "Recurse submodule.recurse from config for gar/bage" &&
+		git -c submodule.recurse push ../pub.git master &&
+		# Check that the supermodule commit got there
+		git fetch ../pub.git &&
+		git diff --quiet FETCH_HEAD master &&
+		# Check that the submodule commit got there too
+		cd gar/bage &&
+		git diff --quiet origin/master master
+	)
+'
+
 test_expect_success 'push recurse-submodules on command line overrides config' '
 	(
 		cd work/gar/bage &&
-- 
2.13.0.17.gab62347cd9


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6222023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761735AbdEVTs0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33009 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761721AbdEVTsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:18 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so91774721pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPii7wBoi99iuVpljPYziFiXFeZ0wjsXuUTUsFqlzfA=;
        b=n0P0DNmwXoz1xRTSPqRRokNuBYjY8esYYfO4LcrzDw1TMfIxEQuZjUMOt3OCou3MHV
         W8qX6gF90ma+y6oLx/GhAuS5iqQaBvmPYgQ68fm1oWjWSNsnzHt96kBUy1SaS/9LBTqb
         +z4x45A0xPqWdzrrdeRGw+ei9i5Z9+sTrDVOj6qz3oz3pRNN+frGP7kC+pFa3jUh1qen
         /+ZHiKCROYxKLNXrFOGnxT5jAbzfslhxytrhBphvgzZ3xLq0IDFfJUtBpJcd2yMhZecG
         VbZSLIJaLy7VLa8NnIqHudLFj1aZjQ60WYEAc7bH5HH+0ZsS0TV3ynD1GXTou4wtU45o
         wP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IPii7wBoi99iuVpljPYziFiXFeZ0wjsXuUTUsFqlzfA=;
        b=R1F4MQoFDgdu6a9PojKwoOfdHyo1CTcBaEDgWm/qfM4k69M/r1zugyJi9lioFC9GPM
         gn4271ojbRKbc0d1zXfv8kbzH64cqd1WW21y6+Ry2Uah/mXDpQMuHQEBs1u20wbTASBd
         1NKzc/bOQbJhRDh1GfJZFa+8Fo9HoZxPQghJcehUMXAkppO7rt6Rg7/+ZKithqVECcCk
         ZbI2oVXBNnewQAa6n6go8kyesX56tQKE1LaRRhRImd4XVNWVQ7dv+iFhNjyr6qLu68Sh
         traZh/HQMKzSPv6E35uGGHCX8zAvzDAaEWN8MYPwiDOWELJe36MP8S3xYCQubB60M1bX
         Gy5A==
X-Gm-Message-State: AODbwcBHx3U4ZNv47E9dt2ZJyvh4tMlrAskbkMuhCLaifM8p19/1afmQ
        1tU0t2TPKZrikvmu5TpWtA==
X-Received: by 10.98.160.74 with SMTP id r71mr27267469pfe.16.1495482496908;
        Mon, 22 May 2017 12:48:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id v13sm34253644pgo.44.2017.05.22.12.48.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/6] builtin/push.c: respect 'submodule.recurse' option
Date:   Mon, 22 May 2017 12:48:06 -0700
Message-Id: <20170522194806.13568-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170522194806.13568-1-sbeller@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The closest mapping from the boolean 'submodule.recurse' set to "yes"
to the variety of submodule push modes is "on-demand", so implement that.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/push.c                 |  4 ++++
 t/t5531-deep-submodule-push.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 5c22e9f2e5..fcf66b3bec 100644
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
index f55137f76f..97c1f14f6b 100755
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
2.13.0.18.g7d86cc8ba0


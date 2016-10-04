Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9895520986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754165AbcJDT3T (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:29:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33506 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbcJDT3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:29:17 -0400
Received: by mail-pa0-f48.google.com with SMTP id cd13so72296817pac.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmGgiN9RILL5t2av3DO/UUASTByd4a7iLFPkRY5QMvQ=;
        b=abLRADTONY2lrHoM3+GqRkSAioSDEHjxSQYR/kcJepoxrwqKnx8Yg23s4amRF+gVRc
         5bPWO2Y9e4Bz2rF5mULemvk0IKG8ylCLNbZJu+SB8KgrfU6nOJfJe4OsyZrBMq0W7c3y
         wfrWOGI1WUmHKT5W/WWy4hln+Ck+japF8s3+YZiMoqCt0uIs6/BT7UAoA2EyH9Oel5+1
         vb3aP/ufuZngl+6zZKzjFslK22M2q/mI3KIZY1lJuLV7RAHLu7xHB83UrQ6J+gFhA7mZ
         W7SaYEQUEnVVGbz4t0kNy7BcOHLr8cjm/CECThmxSJvm0B6iQdUr3HATmji8Cux9F4Kj
         2Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmGgiN9RILL5t2av3DO/UUASTByd4a7iLFPkRY5QMvQ=;
        b=eZ2+SuOmYohrjTDU5xg/KxroEHaAfH8fisY7rlMKfl0TtmGch+ctBtQ8Er8SXN1WP7
         xb4rE+0HxUbNMvJA48NCcFzxZhrvSpC2fA8KsOMT9Ub1HQnprDqP/s/tHOyvX6SslS9+
         DhHUzqfpCc5xk3lgMWB49nKqzW2yuhCiPWgUcDtk39LKa2BTCBK44UKR+h4LO8O+UAfB
         E2LVjf7viVhsUv75NOcqhcJqvlJWQu6escu74JuAzKhrCulNgUqPo0cc66S8VxbBdsLK
         uU2L8G0CmX0eDal3LVcGu1x/M5BpcAsOeb/H7PL2hGX8O1wBwDHCqH5Rw450/HJ5noHV
         ImqA==
X-Gm-Message-State: AA6/9Rn0avoc7pzk4230dSYhH2PnlCm/g4PpSpQ46lsofsNxSx02UXNe19p+ARh9+g3yolgo
X-Received: by 10.67.3.102 with SMTP id bv6mr7442684pad.61.1475609356960;
        Tue, 04 Oct 2016 12:29:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d1d:42df:48d7:33a4])
        by smtp.gmail.com with ESMTPSA id t67sm57190516pfd.32.2016.10.04.12.29.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 12:29:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] builtin/push: move flags do_push
Date:   Tue,  4 Oct 2016 12:29:10 -0700
Message-Id: <20161004192910.30649-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
In-Reply-To: <20161004192910.30649-1-sbeller@google.com>
References: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
 <20161004192910.30649-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In do_push we set the flags for other options, so let's make the code
more consistent and also apply the flags for recursing into submodules
there. 

Signed-off-by: Stefan Beller <sbeller@google.com>
---

No functional change intended, just a cleanup while we're at it.
Feel free to drop if it's too much churn.

 builtin/push.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 06fd3bd..6690301 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -388,6 +388,11 @@ static int do_push(const char *repo, int flags,
 		    "    git push <name>\n"));
 	}
 
+	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
+		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
+	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
+
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
@@ -576,11 +581,6 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
-	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
-		flags |= TRANSPORT_RECURSE_SUBMODULES_CHECK;
-	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
-		flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
-
 	if (tags)
 		add_refspec("refs/tags/*");
 
-- 
2.10.0.129.g35f6318


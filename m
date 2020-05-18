Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BFC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DFA2067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHQ1L8NU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgERJkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:40:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E032CC05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r22so4555637pga.12
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFHJOZA82sJ+9MWbERxNEjcNb3NdFVhnyAGLOj19aYM=;
        b=nHQ1L8NU2IqOb8D9gSsvyvAg8aj/XauoCSg3hViaxCYCjycYMoJCqFuRjc//ztwlDg
         p1zMZQPiYMwkKnt4rDz7k36OHIsnK4uiCso7rXeNCj3+8tZ1OPH2tAPTqSp5G8xPAiRG
         xbhQQSipWMK99xkcWq01DrLL3CkA/WUUwt0v5uE+mReqDbCklH3iuFZDQ0GvEEhbBo2w
         bGsQfkYNZjyeWG5ad/VpK4PyYRc2rRhPziDpI7pQ3dTImsLnIfzMLPxYJAoW4LIRZTsg
         EbVw/sRwEAeFBX1u3QuQUKCMSJ1t8fw+bFrN2sHyvmw0sljyeCt0rFzH8co8k2NhLKbc
         c/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFHJOZA82sJ+9MWbERxNEjcNb3NdFVhnyAGLOj19aYM=;
        b=SpAQD1cbaWleI4sNjIpw6r/I1d2geuApNb7N35S0NC1HMh+4tZNfksdjPejAxab//N
         eCgZHJ6NW0c0YNV8/qY07zUC577YK4kzdaNi6QTHxmPcQYBoOtriCSWKbchqrrhR8q/R
         Dl0iw4L9+z1bh6GV7w82XIlbzjqjMB8psw7MnPNuWF/2q67R1klxdBKtui7O/jnV45AI
         MHV6g+oNQTBzumFDrFQACrH+C5oBD+h75BGaAMcOJK1oNNDuKdiJN5fIrsn17Sssr2rH
         vQ/t1OZXFbCj1eEUQpCqXU8kFDj0AynIZC8bbjey7VeM4iUu+RK6pBRlWZM8bn+DkF+8
         iR3Q==
X-Gm-Message-State: AOAM531duGIev8HQj9i9eoKotieTmAmiQir+9HHcDRSLaf9jvey16gon
        e+Rd8cvmqJNKRHhAnaR82+x7lDmf
X-Google-Smtp-Source: ABdhPJxpJ5M5qW4vKXnWYLNcpuIIS0M6cP9IXOxWYaRYpVw0J9vD5hni8/v72UDX8MF/BRuaUMlEfg==
X-Received: by 2002:a63:514:: with SMTP id 20mr14116285pgf.150.1589794850470;
        Mon, 18 May 2020 02:40:50 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:40:49 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 01/11] transport: not report a non-head push as a branch
Date:   Mon, 18 May 2020 05:40:29 -0400
Message-Id: <20200518094039.757-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5516-fetch-push.sh | 2 +-
 transport.c           | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9c6218f568..77938db77f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 15f5ba4e8f..26fefd13c1 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.26.1.120.g98702cf3e9


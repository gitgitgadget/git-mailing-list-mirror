Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C783EC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A22082F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWtfrJ0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYM7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:59:15 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42743 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYM7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 07:59:15 -0500
Received: by mail-wr1-f47.google.com with SMTP id a15so17913326wrf.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnmuCf3GiT/ZLc0vcfxDQZVDEjcfFInmvNwtVxL712U=;
        b=RWtfrJ0s4N89qTJTaF4GXrWuUEi9jXayxlEC5WSVNM3/qdxy3kpDg5PYEgqSIzirR7
         6HTQ6PkNjDjT9hsxRvzRDTx51wGroDD/5SxKNJ342lFdKMzJnZ83aZXutJdjVe9R49NE
         xXJLsdC3MrkYDwp/k905nIAbqaa61sdL8UAfu0eGl0lLJjWjHrJY/tfn2WPhN3ocmFPK
         H4ZUlnOKlQiet2ShPzy/ZfRIwaVIR/9sSdbU1UhH8e9/x51o0jf5jssjnoJLJftJxOi/
         lnrfOnrv3nWjTfw0V+SAGcEa5QEPV0kS1IDdlTlFzpPrjOUCOygD2FzrFg3Tw6pPA1MA
         6tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnmuCf3GiT/ZLc0vcfxDQZVDEjcfFInmvNwtVxL712U=;
        b=SJsU3VODhR64Jw4qahpAxuh+XRkJDosjqiUjBk20vl1fB4WO3YZz/y8zP05+tlMIyy
         m2+fL6YQVzmp95UR3aZgqpdLPp+bZ6V8Ndxr1IbA4rWqfIA3yYMaSdHw9e6M561Q85yw
         dlEVY2bpVZpukdAvjAiJPKnSBwnsbrFxJ+2TNr3IeEWkQSKQFKlwY5Xuq5N4FpK5u3Yk
         UDnp1nu3C0yTDHhbXy6uN6rLMrN3/jst6DqCWoLPWgfucsHdHQturxcse0IST6qpdwVc
         UoWrAzNBLfuSrreTjeuSL05XumFeovM/nxmjb9KjBuF5DGCCzW5HDEhjojtSbgf6k9m4
         t1+Q==
X-Gm-Message-State: APjAAAV8e6R1/3wbF/X6X5XQ7v8fL2aiNHDvI0Y5aHHiCa2usFa5WUut
        curhBiezgZ8yzkXiNioau68=
X-Google-Smtp-Source: APXvYqzuJNHTRPkOWqG5YFyDNc9HLVQ26n/e0vRdhKixd3SnH/8Mwzhg1RbHeh3XBWIRnxFK1dmtvQ==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr2352573wrx.212.1574686751645;
        Mon, 25 Nov 2019 04:59:11 -0800 (PST)
Received: from localhost.localdomain (x4d0c37f4.dyn.telefonica.de. [77.12.55.244])
        by smtp.gmail.com with ESMTPSA id r2sm10268390wrm.71.2019.11.25.04.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 04:59:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib-functions: suppress a 'git rev-parse' error in 'test_commit_bulk'
Date:   Mon, 25 Nov 2019 13:59:07 +0100
Message-Id: <20191125125907.28967-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.587.g7096fda53a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'test_commit_bulk' is invoked in an empty test repository, it
prints a "fatal: Needed a single revision" error, but still does what
it's supposed to do.  A test helper function displaying a fatal error
and still succeeding is always suspect to be buggy, but luckily that's
not the case here: that error comes from a 'git rev-parse --verify
HEAD' command invoked in a condition, which doesn't have anything to
verify in an empty repository.

Use the '--quiet' option to suppress that error message.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b299ecc326..6302bfb51d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -308,7 +308,7 @@ test_commit_bulk () {
 	total=$1
 
 	add_from=
-	if git -C "$indir" rev-parse --verify "$ref"
+	if git -C "$indir" rev-parse --quiet --verify "$ref"
 	then
 		add_from=t
 	fi
-- 
2.24.0.587.g7096fda53a


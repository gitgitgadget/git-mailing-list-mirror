Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C0C64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB1XjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjB1XjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD2199CE
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b20so6860333pfo.6
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXJSsdVXthqG+kEn20I/vA3oLh2scYBLnzjKH4/03V0=;
        b=Rn2M7uZ7jCk0OiIG+zGcnLj7lSAm9hhjTEwVtZFpqW3IBLPpfK0jpqJHQUHVOe93G0
         FonJ9xckhcBRyDhvaxe4JFaYUbfN5zYoGlj7egJ2+mXszgg21/IoBf61l1RAjGJoYKUQ
         FFWpR8EedrQeD8JrkmJsopx8FXFfzjlDu7IA1iIzDdXwj5/eC6BaxgTnPxzWfVg7xCRJ
         Ybi9xIRLYp6CBPNRAtuLEWg5yT3xafs8RNgqxhUAFO9OQPggQVUGZ/Gc7rCTwItOafKt
         VbFIycLjE5J5kzoivk0rfEfXImPZhHcjobfxFGrTW3iQnTgzeUepvoTAWWx/GQL0qVhe
         TJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXJSsdVXthqG+kEn20I/vA3oLh2scYBLnzjKH4/03V0=;
        b=ryy5eIQrGwRlomMafO0UoKRWxGb4s9TvVcwT47/TNFl89sfg5w4SRACM66DKScx6TR
         aB5m62DVjWJYMa5C/uxrMheIUfIq1l2iC86XDBHVkKvxhvhlthurlFaS4qznjX8dimFB
         CtSyOr10/WzqXeS+FWMWC795PKqDnQWGrIfYZzp9wvBC6wp18aVSdwfqg/EeEwgLKkFy
         oKTpP8HH9IQmpuQ3Asq5kt9syGmhB2yZClDNzRSP3+R5Vf9uJD8IDWVt5A5okKBl3r9U
         ZuhTJous75FrcnXtiTjsgTi5oFvYVjhmmk6uMrya0ooA5jfnNmZrivnhhabKckI07F45
         9K6A==
X-Gm-Message-State: AO0yUKXP9RJD2x2M1GwfQJyr+X8kyKR0mxYrJBzWjsQUZ9C3VqLHJLFI
        pjm/lhdraB06wzIU6RhQILznPX4N6T8=
X-Google-Smtp-Source: AK7set8j2y1EQk6FuEqeklGs1K6CspA5OdUue+Bs3kwsOd9R2QDjwBj5qfTVI1r+xFYC8XNPT0wxtg==
X-Received: by 2002:a62:6346:0:b0:5db:c07e:9e4d with SMTP id x67-20020a626346000000b005dbc07e9e4dmr3799610pfb.6.1677627554906;
        Tue, 28 Feb 2023 15:39:14 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78545000000b005a54a978c1bsm6579297pfn.7.2023.02.28.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 02/20] t5541: stop marking "used receive-pack service" test as v0 only
Date:   Tue, 28 Feb 2023 15:38:55 -0800
Message-Id: <20230228233913.684853-2-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We have a test which checks to see if a request to git-receive-pack was
made. Originally, it was checking the entire set of requests made in the
script so far, including clones, and thus it would break when run with
the v2 protocol (since that implies an extra request for fetches).

Since the previous commit, though, we are only checking the requests
made by a single push. And since there is no v2 push protocol, the test
now passes no matter what's in GIT_TEST_PROTOCOL_VERSION. We can just
run it all the time.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5541-http-push-smart.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index ef39d14ed2..f8bf533c33 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -86,12 +86,7 @@ test_expect_success 'used receive-pack service' '
 	POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 	EOF
 
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
+	check_access_log exp
 '
 
 test_expect_success 'push to remote repository (standard) with sending Accept-Language' '
-- 
2.40.0-rc0-32-ga0f05f6840


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669A81F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 01:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEBJQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 20:09:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33764 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfAEBJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 20:09:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so2140759wmh.0
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVFvnuSxFV9oW9YQJvHHg8tMg7RK/1D7fcAjkzudMCc=;
        b=Cy1CuElrKtS8gbxqDiwRhLTd8a8+Srk4WRrN+tJeSqXxW2ed8PrZooKLvGh7TPdI30
         lJSUCXvovuQQce1cbItUsSWQMKNEHD93oif9NcOiVR/z3Wxk0DJ4tOqlIwDag7KN0UtT
         IosKj4zQ08ZQFtBsoDRSKrNEMymnTbHgznhx8Otg7tTMTy1sIHCaP1ArUjG6MfT/ldXW
         xTiJZQ7CV0pip0OB0dMSOOJE8hU2heCuNlZNhwtdfLFxp1hNz5+4m/HWA+Rs+LxDzKL9
         RgqqJt7aWHDijvAktU+CIB//ALFtE3UKi4KIDAQJMXkkC0vVL3Pb0QYmBUCn0YFX2mzH
         jiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVFvnuSxFV9oW9YQJvHHg8tMg7RK/1D7fcAjkzudMCc=;
        b=Zn+zG3r8QC11z3mY4FTWvFx/e5lCpQ8kiFSDMSL2dijxAwvE0BKHTje/6HxS2loIHG
         DDlNEnR6bADaeW8Krk1sOe9jc4fOiEDbBCXIDHnjXTY32OesYGZlOTNdUiAQfQtn/vwh
         Y8LiSisUTZRwlH/o8FndfxHHb8pohDK/ex6lhDs3H2UwqSlGDR0QEWk5bg0dREwegW0w
         oP76Y724thAHNxvLPzxejHoDcSEGkf5we6DVyhv+oyjSWDLlmerMcs+riLLU46ebm1RZ
         8Rb5WZ6oduSLsypkn2V1fi66WCFIoR076Y7QvdR/AC96k3ssOLp8TXFeY6dSg9RYnHxa
         zBVg==
X-Gm-Message-State: AJcUukerv0yu8dSSfUTSlBbA8W7twgO16xs0vQBBHmGkuKXXquBGSNkj
        xXwRAWcQiAeBreYZ9NheF1w=
X-Google-Smtp-Source: ALg8bN7rqHJPxKGtqJgSKnwuPa4WgnUBJ/pXEdXEnuBiMU4ni7R2ASs26Xa9Q8hIJjjjkmOaqbFWrQ==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr3057249wmf.144.1546650554355;
        Fri, 04 Jan 2019 17:09:14 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id c15sm1851353wml.27.2019.01.04.17.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 17:09:13 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/8] test-lib: translate SIGTERM and SIGHUP to an exit
Date:   Sat,  5 Jan 2019 02:08:52 +0100
Message-Id: <20190105010859.11031-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20190105010859.11031-1-szeder.dev@gmail.com>
References: <20181230191629.3232-1-szeder.dev@gmail.com>
 <20190105010859.11031-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now if a test script receives SIGTERM or SIGHUP (e.g., because a
test was hanging and the user 'kill'-ed it or simply closed the
terminal window the test was running in), the shell exits immediately.
This can be annoying if the test script did any global setup, like
starting apache or git-daemon, as it will not have an opportunity to
clean up after itself. A subsequent run of the test won't be able to
start its own daemon, and will either fail or skip the tests.

Instead, let's trap SIGTERM and SIGHUP as well to make sure we do a
clean shutdown, and just chain it to a normal exit (which will trigger
any cleanup).

This patch follows suit of da706545f7 (t: translate SIGINT to an exit,
2015-03-13), and even stole its commit message as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c34831a4de..4c3744cce4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -476,7 +476,7 @@ die () {
 
 GIT_EXIT_OK=
 trap 'die' EXIT
-trap 'exit $?' INT
+trap 'exit $?' INT TERM HUP
 
 # The user-facing functions are loaded from a separate file so that
 # test_perf subshells can have them too
-- 
2.20.1.151.gec613c4b75


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B158E1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeL3TQy (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:16:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36930 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeL3TQy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so23233474wmd.2
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P8f3P+5kgKxaF428sywJpWeG6m7hTg0V/ip9Ral8UY=;
        b=HGh3D2DcLj402j8Td+xw31nl3NyzcUQBnNcoz6Js+LO8+74E4puDVKxq0FVxzrOM//
         vlwIlr84Nf6U/0VnobZarbJhYxsr0sZV3FOPp2ZAnoREyKHhGchLNhfmt/TJUlzyx2uL
         sm5wuyeYkp/ulMCqjC2zqxcriMxPWxfgDw68gVaIEFyaPGKp6ARsJ/TAjzJBWflYOCTg
         MGder4kH5p78HXHZnbWPHqpPOSDjGgGfdIeI5ue3yyYIGj6Gi3NUJaxmk7yM0DQpExfR
         hoR/4dEOCcaOuVN2TOjOPjC4/GcEGT/hUofMWdKEfUK+A2J5ca1MlMbN3QxkA2/BrBG9
         ERGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P8f3P+5kgKxaF428sywJpWeG6m7hTg0V/ip9Ral8UY=;
        b=MAIqaF1iLS4CvTOkUBqHI92G/j7xDFUrAGYLC4wdCvsAflNuB6RKpCPzyFyWigPx6z
         E/D6CAxuh2tC6+gtU++kh9mxOqW/Aom6ATkp/7ADDi8mSmqWBWXsCJ+gOquYOHqtLd3b
         fPoB1gKSdl9LEbjJJQ8Zb/jr/s6jt0rWQb/JhuQYy42DQq0ZOAnW69oznR8QRPqaVPr0
         Pwdtp1rDcVlKJFaExWSegCE0EUj3uFntpjOgllbME5xVFL1WILp9xCc3lAJzgSK+0NsH
         NlBfMFVaqL/RXU90c1rJQg6BAuux3ahBum+J8BSa8R59NoWEY9NlDjSQFQ2e5N7wZyCD
         04sw==
X-Gm-Message-State: AA+aEWbuoEMSIrm5q/9udgDtlUhkm6x/eVVwKy9hHPlY5zVW7pxGSBmf
        WGCMI9FiV8mBOQMK1WfS7Yoozvgj
X-Google-Smtp-Source: AFSGD/XyXe2jNW10uyUZqOYLAi2iqe0dH0pOGpwx7wE1rrfX5QLmtveF/ukd54bY4kacpUe62qtfKw==
X-Received: by 2002:a1c:47:: with SMTP id 68mr27824210wma.89.1546197412458;
        Sun, 30 Dec 2018 11:16:52 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:51 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 1/8] test-lib: translate SIGTERM and SIGHUP to an exit
Date:   Sun, 30 Dec 2018 20:16:22 +0100
Message-Id: <20181230191629.3232-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
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
index 0f1faa24b2..9a3f7930a3 100644
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


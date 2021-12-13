Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhLMGcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhLMGcH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27481C0617A2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i13so3235915ilk.13
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6E58MIW/2W+ewUn8HNh40biFKgvMgBcrxH/UBIAPcA8=;
        b=TGs5ghwjzEb1zMg3Q4sDrwsnUfmHLz217su7wojRvEIwxETbIxGwJTjJObQ0k1DFzf
         nks807PnBOP9BQIzkicUwajLUs1OhWxTddTOc7v2aO8bN1G6Cix5+oICsLoGawguCEDG
         H9S8Nu5vhswE0eFBhzKmgV4PJthVXaBIfSwLwKYMv9RJoMKXN9MxqBHA5aDaZSJGzbIh
         2E4wo4Ipm+4+H/bLSWMQV+e2gS8PLpcYCenk775FSMpnYPXV2+JOa87G4egkkjIhRFJi
         di8iM6S/qw0Mo4qVwwNP84Visk+mcTBK3Rc1hlIjRisb22jmaTlc76lrq/o2m8pJhjSx
         /dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6E58MIW/2W+ewUn8HNh40biFKgvMgBcrxH/UBIAPcA8=;
        b=6S3oQX5/3mYER5hXCMH1sPnb9DNuIOe2un+zApxKavzPBjGaODmiGRTwgGCwNDUvp5
         EjKqVPDiEQyDoC+w1nc/jwb03hnLuaBygFGEUC1Jo8oMa1xSVTH9wSQtxCD4bOv4WWY/
         Wzp8c0BjOu3z+C8UtC77nz9EaO4mRbDhl5RkfJKSaSDvWyFM+f3wt8WKuAzhr2LEI8KF
         wnynp338Il69bZX8Wn7C2RXV9iU7Hwl6ljXUGxuBGJOdZrcobdkLbg9tsMCaA73B9xg/
         aAXuv3NfU1ruXe0oguSLB+igQ6BrHJne1mSOqjslvVmguUlB0kHG4Ff/hz0IGCtHXZ/o
         jXow==
X-Gm-Message-State: AOAM530JNeYxITxmFohIKsLYvssc9aAxs/HDtkN7/jLnttBq+XFi7FJN
        aHsyYHOdVwa5NA19NE6rUm19Go0BvX3CaA==
X-Google-Smtp-Source: ABdhPJxwsV8iHP7qYUVl+U5R8grvphnBgwP+s5FJN5Wc1olue6q5W3/+nK5Lilch0EO7Z0qLY9VJzA==
X-Received: by 2002:a05:6e02:1a08:: with SMTP id s8mr31971418ild.309.1639377126317;
        Sun, 12 Dec 2021 22:32:06 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:06 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/15] chainlint.sed: make here-doc "<<-" operator recognition more POSIX-like
Date:   Mon, 13 Dec 2021 01:30:55 -0500
Message-Id: <20211213063059.19424-12-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to POSIX, "<<" and "<<-" are distinct shell operators. For the
latter to be recognized, no whitespace is allowed before the "-", though
whitespace is allowed after the operator. However, the chainlint
patterns which identify here-docs are both too loose and too tight,
incorrectly allowing whitespace between "<<" and "-" but disallowing it
between "-" and the here-doc tag. Fix the patterns to better match
POSIX.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 2689e13636..b382746526 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -88,8 +88,8 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/ {
-	s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
+/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<-*[ 	]*[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 	s/[ 	]*<<//
 	:hered
 	N
@@ -152,7 +152,7 @@ s/.*\n//
 }
 :folded
 # here-doc -- swallow it
-/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/bheredoc
+/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -274,7 +274,7 @@ bfolded
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
+s/^\(.*\)<<-*[ 	]*[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
 :hdocsub
 N
-- 
2.34.1.397.gfae76fe5da


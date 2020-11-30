Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56175C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CC3207F7
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw1RcRxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgK3EoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 23:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgK3EoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 23:44:15 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA98C0613D2
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:29 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so10437342iov.8
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3N8OmOQFNx6Z25QLFPQLON+DSEIPCgbfupV+r8IndRg=;
        b=hw1RcRxkQHhKLkRD/AySNozKvvbNOGRUkEPeQ7kxIi0qCODVvgVlhwzD1ihzV71SJU
         +Cho0brc49YA6wU1MKGvLUtkaz35Gmfaa1l47IGHzGCT68fNpY29bXk0S6JnPZMCt85H
         S353vB6QCq4we27QbS1xTlQLuIJjxboM+1ZqrcRc07JmZLuw11dKaassezXoKp2i6exp
         JgT6HXl1f/g/vkGPaReicCDOWA666bRMWE5APCpDS8C/Y9plN2pBQ5Gf57tXa3nhbRi5
         tW2Z9KYLF05oC9zolZKq/Ocw/fg+g3hUyTrtiIk40tUrE/fz7nDlN3G0Spjvz6+gDfqa
         +blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3N8OmOQFNx6Z25QLFPQLON+DSEIPCgbfupV+r8IndRg=;
        b=XsaYg9u7//cfUZWVv0UkjBfL0/nf6x1Npy5wE2O+MyUw1HOs8oKbmZPDxkGfZDf2Cz
         4QJZybZ/3JElbl31H44RKjdJ0gWc+KLZZOLUcLoBsQ/tLpO7L3X0zCJI1V/Me07AOxOr
         Qxh9ONpKyC+D7eb7UIDz1qGadoq7T1OpNYA7ubt3a7oulFd+k+H3ymqTmkKduGQ7i5Tf
         gXqumpHMviKzlp2i6qQd7hLPi/7YnD/Tjf/H5L3jFlgu3bkgQGbVzhdoeWH1q93iOsVd
         qawQezPGcC8rItw3jc4FBGF98DcdlM6oiekokG4dB4VW82N3ER+zngp46rMqptpisO7/
         MaHg==
X-Gm-Message-State: AOAM5324Kn6JS9WdZcf6j53pKlpsS4ZegrNb0P05ISZrl1gyoL6zgmXW
        aWYk8Rg7MhK0HXQIOgvbugczxVPFqng=
X-Google-Smtp-Source: ABdhPJyZ5vV75ARCE/jP/3bahB4zvLSHn/bz3lecuQMQWZ9rH19r8TBSlLXkBHs25Sq7rqMiFLhmJw==
X-Received: by 2002:a02:b011:: with SMTP id p17mr12480999jah.55.1606711408573;
        Sun, 29 Nov 2020 20:43:28 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id h16sm9754285ile.14.2020.11.29.20.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 20:43:28 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] t7900: fix test failures when invoked individually via --run
Date:   Sun, 29 Nov 2020 23:42:23 -0500
Message-Id: <20201130044224.12298-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
In-Reply-To: <20201130044224.12298-1-sunshine@sunshineco.com>
References: <20201130044224.12298-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple tests use `rm expect` to remove a file created by earlier
tests. The presence of this file is immaterial at the point the attempt
is made to remove it, yet if it doesn't exist, the test fails
unnecessarily. One case in which the file may validly not exist is when
--run or GIT_SKIP_TESTS is used to selectively run particular tests. Fix
these pointless failures.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7900-maintenance.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0246e4ce30..ef3aec3253 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -429,7 +429,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	EOF
 	test_cmp expect actual &&
 
-	rm expect &&
+	rm -f expect &&
 	for frequency in hourly daily weekly
 	do
 		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
@@ -491,7 +491,6 @@ test_expect_success 'start and stop Windows maintenance' '
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
-	rm expect &&
 	printf "/delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >expect &&
 	test_cmp expect args
-- 
2.29.2.576.ga3fc446d84


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1208C64E7A
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E61021D93
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7QgEeN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392795AbgK0Hvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392782AbgK0Hvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 02:51:54 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58549C0613D1
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:54 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d8so2776389ioc.13
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNhiXpAvChUo67W1GqCsOYvZ7qzYIPgcZa6uJQ3FIIQ=;
        b=C7QgEeN7++XnU6L0cYD5Of+dQsZKkh7dwTMkp1Lo0ZtiiPt1y+npbgg5EGMC3E+9NT
         +zbm85SadE24IIrj1zbBOQhXASXszipBn21/TcR5PUIqCMjzVCAtgipChbbh0T4cjqqO
         IdxG7TlKUm2Y/Vizs2PFP3zV40GNtMVymYDn1t5m+NX13CcpKy4CLMr0uXSX4ktVVmX5
         LcEv3HKk0VwYPSd9lqUxjhGwGOwRp8GHK9q2JtlCoAAh+GEiyTySiqQfx4VOYUQPgGxX
         QqzkfgQkuHtdk3AMVuzJQN76vP48/f6hjI5p6J6TGPLQ1wRffpMEBHjcE939d13StLu2
         iStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wNhiXpAvChUo67W1GqCsOYvZ7qzYIPgcZa6uJQ3FIIQ=;
        b=leBPyR7Ey0EZND9lQwN1q54qYEgQ/ghLWoHhb2ceeeGYE71Swo0/Aw+SXkxvrP1Zbl
         avZvU1m4nOS2OD4xccTei+ItbTuLX0hdPIznZsyK46h875XWTF8MmjRZgg3UFubzQDir
         MyA8tPUrWO9f2ktvv5v9GFWedHjSOs+I0Mt0GfVbsnlOf+iZXsdCKk2zpZMGCwmgsQy0
         NnYc3el33Sol0+Ohe5klLEsDZq43HpcVptx+mHxRX9Cygj+V/N+2KQMvCQd6DCWk0Ml7
         EODEHhePyTHuXpq6Urk+TTDzTT+EI0EUwK/SQrft7iND9WDU6huxIUZU2g5Ga/YscWF0
         rSvg==
X-Gm-Message-State: AOAM531K45+iiwo8sMlgS2q4k/Db7xcxt+kg3YXuiQrm9l5VsHzMON8f
        +5d02F/chL2viCehdQBLW2sIvKVvAqE=
X-Google-Smtp-Source: ABdhPJwTViKLO/Gpgrd+kd3Y6bO57R//5fv4BpZWZWkU62TkLhH1F6xcZqgQEJzw+4cVEFEv1tPaMw==
X-Received: by 2002:a05:6638:15a:: with SMTP id y26mr6415642jao.57.1606463513381;
        Thu, 26 Nov 2020 23:51:53 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 10sm4652447ill.75.2020.11.26.23.51.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2020 23:51:52 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] t7900: make macOS-specific test work on Windows
Date:   Fri, 27 Nov 2020 02:50:54 -0500
Message-Id: <20201127075054.31174-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
In-Reply-To: <20201127075054.31174-1-sunshine@sunshineco.com>
References: <20201127075054.31174-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `git maintenance start` and `git maintenance stop` necessarily
invoke platform-specific scheduling utilities, their related tests have
been carefully crafted -- with one minor exception -- to work correctly
on any platform, thus improving overall coverage. The exception is that
the macOS-specific test fails on Windows due to unportable use of
`$(id -u)` and comparison involving the value of $HOME which suffers
from the typical shortcoming on that platform in which the same path may
be represented two different ways depending upon its source (i.e. as a
Windows path `C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
`/usr/src/git/foo`). Fix both problems and drop the !MINGW prerequisite
from the macOS-specific test, thus allowing the test to run on Windows,
as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7900-maintenance.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ef3aec3253..500eaae4fd 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -408,8 +408,10 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
-test_expect_success !MINGW 'start and stop macOS maintenance' '
-	uid=$(id -u) &&
+test_expect_success 'start and stop macOS maintenance' '
+	uid=$(test-tool getuid) &&
+	# ensure $HOME can be compared against hook arguments on all platforms
+	pfx=$(cd "$HOME" && pwd) &&
 
 	write_script print-args <<-\EOF &&
 	echo $* >>args
@@ -432,7 +434,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	rm -f expect &&
 	for frequency in hourly daily weekly
 	do
-		PLIST="$HOME/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
 		test_xmllint "$PLIST" &&
 		grep schedule=$frequency "$PLIST" &&
 		echo "bootout gui/$uid $PLIST" >>expect &&
@@ -446,7 +448,7 @@ test_expect_success !MINGW 'start and stop macOS maintenance' '
 	# stop does not unregister the repo
 	git config --get --global maintenance.repo "$(pwd)" &&
 
-	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+	printf "bootout gui/$uid $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
 		hourly daily weekly >expect &&
 	test_cmp expect args &&
 	ls "$HOME/Library/LaunchAgents" >actual &&
-- 
2.29.2.576.ga3fc446d84


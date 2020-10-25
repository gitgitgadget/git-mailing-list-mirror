Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D27C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449BD222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419149AbgJYWLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:11:48 -0400
Received: from 0x63.nu ([109.74.10.199]:54914 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1419146AbgJYWLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:11:47 -0400
X-Greylist: delayed 2673 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 18:11:47 EDT
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-CH; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 06/21] t4205: add test for trailer in log with nonstandard separator
Date:   Sun, 25 Oct 2020 22:26:37 +0100
Message-Id: <20201025212652.3003036-7-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-CH; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 t/t4205-log-pretty-formats.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 757575d3f6..42544fb07a 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -757,6 +757,18 @@ test_expect_success 'pretty format %(trailers) combining separator/key/valueonly
 	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers) with nonstandard separator' '
+	git commit --allow-empty -F - <<-\EOF &&
+	Some fix
+
+	Closes #1234
+	EOF
+
+	git -c "trailer.separators=:#" log --no-walk --pretty="format:%s% (trailers:key=Closes)"  >actual &&
+	echo "Some fix Closes: 1234" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
-- 
2.25.1


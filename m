Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6280FC433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426082067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGAJqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:04 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:50407 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgGAJqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:03 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 05:46:03 EDT
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 20D018086D57; Wed,  1 Jul 2020 11:37:21 +0200 (CEST)
Received: from ferret.domein-it.nl (ferret.domein-it.nl [84.244.139.72])
        by smtp01.domein-it.com (Postfix) with ESMTP id 0B81A8086D5B
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 11:37:07 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:48484 helo=ben.dynamic.ziggo.nl)
        by ferret.domein-it.nl with esmtpa (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jqZAs-00066q-Uv; Wed, 01 Jul 2020 11:37:03 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Ben Wijen <ben@wijen.net>
Subject: [PATCH 1/2] git clone: check for non-empty directory
Date:   Wed,  1 Jul 2020 11:36:52 +0200
Message-Id: <20200701093653.3706-2-ben@wijen.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701093653.3706-1-ben@wijen.net>
References: <20200701093653.3706-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jqZAs-00066q-Uv
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using git clone with --separate-git-dir realgitdir and
realgitdir already exists, it's content is destroyed.

Extend test to make sure content is left intact

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 t/t5601-clone.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 84ea2a3eb7..03901c55f2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -271,7 +271,8 @@ test_expect_success 'fetch from gitfile parent' '
 
 test_expect_success 'clone separate gitdir where target already exists' '
 	rm -rf dst &&
-	test_must_fail git clone --separate-git-dir realgitdir src dst
+	test_must_fail git clone --separate-git-dir realgitdir src dst &&
+	test -f realgitdir/config
 '
 
 test_expect_success 'clone --reference from original' '
-- 
2.27.0


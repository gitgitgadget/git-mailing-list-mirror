Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B263C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390C261B29
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhKRQwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52780 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48262218B8
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivlBUFy6KLRqxRf+OtPU/FcocZMZLDnmlNbcKj3V+UQ=;
        b=Xc+A4o1YqkwTuMfIe8Y+D4d+1I7I/kmNTlTzj0teVAYRVzrRUDqVgsZSuU+T1pT/7X4QHh
        vsGzym3B05xSxZYli5Gl/9LsAjnVyP3ueNBpa7+Z4NhcshmZG4u17BPAGda68LqpqYQDxH
        m3aNa5v9tSKgKyrpQ02LlBD+pHWYgsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivlBUFy6KLRqxRf+OtPU/FcocZMZLDnmlNbcKj3V+UQ=;
        b=fJVRzrxfYxr/Vp3eupT6X1BVSBNe/gm+zH8rIyfLATkYcEewgDs8ERFckuPo2AFin5vxQw
        IOrz3GH8BVUPa5DQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1E7EDA3B8A;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 743E91E0679; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 01/27] bisect: Fixup test rev-list-bisect/02
Date:   Thu, 18 Nov 2021 17:49:14 +0100
Message-Id: <20211118164940.8818-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 2 from t6002-rev-list-bisect.sh expects 'c2' as the bisection point
but b2 is an equivalent choice. Improve the test to accept both.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6002-rev-list-bisect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index b95a0212adff..48db52447fd3 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -247,8 +247,9 @@ test_expect_success 'set up fake --bisect refs' '
 test_expect_success 'rev-list --bisect can default to good/bad refs' '
 	# the only thing between c3 and c1 is c2
 	git rev-parse c2 >expect &&
-	git rev-list --bisect >actual &&
-	test_cmp expect actual
+	git rev-parse b2 >>expect &&
+	actual=$(git rev-list --bisect) &&
+	grep &>/dev/null $actual expect
 '
 
 test_expect_success 'rev-parse --bisect can default to good/bad refs' '
-- 
2.26.2


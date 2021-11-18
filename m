Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA8C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67166138D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhKRQw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:52:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57600 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhKRQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 751271FD3A
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diWe5KBRJnS5BEgTzQ7aWOywkai+rWrsV6GF881RCPI=;
        b=IupUE92ig1STvICd7E4qecCwgkXGFu9SS5zXolCp9Z+btLxjL40CF/CYtjkimWxCb1cajf
        8qR5GlmCeoyT/vqY/mN7ahUm6Wl27SlCVVhyZYnTeI0cIcSChQa8mNRsMrr+tpXBH75UdS
        W8HuvI/HcHTCuxEWoYhPXWH4fkFcqXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diWe5KBRJnS5BEgTzQ7aWOywkai+rWrsV6GF881RCPI=;
        b=G8jD0VXW2VopDAIlbkQUtvco+2+vTVGxSaBpSXnnQKEFJ0tOxetdVapqKHN/9AJ6Wz6ru1
        9XQxUc/R+2PwEHAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 678BBA3B93;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 811731F2CA3; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 05/27] bisect: Fixup bisect-porcelain/34
Date:   Thu, 18 Nov 2021 17:49:18 +0100
Message-Id: <20211118164940.8818-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 34 from t6030-bisect-porcelain.sh assumes that bisection algorithm
suggests HASH6 after merge base when HASH5 is an equivalent choice. Fix
the test to work in both cases.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 t/t6030-bisect-porcelain.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index d693c0002098..ed81a6403b63 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -433,7 +433,7 @@ test_expect_success 'good merge base when good and bad are siblings' '
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	! grep "merge base must be tested" my_bisect_log.txt &&
-	grep $HASH6 my_bisect_log.txt &&
+	grep -E "$HASH5|$HASH6" my_bisect_log.txt &&
 	git bisect reset
 '
 test_expect_success 'skipped merge base when good and bad are siblings' '
-- 
2.26.2


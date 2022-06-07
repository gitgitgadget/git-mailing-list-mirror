Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A76C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386211AbiFHA3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1589004AbiFGXzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:55:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769823B156
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:50:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CF4819A357;
        Tue,  7 Jun 2022 17:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=t
        tbYHHhTr1xA+qzYMhmz7qXldn0PHkaWN/prlgC7p3I=; b=SQEo8/Ez9iWXR10y0
        jghFE/9Ic7nzR7A1LyD2wO6iTcDVTShnQlzuADWTD/0y0yamADrVONtMZZsIDv5i
        H7lVku+xSvwe0wJyBQj0Yqk7snh506g67PLGni1PXEiz8xnAgUzZjRBdpP/nnFDs
        bjowVUXrA8CX2WuaiY64lA2bo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6591319A356;
        Tue,  7 Jun 2022 17:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3E2719A355;
        Tue,  7 Jun 2022 17:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] cocci: retire is_null_sha1() rule
Date:   Tue, 07 Jun 2022 14:50:50 -0700
Message-ID: <xmqq7d5suoqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6468798-E6AB-11EC-BB73-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 8d4d86b0 (cache: remove null_sha1, 2019-08-18) removed the
is_null_sha1() function, rewrite rules to correct callers of the
function to use is_null_oid() instead has become irrelevant, as any
new callers of the function will get caught by the compiler much
more quickly without spending cycles on Coccinelle.

Remove these rules.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/object_id.cocci | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index ddf4f22bd7..01f8d6935b 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -1,15 +1,3 @@
-@@
-struct object_id OID;
-@@
-- is_null_sha1(OID.hash)
-+ is_null_oid(&OID)
-
-@@
-struct object_id *OIDPTR;
-@@
-- is_null_sha1(OIDPTR->hash)
-+ is_null_oid(OIDPTR)
-
 @@
 struct object_id OID;
 @@
-- 
2.36.1-485-g100d6d3ce6


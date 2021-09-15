Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B01C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB08C61178
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhIOWep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 18:34:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhIOWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 18:34:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 529F813F93C;
        Wed, 15 Sep 2021 18:33:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=gvzjGLBgX2sMV7PBfjwvjCtUm
        VzTrvN4zW540RXzAC8=; b=m+c64RKsk91HbcVLvFriMTMqfkcNQWTCsiZtwJXCT
        yM6BezIqUHkqtHp1Pn9mUeZh+mWOU+2+/lSE/UH9HSCN+k6F0XCW+XRI5WaNYgw0
        HnaAIM+QoYERap1JGb3HkMa8CUUfqzng2Yhmh9gXdYKCrrZFMXajfwHwesL+Jo5C
        WQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CBBE13F93B;
        Wed, 15 Sep 2021 18:33:24 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83B0413F910;
        Wed, 15 Sep 2021 18:33:19 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] diff: simplify quote_two()
Date:   Wed, 15 Sep 2021 15:33:15 -0700
Message-Id: <20210915223316.1653443-2-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-649-gd4f4107c2b
In-Reply-To: <20210915223316.1653443-1-gitster@pobox.com>
References: <20210915223316.1653443-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: ED564F76-1674-11EC-9868-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement the function as a mere thin wrapper around
quote_two_c_style().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index a8113f1707..8143b737b7 100644
--- a/diff.c
+++ b/diff.c
@@ -482,19 +482,9 @@ int git_diff_basic_config(const char *var, const cha=
r *value, void *cb)
=20
 static char *quote_two(const char *one, const char *two)
 {
-	int need_one =3D quote_c_style(one, NULL, NULL, CQUOTE_NODQ);
-	int need_two =3D quote_c_style(two, NULL, NULL, CQUOTE_NODQ);
 	struct strbuf res =3D STRBUF_INIT;
=20
-	if (need_one + need_two) {
-		strbuf_addch(&res, '"');
-		quote_c_style(one, &res, NULL, CQUOTE_NODQ);
-		quote_c_style(two, &res, NULL, CQUOTE_NODQ);
-		strbuf_addch(&res, '"');
-	} else {
-		strbuf_addstr(&res, one);
-		strbuf_addstr(&res, two);
-	}
+	quote_two_c_style(&res, one, two, 0);
 	return strbuf_detach(&res, NULL);
 }
=20
--=20
2.33.0-649-gd4f4107c2b


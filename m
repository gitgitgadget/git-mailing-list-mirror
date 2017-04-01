Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39D71FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 04:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750760AbdDAEOK (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 00:14:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750726AbdDAEOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 00:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8789834F4;
        Sat,  1 Apr 2017 00:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MlU/pE31QfvCy6ryie+nNYTqfHE=; b=MbhmTp
        cftOkhVL4hwKPIZ90RB9IVOMQJwUu8ArD1KisKuY1jTb0OYS8txRitb2r/ucJ395
        9Y8IVWmrO46jwYE/5fOuaHlRp8ha6Oy4JszYqb1x9fxKENICz8iuzeH0LJT7/h4M
        Kb3imllva/R2lyf5qgdqPjBZ9/kz4WYopkk9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CBGhyGerJqO3Ax3OjDW9rMWxthjeF7aS
        nNwN8GfDpd47etgky0tXiPg2CRUkibOUl0qgoqxmFBrsferFxjB0GXDTgk1xJ7dY
        UVSys1Ze3lK7NpPTqNtmU9RlplM4k0VZR0uQczE8THojGvAl9D+tN0oijRP4hSa5
        VGoL7xa5hZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0DA2834F3;
        Sat,  1 Apr 2017 00:14:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FA8B834F2;
        Sat,  1 Apr 2017 00:14:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] contrib/git-resurrect.sh: do not write \t for HT in sed scripts
References: <20170331173214.47514-1-git@jeffhostetler.com>
        <20170331173214.47514-2-git@jeffhostetler.com>
        <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
        <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
        <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
Date:   Fri, 31 Mar 2017 21:14:06 -0700
In-Reply-To: <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
        (Junio C. Hamano's message of "Fri, 31 Mar 2017 16:18:29 -0700")
Message-ID: <xmqqd1cwwyr5.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B1351E-1691-11E7-AF4F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like we did in 0d1d6e50 ("t/t7003: replace \t with literal tab
in sed expression", 2010-08-12), avoid writing "\t" for HT in sed
scripts, which is not portable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This should hopefully kill the last instances of the same issue
   to make sure people do not copy-and-paste this unportable
   construct.

 contrib/git-resurrect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index c364dda696..3b78ffd079 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -24,13 +24,13 @@ n,dry-run            don't recreate the branch"
 . git-sh-setup
 
 search_reflog () {
-        sed -ne 's~^\([^ ]*\) .*\tcheckout: moving from '"$1"' .*~\1~p' \
+	sed -ne 's~^\([^ ]*\) .*	checkout: moving from '"$1"' .*~\1~p' \
                 < "$GIT_DIR"/logs/HEAD
 }
 
 search_reflog_merges () {
 	git rev-parse $(
-		sed -ne 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':.*~\1^2~p' \
+		sed -ne 's~^[^ ]* \([^ ]*\) .*	merge '"$1"':.*~\1^2~p' \
 			< "$GIT_DIR"/logs/HEAD
 	)
 }
-- 
2.12.2-752-g2215051a9e


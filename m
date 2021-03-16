Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA81C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0E64F04
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhCPAzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:55:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55627 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhCPAzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:55:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72D77B3735;
        Mon, 15 Mar 2021 20:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=peV9jzqEmWjdOyspd3OZ8sy1TQo=; b=r0LwIs
        Sdc7uyVIZoAFbf6XOEpdcOd1ICYlb0DknLu2sBioFuUTpJyGE75gzp8VMpSV+CIH
        mMdFikhUpHOKZLSpFe+g3NOr1HFuoXdplZTh7ZPMD2YGBMy4rb37slt7JGhX6p81
        JZxgTvlY6nejy7BOv2/H0KzSKu6k5umgRpwK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vc2Dm2zThuWsmi428GHd+Ye/QmZ9/upp
        CeajJn1kNvQNuDx4rvn6PnWCm/QJyQMO3TYLvWXwhmbJvUIFFAfiWxC2vI2AnyVF
        FW4mODQPguenq0RZXOQJKlW8ZqVN0hHwU2ZcwZmG+IxRu9yOU3ndZ/yRhgZsNMda
        XLIHEnmJmZo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B2BCB3734;
        Mon, 15 Mar 2021 20:55:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4925B3733;
        Mon, 15 Mar 2021 20:55:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] xcalloc: use CALLOC_ARRAY() when applicable
References: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
        <b2942f67-f0c0-872b-9b8c-11b6ea295412@web.de>
        <xmqq35ww1amf.fsf@gitster.g>
        <48772615-4b68-724f-dae6-4153aafbde35@web.de>
        <xmqqk0q8ynz0.fsf@gitster.g>
Date:   Mon, 15 Mar 2021 17:55:10 -0700
In-Reply-To: <xmqqk0q8ynz0.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        15 Mar 2021 16:52:03 -0700")
Message-ID: <xmqqft0vzzm9.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4284B406-85F2-11EB-B86D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are for codebase before Git 2.31

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In addition to fixes to topics in flight, I found these in the
   codebase dating as far back as 2.27 days.

 builtin/receive-pack.c | 8 +++-----
 t/helper/test-bloom.c  | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ea3d0f01af..6a66687e28 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1837,11 +1837,9 @@ static void prepare_shallow_update(struct shallow_info *si)
 	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
 
-	si->need_reachability_test =
-		xcalloc(si->shallow->nr, sizeof(*si->need_reachability_test));
-	si->reachable =
-		xcalloc(si->shallow->nr, sizeof(*si->reachable));
-	si->shallow_ref = xcalloc(si->ref->nr, sizeof(*si->shallow_ref));
+	CALLOC_ARRAY(si->need_reachability_test, si->shallow->nr);
+	CALLOC_ARRAY(si->reachable, si->shallow->nr);
+	CALLOC_ARRAY(si->shallow_ref, si->ref->nr);
 
 	for (i = 0; i < si->nr_ours; i++)
 		si->need_reachability_test[si->ours[i]] = 1;
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index f0aa80b98e..eb7c011ca6 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -65,7 +65,7 @@ int cmd__bloom(int argc, const char **argv)
 		struct bloom_filter filter;
 		int i = 2;
 		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
-		filter.data = xcalloc(filter.len, sizeof(unsigned char));
+		CALLOC_ARRAY(filter.data, filter.len);
 
 		if (argc - 1 < i)
 			usage(bloom_usage);
-- 
2.31.0-186-g100f68d7d5


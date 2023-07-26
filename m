Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A8C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 05:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjGZFRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGZFRf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 01:17:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B51FEF
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 22:17:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B147194272;
        Wed, 26 Jul 2023 01:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JZfBDq9spURqZIx7Qx7/7lojV32Zo7YOW/NAET
        yIhDc=; b=qdcUjvQ2lbSShk1+ofhChxV/WXgjpY4InmlsPFoX4aO9E/w88rkhNn
        CvsiYj5oqRdmMn7gsLEIv53LP+R/gf53qr2IIK51Q6cF6rdiULxy9OIDrgsGEl20
        JIm7W1Sb0YxV5DAxogRHWgHhb2A/mojlJPvRBs0amTi/LV8kZ2Hjo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 939A8194270;
        Wed, 26 Jul 2023 01:17:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0807D19426E;
        Wed, 26 Jul 2023 01:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: [PATCH 7/5] SubmittingPatches: explain why 'next' and above are
 inappropriate base
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
Date:   Tue, 25 Jul 2023 22:17:31 -0700
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> (Linus Arver
        via GitGitGadget's message of "Wed, 26 Jul 2023 03:04:56 +0000")
Message-ID: <xmqqbkfzfdzo.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B99ED39A-2B73-11EE-B3F1-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'next' branch is primarily meant to be a testing ground to make
sure that topics that are reasonably well done work well together.
Building a new work on it would mean everything that was already in
'next' must have graduated to 'master' before the new work can also
be merged to 'master', and that is why we do not encourage basing
new work on 'next'.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d1e3783978..559c02c90c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -57,10 +57,14 @@ latest HEAD commit of `maint` or `master` based on the following cases:
 
 This also means that `next` or `seen` are inappropriate starting points
 for your work, if you want your work to have a realistic chance of
-graduating to `master`.  They are simply not designed to provide a
-stable base for new work, because they are (by design) frequently
-re-integrated with incoming patches on the mailing list and force-pushed
-to replace previous versions of these branches.
+graduating to `master`.  They are simply not designed to be used as a
+base for new work; they are only there to make sure that topics in
+flight work well together. This is why both `next` and `seen` are
+frequently re-integrated with incoming patches on the mailing list and
+force-pushed to replace previous versions of themselves. A topic that is
+literally built on top of `next` cannot be merged to 'master' without
+dragging in all the other topics in `next`, some of which may not be
+ready.
 
 For example, if you are making tree-wide changes, while somebody else is
 also making their own tree-wide changes, your work may have severe
-- 
2.41.0-450-ga80be15292


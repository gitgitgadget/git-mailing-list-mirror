Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69BC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C85D61920
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEKFmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 01:42:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50702 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhEKFmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 01:42:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 539EBBD5A0;
        Tue, 11 May 2021 01:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W6VHcFLa48hv4Y2TQ5a8rZM3dUbtz7PmQNhvL2
        tAyPU=; b=XBvsr3TuQ4YgQTw9NFHwLdyRN/1cCulN1mw/38coM7bw8HrjAB/la/
        aSSpIV9G7jOEarl1XANBehz7zXwdknTyDH5zh7asStIHl8wTl6ywW7ObHeVOJsgi
        7kPKPj8g5dsCYbCveAQihD0CNASH7beQGzARKZhHf4U+qsp1P5tM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3926FBD59E;
        Tue, 11 May 2021 01:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99F29BD59D;
        Tue, 11 May 2021 01:41:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] diff-merges: move specific diff-index "-m" handling
 to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-3-sorganov@gmail.com>
        <xmqqwns5oqrm.fsf@gitster.g> <xmqqfsytonbx.fsf@gitster.g>
Date:   Tue, 11 May 2021 14:41:00 +0900
In-Reply-To: <xmqqfsytonbx.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 14:23:46 +0900")
Message-ID: <xmqqbl9homj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7843D0F4-B21B-11EB-9796-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll insert the following immediately after this step as a reminder
for ourselves while queuing.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
Subject: [PATCH] t4062: diff-index -S can take its string as a separate arg

Butchering the command line parser in a wrong way can break this
test, confusing the parser to mistake "--cached" which is a mere
argument to the "-S" option as "compare the tree with the index"
option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4062-diff-pickaxe.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 1130c8019b..1c93812378 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -26,4 +26,9 @@ test_expect_success '-S --pickaxe-regex' '
 	verbose test 4096-zeroes.txt = "$(cat out)"
 '
 
+test_expect_failure '-S with separate option should not error out' '
+	# "--cached" here is not an option---it is an arg to "-S"
+	git diff-index -S --cached HEAD^
+'
+
 test_done
-- 
2.31.1-734-g054d640baf


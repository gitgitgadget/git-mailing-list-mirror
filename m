Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60905EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGFRfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGFRfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 13:35:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF4129
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 10:35:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 450AC18C938;
        Thu,  6 Jul 2023 13:35:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ceTGHQHykNaDBgrRGJSFlmmWNISgGiIXJBS6TS
        WR21A=; b=EOCdx/d1QPYBr6ecWUFOfYufu/dZ5qJd/Ai91KtNxjYUX7HaQwfst+
        3E5IeahabwLYPXUEcif/O+lGHyHjFkRveLpAiaHyJhAggrFYPOfrwyA48Dc7OQvV
        O/S/7Ob0ketFfrR4sN4KUNdhnxkkXQp2dwkd30yoC5TF5nrwtwsls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 388D718C937;
        Thu,  6 Jul 2023 13:35:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A25EC18C936;
        Thu,  6 Jul 2023 13:35:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew Hughes <mhughes@uw.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: Expected behaviour for pathspecs matching attributes in
 subdirectories
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
Date:   Thu, 06 Jul 2023 10:35:29 -0700
In-Reply-To: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
        (Matthew Hughes's message of "Thu, 6 Jul 2023 11:33:29 +0100")
Message-ID: <xmqq7crddjtq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80E23A06-1C23-11EE-BDDF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew Hughes <mhughes@uw.co.uk> writes:

> Is this the expected behaviour? I looked in t/t6135-pathspec-with-attrs.sh and
> didn't see a test case covering something similar. If this is expected, is
> there another way to achieve what I'm looking for?

I wonder if this serves a good addition to the tests?

 t/t6135-pathspec-with-attrs.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/t/t6135-pathspec-with-attrs.sh w/t/t6135-pathspec-with-attrs.sh
index 457cc167c7..83e6bac8e5 100755
--- c/t/t6135-pathspec-with-attrs.sh
+++ w/t/t6135-pathspec-with-attrs.sh
@@ -75,6 +75,14 @@ test_expect_success 'check specific set attr' '
 	sub/fileSetLabel
 	EOF
 	git ls-files ":(attr:label)" >actual &&
+	test_cmp expect actual &&
+
+	git ls-files ":(attr:label)sub/" >actual &&
+	test_write_lines sub/fileSetLabel >expect &&
+	test_cmp expect actual &&
+
+	git ls-files ":(attr:label)sub" >actual &&
+	test_write_lines sub/fileSetLabel >expect &&
 	test_cmp expect actual
 '
 

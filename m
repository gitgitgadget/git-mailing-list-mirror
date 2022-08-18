Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58636C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbiHRQyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRQyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:54:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24651AB43D
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:54:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62F4A14C610;
        Thu, 18 Aug 2022 12:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WWgWkhxctDV4wBrmoqMTb2QNmao4qwo1X3v5MM
        eXJfU=; b=muDbh5OwpSJQl8Gq4POsci3h7jSaq7YdhrC5dEs02J65eJaHsWr5Ef
        dmMdto5hYX2+dHYHeLYBXxBaHQ+Fq59vVqBXgSisNQt4J+ugj0Gt0aM122et6l+s
        tG0oQJlh5WVB3QzHPV5yej5Uscw7IvV5PmOKxhI9u51cFxolBiDRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59F8314C60F;
        Thu, 18 Aug 2022 12:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C22C414C60E;
        Thu, 18 Aug 2022 12:54:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
        <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 09:54:15 -0700
In-Reply-To: <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com> (Max
        Bernstein via GitGitGadget's message of "Thu, 18 Aug 2022 07:54:03
        +0000")
Message-ID: <xmqqk075qyq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65543768-1F16-11ED-A58F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v1:
>
>  1:  404a6d1b193 ! 1:  4d490851ac2 trailer: allow spaces in tokens
>      @@ Commit message
>       
>           Signed-off-by: Max Bernstein <max@bernsteinbear.com>
>       
>      + ## t/t4014-format-patch.sh ##
>      +@@ t/t4014-format-patch.sh: test_expect_success 'signoff: not really a signoff' '
>      + 	4:Subject: [PATCH] subject
>      + 	8:
>      + 	9:I want to mention about Signed-off-by: here.
>      +-	10:
>      +-	11:Signed-off-by: C O Mitter <committer@example.com>
>      ++	10:Signed-off-by: C O Mitter <committer@example.com>
>      + 	EOF
>      + 	test_cmp expect actual
>      + '

So, the updated code mistook the body of the message that is not a
sign-off, because there is a colon on the line, the line does not
begin with the colon, and everything before the colon is an alnum or
a whitespace, so squashed the paragraph break before the real
trailer block and the last line of the body and made it a body-less
commit log message?

This might be a good demonstration of why it is a mistaken design to
allow whitespaces, which may steer us toward fixing the documentation?

I dunno.  What do others think?

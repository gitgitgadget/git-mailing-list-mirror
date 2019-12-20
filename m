Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C134C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BDB20866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N+/oK02Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLTSVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:21:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLTSVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:21:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C310899295;
        Fri, 20 Dec 2019 13:21:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Xe55IbJQ4Op65i6WsmlUk+8u8E=; b=N+/oK0
        2Y/gYWa/F8W/VuFQn4M2kH/LNRdPHKcneYw3vwQhCAB+SXdxqhspTtHmwzII8y/D
        kGLxaOExdSL8fFkOuP76Yn9vWAxw9O3SUb/j/YOFabn6KJmfVMkKnQ24o4+Lrazu
        uxNNy27/kSxhwCpMGuYSnjFiBDiMLRewgE2qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A2oleweJgeA5cqbwywXLb/gUk0NeyeUs
        M7SG49WRhxuOo0JcB6+Mj8PiGZoJ4g77b5nRFD5qW4U2nLFarC9IFOjK17e0nn61
        CQ5cxXJRzH8E60gKCnN0K8xk2Gl7Q2viIFK27ymq3Zj+P0lkC+U3L+8UOycUHBki
        jlTi1v7C6d0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAD9D99294;
        Fri, 20 Dec 2019 13:21:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E20C999293;
        Fri, 20 Dec 2019 13:21:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ed Maste <emaste@freebsd.org>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
References: <20191219015833.49314-1-emaste@FreeBSD.org>
        <20191220153814.54899-1-emaste@FreeBSD.org>
        <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
Date:   Fri, 20 Dec 2019 10:21:17 -0800
In-Reply-To: <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 20 Dec 2019 12:55:34 -0500")
Message-ID: <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85095B70-2355-11EA-936D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> anomalous behavior is still present. It would be helpful, therefore,
> to mention such an implementation by name:
>
>     ...some 'ls' implementations, such as on FreeBSD, include...
>
> (One can, of course, always argue that the commit message can be
> consulted to learn about a particular 'ls' implementation, but then
> why have an in-code comment at all?)

"This is similar to ls" is not all that important, especially if we
then need to say how different from "ls" ours is.  The log message
that describes why we needed to move away from "ls" is a good place
to say what aspect of "ls" was unsuitable.

If we _were_ to add an in-code comment, we may want to say something
like

	# Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
	# enables "-A" when run by root without being told, and ends
	# up including ".git" etc. in its output.

to warn future developers against improving and/or cleaning up.

Not that we encourage running our tests as root, though.  I am
slightly worried that the above phrasing might be taken as such.

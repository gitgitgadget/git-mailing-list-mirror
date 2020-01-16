Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1596C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AAA2075B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Py4q7lvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgAPWs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:48:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60395 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAPWs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:48:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAD2A9FCE2;
        Thu, 16 Jan 2020 17:48:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XMvIHGEdhymQ+v21KvTDcGHi3Os=; b=Py4q7l
        vdxOhK1kn1u6g7DHl9gPB7mZf6cvjfJaTCakavYcWO8Iy18NNWViJXZ5yQ1POdB9
        IVPFI89Bp2JKnXzM+yGWyoFlN7qEJgx48X46QQQNqWuMndI6XKgfOz8rmtSkVT05
        9R190K6N8ze99NcCu3aC9Z0/+QdiyS4RYbfl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u2uCAXD+Y6j3fNhGETMSGf7mZDfhzrFK
        sgYBiiSXE0s1wKz8wzV6k0E+Fv/JMy2Zx4uIXV5DwsMnHF8mBqIu17XWUmnZ47BH
        tZwphj+MMACRVYiAaFxbP50MqMJLmLLMvg9vr7O0sjgb9pe4W0pCRpbA3IRqaLqT
        oZAJTfYSA1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E277B9FCE1;
        Thu, 16 Jan 2020 17:48:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1A0BD9FCE0;
        Thu, 16 Jan 2020 17:48:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7800: don't rely on reuse_worktree_file()
References: <20200116181940.GA2945961@coredump.intra.peff.net>
Date:   Thu, 16 Jan 2020 14:48:19 -0800
In-Reply-To: <20200116181940.GA2945961@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jan 2020 13:19:40 -0500")
Message-ID: <xmqqo8v3f26k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C272FE0-38B2-11EA-8EF2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... At any rate, since reuse_worktree_file()
> is meant to be an optimization that may or may not trigger, our test
> should be robust either way.
>
> Instead of checking the filename, let's just make sure we got a single
> line of output (which would not be true if we continued after the first
> failure).

Makes sense.  Thanks for spotting.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7800-difftool.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 6bac9ed180..29b92907e2 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -125,15 +125,14 @@ test_expect_success 'difftool stops on error with --trust-exit-code' '
>  	test_when_finished "rm -f for-diff .git/fail-right-file" &&
>  	test_when_finished "git reset -- for-diff" &&
>  	write_script .git/fail-right-file <<-\EOF &&
> -	echo "$2"
> +	echo failed
>  	exit 1
>  	EOF
>  	>for-diff &&
>  	git add for-diff &&
> -	echo file >expect &&
>  	test_must_fail git difftool -y --trust-exit-code \
>  		--extcmd .git/fail-right-file branch >actual &&
> -	test_cmp expect actual
> +	test_line_count = 1 actual
>  '
>  
>  test_expect_success 'difftool honors exit status if command not found' '

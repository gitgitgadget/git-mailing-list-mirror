Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CAC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EBB20882
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dlro6JOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLZT0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:26:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50186 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLZT0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:26:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A971019E64;
        Thu, 26 Dec 2019 14:26:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BwrX6bPIiLoJTeJR6UZvXtE/CZA=; b=Dlro6J
        OwEliQVqFeUxPHBBTHLVl0KoGWM2y3U2c5prvy/88R18NlO3CkjIkLTo1GBnDd9e
        7RCAI47NqTbYKbRZJeaFRhP1OqVm+KSUb6AYyiGLzOloz8hWRyFRHWpw0H05bvtj
        ruGjtqxCLg0SscKHaatw4NzDbLgwYQNX5R5CA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gru7LWUgbnzS1UK6MhNTNied+7WR0lS0
        9pikHTXirYqfEzuB9H4CjHtwLDKDpzh7zhtlZP5+fPrdtPTmY6zwx4VCgNVaJWS2
        8QPzLmwfAxngi9S2UrA5oHjtPR/yil7ogRv+j3IR7Nazh1X34tZUFuqwBFgTlwRY
        tTnNJIuh1Js=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FE1E19E61;
        Thu, 26 Dec 2019 14:26:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5B6219E60;
        Thu, 26 Dec 2019 14:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 3/5] test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate
References: <20191224005816.GC38316@google.com>
        <20191224010110.GF38316@google.com>
Date:   Thu, 26 Dec 2019 11:26:34 -0800
In-Reply-To: <20191224010110.GF38316@google.com> (Jonathan Nieder's message of
        "Mon, 23 Dec 2019 17:01:10 -0800")
Message-ID: <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1A48416-2815-11EA-A490-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
> index f70cbcc9ca..a2a5e0743f 100755
> --- a/t/t5552-skipping-fetch-negotiator.sh
> +++ b/t/t5552-skipping-fetch-negotiator.sh
> @@ -107,7 +107,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
>  
>  	# The ref advertisement itself is filtered when protocol v2 is used, so
>  	# use v0.
> -	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
> +	GIT_TEST_PROTOCOL_VERSION=0 trace_fetch client origin to_fetch &&

Didn't this trigger "FOO=bar shell_func" test lint for you?


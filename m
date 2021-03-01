Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E297C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FA565411
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhCASGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:06:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52268 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhCASCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:02:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5A71AA502;
        Mon,  1 Mar 2021 13:02:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lmMa2I1/It2PUYxt0FtBC+xpMKg=; b=BbGrja
        /LbY4TceIlhlqUoBvihyVBDnc3pM91i0hyHMswtzZOAe4+bTR5XU9DvUBD9F9ii1
        9AhXT80HIizoA8kPD3wdKu6CI00mYPDZLpWmoyEtpp34cfg9yMXmMSK1jKcri5Qs
        1ZLeEGgG8SzW2RHlJh21aJaehyaPvCD/PLkpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t1z4QDspokFCYwBLhixN38FcYcgPvRm7
        2yuPLX3W3iL3XQEmmr122hswR2P557wwVWwk/k0bxohkWp+Y5eC5pZDao2u4F8w8
        qsS3YH5hNVWBDO6BVGLpzOZJFR6mDXtBSiNuWHCozA7DdGPNRuzAOUesgkJOR0hZ
        0arWH3zwhu0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB5E1AA501;
        Mon,  1 Mar 2021 13:02:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5CA5AA4FF;
        Mon,  1 Mar 2021 13:02:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] docs: add a FAQ section on push and fetch problems
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
        <20210227191813.96148-4-sandals@crustytoothpaste.net>
Date:   Mon, 01 Mar 2021 10:02:00 -0800
In-Reply-To: <20210227191813.96148-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 27 Feb 2021 19:18:12 +0000")
Message-ID: <xmqqtupurbvr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39450048-7AB8-11EB-8786-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +[[remote-connection-http-411]]
> +Why do I get an error about an HTTP 411 status?::
> +	Sometimes users see error messages when pushing that refer to HTTP status 411,
> +	such as "RPC failed; result=22, HTTP code = 411."  This status means that the
> +	server or a machine in the middle, such as a proxy, TLS middlebox, antivirus,
> +	firewall, or other middlebox, refuses to accept a streaming data connection.
> ++
> +When pushing or fetching over HTTP, Git normally uses a small buffer and, if the
> +data is large, uses HTTP 1.1 chunked transfer encoding or HTTP 2 streaming to
> +send the data without a defined size.  This is useful because it allows a push
> +or fetch to start much faster and therefore complete much faster.  This type of
> +streaming has been standardized since 1999 and is well understood, and all
> +modern software should be capable of supporting it.
> ++
> +However, in this case, the remote server or middlebox is misconfigured and does
> +not correctly support this.  The best thing to do is contact the responsible
> +party and ask them to fix the server or middlebox, since this misconfiguration
> +can affect many pieces of software, some of which will simply not function at
> +all in this environment.
> ++
> +If the remote server supports SSH, you may wish to try using SSH instead.  If
> +that is not possible, you can set `http.postBuffer` to a larger value as a
> +workaround.  This is one of the few times when that option is useful, but note
> +<<http-postbuffer,as outlined in the answer above>> that doing so will increase
> +the memory usage for every push, no matter how small, and will not be able to
> +handle pushes of arbitrary sizes, so fixing the broken server or device or
> +switching to SSH is preferable in almost all cases.

Don't we rather want to merge this with [[http-postbuffer] part of
the faq?  If we can have two header lines for the same description
(i.e. the FAQ list may have

    "What does `http.postBuffer` do?" aka "I got HTTP 411--what now?"

as either a single link or a two separate but clearly related
entries), that might be ideal.

Thanks.


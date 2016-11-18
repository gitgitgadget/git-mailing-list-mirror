Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9DF1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbcKRVFm (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:05:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752364AbcKRVFm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:05:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4A304FBB2;
        Fri, 18 Nov 2016 16:05:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mCtD7DFMPYrsHPQmFKQiNu3+/6Y=; b=cPTLNC
        gYswh18NppH4JCKW4DzC2NJOm8W7f+4KtEfwJH6umk5A9ojn3WXI6Z+Gmumfp3kw
        urNukZQih8b5vdsaAY6chSaQ76iy7C+WW8WwXGBeQytkqG6pX+l4ePI226aUO8Zc
        dDblPiFO6TTE/9uUYEWI8OZHKpmxk7AeHTBcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wy6QXnclVDFaa048jN/HCv4PmBEDs7N0
        i7c/d7n1XufDxycGHfu8qNGs/j42lZrEP8l73e8MfjvfzWkjSWQ0wR47gux7TvYL
        5D5MphPOiJdot6cZAzn43HSsT5nkNENlsPQXe0VxQO8UJlaLgaKx1CTl3zCOfzHu
        CTvI+yGjycY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCE554FBB1;
        Fri, 18 Nov 2016 16:05:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FC164FBB0;
        Fri, 18 Nov 2016 16:05:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, peff@peff.net
Subject: Re: [PATCH v3] remote-curl: don't hang when a server dies before any output
References: <1479501049-15458-1-git-send-email-dturner@twosigma.com>
Date:   Fri, 18 Nov 2016 13:05:38 -0800
In-Reply-To: <1479501049-15458-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Fri, 18 Nov 2016 15:30:49 -0500")
Message-ID: <xmqqd1hsmrbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2BF9A16-ADD2-11E6-9D24-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> In the event that a HTTP server closes the connection after giving a
> 200 but before giving any packets, we don't want to hang forever
> waiting for a response that will never come.  Instead, we should die
> immediately.
>
> One case where this happens is when attempting to fetch a dangling
> object by SHA.  In this case, the server dies before sending any data.
> Prior to this patch, fetch-pack would wait for data from the server,
> and remote-curl would wait for fetch-pack, causing a deadlock.
> ...
> Still to do: it would be good to give a better error message
> than "fatal: The remote end hung up unexpectedly".
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks.

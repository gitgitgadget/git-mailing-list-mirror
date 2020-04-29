Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB4C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208D62137B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SsJNqxIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgD2WE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:04:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52540 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2WE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 18:04:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7EB1B0E39;
        Wed, 29 Apr 2020 18:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zjYUFeVm1ijK
        SEjIR0wgfS7zw38=; b=SsJNqxIaztrUIIIVRI7jFQ498QucaehkeGHzpT+SXT2I
        8KzrKq33NBWvh7F0rwEm+8mTjUbL/5GnzfnOpfY3RECRZ5IMFHU1aXgbf/JIlKVY
        vEUV00boBt/mujoytmF9tfgiyatzgNenthEg5nzmQMZUvTUIjJzJdd72mUMUh5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y1FR3s
        NK88/eaJrhdqLo5XorRV1gT1QC6hw1o4zLw37Lf3zuRb2ZHmHOkgDMVjFiVJUwoj
        +hxzM3AogXR6B4og0pJgnCS7qYzHhUPyxU5s8x2pJzo6AY+i1bv1L3l/H+qw8l87
        3Js7VJvnpl/o+MPgYCFrHmoPvGZHxn8CFOZqw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DEB2FB0E38;
        Wed, 29 Apr 2020 18:04:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 279BBB0E34;
        Wed, 29 Apr 2020 18:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [RFC PATCH v6 2/2] credential-store: warn for any incomplete credentials instead of usingy
References: <20200429003303.93583-1-carenas@gmail.com>
        <20200429203546.56753-1-carenas@gmail.com>
        <20200429203546.56753-3-carenas@gmail.com>
        <xmqqk11yuhca.fsf@gitster.c.googlers.com>
        <20200429214931.GB33264@Carlos-MBP>
Date:   Wed, 29 Apr 2020 15:04:20 -0700
In-Reply-To: <20200429214931.GB33264@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 29 Apr 2020 14:49:31 -0700")
Message-ID: <xmqq7dxyuexn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61966616-8A65-11EA-86AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> Sorry, but isn't that what happend already in the previous step?
>> What are you ordering the codebase (after applying the previous
>> stpe) do further?  It already is "using it to notify the user when
>> username and/or password is missing".
>
> not sure I follow, but the current code (as well as the one after patch=
 1)
> just silently ignores any credential that was missing username and pass=
word
> since the _gently version of the call will only really fail for a missi=
ng
> protocol.

Ah, I misread the intention of [1/1].  While I was rewriting the
if/else structure inside the loop, somehow I thought that we want to
warn when from_url_gently() fails or user/pass are missing, and in
this step, we are adding to the "warning-worthy" set an entry that
does not have either host or path.

Sorry about the confusion.

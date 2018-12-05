Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF73211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeLEFzH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:55:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51990 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEFzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:55:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E664131B0A;
        Wed,  5 Dec 2018 00:55:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+APSFw4YTnYD4h4n1qawcP9aHho=; b=jZbj+c
        nxA03LantSMMQuk2ZDI9gzmzdegLHl44vUBVP4c4Z0ie+5dfhvbWb/BdwBXuzYLG
        vE7ODenllGbyYpYobzkZ133mXAWZakYtd8P4x6v7gi+rkPFlw6Ak/iPj4TsBnZBX
        FcdR0uNN61leW1HS+sITEJjXH6PNCkvQA15DI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yd7kBZiFgu8S0iFayvp/wFHDG4CCGcS/
        Xs96MnWk98yKCW/0kxwOwlwuFsnZMcWObt06UWdLrKlyaHW2McuJr1r7F7sh3Ztd
        qKyOCHYzjBLGGvsJKVm5jvU6cADFlJi1sFEx2C6ZSaQ/WJ6I1Bj8EFuqEE5cDXfM
        CeLvL7UXWQI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE09A31B08;
        Wed,  5 Dec 2018 00:55:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6394C31B06;
        Wed,  5 Dec 2018 00:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
References: <cover.1543879256.git.jonathantanmy@google.com>
        <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
        <xmqqbm60d0s1.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 05 Dec 2018 14:55:00 +0900
In-Reply-To: <xmqqbm60d0s1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Dec 2018 14:02:06 +0900")
Message-ID: <xmqq7egocybv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E956B9E-F852-11E8-BC5E-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, this is OK, but
>
>> +Clients then should understand that the returned packfile could be incomplete,
>> +and that it needs to download all the given URIs before the fetch or clone is
>> +complete. Each URI should point to a Git packfile (which may be a thin pack and
>> +which may contain offset deltas).
>
> weaken or remove the (parenthetical comment) in the last sentence,
> and replace the beginning of the section with something like
>
> 	If the client replies with 'packfile-uris', when the server
> 	sends the packfile, it MAY send a `packfile-uris` section...
>
> You may steal what I wrote in the above response to help the
> server-side folks to decide how to actually implement the "it MAY
> send a packfile-uris" part in the document.

By the way, I do agree with the practical consideration the design
you described makes.  For a pregenerated pack that brings you from
v1.0 to v2.0, "thin" would roughly save the transfer of one full
checkout (compressed, of course), and "ofs" would also save several
bytes per object.  Compared to a single pack that delivers everything
the fetcher wants, concatenation of packs without "thin" to transfer
the same set of objects would cost quite a lot more.

And I do not think we should care too much about fetchers that lack
either thin or ofs, so I'd imagine that any client that ask for
packfile-uris would also advertise thin and ofs as well, so in
practice, a request with packfile-uris that lack thin or ofs would
be pretty rare and requiring all three and requiring only one would
not make much practical difference.  It's just that I think singling
out these two capabilities as hard requirements at the protocol
level is wrong.

Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A3C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC62C2227F
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="emAbycVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgKBWAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:00:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56772 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKBWAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:00:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D65FF101DEB;
        Mon,  2 Nov 2020 17:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vs/DE/zvGOa+
        XqYMLP1eb2xG7OU=; b=emAbycVl7vHL8w+OXLXX/3LkTDii1PD+FEEa7kMTt0KC
        ItUAuOD9KkKfXRPBEtjazjn6FDR9oaQQbv7xe/bB2dZWxUpnks2WOTt/wliR4OiH
        fAcdennvfZvzcQ5Sb7v0koF+UYrytV8eOj1C+a6uS5simIUh4MIeBJE+zR0vI/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vvW3UE
        FtfhFdAaBNg0zs1cKnMP8DVOylYRksDPKaewaF0MKd3GPEfgQXbx6Gw3JFwWzGo1
        wkYepxd2j9PyuXyk8wOI3/Jrjq9FGI6mIxQ75RvqxeHC1eBIp0+u9rRoERQ4OzsP
        DYYaxq2BO2bpqldUWtTbwU/5z4VFQaAfqlvFg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF91D101DEA;
        Mon,  2 Nov 2020 17:00:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BEC54101DD4;
        Mon,  2 Nov 2020 17:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
Subject: Re: git-diff bug?
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
        <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
Date:   Mon, 02 Nov 2020 14:00:18 -0800
In-Reply-To: <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 2 Nov 2020 18:45:03 +0100")
Message-ID: <xmqqpn4vs9l9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCF5C742-1D56-11EB-89F3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>     $ diff --ignore-blank-lines -u 1 2
>     --- 1	2020-11-02 18:11:04.618133008 +0100
>     +++ 2	2020-11-02 18:11:04.618133008 +0100
>     @@ -1,4 +1,4 @@
>      aaa
>      bbb
>     -ccc
>
>     +ccc
>     $ diff --ignore-blank-lines -u 2 1
>
> This matches your results.  That the order makes a difference is a bit
> odd.  Both are valid diffs of the inputs and neither one changes blank
> lines, though, so it doesn't look like a bug.

Interesting.  If "diff" happens to pick the line with "ccc" on it as
the unchanging pair of lines between the preimage and the postimage,
then another "valid diff of the inputs" would look like this:

     aaa
     bbb
    +
     ccc
    -

What such a patch would change consists only of blank lines.  It is
reasonable to expect "--ignore-blank-lines" would turn it into a
no-op, provided if "diff" picks "ccc" as the matching line.

But if "diff" picks that the blank line at the end of the original
file as unchanged line, then we'll see the diff quoted in the first
part of this message.  And that patch does not change any blank
lines, so it is unreasonable to expect "--ignore-blank-lines" to
turn it into a no-op.

So it all depends on which matching pair "diff" first picks, before
the "are all the lines changed by the hunk blank ones?" kicks in.

One could argue that "diff" should work hard to enumerate all the
possible combinations (we just saw two possible combinations above)
to find one that allows "--ignore-blank-lines" to produce an empty
patch, but I am not sure it is a sensible thing to do.


>     $ git diff --ignore-blank-lines 1 2
>     $ git diff --ignore-blank-lines 2 1
>     $ git --version
>     git version 2.29.2
>
> This matches your expectation, but not your results.  Which version do
> you use?
>
> Ren=C3=A9

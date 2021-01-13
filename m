Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30DC433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E3F22D05
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbhAMUi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:38:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61464 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAMUi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:38:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2348105FEA;
        Wed, 13 Jan 2021 15:37:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ifNw7Qis6jO2bqnFJJlkSlkFz/M=; b=S6mCso
        RT1cDxOff3mKQ96iu7PgUeHe7IoyYMZifXMAMrY37Dfi8+QVFrC4KKvLcRG8r71G
        5dOepKovJifgzmndbXu06Sa3OBS4oghGsiz8Z97KoqB8e01F94IfxBQtstuiNwLc
        7gfZejGkSrU7vyAroKsgL8U6yoxJGYJf6v+WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqe3CwjA8bpK/7Fax/D0otsQgR9Qx+km
        g5UMxT/cDB8qBNdn70FITCuXH+n8DIIVe4Uv6mNEAFBUaLaPQB8ISmraWJCPtnz5
        6QV2i6RFTBpnAMdNmLXngYuhGmQ+8vF/No3KtE2TLpDsk6apAQ4TQHB7Kec+EtRP
        lnhp3W0h+NU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9312105FE9;
        Wed, 13 Jan 2021 15:37:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 09C89105FE3;
        Wed, 13 Jan 2021 15:37:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 5/9] sequencer: use const variable for commit
 message comments
References: <20210108092345.2178-1-charvi077@gmail.com>
        <20210108092345.2178-6-charvi077@gmail.com>
        <X/9GrVjBmnJUZcGn@nand.local>
Date:   Wed, 13 Jan 2021 12:37:41 -0800
In-Reply-To: <X/9GrVjBmnJUZcGn@nand.local> (Taylor Blau's message of "Wed, 13
        Jan 2021 14:14:53 -0500")
Message-ID: <xmqqv9c0wp2i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FA8B686-55DF-11EB-9FA8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Two nit-picks here. The line break after the '=' is a little awkward,
> since two of these lines are less than 80 characters combined, and the
> other two are just slightly longer than 80 characters. The other nitpick
> is that its typical to see 'char *foo' instead of 'char foo[]'.
>
> So, I'd write these as:
>
>     static const char *first_commit_msg_str = N_("This is the 1st commit message:");
>     static const char *nth_commit_msg_fmt = N_("This is the commit message #%d:");
>     static const char *skip_nth_commit_msg_fmt = N_("The commit message #%d will be skipped:");
>     static const char *combined_commit_msg_str = N_("This is a combination of %d commits.");

I actually am OK with []; it saves sizeof(char*) bytes from each of
the variable, doesn't it?

> I also noticed that you suffix these with _fmt or _str depending on
> whether or not there are arguments that get filled in later on. That
> makes 'combined_commit_msg_str' labeled incorrectly (it should be
> 'combined_commit_msg_fmt').

Good eyes.

Thanks.

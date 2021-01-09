Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF011C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B3523B01
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbhAIWCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:02:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIWCx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:02:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E14B9EB4D;
        Sat,  9 Jan 2021 17:02:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=91ZjMbMqELuspAsxYggYvSSUhjE=; b=JoZLgB
        R/H/fCONWcfFJnupOlZ2cXwPkVR+zXKB/xg8scp4ZfNSTvWnAQyKShXysiOxLkDY
        1JIcNDdfoHdHLQuv0I9Sc0YzLawNc2kwTDwzycGtNhRLdpCR1VPbU5n9UQ6NypHV
        Cz76RE7SKzNo+DsqoAbF4/APSIuu/+PD/pfg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cr2rf6UPldi1yL1w9AwHJG3t1yIjIy0b
        dhtcxLgl10Uqfg9R/aHInq1Hwx0JNJJ17U70uYvH7S4Z4a3WtEFMtNCWG4VfP5Ii
        1mFLwOU0TkS/9MfgRM8fwgzDsvMcIL9viPl/FWSCG3i9q0ycYboLNzSiJAnufRA9
        GGHm7dgIxWI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 163C39EB4C;
        Sat,  9 Jan 2021 17:02:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BB9C9EB4B;
        Sat,  9 Jan 2021 17:02:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/2] bundle: lost objects when removing duplicate
 pendings
References: <X/cqrTgilKAW9P9G@danh.dev>
        <20210108144514.24805-2-worldhello.net@gmail.com>
        <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
        <CANYiYbGcXORT-kryEngy17_J1g3FDKbty9wVXj1U5OWHu8yM8g@mail.gmail.com>
Date:   Sat, 09 Jan 2021 14:02:09 -0800
In-Reply-To: <CANYiYbGcXORT-kryEngy17_J1g3FDKbty9wVXj1U5OWHu8yM8g@mail.gmail.com>
        (Jiang Xin's message of "Sat, 9 Jan 2021 21:32:18 +0800")
Message-ID: <xmqqbldxg466.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 527D03F4-52C6-11EB-A097-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>> > +# Create a commit or tag and set the variable with the object ID.
>> > +test_commit_setvar () {
>> > +     notick= &&
>> > +     signoff= &&
>> > +     indir= &&
>> > +     merge= &&
>> > +     tag= &&
>> > +     var= &&
>> > +     while test $# != 0
>> > +     do
>> > +             case "$1" in
>> > ...
>> > +             -*)
>> > +                     echo >&2 "error: unknown option $1"
>> > +                     return 1
>> > +                     ;;
>> > +             *)
>> > +                     test -n "$var" && break
>> > +                     var=$1
>
> The loop ends only if $var has been assigned a value, or no other
> args.  Will report error if no other args later.

"We see an arg that is not an dashed option.  We already saw an arg
and taken it as the name of the variable, so break" was a misleading
way to structure this loop.

It looked as if it was just refusing to parse the remainder of the
command line, so that a check after the loop would complain if there
is still remaining arguments (as if to warn "var given twice").  But
that is not what the post-loop check does; it expects there still
are some argument left to be processed in mode-specific code that
follows, so it happens to work as intended.

That is brittle, though.  The current code may always consume one or
more extra arguments in $merge/$tag/other specific mode in the code
after the loop, but a new mode that will get added in the future to
sit next to --merge and --tag may learn all necessary info in the
command line parsing loop above, without any need for extra args to
be processed after the loop.  And $#=0 may not always be an error at
that point.

I forgot to notice / mention it, but now you made me to look at the
loop again, I see this part

	-C)
		indir="$2"
		shift
		;;

does not ensure we are getting something sensible in -C; that
potential bug by the caller also happens to be covered by the
post-loop "we require at least one argument that we can use as an
arg" check, but as I said already, that feels rather brittle.

Anyway, let's queue the patches as-is and see what others think.

Thanks.

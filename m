Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26164C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1D6103A
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhKLTWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 14:22:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56712 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLTWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 14:22:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1452FA39A;
        Fri, 12 Nov 2021 14:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h/ohypgkp/HW
        9FlV1AZRHLzs7V9mXBloZ0uKIW6UKMA=; b=GmoWNgw8z4lvNSk7jRhyNpNQzYbQ
        CfLGwf/fRnUiL8qWIo/xfXLFhx8Vm5dVeKmXc2IdNHlFsVBpRJHKkHNdNpXnYgeO
        LE/CPfRSkpMza7kj4M5o1ufjlaOh2iF/eCbHXkkOnD6/FSxxYH3KoMVaUjboVyTW
        ugWNr/GDvMCXR7U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C94D7FA395;
        Fri, 12 Nov 2021 14:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C21FFA38C;
        Fri, 12 Nov 2021 14:19:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] grep: simplify config parsing, change grep.<rx
 config> interaction
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-7.8-140a7416223-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 11:19:28 -0800
In-Reply-To: <patch-v2-7.8-140a7416223-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:49
        +0100")
Message-ID: <xmqqpmr5qj0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 751AAE34-43ED-11EC-A924-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the interaction between "grep.patternType=3Ddefault" and
> "grep.extendedRegexp=3Dtrue" to make setting "grep.extendedRegexp=3Dtru=
e"
> synonymous with setting "grep.patternType=3Dextended".

This description alone is not quite understandable.  It is not
saying much more than the single line title, and presense of it does
not seem to improve the understanding by the readers.

> When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
> grep.patternType configuration setting, 2012-08-03) we made two
> seemingly contradictory promises:
>
>  1. You can set "grep.patternType", and "[setting it to] 'default'
>     will return to the default matching behavior".
>
>  2. Support the existing "grep.extendedRegexp" option, but ignore it
>     when the new "grep.patternType" is set, *except* "when the
>     `grep.patternType` option is set. to a value other than 'default'".

OK, so setting grep.patternType=3Ddefault makes grep.extendedRegexp to
be taken into account.  By grep.patternType to something else, the
other one is ignored.  2. is a very explicit way to say so.  Where
did you get 1. from?  If you have this paragraph in the log message
in mind, I agree that it is less than ideally phrased, but ...

    Rather than adding an additional setting for grep.fooRegexp for
    current and future pattern matching options, add a
    grep.patternType setting that can accept appropriate values for
    modifying the default grep pattern matching behavior. The
    current values are "basic", "extended", "fixed", "perl" and
    "default" for setting -G, -E, -F, -P and the default behavior
    respectively.

... with the understanding of 2. (which is in what the commit adds
to Documentation/config.txt), it is reasonable to understand that
"the default behaviour" is "use BRE or ERE, depending on the setting
of grep.extendedRegexp".

Doesn't the code behave that way?  I think the above is exactly how
the commit wanted to make the code behave.

> I think that 84befcd0a4a probably didn't intend this behavior, but
> instead ended up conflating our internal "unspecified" state with a
> user's explicit desire to set the configuration back to the
> default.

I am not sure where that comes from, but if I imagine somebody
confuses between "default" and "basic" and considers "default" a
synonym for "basic", I can sort-of understand it.  Is it what is
happening here?

But it is not what the original .patternType patch wanted to do back
then, and it is not what we want to see now.

> I.e. a user would correctly expect this to keep working:
>
>     # ERE grep
>     git -c grep.extendedRegexp=3Dtrue grep <pattern>

This makes sense.

> And likewise for "grep.patternType=3Ddefault" to take precedence over
> the disfavored "grep.extendedRegexp" option, i.e. the usual "last set
> wins" semantics.
>
>     # BRE grep
>     git -c grep.extendedRegexp=3Dtrue -c grep.patternType=3Dbasic grep =
<pattern>

This makes sense, too.

Do either of the above two not work as you expect (i.e. the first
use ERE and the second use BRE)?

What I have trouble with is that it is unclear if you are describing
what should happen (in the above, I said "makes sense", to show my
agreement, assuming that it is the case), or if you are describing
what does happen that you disagree with.=20

Another thing I have trouble with is your mention of "keep working".
Are you proposing to deliberately break what is working as users
correctly expect?  Why?

> But probably not for this to ignore the favored "grep.patternType"
> option entirely, say if /etc/gitconfig was still setting
> "grep.extendedRegexp", but "~/.gitconfig" used the new
> "grep.patternType" (and wanted to use the "default" value):
>
>     # Was ERE, now BRE
>     git -c grep.extendedRegexp=3Dtrue grep.patternType=3Ddefault grep <=
pattern>

I do not quite get your "Was X, now Y" label.  What did you want to
say with that?

Also I am not sure what you exactly mean when you say "and wanted to
use the 'default' value".  There is no single "THE" default value.
If patternType=3Ddefault is the last patterntype (it may be set in
many places, but the last one should win), the user is telling that
the last-one-wins setting of extendedRegexp is to be honored.  So,
if grep.extendedRegexp in /etc/gitconfig is the last one defined, we
would choose between BRE and ERE depending on that setting.

Isn't that what is happening in the current code?

Or are all the above explanation result of simple misunderstanding
that setting to "default" means setting to "basic"?


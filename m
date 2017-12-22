Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A5A1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756149AbdLVV2F (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:28:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52240 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755458AbdLVV2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:28:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE777BD36D;
        Fri, 22 Dec 2017 16:28:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Yy9GnG2kIWSg
        deTm/Wa7dqxVMyw=; b=UqDKcHDTz1dsyJOh3CJbOfkcpPKDRawR461mPHMlQleB
        ULcIM40ydzd/59S70iuZM6/38ykIcOU3N5gYPWshhhdlh3OktKHzogoTFGt5J2Zs
        NT/pz+yQp138eFIsA1ZLXOgJi6uY+Y5jdLiCMd4FGn+lXqYm7rCEoUFBnj2LsCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rPLcE/
        LyGQqwY1/k3qQ/xqo7X83aVaYkTcFcYAxJ35qilB68d+dX5pLbqpZOGxTNgTmjMG
        yGR6tKgQ+1FaDUDzUh5oet4/j+63TlJiUdJYYkXbaDag+ufxRzcYF/TuYXT3tX32
        crTP1IFDXm82SNbOuiZpkETMmsxoez/80nawE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4C2EBD36B;
        Fri, 22 Dec 2017 16:28:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2793CBD369;
        Fri, 22 Dec 2017 16:28:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
        <20171222204152.4822-1-avarab@gmail.com>
Date:   Fri, 22 Dec 2017 13:28:01 -0800
In-Reply-To: <20171222204152.4822-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Dec 2017 20:41:52 +0000")
Message-ID: <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FDF63BE6-E75E-11E7-B8F5-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Those options could also support combining with -m, but given what
> they do I can't think of a good use-case for doing that, so I have not
> made the more invasive change of splitting up the logic in commit.c to
> first act on those, and then on -m options.
>
> 1. d71b8ba7c9 ("commit: --fixup option for use with rebase
>    --autosquash", 2010-11-02)

To be fair, when "rebase --autosquash -i" is run (which is why you
would use --fixup in the first place), the log message of the fixup
one is used only for locating which one is to be corrected, and the
contents of the log message is discarded.  So "given what it does",
I can't think of a good use-case for using --fixup and -m together,
either.  So "nobody immediately thought of it when it was added" is
certainly not a reason to later make the combination possible.

But I personally am moderately negative on one of these two imagined
use cases.

> Add support for supplying the -m option with --fixup. Doing so has
> errored out ever since --fixup was introduced. Before this, the only
> way to amend the fixup message while committing was to use --edit and
> amend it in the editor.
>
> The use-case for this feature is one of:
>
>  * Leaving a quick note to self when creating a --fixup commit when
>    it's not self-evident why the commit should be squashed without a
>    note into another one.

This is probably OK.

>  * (Ab)using the --fixup feature to "fix up" commits that have already
>    been pushed to a branch that doesn't allow non-fast-forwards,
>    i.e. just noting "this should have been part of that other commit",
>    and if the history ever got rewritten in the future the two should
>    be combined.

This has a smell of the tail wagging the dog.

Perhaps your editor does not have a good integration with external
commands to allow you to insert a single-liner output from

    git show --date=3Dshort -s --pretty=3D'format:%h ("%s", %ad)' "$1"

and that is what you are abusing --fixup for? =20

It is simply bad practice to leave a log entry that begins with
!fixup marker that would confuse automated tools like "rebase -i"
machinery on a commit that you have no intention of squashing into
another, as it invites mistakes. =20

I do agree with the scenario where you would wish you could take
back an earlier mistake but you cannot.  But the log for such a
follow-up fix should be written just like any other follow-up fix
commit, i.e. describe what was wrong and how the wrongness is
corrected with the follow-up change.  What was wrong in "which
commit" is of course important part, but it is a relatively small
part.

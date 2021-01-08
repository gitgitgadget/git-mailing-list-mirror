Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EDC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663FC23AC1
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbhAHUKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:10:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63579 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhAHUKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:10:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A0919106930;
        Fri,  8 Jan 2021 15:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M4PRx3TKohNn
        F2T/tKbueCDLZVM=; b=woPXdbw4K22kDoM9oRz+9AuEURfCLYqXemeYThbYBCS/
        mkkHDADfK+WsEgSfWDvP4OdmYPxrR+xg3paMqJs00G80HUEwJQY8xJDeNWbmqDMZ
        m/w4FsLE/nIe7oHsz61ZF2zSKbgESpzufJdbEe7BjYWGahzPHRadICay4dJlXjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Vqwdq7
        VLa9PFLvT6x7BSZaseiiJJVp1t8DLevo5LNi4To7gKSozbSLXEJnp/+Rcsu8kDgW
        mU3NZURQ6v3gPgDDgsZfdiqs1BiJ4St83wGtSS1FYy0Xckr/wshJ/YgvSD1hBUIV
        Zp6GcFOsuNzZ+z6SdPqKNGPdu7r2tE+W7co2Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96FD010692F;
        Fri,  8 Jan 2021 15:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94B7F106929;
        Fri,  8 Jan 2021 15:10:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7800-difftool: don't accidentally match tmp dirs
References: <20201224092431.13354-1-szeder.dev@gmail.com>
        <xmqq35zdnu1w.fsf@gitster.c.googlers.com>
        <20210108092036.GR8396@szeder.dev>
Date:   Fri, 08 Jan 2021 12:10:00 -0800
In-Reply-To: <20210108092036.GR8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 8 Jan 2021 10:20:36 +0100")
Message-ID: <xmqq1revi413.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DE5DAC2-51ED-11EB-ABDC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Jan 06, 2021 at 10:24:27PM -0800, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> > index a578b35761..fe02fe1688 100755
>> > --- a/t/t7800-difftool.sh
>> > +++ b/t/t7800-difftool.sh
>> > @@ -439,73 +439,104 @@ run_dir_diff_test () {
>> >  }
>> > =20
>> >  run_dir_diff_test 'difftool -d' '
>> > +	cat >expect <<-\EOF &&
>> > +	file
>> > +	file2
>> > +
>> > +	file
>> > +	file2
>> > +	sub
>> > +	EOF
>> >  	git difftool -d $symlinks --extcmd ls branch >output &&
>> > -	grep sub output &&
>> > -	grep file output
>> > +	grep -v ^/ output >actual &&
>>=20
>> This unfortunately would not catch full paths on certain platforms.
>>=20
>> See https://github.com/git/git/runs/1660588243?check_suite_focus=3Dtru=
e#step:7:4186
>> for an example X-<.
>
> Hrm, one has to log in to view those CI logs?  Really?! :(

Yup, it sucks.  I am curious (but not strongly interested enough to
demand) to learn the reason why from GitHub folks.

> Anyway, I (apparently falsely) assumed that the output these tests
> look at come from Git itself, and therefore we can rely on difftool's
> temporary directories being normalized UNIX-style absolute paths...
> But it seems they don't actually come from Git but from 'ls', because
> that's what those '--extcmd ls' options do, and I now going to assume
> that 'ls' prints those absolute paths with drive letter prefixes and
> whatnot on Windows.
>
> The initial version of this patch just tightened all potentially
> problematic 'grep' patterns, e.g. 'grep ^sub$ output && grep ^file$
> output'.  That should work on Windows as well, shouldn't it.  Will see
> whether I can dig it out from the reflogs.

I only see 'file', 'file2', 'b', 'c', etc. used in the tests; do we
ever use any path that ends with a colon?

I wonder if would it be more robust to use something like

	sed -e 's|^.*/\([a-z]*\)/:$|/directory-path-\1/:|'

in place of "grep -v /" to redact the temporary directory names
difftool creates.  It would give you /directory-path-left/: or
/directory-path-right/: instead of removing these lines and it would
clarify what these two series of file names are, which may be an
added bonus.

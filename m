Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EBC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FC5207D0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 20:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pe3szKZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFCUCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:02:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58209 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 16:02:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36319DEB67;
        Wed,  3 Jun 2020 16:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RKN/yDPZ3Ix3
        aWlpwtO/uirWoIM=; b=Pe3szKZZbGj6KzoAVtwuI/8xuuYbn3eWXoy1ogHW1rPD
        ZSXXYNs4OgmJZjrHDEuiQd8EE9hKs0Se8ARpUfQG1qmy4lCBOk0KlPugy+mdzdS1
        BhKU0CIQbqk7/Ta8Sr5RSO062C8CvtF1nAg0WQFziN1vuW7Eg3eAj5Rzp/fkURc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nV29tz
        riD43i5vq+pNRvK3/uczMmEwdq5aBBhDhuW9+gzwiPTT0aH1t1qo6bZG1Ps0wYvc
        cjBNOzxg2Bo+zco5fV7TRuipcmSoX6yyWPeIpMYdj9Icl3zrx8S4lLqO48j6DcVv
        N/alEQGAV/ln8cxW5yOkUacYqgC56WSa8lDX4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D44EDEB66;
        Wed,  3 Jun 2020 16:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65300DEB65;
        Wed,  3 Jun 2020 16:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from shell to C
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
        <20200602163523.7131-1-shouryashukla.oo@gmail.com>
        <xmqqzh9ls622.fsf@gitster.c.googlers.com>
        <20200603001225.GB2222@danh.dev>
Date:   Wed, 03 Jun 2020 13:02:12 -0700
In-Reply-To: <20200603001225.GB2222@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Wed, 3 Jun 2020 07:12:25 +0700")
Message-ID: <xmqqtuzrrk8r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E5E3B7C-A5D5-11EA-AD0C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-06-02 10:58:45-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>>=20
>> > +	 * though there is nothing to make less verbose in this subcommand=
.
>> > +	 */
>> > +	struct option options[] =3D {
>> > +		OPT_NOOP_NOARG('q', "quiet"),
>> > +		OPT_BOOL('d', "default", &opt_default,
>> > +			N_("set the default tracking branch to master")),
>> > +		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
>> > +			N_("set the default tracking branch")),
>> > ...
>> > +		OPT_END()
>> > +	};
>> > +	const char *const usage[] =3D {
>> > +		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) =
<path>"),
>> > +		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <=
branch> <path>"),
>>=20
>>=20
>> I notice that we gained back -d and -b shorthands that was
>> advertised but not implemented the previous rounds.  It is a bit
>> curious that we are adding these short-hands that nobody uses,
>> though. =20
>
> I think a day will come, when all git-submodule functionalities will
> run by calling git-submodule--helper.

I'd expect that when that day with no scripted parts of "git
submodule" remains comes, the main entry point functions in
builtin/submodule--helper.c (like module_list(), update_clone(),
module_set_branch(), etc.) will become helper functions that live in
submodule-lib.c and would be called from builtin/submodule.c.  And
the conversion would rip out calls to parse_options() in each of
these functions that would migrate to submodule-lib.c

    Side note: instead of adding submodule-lib.c, you could add them
    directly to submodule.c if they are small enough.  I am however
    modeling after how the "diff" family was converted to C; the
    diff-lib.c layer is "library-ish helpers that get pre-parsed
    command line arguments and performs a single unit of work" that
    utilizes service routines at the lower layer that are in diff.c
    and submodule-lib.c and submodule.c will be in a similar kind of
    relationship.

> In that day, we will use current git-submodule--helper as the new
> git-submodule.

No, I do not think so.  Most of the option parsers would be redone
in builtin/submodule.c; only some that can be used as-is may migrate
as a whole to builtin/submodule.c and its parse_options() stuff
reused, but most of what is in submodule--helper would have to lose
their parse_options() calls, as nobody would be using module_list()
when there is no scripted "git submodule" exists, for example.

> Or is that a complain for missing some tests?

No, it was "do the minimum necessary for an implementation detail,
as we'll discard that part later anyway".

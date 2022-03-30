Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D01C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351037AbiC3Ujp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiC3Ujn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 16:39:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C424555A0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 13:37:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AA1817BF41;
        Wed, 30 Mar 2022 16:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2EKX415yRpw2
        jSBjw5tQREgnn6UEzSydgDKejnVCSvg=; b=eYhSsN5fHIMYrJET0hU5mvRQBxV3
        swezHdAT54mAW6YZMNhxBon2Ec01tN52KbOXbKtMXBtcwQOzVE9vdk/cbt8uhVyQ
        mV6xBLyY3By2lvrl7lm6G0999fBzk4+tKQvMWl0aKjxzb1fMGbGdqPE2M4o9cFaN
        Za2ECfzBWoIv8MA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72B0017BF40;
        Wed, 30 Mar 2022 16:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA3ED17BF3D;
        Wed, 30 Mar 2022 16:37:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
        <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
        <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
Date:   Wed, 30 Mar 2022 13:37:53 -0700
In-Reply-To: <220330.864k3fpo32.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 30 Mar 2022 15:19:47 +0200")
Message-ID: <xmqqmth76use.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46E4D8D0-B069-11EC-980F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:
>
>> From: Tao Klerks <tao@klerks.biz>
>
>> +		case 2:
>> +			// there are at least two remotes; backfill the first one
>
> Nit: I think it's been Junio's preference not to introduce C99 comments=
,

I often mention the rule to new contributors, simply because it has
been that way in our code base, regardless of what my personal
preference might be, and sticking to the style will be more
consistent.  It's not like I am forcing my personal preference on
developers.  Do not mislead new people into thinking so.  It is
especially irritating to see ...

> despite other C99 features now being used (and I think it should work i=
n
> practice as far as portability goes, see
> https://lore.kernel.org/git/87wnmwpwyf.fsf@evledraar.gmail.com/)

... a mention like this, when you know that it is not about
portability but is about consistency, and also you know I've
mentioned more than once on the list if we want to loosen some
written CodingGuidelines rules, especially those that tools do not
necessarily catch.

>> +	if (tracking.matches > 1) {
>> +		int status =3D die_message(_("not tracking: ambiguous information f=
or ref %s"),
>> +					    orig_ref);
>
> This isn't per-se new, but I wonder if while we're at it we shold just
> quote '%s' here, which we'd usually do. I.e. this message isn't new, bu=
t
> referring again to "ref %s" (and not "ref '%s'") below is.

Good.

>> +				 "To support setting up tracking branches, ensure that\n"
>> +				 "different remotes' fetch refspecs map into different\n"
>> +				 "tracking namespaces."),
>> +			       orig_ref,
>> +			       remotes_advice.buf
>> +			       );
>
> Nit: The usual style for multi-line arguments is to "fill" lines until
> you're at 79 characters, so these last three lines (including the ");")
> can all go on the "tracking namespaces" line (until they're at 79, then
> wrap)>

I didn't know about the magic "79" number.  It makes the resulting
source code extremely hard to read, though, while making it easier
to grep for specific messages.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F47BC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244772AbiCBTAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiCBTAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 14:00:21 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215B36E37
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:59:37 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73C55179C17;
        Wed,  2 Mar 2022 13:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MniiS4o6H2/7
        AhPZI0BP/2JmNOqUXiZeZcsev6wnzGM=; b=vKE9ufvGUI7MhxNvm8qlYX4/D1Ha
        kno2PiIjsE42FfypugPrdXMeXEnF3QfdjYD6R+LcaluohLSzbJ7pBIh0xFNk+baW
        JtWVRb29ae1DNAGGpoKgqXbh0mQ4JQptp2fPNdbBOXlK6fhvKDyT7TVCNa1NpKR4
        K30Oeyab7mIp9M8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CC36179C16;
        Wed,  2 Mar 2022 13:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0ECE179C15;
        Wed,  2 Mar 2022 13:59:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: make parse_options_check() test-only
References: <xmqqtuck3yv2.fsf@gitster.g>
        <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
        <xmqqzgma287n.fsf@gitster.g> <xmqqr17lphav.fsf_-_@gitster.g>
        <220301.86pmn5z5we.gmgdl@evledraar.gmail.com>
        <xmqqo82pnwoc.fsf@gitster.g>
        <220302.86r17k7gry.gmgdl@evledraar.gmail.com>
Date:   Wed, 02 Mar 2022 10:59:33 -0800
In-Reply-To: <220302.86r17k7gry.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 02 Mar 2022 11:52:22 +0100")
Message-ID: <xmqq1qzkmb8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6AB0936-9A5A-11EC-856A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Meaning that a parse-options array can be fed by "rev-parse --parseopt=
"
>> and having the sanity check enabled does help the use case?  Even ther=
e,
>> I would say that once the script writer finishes developing the script
>> that uses "rev-parse --parseopt", setting the parseopt input in stone,
>> there is no need to check the same thing over and over again.  Am I
>> mistaken?  Does "rev-parse --parseopt" that is fed the same input
>> sometimes trigger the sanity check and sometimes not?
>
> If we're declaring that "git rev-parse --parseopt" is something that wa=
s
> only ever intended for in-tree usage sure, that should hold true.

> So out-of-tree users wouldn't guard against
> GIT_TEST_PARSE_OPTIONS_CHECK, and I wouldn't be surprised if we could
> e.g. segfault on some subsequent code if some of the sanity checks
> aren't happening anymore.
> ...
> No, I'd be quite happy if we declared that it's for our use only, and
> could remove it when the last in-tree *.sh user went away. there's a bi=
t
> of complexity in parse_options() required only for its use....

I do not see any need for such a declaration.  We are not changing
the behaviour of "git rev-parse --parseopt" plumbing command at all
for those who feed valid input to it.

"rev-parse --parseopt" users can keep using their scripts just the
same as before, debugging their scripts to catch silly mistakes like
duplicated short options may become slightly harder, but they still
have a way to ask for the same debugging support available.

Yes, I am saying that is perfectly fine, and both in-tree and
out-of-tree users have a way to reinstate the sanity checks.  I also
do not mind if your proposal were one of these:

 * introduce --parseopt-with-sanity-check to "rev-parse" and arrange
   the parse_options_check() call to be made when the command was
   invoked with it; or

 * introduce --parse-opt-without-sanity-check to "rev-parse", and
   arrange the parse_options_check() call to be still made when
   "--parse-opt" is used.  Those who finished developing their
   scripts can rewrite their --parse-opt to "without" version for
   conceptual cleanliness.

> So the performance cost is trivial & not worth worrying about.

I already said I am not worried about it, didn't I?  These numbers
do not matter in this discussion.


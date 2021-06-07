Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71AC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EEC60FDA
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 11:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFGLHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:07:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51360 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhFGLHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 07:07:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5B7012C8BB;
        Mon,  7 Jun 2021 07:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/bFEZxkq3G/y
        PdWn7XIn9OLaTkoqUEGq/yWB3vpBYgg=; b=nVbfkzL+XHd6X5gB71K36qG8RIfB
        T86qluJ5McfzeE+YjXnGQkIalgGaD/J3uVJ/EJKH9t8Gt5dgp5DDFVvVXOHSfhc8
        CVBxjUiC548/5MjGe53DRYZ++74pRJ04kpgjBSWZ8FsIIMf7XVG4HFoOblijmtNn
        PmX03/AQaOmS088=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F7C712C8BA;
        Mon,  7 Jun 2021 07:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 220E312C8B8;
        Mon,  7 Jun 2021 07:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere: enable by default
References: <xmqqfsxvxjj2.fsf@gitster.g> <877dj654or.fsf@evledraar.gmail.com>
Date:   Mon, 07 Jun 2021 20:05:09 +0900
In-Reply-To: <877dj654or.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 07 Jun 2021 11:50:35 +0200")
Message-ID: <xmqqpmwyue8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A39415C-C780-11EB-8A6D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jun 06 2021, Junio C Hamano wrote:
>
>> By default, the rerere machinery has been disabled since a bug in
>> the machinery could screw up the end user's data at the most
>> stressful time during the end user's workday (i.e. during conflict
>> resolution).
>
> What was that bug & in what commit was it fixed? Makes sense to note
> that here.

There is no such bug ;-).

Writing buggy code, not thinking about it carefully enough and
jumping up and down yelling this shiny new toy must be merged down
immediately is something we see on this list from others, but it is
the total opposite of how I operate.  I just am extra cautious and
even after I am reasonably sure the code would not break, I prefer
to have volunteers to opt into testing.

> 	@@ -130,7 +129,6 @@ test_expect_success 'unmerge with plumbing' '
> 	 test_expect_success 'rerere and rerere forget' '
> 	 	# from here on, use rerere.
> 	 	git config rerere.enabled true &&
> 	-	mkdir .git/rr-cache &&
> 	 	prime_resolve_undo &&
> 	 	echo record the resolution &&
> 	 	git rerere &&
>
> So the only impact of that rerere.enabled=3Dfalse early is to make sure
> we're not creating the .git/rr-cache.

Not really.  Unresolve is about recording the initial conflict in
the index, so it is far easier to see its effect if you do not
enable rerere, when you are manually debugging these earlier tests.

And later test do check how it works with rerere enabled, but the
way the original sequence of tests enable it is with the "mkdir".
I.e. "if rerere.enabled is not set either way, presence of the
directory means it is already enabled".  The new test sequence
uses the configuration variable explicitly, because in the new world
order, the presence of the directory does not mean a thing.

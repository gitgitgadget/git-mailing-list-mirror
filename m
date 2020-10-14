Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76AC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF12222A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p6YOKmMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgJNPbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:31:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgJNPbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:31:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C990F7BB05;
        Wed, 14 Oct 2020 11:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=d1xPIXcdy0Oz
        Bd/nbt8RVx0dKtk=; b=p6YOKmMiMDRka/RbCzhdyD9NAvKXwS3ads6aH7VeHtkU
        EAog+P+npFJBY/hKFygPDEr8Iu03edJB/Fb7aKgKZ9HijhaAHgq+XmZ3+GmGfYvx
        77+ma3IztUXrlfgoyFLOR4H0xV1KVR1SzXFbEznUodvs1uIWSoxANGoOyuwvaug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fMkb9u
        CyEZqJIvo7udSSxhGSUI7H66TQtZ43KXVN92xRu3w8zUIf7+Deh5gAVlYr2guqcj
        aDofsk5K8aYOH8hiUglHfaiGlciO+oWUzndbxdTkFSaIUJWfj3rzWnnwGNlGf7og
        iEqUJOiLGEvMAfDYuCQTUk05sMSiD3WR9ImJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFBDB7BB04;
        Wed, 14 Oct 2020 11:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1654C7BB03;
        Wed, 14 Oct 2020 11:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel =?utf-8?Q?=C4=8Cavoj?= <samuel@cavoj.net>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
References: <20201012234901.1356948-1-samuel@cavoj.net>
        <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
        <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
        <20201013234519.73grqc2kkybccryf@fastboi.localdomain>
Date:   Wed, 14 Oct 2020 08:31:42 -0700
In-Reply-To: <20201013234519.73grqc2kkybccryf@fastboi.localdomain> ("Samuel
        =?utf-8?Q?=C4=8Cavoj=22's?= message of "Wed, 14 Oct 2020 01:45:19 +0200")
Message-ID: <xmqqimbcj02p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CB008EA-0E32-11EB-9324-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel =C4=8Cavoj <samuel@cavoj.net> writes:

> Speaking of v3, I pulled the trigger a little too fast on that one,
> should have waited a little longer for feedback. Sorry about that.

Nothing to be sorry about---working asynchronously, mails crossing
and timings not coinciding are just expected parts of life.  It is
the kind of thing participants need to learn to adjust, as "normal
latency" is different from community to community.

> Though, I am not sure what has happened to it. I sent it out in the
> usual manner, but it hasn't appeared in any of the mailing list
> archives. Can you please confirm (or deny) that you have received it?
> In case not, should I just send it again, with the same Message-Id's?
> All the recipient mail servers responded with a 250 Ok from my postfix
> logs.

I see the message I am responding to has a timestamp that is about
16 hours ago (relative to the time I am typing this response), but I
am fairly sure that I didn't see it ten hours ago (i.e. my last
night's final e-mail scanning).

Perhaps there was congestion somewhere that held some messages.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2910211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 05:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeK2QIU (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 11:08:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61732 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeK2QIU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 11:08:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD4512DD6F;
        Thu, 29 Nov 2018 00:04:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TOZgl2bvBNFg
        PTsO1fLm0N71Mv4=; b=hNM4EqSnvmKdRlsb04QR/hYC8ydKEDFbur8dW2Ve3slZ
        xvxwtXKKsADVHSK00HDAQSaK13LuttNHtEG2Q+RfjVd64F+o/XG/vzdeBGSQzqvT
        aaomow1+5h+PNfI2PKNB2mL0UzGtc3EkyJW9thptmELoykDfyQar1AqRy5SXIMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jdXyvR
        5mLAjuWvPteGE2eFVgjE/fCkKwiDEzQSZx8myb8zeK8/tRe38Jwahl+C0hD7T+Er
        VvQi7yMWVq23f3alzcpHf7J0+TjaKIIZmFf6h8zLcJq8HbIIZBOHVFKO9iDmjkqt
        F2yojBRb7ZxZrgejsIlYCMVPRoOJ6hXN4v8U4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 426CA12DD6E;
        Thu, 29 Nov 2018 00:04:12 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0B3712DD6D;
        Thu, 29 Nov 2018 00:04:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "Clemens Buchacher" <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        "Kevin Ballard" <kevin@sb.org>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
        <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
        <87mupuzhfx.fsf@evledraar.gmail.com>
        <xmqqa7ltua2s.fsf@gitster-ct.c.googlers.com>
        <875zwgzx4v.fsf@evledraar.gmail.com>
Date:   Thu, 29 Nov 2018 14:04:10 +0900
In-Reply-To: <875zwgzx4v.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 28 Nov 2018 22:54:08 +0100")
Message-ID: <xmqqzhtspj91.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35C19150-F394-11E8-97C4-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't think something like the endgame you've described in
> https://public-inbox.org/git/xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com=
/
> is ever going to work. Novice git users (the vast majority) are not
> going to diligently update both .gitignore and some .gitattribute
> mechanism in lockstep.

That goes both ways, no?  Forcing people to add the same pattern,
e.g. *.o, to .gitignore and .gitattribute to say they are
expendable, when most of the time they are, is not something you
should expect from the normal population.

>> I would think that a proper automation needs per-path hint from the
>> user and/or the project, not just a single-size-fits-all --force
>> option, and "unlike all the *.o ignored files that are expendable,
>> this vendor-supplied-object.o is not" is one way to give such a
>> per-path hint.
>>
>>> This would give scripts which relied on our stable plumbing consisten=
t
>>> behavior, while helping users who're using our main porcelain not to
>>> lose data. I could then add a --force option to the likes of read-tre=
e
>>> (on by default), so you could get porcelain-like behavior with
>>> --no-force.
>>
>> At that low level, I suspect that a single size fits all "--force"
>> would work even less well.
>
> Yeah I don't think the one-size-fits-all way out of this is a single
> --force flag.

Yes, indeed.  That's why I prefer the "precious" bit.  The system
would behave the same way with or without it, but projects (not
individual endusers) can take advantage of the feature if they
wanted to.


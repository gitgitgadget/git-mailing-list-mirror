Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3AC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D99207DD
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 18:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W6kIkMNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgFQSal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:30:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64788 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgFQSai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 14:30:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C52B571DE1;
        Wed, 17 Jun 2020 14:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jJLvnupBHH9yt0JDlWaOkkyE19M=; b=W6kIkM
        NS8qHGyxHsb6t8yA7x6nX7i/24rLlKsyyp+BCdYADxjh3wDvy4qFaL1zacN0BjYE
        YnxAbwb3h7Px1HX6/NMRHYV/bbwSEPAsVIxzOrYUHqEzxbC13v1O6ZAfAOkSkKME
        qHyR3vlTopR5xcuILCnbSyICQJfIzVoyzwBIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K9bbJBUjUTa6iPwFMOD6pItCifoPPoC2
        amxS4Ub7GSuriTF2wwMapHsVxh+w53Z2bH+Ua6N4Kcy2V6Zkdh+BC2mN4TXOWno1
        cB6dUsSjxQnl3YjaFj7Rt8W3x3ABkkEKcVaCinnLkwEnaUARg/oFyf7yKfqp4zUw
        SO1/GcSxWEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB75271DE0;
        Wed, 17 Jun 2020 14:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C81771DDF;
        Wed, 17 Jun 2020 14:30:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Curtin\, Eric" <Eric.Curtin@dell.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Geary\, Niall" <Niall.Geary@dell.com>,
        "rowlands\, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "Coveney\, Stephen" <Stephen.Coveney@Dell.com>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
        <xmqqa716zs7w.fsf@gitster.c.googlers.com>
        <30661592138737@mail.yandex.ru>
        <BY5PR19MB34007DEED68D13003C614F5F909C0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <c4ebf430-a69d-3d46-bfb9-37c9ece9f519@iee.email>
        <xmqq1rmgxo67.fsf@gitster.c.googlers.com>
        <8b0e65ec-02c1-a1c7-b363-e81f37f3fe7e@iee.email>
Date:   Wed, 17 Jun 2020 11:30:35 -0700
In-Reply-To: <8b0e65ec-02c1-a1c7-b363-e81f37f3fe7e@iee.email> (Philip Oakley's
        message of "Mon, 15 Jun 2020 20:37:33 +0100")
Message-ID: <xmqqa711v92s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2FD561C-B0C8-11EA-9F44-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Hi Junio,
> On 15/06/2020 17:57, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> It could be effectively a special strategy. IIUC the '--' separator is
>>> already supported by the underlying parser code, so may not be that
>>> hard? (perhaps a local contribution to the codebase;-). Just a thought.
>> Assuming that there are paths A and B that would leave conflict in
>> an attempted merge between commits X and Y,
> Are we confusing the file merge X.A and Y.A with X.B and Y.B?

No.

> The scenario envisaged is that dev.a has responsibility over the .A file
> merge, while dev.b will handle the merge for .B merge (e.g. different
> parts of the driver code).

Yes.  The question is, that division of labor is agreed between
humans dev.a and dev.b, but somehow need to be encoded in the data
passed from dev.a to dev.b that says "I've done with As and am
comfortable with the result; I didn't even look at Bs, but it's your
turn to deal with them".

After seeing "git pull" leave conflicts, "git checkout HEAD -- Bs"
(or checkout may be done out of MERGE_HEAD?  I dunno) would be a way
to get dev.a concentrate on As only, but the result cannot be tested
sensibly anyway, and it cannot be committed as the result as taking
"ours" or "theirs" for Bs was not dev.a's intention.  How to express
that "I didn't do anything to Bs" in such a way that can be
distinguished from "I did look at Bs, and I believe taking all from
my HEAD is the right resolution" was what I asked.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B576C43460
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6098361007
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhCaSuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:50:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65000 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhCaSut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:50:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1658D122F19;
        Wed, 31 Mar 2021 14:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j9Wt/02L608G
        r37/nc9pE9+YcdM=; b=Rhtwlu/RDks+csfaGZiFrkGw216Kdejn7M0RHy1PO00w
        bOjWYTp/C2r4iyc62ilnfqDKj7hAgVYp6uDK1L3uRsnij57JdmYN48bu/GYpsEhe
        5AwasMm7QijFgHHjJTOPoVgBG1NUnPXJNipm1D6q5TpxiJvHzEtxDR3wpsHFddQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RWlBN8
        XhUkmAk0im+awri2S7tqZLUZ8GduZkM4WzZ7SbNcuILSejjunZYqfsZI8cEb23ro
        NYAyNYZfxmc80BX9FjaYL3qp1GFoD5bOnkND9c8EBJ13W0r5cDlyxZui+KH6Sws1
        2mdVZDFswlrjQsN3NSIziGXW/8gkJZAQ5UryM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DDAA122F18;
        Wed, 31 Mar 2021 14:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2405E122F13;
        Wed, 31 Mar 2021 14:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
        <xmqqy2e5kegv.fsf@gitster.g> <87ft0dmtkw.fsf@evledraar.gmail.com>
        <xmqqh7ktfq3y.fsf@gitster.g> <87pmzfl861.fsf@evledraar.gmail.com>
Date:   Wed, 31 Mar 2021 11:50:44 -0700
In-Reply-To: <87pmzfl861.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 31 Mar 2021 16:17:10 +0200")
Message-ID: <xmqqmtuj6ttn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00B2D938-9252-11EB-AA5D-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> What I meant was if there are well known upstream projects whose
>> Makefile actually use
>>
>> 	$(CC) -o $@+ ...
>> 	mv $@+ $@

... or can you find a popular build generator or two that write such
rules for the final linkage stage (or individual object file
generation step) and argue that all the projects that use the tool
do benefit from such a rule because they can run without installing
and rebuild while the old one is running?

Then I may have found a good reason to believe that some projects
thought hard and long and came to the same conclusion as you did.

I started from the place where I didn't find your rationale for
wanting such a construct sensible, and such a finding may tempt me
to think again.  But otherwise...


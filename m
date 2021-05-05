Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D808AC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9ACE610E6
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEEEfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:35:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56494 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhEEEfd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:35:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50AA111B6AE;
        Wed,  5 May 2021 00:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VFAFPMptHC481kbRAVEI+8jX6UDIQx3moc5M0K
        rNgrU=; b=Xg0i3yvdTeUuYDuY71zfErK+snDOk0xYYW0Q+nr3PnJ+L3JxyeJ3I8
        b8adKLOMqY9/voC30mysMUOlG8oqwnbYM9LVlOt25mmbqgD1uzRAp2DVqMZ3id7M
        9k5HaegZR9NveIWyq/bnHFQM09SXR9dXDRXIz9ZZnw/2uNdkkSS9w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4996D11B6AD;
        Wed,  5 May 2021 00:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82D1911B6AC;
        Wed,  5 May 2021 00:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Andrew Oakley <andrew@adoakley.name>,
        Luke Diamand <luke@diamand.org>,
        Git List <git@vger.kernel.org>, Feiyang Xue <me@feiyangxue.com>
Subject: Re: [PATCH 2/2] git-p4: do not decode data from perforce by default
References: <20210412085251.51475-1-andrew@adoakley.name>
        <20210412085251.51475-3-andrew@adoakley.name>
        <CAKu1iLXRrsB4mRsDfhBH5aahWzDjpfqLuWP9t47RMB=RdpL1iA@mail.gmail.com>
        <20210430095342.58134e4e@ado-tr>
        <021c0caf-8e6f-4fbb-6ff7-40bacbe5de38@diamand.org>
        <CAKu1iLWbmPrVjAcgLKP1yisjmVxJr+kKQWJLiqkRzh=aAzETwA@mail.gmail.com>
        <20210504220153.1d9f0cb2@ado-tr>
        <CAKu1iLXOFiUGmQUeoW-YkiiJ8P2+LznXWz4YabEiGktv=nUYjA@mail.gmail.com>
        <xmqqczu656iv.fsf@gitster.g>
        <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>
Date:   Wed, 05 May 2021 13:34:32 +0900
In-Reply-To: <CAKu1iLUaLuAZWqjNK4tfhhR=YaSt4MdQ+90ZY-JcEh_SeHyYCw@mail.gmail.com>
        (Tzadik Vanderhoof's message of "Tue, 4 May 2021 21:02:54 -0700")
Message-ID: <xmqq1ral4x47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 314A33B0-AD5B-11EB-8E20-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:

> On Tue, May 4, 2021 at 6:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com> writes:
>>
>> > On Tue, May 4, 2021 at 2:01 PM Andrew Oakley <andrew@adoakley.name> wrote:
>> >> The key thing that I'm trying to point out here is that the encoding is
>> >> not necessarily consistent between different commits.  The changes that
>> >> you have proposed force you to pick one encoding that will be used for
>> >> every commit.  If it's wrong then data will be corrupted, and there is
>> >> no option provided to avoid that.  The only way I can see to avoid this
>> >> issue is to not attempt to re-encode the data - just pass it directly
>> >> to git.
>> > ...
> Are you talking about a scenario where most of the commits are UTF-8,
> one is "cp1252" and another one is "cp1251", so a total of 3 encodings
> are used in the Perforce depot?  I don't think that is a common scenario.

Yes.  I think that is where "not necessarily consistent between
different commits" leads us to---not limited only to two encodings.

> I agree with the idea that if you know what the encoding is, then
> why not just use that knowledge to convert that to UTF-8, rather
> than use the encoding header.

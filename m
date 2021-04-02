Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F21C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A75C61167
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 22:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBWJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 18:09:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53009 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBWJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 18:09:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C9E6BAA62;
        Fri,  2 Apr 2021 18:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sKYI8TaGK6UkmdRinq2vtlbDwCE=; b=IVNaqD
        wnJAVDm5KRws00WeWyLlUvraeJFIkksitBJoXiljaduFsHjt04bxd0OyN9XuigX6
        Y3VyE8ycF0rrZAxxqPrSCubONyB3ODzlLhK+RPy9IoZuyHS4UtG67F/BkNOBUUvi
        3dLEC+AglaPYBRPGuGiT6LpAR0U0Cc77qKVBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fq9B11LZUozbq2L0wFrfey6pBYxgWBxH
        AwAkCXbIkOiKBioXtpU+E97NVdFqIkJr5S5xCfYdfZET95P8DJDiF1xSxBWC3zVv
        VfIYZ/WO/HwH4uMGy/Ly5JvtCHvZJN7kh+2yMw3Plu1QW4a1n3xzttadUk8RJ6BO
        JorF1RacDQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F882BAA61;
        Fri,  2 Apr 2021 18:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63917BAA60;
        Fri,  2 Apr 2021 18:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
        <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com>
        <xmqq8s613gqa.fsf@gitster.g>
        <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
        <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
        <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
        <a4cf3e48-aed5-ba1f-298d-1f2cc2359be2@gmail.com>
        <20210402213909.zuyyqqisvq7gjcxo@brm-x62-17.us.oracle.com>
Date:   Fri, 02 Apr 2021 15:09:01 -0700
In-Reply-To: <20210402213909.zuyyqqisvq7gjcxo@brm-x62-17.us.oracle.com> (Tom
        Saeger's message of "Fri, 2 Apr 2021 15:39:09 -0600")
Message-ID: <xmqqft082vb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 083FE5B0-9400-11EB-B062-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tom Saeger <tom.saeger@oracle.com> writes:

> On Fri, Apr 02, 2021 at 05:07:09PM -0400, Derrick Stolee wrote:
>> On 4/2/2021 4:43 PM, Derrick Stolee wrote:
>> > On 4/2/2021 2:27 PM, Tom Saeger wrote:
>> >> generally isn't it still changing the right-hand side of refspec?
>> >>
>> >> replacing ":refs/" with ":refs/prefetch/"
>> > 
>> > Right, this substring replacement might be easiest to achieve. The
>> > 'struct refspec' doesn't make it incredibly easy. Perhaps skipping
>> > the refspec parsing and just doing that substring swap directly from
>> > the config value might be the best approach.
>> > 
>> >> This would still work for refspecs with negative patterns right?
>> > 
>> > One of the issues is that negative patterns have no ":refs/"
>> > substring.
>> > 
>> > The other issue is that exact matches (no "*") have an exact
>> > string in the destination, too, so replacing the _entire_
>> > destination with "refs/prefetch/<remote>/*" breaks the refspec.
>> > I think the substring approach will still work here.
>> 
>> I updated my branch with the substring approach, which is
>> probably the better solution. Please give it a try. I don't
>> expect that change to help the FreeBSD build, but we will see.
>
>
> This worked for all the scenarios I tried, which had both negatives and
> multi remote fetch values.
>
> Looks good!
>
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>

That sounds more like tested-by, but anyway, thanks for working well
together.



>
>>  
>> > [1] https://github.com/gitgitgadget/git/pull/924
>> > [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534
>> 
>> Thanks,
>> -Stolee

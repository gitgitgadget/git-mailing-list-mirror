Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCE9C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C61320760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mwVlQC2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFJXZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:25:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64048 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:25:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63523DDE26;
        Wed, 10 Jun 2020 19:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lp4192/8SYQ+mJb5sI+tuBL2rI8=; b=mwVlQC
        2EnI7JP7equ5q60s1o3StcSX4wcr5PXj61/H1p/NQSUAxEIBb6rLVrt9Zur4v4/m
        mB9gxMykpFAc08t3O41kKnbSIU3k+ntHLu4vkWZu7X7hjd/7OsGnZREEmAgIQlCf
        nbAzIB9813+9FuGniQfP76ALGJ9VO+8vd3INg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IrNgz7vpp4qk7Mpb1GRo5/ht/4yG4PEe
        9FdI+FpplvDzMI+wEGdLuM/D/kj9js3D6MEr++5Dpy95Vf+Ut3aWwB1peXfKNFmk
        W2g7OOY39mtv6H/COdBupyIHe/R4U5jyT+26HovsVk/VOiYq6sBK7oKAJx6arKhy
        ghzQdc5qrtw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BC86DDE25;
        Wed, 10 Jun 2020 19:25:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1716DDE24;
        Wed, 10 Jun 2020 19:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
Date:   Wed, 10 Jun 2020 16:25:52 -0700
In-Reply-To: <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        (Matt Rogers's message of "Wed, 10 Jun 2020 17:54:01 -0400")
Message-ID: <xmqqbllqec5b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA7F8AB4-AB71-11EA-82C3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

>> -        * We also leave "master" as a special case, since it does not reveal
>> -        * anything interesting.
>> +        * We also leave the default branch name as a special case, since it
>> +        * does not reveal anything interesting.
>>          */
> I feel this is a weird thing to do, since you're trying to anonymize the branch
> name,and now the default branch is identifiable with your config file.  For
> example, if the default branch contains the name of my project/repo then this
> sounds like a recipe for accidentally sharing it. I feel a better
> alternative would
> be to exclude nothing from the anonymization or the proposed default default
> branch name

I wonder if anything bad happens if we keep *no* refs intact in this
function.  "Since it does not reveal anything interesting" is an
excuse why not munging it may be OK, but it does not explain why we
prefer not munging it actively.

If there is no reason to keep _some_ refs as-is, I agree that it is
perfectly sensible not to have this special case at all.

Thanks.

>> -       if (!strcmp(refname, "refs/heads/master"))
>> +       if (!default_branch_name)
>> +               default_branch_name = git_default_branch_name(0);
>> +
>> +       if (!strcmp(refname, default_branch_name))
>>                 return refname;
>>
>>         strbuf_reset(&anon);
>> --
>> gitgitgadget
>>

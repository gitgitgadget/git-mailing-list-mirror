Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2446C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbiCJT6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiCJT6p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:58:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182F38AA
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:57:42 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42800182955;
        Thu, 10 Mar 2022 14:57:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8xqchkDv5l6lWe5+ARmZeKWQLrG9tCL1lJ/0iO
        NW4R0=; b=Pt85KrVTocm0Ccop7VwwwBb0069BiNS4M5L1rfxjlAJKPCx8xwLL2B
        +19f8zUpzPvX4w4F1v0pKwa4qBaLgQOCrgO2e1ZubdsP4W20l70Db3/SG90ff99M
        6d4LeNTZWMCSAbtJwIG9uJuB0MHg921Xe0xbu7fb5kKK94y9m7po0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BB2D182954;
        Thu, 10 Mar 2022 14:57:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE03E182953;
        Thu, 10 Mar 2022 14:57:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
        <xmqqo82eirnv.fsf@gitster.g>
        <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
        <xmqqcziugtpw.fsf@gitster.g>
        <CANQDOdcDbYHyRuJj0hV_LcYPJdkoJjF_EGN4CXpndc4VQ9dVAA@mail.gmail.com>
        <xmqqv8wlejgc.fsf@gitster.g>
Date:   Thu, 10 Mar 2022 11:57:38 -0800
In-Reply-To: <xmqqv8wlejgc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        10 Mar 2022 10:44:19 -0800")
Message-ID: <xmqqtuc5d1hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 571C26D0-A0AC-11EC-9A19-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Neeraj Singh <nksingh85@gmail.com> writes:
>
>>> > At the conclusion of this series, I defined 'default' as an aggregate
>>> > option that includes
>>> > the platform default.  I'd prefer not to have any statefulness of the
>>> > core.fsync setting so
>>> > that there is less confusion about the final fsync configuration.
>>>
>>> Then scratch your preference ;-)
>>
>> Just to clarify, linguistically, by 'scratch' do you mean that I should drop
>> my preference
>
> Yes.

Let me take this part back.

I do not mind too deeply if this were "each occurrence of core.fsync
as a whole replaces whatever we saw earlier, i.e. last-one-wins".

But if we were going that route, instead of starting from an empty
set, I'd prefer to see it begin with the built-in default (i.e. the
one you defined to mimic the traditional behaviour before core.fsync
was introduced) and added or deleted by each (possibly '-' prefixed)
element on the comma-separated list, with an explicit way to clear
the built-in default.  E.g. "none,refs" would clear the components
traditionally fsync'ed by default and choose only "refs" component,
while "-pack-metadata" would mean the default ones minus
"pack-metadata" component are subject for fsync'ing.  An empty
string would naturally mean "By having this core.fsync entry, I am
telling you not to pay any attention to what lower-precedence
configuration files said.  But I want the built-in default, without
any additions or subtractions made by this entry, just the default,
please" in such a scheme, so do not forbid it.

Or, we can inherit from the previous configuration file to allow
/etc/gitconfig and the ones shipped by Git for Windows to augment
the built-in default before letting end-user configuration to
further customize the preference.

Either is fine by me.

Thanks.

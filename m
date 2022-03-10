Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4346DC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245548AbiCJSp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbiCJSpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:45:25 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCD13EF85
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:44:23 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BFDA18A4CA;
        Thu, 10 Mar 2022 13:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yQF7eD633IAAAQTc+rlMwLMAozBwgTm3dT6bfs
        WH574=; b=oMH9bFUJnOEIUFKujw//oqWHwDcmKFdDMC7Zm/JawoKknp++E6vQ9S
        Tpi7Jj2fpdfZaQsoFxlSed/evhWoD57hcLUitBl1/sWIgsm/pmEByaFosB5LgDYK
        sZsH1yDD7BjhlvBl2MxmLlSez7bUyL/jRkcnJWDoDm3dkUI0dr7J4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8126418A4C9;
        Thu, 10 Mar 2022 13:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EEDF718A4C8;
        Thu, 10 Mar 2022 13:44:20 -0500 (EST)
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
Date:   Thu, 10 Mar 2022 10:44:19 -0800
In-Reply-To: <CANQDOdcDbYHyRuJj0hV_LcYPJdkoJjF_EGN4CXpndc4VQ9dVAA@mail.gmail.com>
        (Neeraj Singh's message of "Thu, 10 Mar 2022 10:38:45 -0800")
Message-ID: <xmqqv8wlejgc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19393858-A0A2-11EC-984E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> > At the conclusion of this series, I defined 'default' as an aggregate
>> > option that includes
>> > the platform default.  I'd prefer not to have any statefulness of the
>> > core.fsync setting so
>> > that there is less confusion about the final fsync configuration.
>>
>> Then scratch your preference ;-)
>
> Just to clarify, linguistically, by 'scratch' do you mean that I should drop
> my preference

Yes.

> Is there a well-defined place where we know that configuration processing
> is complete?  The most obvious spot to me to integrate these two values would
> be the first time we need to figure out the fsync state.

That sounds like a good place.

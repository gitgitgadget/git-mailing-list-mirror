Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F59C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiCJRTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiCJRTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:19:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D0188A26
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:18:40 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55096181429;
        Thu, 10 Mar 2022 12:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SBpQLdp+3BE/z0Z+jeNHrubvixFVNBT9Z2mhXA
        zsnVU=; b=T3ikMysy9hkrUsQotRDQ3grIJboyla5J44kaVvi9jIFxyPgCu6kHsA
        Nr+2w+UUwBTH2BF/vLMPuYJN6nKtK9JYG4JGgLl5Fqn6ROBRPOrRC66tKYPCF16U
        UzIRTfY8Dk1KV6mR1vgO/eCz1Q0pNXd99ZwvWLC+iCNIAcqDnijCo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B581181428;
        Thu, 10 Mar 2022 12:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C7CE5181425;
        Thu, 10 Mar 2022 12:18:37 -0500 (EST)
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
Date:   Thu, 10 Mar 2022 09:18:36 -0800
In-Reply-To: <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 9 Mar 2022 18:53:45 -0800")
Message-ID: <xmqq4k45hgk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FA8E262-A096-11EC-8B4B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> I am wondering if fsync_or_die() interface is abstracted well
>> enough, or we need things like "the fd is inside this directory; in
>> addition to doing the fsync of the fd, please sync the parent
>> directory as well" support before we start adding more components
>> (if there is such a need, perhaps it comes before this step).
>>
>
> I think syncing the parent directory is a separate fsyncMethod that
> would require changes across the codebase to obtain an appropriate
> directory fd. I'd prefer to treat that as a separable concern.

Yeah, that would be a sensible direction to go.  If we never did the
"sync the parent" thing, we do not need it in the fsyncMethod world
immediately.  It can be added later.

Thanks.


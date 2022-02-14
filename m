Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E3C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348592AbiBNRRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:17:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiBNRRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:17:46 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840FC4F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:17:38 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 549EC1862F1;
        Mon, 14 Feb 2022 12:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHgQo3FuKLwlA60RNFWq9ItL4LBbGGW5LuQrFv
        bxunA=; b=LAUWp1m9QN3SLesKF48njBmt9NvhnMZZ1Ch+59Wt9/nuIgoVi9PrCW
        IP2b39Hcvb9lag2sgRM46Jzqo1U/EUVo59o/n0khnpn8839fg3S5AU6ugnZb6+qG
        pPqTKYWLB4h8cTo1KYtO6/GGcdvaNWOKTZEsQwkFHWh+V4o4MC6t4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36FBA1862F0;
        Mon, 14 Feb 2022 12:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A7601862EF;
        Mon, 14 Feb 2022 12:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
        <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
        <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
        <xmqqczjt9hbz.fsf@gitster.g>
        <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
        <xmqq35kp806v.fsf@gitster.g> <Ygn/GvLEjbCxN3Cc@ncase>
Date:   Mon, 14 Feb 2022 09:17:31 -0800
In-Reply-To: <Ygn/GvLEjbCxN3Cc@ncase> (Patrick Steinhardt's message of "Mon,
        14 Feb 2022 08:04:58 +0100")
Message-ID: <xmqqh7914bbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEB280DE-8DB9-11EC-B26A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> To summarize my take: while the degree of durability may be something
> that's up for discussions, I think that the current defaults for
> atomicity are bad for users because they can and do lead to repository
> corruption.

Good summary.

If the user cares about fsynching loose object files in the right
way, we shouldn't leave loose ref files not following the safe
safety level, regardless of how this new core.fsync knobs would look
like.

I think we three are in agreement on that.

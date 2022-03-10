Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81811C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiCJVSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbiCJVSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:18:24 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A50179269
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:17:23 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E8FB1074F9;
        Thu, 10 Mar 2022 16:17:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OF0ixki94MZ5Xxi7FaX7S0T73GL8/KQtDRszNd
        OFSxU=; b=qxuR7wlSRcJnyNUl+VGCkuzUU0IExqv1kpdjJYkNwTOdB5/IE8mORO
        Lpx48UZ93nAcwzgoqoH7Y6xxCrfc2W/DgTEqqIkeR8zwFvDoJm8iAzcvOhl7oCBF
        ZFGxm/1zdwhYi8OTIDhI8JZ2y92phRiJ/Vx/igKsq+g8EVFXj9TSw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0421B1074F7;
        Thu, 10 Mar 2022 16:17:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EE0A1074F6;
        Thu, 10 Mar 2022 16:17:21 -0500 (EST)
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
        <xmqqv8wlejgc.fsf@gitster.g> <xmqqtuc5d1hp.fsf@gitster.g>
        <CANQDOdfvADcZ5Ng876EO=W2w+6ROvkWAm=XaAOtSUnxV5GGAXA@mail.gmail.com>
Date:   Thu, 10 Mar 2022 13:17:20 -0800
In-Reply-To: <CANQDOdfvADcZ5Ng876EO=W2w+6ROvkWAm=XaAOtSUnxV5GGAXA@mail.gmail.com>
        (Neeraj Singh's message of "Thu, 10 Mar 2022 12:25:20 -0800")
Message-ID: <xmqqk0d1cxsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 793691D2-A0B7-11EC-B884-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Under this schema, 'default' isn't useful as an aggregate option, so
> I'll eliminate
> that.

Yeah, the only difference is the starting point.  Either start with
default set of bits and give an option to clear, or start with an
empty set and give an option to set default.  The former may be a
bit less cumbersome to users but there isn't a huge difference.


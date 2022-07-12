Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A56C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 05:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiGLFXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLFXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 01:23:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5631202
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 22:23:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57A6A1A2E32;
        Tue, 12 Jul 2022 01:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q31oC6APhffyXPJ+Bomsoo5M7aIeAht/XLwGdJ
        P4hNI=; b=lkIP1fM8ymO3RuIQj9pmDv1FmxWvQnRcuLbIglzmzw++MxfXpNyfDH
        mu61jRgwnTBCmHPLADjf1eoWRypQ2O9tRPiKpKuHXrW3IIGOdCDByJp+E0kH03dn
        PBgHi11NBfPJeufpPfGqhM5bUSvcTI8pUR++B26GGWuxfQgAzygTU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F3B01A2E31;
        Tue, 12 Jul 2022 01:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF41F1A2E2F;
        Tue, 12 Jul 2022 01:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     Jeff King <peff@peff.net>, Michael J Gruber <git@grubix.eu>,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [External] Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
        <cover.1656593279.git.hanxin.hx@bytedance.com>
        <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
        <165736941632.704481.18414237954289110814.git@grubix.eu>
        <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
        <xmqqk08jo147.fsf@gitster.g>
        <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
Date:   Mon, 11 Jul 2022 22:23:01 -0700
In-Reply-To: <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
        (Han Xin's message of "Tue, 12 Jul 2022 09:52:42 +0800")
Message-ID: <xmqq1quqkiq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B3B9BB12-01A2-11ED-B683-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

>> I wonder if we can just run the test without any limit?  If in an
>> unattended CI situation, hopefully they will kick the job out due to
>> quota, and on a developer workstation, there may be processes killed
>> left and right, but that is only when the "infinite respawning" bug
>> reappears.
>>
>
> The tricky thing about using ulimit is that it's tied to the entire development
> station. I have tried to run the test without any limit [1], it did finally be
> canceled after 6 hours.

I am not worried so much about developer workstation, which people
are sitting in front of.  They can ^C any runaway test way before 6
hours just fine.

I am assuming that we do not have to be worried about CI settings
too much, either, as they should already be prepared to catch
run-away processes.

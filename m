Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1032C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbiHSR4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351691AbiHSRzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:55:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE45402C2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:36:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B3F81AC6BA;
        Fri, 19 Aug 2022 13:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iitTEKDu62DK2Sxfu5InNj22GjBDZ+P/rd1Cg3
        hfYY4=; b=RdDebLoDUXai6MeAf8ZxMEppaBKC2Rpibr76cFAdTqiH8XlQ8KWj2v
        kbhiwcdS7y62BEM4vcf5crFQb3rHQr513kcfT1p9BLvS+zap8zwN5W3hT8BxS+za
        6UDYg3UB2LkgbRtRelIAQS7VC2yf+z2SobeVO8BS3ISkjbXWEluRM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13F4B1AC6B9;
        Fri, 19 Aug 2022 13:36:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B85A61AC6B5;
        Fri, 19 Aug 2022 13:36:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
        <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
        <06s6r3s7-27nn-1o9s-1n7p-5413284r8740@tzk.qr>
Date:   Fri, 19 Aug 2022 10:36:18 -0700
In-Reply-To: <06s6r3s7-27nn-1o9s-1n7p-5413284r8740@tzk.qr> (Johannes
        Schindelin's message of "Fri, 19 Aug 2022 11:26:35 +0200 (CEST)")
Message-ID: <xmqqfshsm8z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F8AFE9A-1FE5-11ED-A2BA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Perhaps we should have the error_resolve_conflict() function take a
>> "enum replay_action" instead?
>
> We could do that. We could also just delete the sequencer code. It's just
> that both are a bad idea.

Sorry, but I do not quite understand this comment.  You may think
some parts of the sequencer code are a bad idea but I think overall
it is eminently useful and usable enough that it does not make sense
to "just delete the sequencer code"---if there are things we find
bad ideas in there, we should fix them instead, no?

In any case, can you keep the conversation more civil?  I have to
say that between you two, you may by no means be the only one who is
unnecessarily abrasive, but if you do not understand why the other
side suggests a solution you feel you do not like, you can ask more
constructively why they think it is a good idea, without assuming
that they are doing so only to block you.  Or explain why you think
it is a bad idea by showing the consequences of their solution, e.g.
"there are 20 callsites, among which only 1 has the enum readily
available so it would be a lot of churn to give the other 19 the
enum, even though the error helper may become simpler with a single
switch() statement if we allow it to take an enum." or something (I
know this function is called only from very few places, so 1 out of
20 is a totally made-up reasoning that would not apply in this case,
but you get the idea).

Thanks.


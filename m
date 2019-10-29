Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3981F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfJ2BUS (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:20:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57581 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfJ2BUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 21:20:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56BBB33928;
        Mon, 28 Oct 2019 21:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hptOrTtbPX+lwbHfKvzDy/uDdak=; b=TgN2YK
        8PYctgbgTKqdGeb4zb2jNLTgHgXa/ZS2DbVRrGSSFtbnm5bsW6YNBOE1F3KWTETe
        hjukqXxnw3HsTSVW+b7swPRGr8xGivEsE+Gpmj2VI4h4/+FMwCI/kaENq4qj2vwJ
        Fea74Swd2V0pEMnrYN5NnM7bg+f9uz6JKr4kU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=obS1nal7MWZ3ApWAhXCC6ld4f1U/ly0t
        nBwdfem1Fr1jjaWVrx8Bj0m0UicFROrU60QyAJzW3RhwzkQXvFs7UWIRlXaJ6h4h
        X4xK+8SBluV2bw/sXHa4xA49r9zs11sUeI53etfTA173fQt8blUtaH7eQQopmXOI
        53SVrWrmB8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F08833927;
        Mon, 28 Oct 2019 21:20:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B60CB33926;
        Mon, 28 Oct 2019 21:20:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the root directory
References: <pull.390.git.gitgitgadget@gmail.com>
        <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet>
        <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet>
        <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet>
        <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Oct 2019 10:20:14 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 25 Oct 2019 15:30:37 +0200 (CEST)")
Message-ID: <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4342B306-F9EA-11E9-B410-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
>> sanity in the face of refactoring and rewriting -- and as mentioned
>> before they have caught refactoring bugs in those areas that appear at
>> first blush as "overzealous", ...
>
> One idea would be to try to guard those extra careful tests behind the
> `EXPENSIVE` prereq.

Yeah, I like that---I think it is perfectly in line with the spirit
of EXPENSIVE, too.

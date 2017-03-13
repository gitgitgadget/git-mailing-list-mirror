Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8D21FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754244AbdCMRL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:11:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753451AbdCMRL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:11:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67B9F7FEDD;
        Mon, 13 Mar 2017 13:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qWfp9BgUTqrG9jrwI91KMPJKd7A=; b=mgekWo
        9DULnYGR12yHe30rZMmwO25qDMQMElqCQOfss4RbS50+Y1KvpI3+daiYNmwt5881
        ZbtzHUDY+J4pRxA9b0z7hMSPf936XC6Q0m6izUqw2V6LEe9zRV8IGbXoE7DvrOvG
        Ttr319c80V9nG3yy9507YJOQpk/6Z98clnM3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vbaKbFqkCN/tn2PsDSVssHwUEB8Z1kF3
        l/Kh6X/bfkG/OrzmobS2Qo7EFNgP7k7KpmgaUyrXixkrHPd3r7yyazuYwQ66gzvp
        QHdlyTAOOSoBf2Pmx0P4qcN50cqUKVeunDioTWndqm1Dh4JnwmuE37kG8tTWGS0K
        SETr4PHxX5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 617D47FEDC;
        Mon, 13 Mar 2017 13:11:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D31277FEDA;
        Mon, 13 Mar 2017 13:11:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
        <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
        <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
        <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
        <xmqq7f3uuzuu.fsf@gitster.mtv.corp.google.com>
        <ee3f01f0-2dc1-f919-223c-dad6032fa396@oracle.com>
Date:   Mon, 13 Mar 2017 10:11:23 -0700
In-Reply-To: <ee3f01f0-2dc1-f919-223c-dad6032fa396@oracle.com> (Vegard
        Nossum's message of "Mon, 13 Mar 2017 12:07:32 +0100")
Message-ID: <xmqqbmt5t83o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 168A7994-0810-11E7-847C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> However, I think it's more useful to think of these testcases not as
> "binary test that nobody knows what they are doing", but as "(sometimes
> invalid) packfiles which tickle interesting code paths in the packfile
> parser".
>
> With this perspective it becomes clearer that while they were generated
> from the code, they also in a sense describe the packfile format itself.

I do agree with these two paragraphs (that is why I said that
continuously running fuzzer tests on the codebase would have value),
and I really appreciate the effort.

> I did a few experiments in changing the code of the packfile reader in
> various small ways (e.g. deleting a check, reordering some code) to see
> the effects of the testcases found by fuzzing, and I have to admit it
> was fairly disappointing. The testcases I added did not catch a single
> buggy change, whereas the other testcases did catch many of them.

In short, the summary of the above three paragraphs is that we still
do believe the general approach of using fuzzer has value, but your
experiment indicates that data presented in the patch in this thread
weren't particularly good examples to demonstrate the merit?



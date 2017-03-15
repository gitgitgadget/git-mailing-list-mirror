Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE806202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdCOTQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:16:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751416AbdCOTQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:16:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C407DE4D;
        Wed, 15 Mar 2017 15:15:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=twZ/av+o/yuho+GN9+Hc8ln8aus=; b=oIllCG
        gf6CjXyRfqQdsrcOYSMmYb3f2r8KwdAtNAjDbC7R2mb52FrFHc3Ff3KM5najW66M
        E74CtIlVj7nWeXIIPg3+nSu9rhZs/cpLpT5MlnrwupxJmji7bmbYeCgy7yoEGx28
        Tv8z13RBBWnyNGT15QnSeMhTAtEdsOqKXbfvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KfcLk3brUrPncsTMW7Qx0bzmk82BvcIw
        IAe1GhAqOg23ZKUvcE0pBcGs9jKJMCOvCAd1yUO5MtV9CHb9AULoomzBSqO+DeYN
        K+gLvWpqo7F/ue1zUvP5XBRxyaAdpk/iLBsQYSs8Ihe8EgXyQuXHLGM8o7ag2pjt
        BjdM1YpkW8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D65FB7DE4C;
        Wed, 15 Mar 2017 15:15:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48F5A7DE4B;
        Wed, 15 Mar 2017 15:15:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] cherry-pick: detect bogus arguments to --mainline
References: <CACBZZX7Um==4pWfUVcLM8Kbk-ry8HQAmDoUVGjVPmhY3ZXUNYg@mail.gmail.com>
        <20170315165623.sniukjnhonf3uddy@sigill.intra.peff.net>
Date:   Wed, 15 Mar 2017 12:15:44 -0700
In-Reply-To: <20170315165623.sniukjnhonf3uddy@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Mar 2017 12:56:23 -0400")
Message-ID: <xmqq4lyufj1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA219ECA-09B3-11E7-B3AF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "0" comes from the initialization of the replay_opts struct (it also
> happens if you explicitly disclaim any previous option with
> --no-mainline).
>
> I think using 0 as a sentinel is OK here, but the option-parser should
> complain when we go out of range. Like this:

An alternative could be to use -1 as a sentinel and clean it up
after parse_options() returns, but then we will see another "bug"
report that says "cherry-pick -m -1" gives a bad error message,
which essentially is the same "bug" report as the one that triggered
this change, which says the error message from "cherry-pick -m 0" is
wrong X-<.

The "RANGE" thing is certainly tempting, but let's do so after we
find multiple places that can benefit from it.

Will queue; thanks.

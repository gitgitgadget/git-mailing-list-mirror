Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDA520282
	for <e@80x24.org>; Wed,  1 Mar 2017 23:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbdCAXZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:25:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52261 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753099AbdCAXZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:25:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08A027775C;
        Wed,  1 Mar 2017 18:18:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FSYUp90prmp6TVSomwv0GtmwCuI=; b=iAMk1O
        8qXfU+aA5x4R67v3HelKpGDE6TkI49SVVRL4HpOGK5i596SxhxlUvuG3EXA6YBLb
        k+yLHUllNWghYi+ZMmB0/fFKmTdGmDUgzDnpSK2YR0XOvEsaqQ8cp6Xf/vel0vyz
        VP2ZlCXnraML4VEQUe4+4mp8JZbsJSeq03oSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i1MHUM+EzznkSee+EVrezP6EqfG41tej
        x6oCA5FkHWmHtgNmntDoPj3TcayQAMG4NXbbzbeoxfzqyIzN1KCEf3wzmbotr50y
        h6hPPC9356wXSmATgkBd4D54ceE8qs+CND+/kgYUy+LHnrur0VkxkvP/P8vqBjdc
        zt8fp+z08xQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01BE77775B;
        Wed,  1 Mar 2017 18:18:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BB8A7775A;
        Wed,  1 Mar 2017 18:18:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 6/6 v5] revert.c: delegate handling of "-" shorthand to setup_revisions
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
        <1488007487-12965-7-git-send-email-kannan.siddharth12@gmail.com>
Date:   Wed, 01 Mar 2017 15:18:56 -0800
In-Reply-To: <1488007487-12965-7-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Sat, 25 Feb 2017 07:24:47 +0000")
Message-ID: <xmqqa894egbj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71F15A08-FED5-11E6-BD31-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> revert.c:run_sequencer calls setup_revisions right after replacing "-" with
> "@{-1}" for this shorthand. A previous patch taught setup_revisions to handle
> this shorthand by doing the required replacement inside revision.c:get_sha1_1.
>
> Hence, the code here is redundant and has been removed.
>
> This patch also adds a test to check that revert recognizes the "-" shorthand.

Unlike "merge" [*1*], I think this one is OK because "git revert
$commit" does not try to say _how_ the commit was given, and most
importantly, it does not say what branch the reverted thing was.

Thanks.

[Footnote]

*1* Probably "checkout" would exhibit the same issue as we saw in
    5/6 for "git merge" if you remove the "- to @{-1}" conversion
    from it.



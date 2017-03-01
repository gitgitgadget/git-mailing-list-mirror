Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA292027B
	for <e@80x24.org>; Wed,  1 Mar 2017 22:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbdCAWnM (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 17:43:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51055 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751055AbdCAWnI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 17:43:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D7DB771A2;
        Wed,  1 Mar 2017 17:43:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rn68Pi79HTlEb0diRx7WNO6nFD4=; b=Nc51Ww
        qpsG8YU+iuHWTxgkfd6GtXQWzibidmr4kLpS7a2dfVZdpc6cALl8tqI8gJudkOZo
        UkAIf3aXY86kfPiLJEp4IoCPMtgko5Yh/pzdgNHZKHwdQYxaU2QGHOhgsx0p5UWq
        lQGZvv9zL3yJJG1ePDtrn1ywbt95y2+Pj+D8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nLfLl0Tn/K3hqucznoTALRhx0kWBdUhi
        M+/CQ8gaIOrrR0F0EukFJypfJjVOumMPu8SerGP2qbjwUAIvLx1AQPhK1UPVF7VZ
        pZVgpDXmGocpVfJ5FnwW4ir5DJNRYSfMDlSTmjM6MLmH2eZHE1sjpqruE1Z9ykIi
        uVqj/gr4GEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77247771A1;
        Wed,  1 Mar 2017 17:43:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBD2E7719F;
        Wed,  1 Mar 2017 17:43:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170228203340.18723-1-t.gummerer@gmail.com>
        <20170228203340.18723-5-t.gummerer@gmail.com>
        <xmqqo9xmhshd.fsf@gitster.mtv.corp.google.com>
        <20170301215759.GA11067@hank>
Date:   Wed, 01 Mar 2017 14:43:04 -0800
In-Reply-To: <20170301215759.GA11067@hank> (Thomas Gummerer's message of "Wed,
        1 Mar 2017 21:57:59 +0000")
Message-ID: <xmqqtw7cehzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F903158-FED0-11E6-8540-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 02/28, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> 
>> > +			git reset ${GIT_QUIET:+-q} -- "$@"
>> > +			git ls-files -z --modified -- "$@" |
>> > +			git checkout-index -z --force --stdin
>> > +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")
>> 
>> I think you forgot to remove this line, whose correction was added
>> as two lines immediately before it.  I'll remove it while queuing.
>
> Yes, sorry.  What you queued looks good to me, thanks!

Thanks for double-checking, and thanks for working on the topic.  I
think this is ready for 'next'.

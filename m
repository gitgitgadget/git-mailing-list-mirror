Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE878201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 03:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbdKJDOv (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 22:14:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56439 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755887AbdKJDOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 22:14:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA5E5B41CA;
        Thu,  9 Nov 2017 22:14:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xpfO7DosF7jADyDbLWge2S/XhpU=; b=J/ch9f
        e5VVZo2AJABt5jlsRbLAwgz2aRRaV2RLZ3OtSMJgafWM6NylITH7KHL3kRkiSf0P
        a7BMpkuUaI6jfEVYUD10du8KBiYDFVtjlPT1vqbbYXQo7GUr2m5r7dqpIYhEMYQY
        QcnaAXeUUlqBA/L5QG/nlsVZn+Qas8sXK5+Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=trQDezOOi2tp6p2ZwKIJHriy96TXm3Gx
        D6rwm8Xx0vsjrINhdNbt+mLbd2O1+Kh2ha0+LpOhI5G6EKeIpj2vTfg3dMdwDBrx
        NG2w1S5IOku+C5lKBKa87aPgub5tJe50UtrKF51IhgP0cnm+ZzJf60MayxnE5iEl
        iozpdaHqZJM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D319DB41C8;
        Thu,  9 Nov 2017 22:14:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B814B41C7;
        Thu,  9 Nov 2017 22:14:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git List <git@vger.kernel.org>,
        Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: add `rm` and `delete` commands
References: <20171109134617.65244-1-adam@dinwoodie.org>
        <CAPig+cRq7thrPtzS0V6o-wMhHyYWKeWg-xOQhnWCO5sLE=kDcw@mail.gmail.com>
Date:   Fri, 10 Nov 2017 12:14:44 +0900
In-Reply-To: <CAPig+cRq7thrPtzS0V6o-wMhHyYWKeWg-xOQhnWCO5sLE=kDcw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 9 Nov 2017 11:18:01 -0500")
Message-ID: <xmqq1sl6j04b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D3EFB18-C5C5-11E7-AB14-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> or against the change:
>
>     - synonym bloat; balloons documentation
>     - steals command verbs from potential future features
>     - ...

I tend to agree with these two (and if I were to replace the "..."
with something concrete, this change is not desirable because it
will force us to add all these three when we introduce "remove"
elsewhere in the system).

Having said that, this remids me of an age-old topic we discussed in
a distant past but stalled due to lack of strong drive, which is:

    Some git subcommands take command verb (e.g. "git notes 'remove'")
    while others take command mode flags (e.g. "git branch --delete"),
    and the users need to remember them, which is not ideal.

I think the consensus back then, if we were to aim for consistency
by uniformly using only one of the two, is to use the command mode
flags, simply because existing commands that have the primary mode
and take an optional command mode flag [*1*] cannot be migrated to
the command verb UI safely and sanely.

And then, if we are not careful when we standardize all subcommands
to take command mode flags, we might end up with a situation where
some subcommand say "--remove" while other say "--delete", and some
users will wish to rectify that situation by adding an alias defined
for these flags---I view this patch as a part of that possible
future topic ;-).


[Footnote]

*1* For example, "git branch" by default is in the branch creation
    mode, but it can be told to work in its branch deletion mode
    with "--delete".

    If we were to standardize on command verbs, is "git branch
    delete" a deprecated relic from the old world that wants to
    create a branch whose name is 'delete', or is it done by a
    script in the new world that collected names of branches to
    delete and asked "git branch delete $to_delete" to delete all of
    them, where the $to_delete variable happened to end up empty?

    With command mode flags, we do not have to worry about such an
    ambiguity during and after transition.

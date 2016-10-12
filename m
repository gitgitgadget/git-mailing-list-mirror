Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD9A20989
	for <e@80x24.org>; Wed, 12 Oct 2016 07:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbcJLHA3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 03:00:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54996 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753967AbcJLHA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 03:00:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A68B53E6FD;
        Wed, 12 Oct 2016 02:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rrw2r+Muqd0qsHfVFTSreXYyzwU=; b=uNnywW
        /qlNVkhOjWH6lFCao4J+BFDnWMYzDLg07JShU6eMzPN/fUEpeeWFL/MSRZaIQCB5
        4EIsxjU3VThQQxQioXs23nF2SEPYgwFGmsgPM67x5baKnty1ARXUHSdfz3Uj1Yni
        RX9U8xjFpgvTh5JDDMtAcY3ty2Y5TinOQvbvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FJO6W/CRfIYBCOEhol3RZewljFrjJ6NM
        zpttQDr7hWQGmZIeP5zjsNTora+Lxoj3Thjb5fvJNrChw4gzIezIFLF8PM8hAU06
        rf3DsAh9WwUcL7IKSzLIlPJXFwgbUWxsEVvDhVsCbYXhfrcpE6fbHwX/DRYcPNly
        eWF8rHTLfIQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E3663E6FC;
        Wed, 12 Oct 2016 02:24:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14F1E3E6FB;
        Wed, 12 Oct 2016 02:24:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 1/5] trailer: use singly-linked list, not doubly
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476232683.git.jonathantanmy@google.com>
        <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
Date:   Tue, 11 Oct 2016 23:24:48 -0700
In-Reply-To: <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Oct 2016 18:23:25 -0700")
Message-ID: <xmqqmvia5bkf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 944367C2-9044-11E6-8886-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Use singly-linked lists (instead of doubly-linked lists) in trailer to
> keep track of arguments (whether implicit from configuration or explicit
> from the command line) and trailer items.
>
> This change significantly reduces the code length and simplifies the code.
> There are now fewer pointers to be manipulated, but most trailer
> manipulations now require seeking from beginning to end, so there might
> be a slight net decrease in performance; however the number of trailers
> is usually small (10 to 15 at the most) so this should not cause a big
> impact.

It is overall a very good change, but can you split this into two
independent patches?  s/struct trailer_item/const &/ sprinkled all
over the place is more or less unrelated change and it is very
distracting to see the primary change of the way lists are handled.

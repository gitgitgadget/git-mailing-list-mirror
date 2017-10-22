Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659AD1FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 02:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbdJVCE2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 22:04:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56711 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932295AbdJVCE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 22:04:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B40F19C79D;
        Sat, 21 Oct 2017 22:04:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a0Td0zc3Lr7hISrHFZxz3eQWHAY=; b=lHGkwV
        /AkYKA8x+zEwn70+VHXFWsA9SE5GTmR/tyyOgpQ74PUFMwTL2RCRZ9HO/Piy9IDZ
        S6k/qSJ7x4Wj/pu0WY4uD7wP1Vo3E2GDN9kEiREt2e4K6nyKC5JL3DuIs8svLNyV
        R6X2dDz2pa/DgQMb1L2SAZEVryGmfn6sxF+rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qljWvvgSZZvB1Zatu4hliuS/MRvMTWxw
        iMO/5M5EPp7bGys9MsIAZ0nEycf+5w6JcYjzQNc/NiddNElp4lTnkY4vXUjqWYTt
        HvQV1Io6tjNsbkeAYl+RH7t2uiyl+tSgLPzNEmH8vcxP/MKqKiuidrApdY9jhP+J
        niCWLZNFjIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC0C9C79C;
        Sat, 21 Oct 2017 22:04:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16A1A9C79B;
        Sat, 21 Oct 2017 22:04:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
Date:   Sun, 22 Oct 2017 11:04:25 +0900
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 19 Oct 2017 14:30:24 +0200")
Message-ID: <xmqq8tg4djkm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5495A8AA-B6CD-11E7-B4F3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Goal
> ~~~~

Totally offtopic, but is it only me who finds these "section
headers" in cover letters from some people irritating and/or
jarring?  It perhaps is because I view the cover letter more as a
part of conversation, not a presentation.  And when you walk up to
somebody and start a conversation, you do not declare section
headers ;-)  

Saying "I want to be able to do these things in the future, and here
is to prepare for that future" at the beginning nevertheless is a
good thing.  It gives us readers an overall vision we can agree to
(or be against, or offer alternatives) and sets expectations on what
the series would do and where it stops and leaves the remainder to
follow-up work.

> Packet related functions in Perl can be useful to write new filters or
> to debug or test existing filters. So instead of having them in
> t0021/rot13-filter.pl, let's extract them into a new Git/Packet.pm
> module.

I left some comments on individual patches to point out places that
may need improvements.  I agree with the overall direction.

Thanks for starting this topic.

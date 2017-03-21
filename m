Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F015F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 17:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757759AbdCUR5t (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:57:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757753AbdCUR4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:56:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7934364BD6;
        Tue, 21 Mar 2017 13:56:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T7DM3c05vCpjqrS/BEOFnmdFOMI=; b=lYtq27
        hLhMCTu8olrrfu3uqABBaEKY86kEgKmI0XV0p3BXoL5MsKpywsdihhyhhDzVWHtN
        euL2h06W2+b+rgXXGKgCBZ6euhklBEs9Leq3jW0XC4O8UAb8lFwy+suH3u2PFVwl
        GQp+9IcP1+24NBOX6KJX8whS2cWRIzgBlQ68o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OcZqhVDEOoQnC6ZNRfTcuE92ZiELyQ/P
        V80hNPuPndQaKda896q9mLDtDM38ukbC1xcYETwCQO4NMrzP6UCF9tUw24jgDo7T
        7Otr1AdzETIu4yrl6cA0Opp/4bf/BJbpKUuXqTqULWbESvYLQlPDrVJ7eWfYNYmy
        b3M0wMe2WjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70DEE64BD4;
        Tue, 21 Mar 2017 13:56:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA23E64BD3;
        Tue, 21 Mar 2017 13:56:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] grep: fix bug when recursing with relative pathspec
References: <20170314221100.24856-1-bmwill@google.com>
        <20170317172257.4690-1-bmwill@google.com>
        <20170317172257.4690-4-bmwill@google.com>
        <CACsJy8Cu8cgtJzDDM09GoJr5Ny+G+nP17GjZjXng6ZPQv9eXXg@mail.gmail.com>
Date:   Tue, 21 Mar 2017 10:56:12 -0700
In-Reply-To: <CACsJy8Cu8cgtJzDDM09GoJr5Ny+G+nP17GjZjXng6ZPQv9eXXg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 21 Mar 2017 18:47:10 +0700")
Message-ID: <xmqqzigeqzsz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACA20F5A-0E5F-11E7-B973-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>         if (recurse_submodules)
>>                 argv_array_push(&submodule_options, "--recurse-submodules");
>
> Side note. It would be awesome if you could make parse_options() (or a
> new function) do the reverse process: given a 'struct option' with
> valid data, spit out argv_array. Less worrying about git-grep having
> new option but not passed to subgrep by accident. You can have a new
> flag to tell it to ignore certain options if you don't want to pass
> all.

It indeed would be awesome.  I do not offhand know if it would be
feasible or the result is easy to use without mistakes, though.

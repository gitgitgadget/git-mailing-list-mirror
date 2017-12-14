Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AEC1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 17:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbdLNRb0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 12:31:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753578AbdLNRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 12:31:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB40C6C06;
        Thu, 14 Dec 2017 12:31:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DNSj7SpWWjbRkd1YJ2qvu397xC0=; b=vkB9Pi
        z+nHXGy16VKXXDFK9+DUGrvrd7RG+QgU0DCeBCRVnQtrk6+hoqa5Mrnmy66U4slJ
        DF8CdZMhh6m8prK2KtLJEtKXb09bBY/H/5sVaF54xGJ0lovw390TvURPfUFiOMGx
        aps7m7QQvyfRdzifLxjQKShApsZNBKR3wB9YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlP59+Cz0MypS9V9JkP9XHh3gK59ClYi
        WcKtCDStm+1HCUh6mh2zDuYZuo73OFGwauZBdRoMQmitZZC4cEzNTtKWgVk+Jc2T
        gTjB77eYpkvAy8eRnNk3EeKPv2ycrZzAju8FxpkRPYbJFn73J2qFgO7h0OYN8/JK
        n0vCjzX+8AE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4457DC6C05;
        Thu, 14 Dec 2017 12:31:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D89BC6C04;
        Thu, 14 Dec 2017 12:31:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/8] perf/aggregate: implement codespeed JSON output
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
        <20171213151344.2138-4-chriscool@tuxfamily.org>
        <xmqqfu8ewepg.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1OAwTNAe94DPuJJSAvTa7ojH3sdsK_fkfsW4LUAw+u=Q@mail.gmail.com>
Date:   Thu, 14 Dec 2017 09:31:23 -0800
In-Reply-To: <CAP8UFD1OAwTNAe94DPuJJSAvTa7ojH3sdsK_fkfsW4LUAw+u=Q@mail.gmail.com>
        (Christian Couder's message of "Thu, 14 Dec 2017 09:57:05 +0100")
Message-ID: <xmqqfu8dusgk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BB7ABF6-E0F4-11E7-A43D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> Aside from portability of 'uname -o' Eric raised, I wonder if the
>> platform information is still useful even when perf-subsection is
>> specified.  With the above code, we can identify that a single
>> result is for (say) MacOS only when we are not limiting to a single
>> subsection, but wouldn't it be equally a valid desire to be able to
>> track performance figures for a single subsection over time and
>> being able to say "On MacOS, subsection A's performance dropped
>> between release X and X+1 quite a bit, but on Linux x86-64, there
>> was no such change" or somesuch?
>
> Yeah, I agree that it would be useful. Unfortunately it looks like the
> number of fields in Codespeed is limited and I am not sure what will
> be more important for people in general.

Is there a reason why such textual labels meant for human
consumption need to be two (or more) separate fields?  Would simply
concatenating them into a single string defeat whatever you wanted
to achieve by having this information in $executable in the first
place?


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC511FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbcLISHE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 13:07:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58629 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752184AbcLISHD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 13:07:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C878566E2;
        Fri,  9 Dec 2016 13:07:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wUW6DHZGrtSa+8JAf0El+PbRlRc=; b=IXOdKQ
        4BCY7br85or+JhyqL9/LK4pYcBO3T0wxJOGKPInnw/7vDHQ8GOcZhp95LL7wYXD7
        RrKmIKMOrIkzeHppUfoOhjrzNivLXjUCFXwFjv4Ngjc4uVBqPqfuivmrkFgZJnyF
        c5S5WzbvSAoPMIb4OBnJUG6vHY9NFf+nSu6YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gARIx4QsURCcsBV2v4bIPsqcatwDkMhY
        PcWcMp8yJk3gBqeTZFA+s+Gzf4/N60qN2IBreuHr4NZMdum6HjKhr48VaB0s0rxn
        3OvOXDb1WKezRAp6ZsBoZaYfQuLStGp6k2ZQPLVtmgCFZMHI8Md1dVmVa7Q3E2i6
        tAXcPyF7Zbg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A1E4566E1;
        Fri,  9 Dec 2016 13:07:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B99A3566DE;
        Fri,  9 Dec 2016 13:07:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
        <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
        <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
Date:   Fri, 09 Dec 2016 10:07:00 -0800
In-Reply-To: <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 9 Dec 2016 18:33:08 +0700")
Message-ID: <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48AF1B48-BE3A-11E6-AF9F-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Dec 8, 2016 at 3:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stephan Beyer <s-beyer@gmx.net> writes:
>>
>>> [1] By the way: git cherry-pick --quit, git rebase --forget ...
>>> different wording for the same thing makes things unintuitive.
>>
>> It is not too late to STOP "--forget" from getting added to "rebase"
>> and give it a better name.
>
> Having the same operation with different names only increases git
> reputation of bad/inconsistent UI. Either forget is renamed to quit,
> or vice versa. I prefer forget, but the decision is yours and the
> community's. So I'm sending two patches to rename in either direction.
> You can pick one.

I actually was advocating to remove both by making --abort saner.
With an updated --abort that behaves saner, is "rebase --forget"
still necessary?


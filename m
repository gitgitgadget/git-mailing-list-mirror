Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0041F731
	for <e@80x24.org>; Fri,  9 Aug 2019 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407566AbfHIRon (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 13:44:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61429 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407544AbfHIRon (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 13:44:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1B2B1740AB;
        Fri,  9 Aug 2019 13:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1Zg7DhETBPdUfzqRXwhbvutCdI=; b=uPVYky
        hIn1j1L2sjId1oBAf8eTdFCszf49l+gE58PaDFkhrfw9mCmZnCdVQKvEcEhc1YtR
        I+/1uzXp9Lhr0urh5bqBmAFHFVM/jb0EEvyqvstd1DHu280d5ugNo95+hlwxdQFV
        eGBHcaFaJT8bWDXnRL+Wz7of5e+AfjMvPfKIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ubZDM3mH/6Bu+3aRT0+mwYNCc5wXr3lZ
        J3Viy+7ZVvBtl4F/vJRKnrkDza1ko18w222EjtpuEMGE5acspYev5O9j86UGmGxa
        lSLrbX7b70vGjGYvRs0ixp2JgzhofrJBTy+WE5s9EVk5THdYetS6Kgo5evigzqTX
        e+QERMivfuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8A411740AA;
        Fri,  9 Aug 2019 13:44:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D4631740A9;
        Fri,  9 Aug 2019 13:44:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Christian Couder'" <christian.couder@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
        <20190809001315.GA87896@syl.lan>
        <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
        <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
Date:   Fri, 09 Aug 2019 10:44:39 -0700
In-Reply-To: <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 9 Aug 2019 10:06:06 -0400")
Message-ID: <xmqq7e7mdyig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D0755FA-BACD-11E9-9DF9-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On 01 Aug 2019 13:05:12, Junio wrote:
>> >> *snip*
>
> I think this got missed in the shuffle, but I am getting questions
> about the topic from my own team that I cannot answer.
>
> I noticed that the switch and restore commands are now available
> in 2.23.0 but are not discussed in recent What's Cooking or Git
> Rev (or I blithely missed them). The question from my team is what
> are the plans for deprecating checkout. They have loads of scripts
> and want to plan for moving over.

The two new commands were done in response to a common "checkout
does two different things, either checkout a branch in order to
start working on it, or checkout paths into the current workspace to
work on them" complaint.  Those who are used to and are OK with the
"git" command that changes behaviour based on the rest of args (i.e.
"checkout <branchname>" and "checkout [<tree-ish>] <pathspec>" are
the ways to obtain these two behaviours) can safely keep using the
command they are familiar with.

I do not think there currently is any plan to deprecate checkout.

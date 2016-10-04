Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B81C207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 04:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbcJDEBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 00:01:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52937 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751664AbcJDEBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 00:01:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDCEA43C29;
        Tue,  4 Oct 2016 00:01:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kGtEJU3Suu4urQ2DjN6AwDafbow=; b=jWA5Io
        bFYy0DNCgmXSD8cv1vUO2wVy9pd2dfg8SE0C12i1jii/MiQR3n/joL0stW3WwKtb
        s+iFS0ZC2X4J/7BkkXH9lx4i0OUnkJODi7OBxmPQ+ltj8xTiFZLabgEzYc7S6syN
        QCdkJUjLtEbCXuBWu1a2lT8DO0gcY7c8DHwTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XGEIwK13WDz6MSEm/vjkkpUAbj5mHLP9
        TnpIylnN6p92u8s837XUwhx/X0c3xgM2JwLJRCRvlRwORqEZwgdkcGcnUw8iqHTC
        xfYbWMp5FIr9qw23qkPSk7UZAwQIX2YSk+ewyph+aTFX5nXM9/NYjMcGqr/TjOZc
        aGWtwANaCBg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF7D143C28;
        Tue,  4 Oct 2016 00:01:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DCC443C26;
        Tue,  4 Oct 2016 00:01:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #01; Mon, 3)
References: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
        <20161004005247.sgeqgw3accn3whgi@sigill.intra.peff.net>
Date:   Mon, 03 Oct 2016 21:01:27 -0700
In-Reply-To: <20161004005247.sgeqgw3accn3whgi@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 20:52:48 -0400")
Message-ID: <xmqq7f9o4vag.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A76C04E-89E7-11E6-9E80-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> * lt/abbrev-auto (2016-10-03) 3 commits
>
> I kind of expected this one to cook in next for a bit while people
> decided whether the larger hashes were irritating or not. Despite
> working on the implementation, I'm on the fence myself.
>
> I'd kind of hoped people would play with core.disambiguate and the hints
> and see if they still actually wanted to bump the default abbrev (and
> how aggressively to do so; if core.disambiguate means most of the
> ambiguity is just between commits, that cuts the number of
> collision-interesting objects by an order of magnitude).

Sure.  Let's keep them cooking.

>> * jk/pack-objects-optim-mru (2016-08-11) 4 commits
>>   (merged to 'next' on 2016-09-21 at 97b919bdbd)
>>  + pack-objects: use mru list when iterating over packs
>>  + pack-objects: break delta cycles before delta-search phase
>>  + sha1_file: make packed_object_info public
>>  + provide an initializer for "struct object_info"
>> 
>>  Originally merged to 'next' on 2016-08-11
>> 
>>  "git pack-objects" in a repository with many packfiles used to
>>  spend a lot of time looking for/at objects in them; the accesses to
>>  the packfiles are now optimized by checking the most-recently-used
>>  packfile first.
>> 
>>  Will hold to see if people scream.
>
> This has been in next for 6 weeks. Is it time to consider graduating it?

Perhaps.

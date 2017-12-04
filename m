Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D79720954
	for <e@80x24.org>; Mon,  4 Dec 2017 18:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdLDSoG (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 13:44:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63904 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752503AbdLDSoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 13:44:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C4C6A6DF3;
        Mon,  4 Dec 2017 13:44:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2mo6IjXguwcUtkb9mT+M8pe8F6o=; b=ey8iwp
        Zvwda9Z5f53+IkbkzdCadlJ/Y7ELnbzRfIpg10TU9omrLxjwc+pM202GK1oVHmgZ
        6CfIa3EgoloFkIZYmPV53SoY7/a/EDJlJJbq4IsW/d1QPXLYpTwGKIPKlnAJJHYr
        PSpTjipzy0hN37aa5UVS/xxi+bBW9Xz7xWWGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AQVCTER/ht7bR6QOMDNucHUhvKzIVIDL
        KXElUrp93b5X1UrQmTDGzFGE4LxD0jJ04SU7hfVPTdNl82CeM34dml9Jt+qQ1rzn
        tC9lyGe3a7zOmqPS5y1BEaq5GCMiJALGO3fOI2pKYEb9z7R1GIZTza09IKJ4Vuoh
        81e67b5slAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73E45A6DF1;
        Mon,  4 Dec 2017 13:44:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B402A6DEF;
        Mon,  4 Dec 2017 13:44:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
        <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
        <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
        <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
        <1511880237.10193.5.camel@gmail.com>
        <xmqqa7z0lgsd.fsf@gitster.mtv.corp.google.com>
        <1512408328.15792.5.camel@gmail.com>
Date:   Mon, 04 Dec 2017 10:44:00 -0800
In-Reply-To: <1512408328.15792.5.camel@gmail.com> (Kaartic Sivaraam's message
        of "Mon, 04 Dec 2017 22:55:28 +0530")
Message-ID: <xmqq8teimiz3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191A404C-D923-11E7-929E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> Stepping back a bit, the mild suspicion above says
>> 
>>     $ git checkout HEAD^0
>>     ... do things ...
>>     $ git checkout -b temp
>>     ... do more things ...
>>     $ git checkout -B @{-1}
>> 
>> that creates a new branch whose name is 40-hex of a commit that
>> happens to be where we started the whole dance *is* a bug.  No sane
>> user expects that to happen, and the last step "checkout -B @{-1}"
>> should result in an error instead [*1*].
>> 
>> I was wondering if "git check-ref-format --branch @{-1}", when used
>> in place of "checkout -B @{-1}" in the above sequence,
>
> I guess you mean '... "git checkout -B $(git check-ref-format --branch
> @{-1}", when used in place of "git checkout -B @{-1}" ...' ?

No you guessed wrong.  I was (and am) wondering if the last step in
the following sequence should fail.

>>     $ git checkout HEAD^0
>>     ... do things ...
>>     $ git checkout -b temp
>>     ... do more things ...
>>     $ git check-ref-format --branch @{-1}

And I am leaning towards saying that it is a bug that it does not
fail; @{-1} is a detached HEAD and not a concrete branch name in
this case, so "check-ref-format --branch" should at least notice
and say that it is a request that may lead to a nonsense next step
(which is to create a branch with that 40-hex name).

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C3220899
	for <e@80x24.org>; Thu, 27 Jul 2017 19:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdG0Tko (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 15:40:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751656AbdG0Tkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 15:40:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2720A01CD;
        Thu, 27 Jul 2017 15:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Md9FTjRR5wMn2XZINp7ESyyqSA0=; b=ategHP
        sOqXSWAKKn2Sv4oR6X6POFqSuSfc0jAA/wT9uIR3qULc2kID0F8ANgXb2gWkWakQ
        jDgJ0w3r1w6IQqZ9DLZQ8naBMHq+eyrs6H46RXVTvHhhIYzyiiB58xE5m1r/slD2
        yqLunlJ2w6B9cTA0J8k/3Upx7go/6ECoisolc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+zCLpDE91o7TdewfehjK3eZs2Jav2vQ
        u099/RYEXO2J0FJFpQgcD4trOd8IysnWnS9WgBzqw4r78Sed0ju9uZHRHPATFDOp
        XWpQDMm0zfz/x01ooEYFR7ik6dIJ0ElVZZlmIiSMy/0dKzoLLm34l3Xk8f5brKK9
        +xyu8PSS3Fk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E6BA01CC;
        Thu, 27 Jul 2017 15:40:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3774CA01CB;
        Thu, 27 Jul 2017 15:40:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
        <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
        <xmqq8tj9okzv.fsf@gitster.mtv.corp.google.com>
        <20170727182854.wxjvjs2x746n3x2t@sigill.intra.peff.net>
Date:   Thu, 27 Jul 2017 12:40:31 -0700
In-Reply-To: <20170727182854.wxjvjs2x746n3x2t@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Jul 2017 14:28:54 -0400")
Message-ID: <xmqqlgn9mzww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73CF3906-7303-11E7-ABE4-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 27, 2017 at 10:19:48AM -0700, Junio C Hamano wrote:
>
>> Makes sense.  Makes me wonder why we need a separate .new file
>> (instead of writing into the .lock instead), but that is a different
>> issue.
>
> It comes from 42dfa7ece (commit_packed_refs(): use a staging file
> separate from the lockfile, 2017-06-23). That commit explains that we
> want to be able to put the new contents into service before we release
> the lock. But it doesn't say why that's useful.

By being able to hold the lock on packed-refs longer, I guess
something like this becomes possible:

 * hold the lock on packed-refs
 * hold the lock on loose ref A, B, C, ...
 * update packed-refs to include the freshest values of these refs
 * start serving packed-refs without releasing the lock
 * for X in A, B, C...: delete the loose ref X and unlock X
 * unlock the packed-refs

Other people racing with the sequence to recreate a loose ref that
is even fresher than the resulting packed-refs file, while we still
hold the lock on packed-refs, is perfectly OK.

But we must make sure our packed-refs is visible to others before
starting to delete and unlock the loose refs.

Hmph, but that is not a sufficient explanation.  I am not seeing
anything bad to happen if we unlock the packed-refs before deleting
loose refs that we have locks on, so there must be something else
that needs "new packed-refs is made visible way before we unlock it".

> I recall from past discussions that this will help close some races,
> and e5cc7d7d2 (repack_without_refs(): don't lock or unlock the packed
> refs, 2017-07-01) alludes to this. I think the races in question have to
> do with holding the packed-refs lock while pruning the just-packed
> files, but I'm having trouble digging up specifics in the archive.
>
> -Peff

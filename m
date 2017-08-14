Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C753620899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbdHNQpi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:45:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751494AbdHNQpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:45:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05FDBA651C;
        Mon, 14 Aug 2017 12:45:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zr8y1k9626/806Cu+2JJ08Domc4=; b=L1jm+c
        VCTuJwYZAHTf/H4dmmCSWM6yUU/mfkXDbr1a/ezzeiMIGEgdWJQYMuJ77sLC3WtN
        R8xnBVjeHSgcZErVBgpTroIxzSupBnrjerzplTTNEReJT85jcjXqV0wX4wv1cGlV
        vvvHPY2ieNwbeM+C4VxIvxB3uS7je3Dwo2Lm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=urWcxH3YW7Cgnw6KZvNMgHN5xuTf0I6G
        70B1ZiwEn9556D7WsG8yiOXOq+gY5D7XVjNc8Fwt7tgAgEhyVggu7JUVYVRssat8
        dIvTPZllfATviGbAYZKCOn61bjvdgmnDYgHTwA+b17m7EElzZScCk+oO9TZpawnp
        E0Xh/064+pA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1CAEA651B;
        Mon, 14 Aug 2017 12:45:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D391A6518;
        Mon, 14 Aug 2017 12:45:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH v2 1/2] format-patch: have progress option while generating patches
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
        <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
        <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
        <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
Date:   Mon, 14 Aug 2017 09:45:34 -0700
In-Reply-To: <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 13 Aug 2017 00:39:40 -0400")
Message-ID: <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE97D448-810F-11E7-B63D-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Aug 12, 2017 at 09:06:18AM +0100, Philip Oakley wrote:
>
>> > > > + progress = start_progress_delay(_("Generating patches"), total, 0, 1);
>> > > 
>> > > I don't really have an opinion on a 1 second delay versus 2. I thought
>> > > we used 2 pretty consistently, though grepping around I do see a couple
>> > > of 1's. It probably doesn't matter, but just a curiosity.
>> > 
> ...
> Here we're just talking about calls to start_progress_delay(), and how
> long it waits before deciding that the operation is slow enough to show
> progress. Blame, rename detection, and checkout use 1 second. Prune,
> prune-packed, and connectivity checks all use 2 seconds. I doubt it
> matters all that much, but presumably the purpose in all is "how long
> before a user starts to wonder if things are actually happening", which
> is probably command-independent.

I feel comfortable moving forward, basing our decisions on the
assumption that the "delay before the user wonders is independent of
the command" without anybody actually proving it.

Even though I think that it is natural for people to expect longer
delay from some operation than others (due to some chicken-and-egg
reasons), trying to scientifically measure and to come up with
different delay value that suited for each and every operation is
waste of our brain cycles.

Perhaps we may want to replace the calls to progress_delay() with a
call to a simpler wrapper that does not let the callers give their
own delay threashold to simplify the API.

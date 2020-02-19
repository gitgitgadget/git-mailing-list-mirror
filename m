Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D591C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 11:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAEA2067D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 11:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C+w7qUd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSLOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:14:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55050 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBSLOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 06:14:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C73244889;
        Wed, 19 Feb 2020 06:14:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EGb9YspM2/wOe8Eo8XnK9zmfdeI=; b=C+w7qU
        d3fwA9TAZoZlkW5bKL3sdt1tgzXwkMafv4IaFZ8mCQhXmyh7pg0a/ISMqo1dWFac
        YcBu5jPzcG5H5BRgNX8vmaE6zgXVhA0blyEMtWojhGwtfWaw5NSmWI3k51f/sLMN
        ToQam8C4SdkNACy0EdXQ1Qouh2O0aepmazHpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4OaSm3t2uvF7xlWXSA1BhESmWFhz2xz
        W6PMqf7kVJfRsZ8GAFyrpXZ3cmwQ7GhRD4yFO3jWaGsxr0D8Rx0dQ0e/v8rrkV6/
        Gb2djHvm1ZOzNPThOFD6j2HxAyeUjX1W1cfkdlpDnmaL2pAD1M12cedkwVvz15yK
        HYEanhPvHYg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03E3044888;
        Wed, 19 Feb 2020 06:14:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 595D944887;
        Wed, 19 Feb 2020 06:14:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
        <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
        <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
        <20200218195402.GA21586@coredump.intra.peff.net>
        <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
        <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
        <20200219015733.GA81560@coredump.intra.peff.net>
        <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
        <20200219035650.GA84414@coredump.intra.peff.net>
Date:   Wed, 19 Feb 2020 03:14:14 -0800
In-Reply-To: <20200219035650.GA84414@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 22:56:50 -0500")
Message-ID: <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6CEC262-5308-11EA-BD6F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think a left a few things unsaid in my "v1.0-bob" example. I was
> imagining that there are _two_ v1.0 tags floating around. One that you
> consider "wrong", tagged by Bob, and one you like. You keep the latter
> in refs/tags/v1.0.

Ahh, OK.  

To continue playing devil's advocate and to step back a bit,

 - The "git describe" command finds that the given commit is
   "closest" to that tag Bob called "v1.0".

 - But if it outputs "v1.0" like the current code does, it cannot be
   fed back to get_oid() to name the right object, if the given commit
   is "at" the tag (i.e. there is no "-$number-g$objectname" suffix),
   which is a problem.  We want "git describe" to give an output
   usable with get_oid() and the name must refer to the correct
   object (i.e. the one given to "git describe" as an input).

There are multiple approaches to make it possible to feed the output
back to get_oid() to obtain correct result:

 - We can describe it based on "v1.0-bob" (i.e. refname, not
   tagname), which is what the proposed patch wants to do.  

   This is nice as it simply exploits the fact that namespace of the
   refs ensures that there can locally be only one tag "v1.0".

 - We can always add "-$number-g$objectname" suffix when we need to
   base the output of "git describe" on such a tag whose name does
   not match its refname.  Both names "v1.0-bob-0-g0123456" and
   "v1.0-0-g0123456" would be accepted by get_oid() and refer to the
   same object 0123456.  

   If we do this, there is no longer any requirement that the
   "tagname" part alone of the output must be usable with get_oid()
   to name the correct object, and because "v1.0-bob" is merely a
   local name external people may not even know about, using
   "v1.0-bob-0-g0123456" may be less desirable than using
   "v1.0-0-g0123456".

 - We can skip the "wrong" tag and not use it to name anything.
   "git describe" may use some other tag that is stored in its right
   place, which may be a bit more distant than tag "v1.0-bob".  The
   warning message may indicate "we would have used this tag to name
   the object because it was the closest, but we skipped because of
   a tagname anomaly".  

   This may be what the person who moved Bob's "v1.0" to "v1.0-bob"
   intended---it is a "wrong" tag that is kept only to communicate
   _about_ the tag, not to be used to refer to other objects
   relative to it.

The "use the refname" and the "use -0-gXXXXXX suffix if using a tag
at a wrong place" approaches are simple and would produce a more
"correct" result than what we currently give.  The "don't use it"
approach simply sidesteps the problem altogether, which is sort-of
attractive ;-)

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBE51F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbdHJWRe (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:17:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753417AbdHJWRT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:17:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2DECA1A80;
        Thu, 10 Aug 2017 18:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bwSryLtwE1r++WcA+u29+eTIcSc=; b=Yvh9qw
        fL94sbeRSHZMUE7EMifRzDyClQgne2JLrjQRudUJbgBdZVoEAo5y24rl+XkF1Lph
        +HrvzG4+g0nrkA5EgfFjIB4MMorIm4jfx1mk2jAsZE3oS3O42PyLl2HShxrvV/D5
        /7ISJqR236uXgTxasrcFP60KVy2Xm6w125gos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CN/mPBsBIhJxZ2wOuX/LdivAYR6E5wul
        xKksaQr3WtPbXhocpO5WLtLuewa6y11XkajgfYLnyDdJSRP/reDOMTDZKFsUTGtx
        U2vzN9bWZC57BnQ8Xt7lROcFBTbw1n5EQXVqnO3XeKTFCPKgJqT6QnShYbNsQuAZ
        eaPGqOkgjH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9A49A1A7F;
        Thu, 10 Aug 2017 18:17:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32AA6A1A7E;
        Thu, 10 Aug 2017 18:17:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
        <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
        <alpine.DEB.2.21.1.1708101111080.11175@virtualbox>
        <20170810213348.g4lue3j4uz6qapal@sigill.intra.peff.net>
Date:   Thu, 10 Aug 2017 15:17:06 -0700
In-Reply-To: <20170810213348.g4lue3j4uz6qapal@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 17:33:49 -0400")
Message-ID: <xmqqshgz1319.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A56528BA-7E19-11E7-8AEE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 10, 2017 at 11:36:41AM +0200, Johannes Schindelin wrote:
>
>> Hopefully I had better luck expressing my concerns this time?
>
> I understand your argument much better now. I'm still not sure I agree.
>
> -Peff

I do not think "there are a dozen #ifdefs and I don't know whether
they still work. I don't know whether anybody (who most likely has
better things to do than read the Git mailing list) is still using
those.  So let's just remove them." was why you were suggesting to
clean up the (apparent) support of older curl in the code, though.

Isn't the reason why your series simplifies these #ifdefs away
because we by accident started using some features that require a
version that is even newer than any of these #ifdef's try to cater
to and yet nobody complained?  That is a lot more similar to the
removal of rsync transport that happened in a not so distant past,
where the reason for removal was "We have been shipping code that
couldn't have possibly worked for some time and nobody complained
---we know nobody is depending on it."

Or "We accidentally started shipping code with comma after the last
element of enum decl and nobody compalined---everybody's compiler
must be ready" ;-)

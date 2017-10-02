Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DB320281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdJBXzi (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:55:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57785 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750927AbdJBXzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:55:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B54DEB252D;
        Mon,  2 Oct 2017 19:55:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kqWGTrEaxXT0x4s1AzTwAVmhldw=; b=dnJxoj
        O0HRf6wzX9uZ7L7+TH/uRvGygOqoNozqYlTb4gzDtYXNjAwR+Tw2mm9eqLY/2IFT
        0T2isUTIlMXB7XN5srSJBBeg8Gujt/xm34SCWOoLJdHqCVAAwjtnXmVeHbgAhAZC
        DzrJ2BrESf5aSaqjAUpU9FvrNxtQfdbZ3xB8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IthJgXz+BV2PjY8bNBZjQiYkJywjCfET
        hTtmshc1350Jl8Mmrf7fJP6imKgjOl5D0gKsPdn56Tl6iWiFPhc74dqBDrnGXi/B
        ZFTRqM5ITD09SbOqEr7kvgDGaKHM8KVMf0quBRlVY62Q9GpntcLWMExMA7b/xFRE
        jZ3LQCsqM6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABF59B252B;
        Mon,  2 Oct 2017 19:55:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0816B2460;
        Mon,  2 Oct 2017 19:55:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] ref-filter.c: pass empty-string as NULL to atom parsers
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
        <20171002161034.44867-1-me@ttaylorr.com>
        <20171002224052.GR19555@aiede.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 08:55:01 +0900
In-Reply-To: <20171002224052.GR19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Mon, 2 Oct 2017 15:40:52 -0700")
Message-ID: <xmqqmv59m7fu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BF82C52-A7CD-11E7-8D3A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The above does a nice job of explaining
>
>  - what this change is going to do
>  - how it's good for the internal code structure / maintainability
>
> What it doesn't tell me about is why the user-facing effect won't
> cause problems.  Is there no atom where %(atom:) was previously
> accepted and did something meaningful that this may break?

That is, was there any situation where %(atom) and %(atom:) did two
differnt things and their differences made sense?

> Looking at the manpage and code, I don't see any, so for what it's
> worth, this is
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> but for next time, please remember to discuss regression risk in
> the commit message, too.

Yes, I agree that it is necessary to make sure somebody looked at
the issue _and_ record the fact that it happened.  Thanks for doing
that already ;-)

I also took a look at the code and currently we seem to abort,
either with "unrecognised arg" (e.g. "refname:") or "does not take
args" (e.g. "body"), so we should be OK, I'd think.

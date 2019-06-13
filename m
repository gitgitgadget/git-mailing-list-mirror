Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429F61F462
	for <e@80x24.org>; Thu, 13 Jun 2019 18:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfFMSWw (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 14:22:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51489 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfFMSWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 14:22:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 871DC15A235;
        Thu, 13 Jun 2019 14:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pd2iSQfBN76Rj1twaBYOfin1VWo=; b=Y36HLJ
        6B3YIUPthNzQxoS+blt6at6t6juJGrE6xtzTOz7ft0Ona830gved1B6i2yiVPn86
        svTV3lAbOE8ybVPqtC31glLSSLQrJ9WIs+qXiK/DX9UwGvUUJWmrpg1FeCBGMrpV
        R0xalGCm0npy4VDiz6ndegYKeI/51BzpPoj0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UyiiPRJwHUJycyy2SpzvrzvHwtKuPlMP
        9ew/Je+/Z1/0pT9CCAjeDzP6QOLRY/4DqYxDk9JBYCw1IIoAo6Y5876J6P0HbsI0
        ANUyyAsePPAkuBO724i2tpeIAJuAp7GGQIL0ihYvDxmzsq6RXpLbDTZ/QqNAtq4D
        8e7++2+KvTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FE3615A234;
        Thu, 13 Jun 2019 14:22:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E771615A233;
        Thu, 13 Jun 2019 14:22:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pedro Larroy <pedro.larroy.lists@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bisect should return 1 when the first bad commit is found
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
Date:   Thu, 13 Jun 2019 11:22:48 -0700
In-Reply-To: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
        (Pedro Larroy's message of "Wed, 12 Jun 2019 15:33:43 -0700")
Message-ID: <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40354C8A-8E08-11E9-8473-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pedro Larroy <pedro.larroy.lists@gmail.com> writes:

> I'm using git bisect, and for complex reasons I can't use git bisect
> run to drive the bisection. I don't think git bisect bad/good is
> returning a different status code when the first bad commit is found
> and this would be very useful to stop the driver of the bisection.
>
> What do you think?  Would such a change be acceptable?

Probably not.

A non-zero exit code would indicate that "git bisect" had trouble
finding the next commit to check after being told 'good' (or 'bad'),
which you wouldn't be able to tell from your "first bad one is
found".

The 'first bad one' is not necessarily the HEAD when the bisect
procedure finds it, so you'd have to read and parse "x is the first
such commit" message anyway, no?  And once you start parsing the
message from 'git bisect', you should be able to tell between
"please try this one, you have approximately 7 steps left" and "we
found the first bad one, which is X", without relying on the exit
status, no?


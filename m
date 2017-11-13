Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A08B2021B
	for <e@80x24.org>; Mon, 13 Nov 2017 02:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdKMCcm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 21:32:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50434 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751107AbdKMCcm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 21:32:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F8A295FA0;
        Sun, 12 Nov 2017 21:32:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4YjxTAkBeO3lGlHpjWFFLkOAKRE=; b=vqIF/m
        DAIFcKcWSRcaprzNHtjqD/vTgP5X6oA/a4K7mpBEoGOJMd6GeF2ror7eQUxj01lC
        vMQnOjw2yCWCFu91BqyQSyZV8iHCyR4oaARydP9WPbQZMvRQrOaR0HQ4ACI8jxSX
        J5peog6ZupOoUi+W3Z5rWQa66YQ+eUdT7pWQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AyCftMOlmyO+MbUu7JyOQvR0Z0I6f2kw
        c8aGpqyEfFlRMAqFn6PW1r0AtNe16LdUhfUypGupZGJ0IP82sFIcbOaJgY38sS4A
        3pSr2222u6kn8YTUFTihIGb3xif1T0nsiS1HOJQqm1T48AP2wwG/+0n2hbmTdObE
        WOQ7nkfEPYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9849F95F9F;
        Sun, 12 Nov 2017 21:32:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BC6895F9E;
        Sun, 12 Nov 2017 21:32:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/4] branch: re-order function arguments to group related arguments
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
        <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20171102065407.25404-3-kaartic.sivaraam@gmail.com>
        <xmqqbmkgjh32.fsf@gitster.mtv.corp.google.com>
        <1510493270.2683.6.camel@gmail.com>
Date:   Mon, 13 Nov 2017 11:32:39 +0900
In-Reply-To: <1510493270.2683.6.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sun, 12 Nov 2017 18:57:50 +0530")
Message-ID: <xmqqefp2c3i0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBF17856-C81A-11E7-812D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> I've tried to improve it, does the following paragraph sound clear
> enough?
>
>     branch: group related arguments of create_branch()
>         
>     New arguments were added to create_branch() whenever the need
>     arised and they were added to tail of the argument list. This
>     resulted in the related arguments not being close to each other.

OK, I understand what you wanted to say.  But I do not think that is
based on a true history.

 - f9a482e6 ("checkout: suppress tracking message with "-q"",
   2012-03-26) adds 'quiet' just after 'clobber_head', exactly
   because they are related, and leaves 'track' at the end.

 - 39bd6f72 ("Allow checkout -B <current-branch> to update the
   current branch", 2011-11-26) adds 'clobber_head' not at the end but
   before 'track', which is left at the end.  

 - c847f537 ("Detached HEAD (experimental)", 2007-01-01) split 'start'
   into 'start_name' and 'start_sha1' (the latter was laster removed)
   and this was not a mindless "add at the end", either.

 - 0746d19a ("git-branch, git-checkout: autosetup for remote branch
   tracking", 2007-03-08) did add track at the end, but that is
   justifiable, as it has no relation to any other parameter.

You could call 39bd6f72 somewhat questionable as 'clobber_head' is
related to 'force' more strongly than it is to 'reflog' [*1*], but
it is unfair to blame anything else having done a mindless "add at
the end".



[Footnote]

*1* I actually think the commit added 'clobber_head' because for the
    purpose of what the commit did, it closely was related to 'track',
    turning <force, reflog, track> into <force, reflog, clobber, track>.
    Arguably, it could have done <force, clobber, track, reflog> instead.


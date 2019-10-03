Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB00D1F4BE
	for <e@80x24.org>; Thu,  3 Oct 2019 22:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfJCW4U (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:56:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50449 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJCW4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:56:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC32494296;
        Thu,  3 Oct 2019 18:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1cw+Zt995VxEx7u3K+tpjem5CYo=; b=winMIZ
        Z3+eRPmrUTYTHcXr6O8YpewDOzVteQ4B+le0vGgI3at1RSgWk5RMifJ3kNtuWVQa
        lzffe9E6EtzXej9JA0ZEzN7gA6aClDxAsezyxQdQBILE7jLhowcRTjGWry2F9HoA
        ne4iXEv0Wf7BxulJJeUcCyc9cgvrxya42iS8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bEkAgG3AeALgO9fyTTLaMrUp4OpltEmo
        RKXGogqJPwvtqq+rIUMG+AoW5JNbAdq/tpY+Ld23GbF3JPzyNJnO14SO2l1G8H1m
        CVQ09pxhmhb5ZJX2XaaT5YMOYYM5ohqYegjpILrD1wYCnzBxrudOucu0NUCqLvjt
        sATV0qi1AOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4AA594295;
        Thu,  3 Oct 2019 18:56:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2E8A94292;
        Thu,  3 Oct 2019 18:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
References: <20191002184546.GA22174@generichostname>
        <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
        <20191002201659.GB24697@generichostname>
        <xmqqmueid508.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CZCdF-jPeYaAxzpnSbtxbRX42ScSJyYFCfmxZ0YBhZGg@mail.gmail.com>
Date:   Fri, 04 Oct 2019 07:56:11 +0900
In-Reply-To: <CACsJy8CZCdF-jPeYaAxzpnSbtxbRX42ScSJyYFCfmxZ0YBhZGg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 3 Oct 2019 13:17:08 +0700")
Message-ID: <xmqqpnjda16c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 000C8E76-E631-11E9-9209-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Oct 3, 2019 at 7:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > In fact, running `git am --show-current-patch` shows the whole mail, not
>> > only the 'patch' file so users would have no reason to expect the line
>> > numbers to refer to the 'patch' file.
>>
>> Yeah, show-current-patch was a misguided attempt to hide useful
>> information from the users.
>
> Not so much hiding as not having the information to present, at least
> not the easy way, since the mail is split at the beginning of git-am
> and never stored in $GIT_DIR. By the time this command is run, the
> mail is already gone. Someone could of course update git-am to keep a
> copy of the mail and improve this option.

By "hiding", I meant "rob from the users an opportunity to learn
where the useful patch file is stored".  

You seem to be doubly confused in this case, in that (1) you seem to
have mistaken that I was complaining about show-current-patch not
giving the full information contained in the original e-mail, and
(2) you seem to think show-current-patch gives the contents of the
patch witout other e-mail cruft.  Both are incorrect.

The first thing the command does is to feed the input to mailsplit
and store the results in numbered files "%04d", and they are not
removed until truly done.  When you need to inspect the patch that
does not apply, they are still there.  Even emails for those steps
that have been successfully applied before the current one are also
there (the split files are all gone, though, but they no longer
matter as they have been applied fine).

I wouldn't have been so critical if "git am --show-current-patch"
were implemented as "cat $GIT_DIR/rebase-apply/patch", but it
does an equivalent of "cd $GIT_DIR/rebase-apply; cat $(cat next)"
which is much less useful when trying to fix up the patch text that
does not apply.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1F120A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdASVml (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:42:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751316AbdASVmk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:42:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A496022C;
        Thu, 19 Jan 2017 16:42:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Omd1FhOZVNy2HzB44+ifOzkCGH4=; b=x31SJw
        We4/MQQHjGDC4MqU0xa2eMrIbU4WQkMF/uoykH1f2t9Rx+Qb0sSMW+ym/zwNEIOr
        bsC7lT48ev1o7prFt1XmqFNh8YJ6bVmLna4RAsRHOayYPnDXwJhNyVUS01JKTgn5
        9Os+HnxvWHX76ECv3zp5hcEYqMhF0Tvi+03ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UEUhiUsE+jRrgR3L39mJC55ZfSltQyu6
        UwsNG7urBpgJgcYhELRonxl+6e+u6NC6VKHIVwer4ktXQJwTrHFLqQ/OvQUeSh5D
        oFPjYfw+aCfvG00cnpcpy/FNl8abrQe+agcDbSZN2biG6e+vkgSa1WpE1MbPevVU
        2yi7OGKnCBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E52060229;
        Thu, 19 Jan 2017 16:42:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD77C60228;
        Thu, 19 Jan 2017 16:42:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David J. Bakeman" <nakuru@comcast.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: merge maintaining history
References: <58798686.5050401@comcast.net>
        <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
        <5880BB23.8030702@comcast.net>
Date:   Thu, 19 Jan 2017 13:42:19 -0800
In-Reply-To: <5880BB23.8030702@comcast.net> (David J. Bakeman's message of
        "Thu, 19 Jan 2017 05:12:03 -0800")
Message-ID: <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27E3CC30-DE90-11E6-BC06-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David J. Bakeman" <nakuru@comcast.net> writes:

>> So you want to merge the "new" history into the original tree now, so
>> you checkout the original tree, then "git merge <new-remote>/<branch>"
>> and then fix up any conflicts, and then git commit to create a merge
>> commit that has the new history. Then you could push that to both
>> trees.
>>
>> I would want a bit more information about your setup before providing
>> actual commands.
>
> Thanks I think that's close but it's a little more complicated I think
> :<(  I don't know if this diagram will work but lets try.
>
> original A->B->C->D->E->F
>              \
> first branch  b->c->d->e
>
> new repo e->f->g->h
>
> Now I need to merge h to F without loosing b through h hopefully.  Yes e
> was never merged back to the original repo and it's essentially gone now
> so I can't just merge to F or can I?

With the picture, I think you mean 'b' is forked from 'B' and the
first branch built 3 more commits on top, leading to 'e'.

You say "new repo" has 'e' thru 'h', and I take it to mean you
started developing on top of the history that leads to 'e' you built
in the first branch, and "new repo" has the resulting history that
leads to 'h'.

Unless you did something exotic and non-standard, commit 'e' in "new
repo" would be exactly the same as 'e' sitting on the tip of the
"first branch", so the picture would be more like:

> original A->B->C->D->E->F
>              \
> first branch  b->c->d->e
>                         \
> new repo                 f->g->h

no?  Then merging 'h' into 'F' will pull everything you did since
you diverged from the history that leads to 'F', resulting in a
history of this shape:

> original A->B->C->D->E->F----------M
>              \                    /
> first branch  b->c->d->e         /
>                         \       /
> new repo                 f->g->h

If on the other hand you did something non-standard and exotic to
rewrite 'e' at the end of "first branch" and make a different commit
that does not even have any parent in "new repo", and the history of
"new repo" originates in such a commit that is not 'e', things will
become messy.  But I didn't think I read you did anything unusual so
a simple "git checkout F && git merge h" should give you what you
want.

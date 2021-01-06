Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A8C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F52313A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 22:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbhAFWQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 17:16:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59576 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAFWQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 17:16:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EAAF1124D5;
        Wed,  6 Jan 2021 17:15:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a/JOaqNlMHGHQ1CGYgz8IkHqw9Y=; b=PZLCvO
        UfsDbGhR0NvwyaxzLMlAp+rjmocuGinFoDIoaf7xznqCJ0rlAF5ifhwuEtpeMXHu
        Ch7U13V4e53/n3EXG8F4LoRNKYyhMjKlY61V4ih6GPzgefFWWNh5VuPdCjxPvb6h
        gWjg06+35fgkoqK2ZyGV1xqs37ojKu7RkxlR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xZTzUJx6/Zyn53UpE17LBulz9s8uRq91
        xzh8IOM8uo23e8A0VIGIBflJ/ANne5QQ3X78MHTF1O8C7d4uY0tR5StDX5Hx6fqT
        +y3sTn7PiaMeOw4B50/H7Gsi50fFTaHJbgLet+56gWjS37UooM1wSDF1m+WEYOpM
        K0fKpQmqEsU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57D8F1124D4;
        Wed,  6 Jan 2021 17:15:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3FE11124CD;
        Wed,  6 Jan 2021 17:15:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jim Hill <gjthill@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <xmqq1rexrbz1.fsf@gitster.c.googlers.com>
        <CAEE75_0e4_m_7hQXycVK1f=4LOb82U2DYveAvcF2XKKNgmfpNw@mail.gmail.com>
Date:   Wed, 06 Jan 2021 14:15:52 -0800
In-Reply-To: <CAEE75_0e4_m_7hQXycVK1f=4LOb82U2DYveAvcF2XKKNgmfpNw@mail.gmail.com>
        (Jim Hill's message of "Wed, 6 Jan 2021 14:01:13 -0800")
Message-ID: <xmqqr1mxpv8n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE7391EC-506C-11EB-A4A7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jim Hill <gjthill@gmail.com> writes:

> On Wed, Jan 6, 2021 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>> a need to have multiple unrelated line of histories in a single
>> repository may not be there, even though a desire to do so might
>> exist.  What is done with these unrelated histories that record
>> unrelated contents [*1*]?
>
> Git itself is an example of other reasons for carrying disjoint dags as a
> set of related histories.

Thanks, it is a good example why a repository may want to have
unrelated histories stored in it, but it is not a good example to
support the use of the "--orphan" option.

Histories for gitk, git-gui and todo come from different local
repositories.  gitk and git-gui histories come to my (local)
repository by pulling from separate repositories that have only
unrelated histories, and the todo branch does not exist even in my
local repository working on git codebase.

You see git, gitk, git-gui histories in a single repository but
these independent histories originate from and worked on each
separate repositories.  You see the todo history in the same
repository as these other three lines, only because I used to have
just a single publishing repository I can push into at kernel.org.

And none of the management above has any need to use "--orphan".

"gitk" and "git-gui" are worked in their own repositories, that do
not even have any commits of "git" history.  "todo" is worked in its
own repository, that do not even have any commits of "git" history.
The former two are pulled into my "git" repository and pushed out to
the public repositories.  The last one is pushed directly from my
"git-todo" repository and pushed out.

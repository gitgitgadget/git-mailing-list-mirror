Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39774C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5B2072E
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CFVsplKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgFDOt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:49:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59661 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgFDOt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:49:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9ABFBC7E3;
        Thu,  4 Jun 2020 10:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R9oGnSEM5lB5e/zL3rnMGNTyu5g=; b=CFVspl
        KCftvIpHQgyI4TTUbQJSZdRPgmR5ROnyi+F3kIdfX9GeKJhVELQl7FRnFoFrxQP+
        MyYNp3ntgKCQOwfSb2z+KRLRI5vtj8TJHQ2aST3wA1zdvOijnv1NWBlMdzJCfyiQ
        9DGK5YX6nYdI+sP95CcSJYgffj77kDhyg1wqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BsdtcVes7OolEoxTXdG578QNLY3LOJ6+
        pryvS/qt5tg3Wj0LsNiV/3X5Sz011gp8gyemJnWyaz262+iZA23wQ2qnJ6J4XAIS
        6vxgBlY4mTxAzr78uNw8I9shlP+4LiLcHpbKunQtJTZQvjCQ1dDLcMrNHSNFyEUX
        /Rd92PASssI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1BE2BC7E2;
        Thu,  4 Jun 2020 10:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFA29BC7E0;
        Thu,  4 Jun 2020 10:49:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com>
        <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
Date:   Thu, 04 Jun 2020 07:49:21 -0700
In-Reply-To: <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 4 Jun 2020 01:14:28 -0700")
Message-ID: <xmqqh7vqrimm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9417C3B8-A672-11EA-B71A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Jun 3, 2020 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Seeing a handful of regression reports [*] immediately after a
>> feature release is made gives me a mixed feeling: people are eager
>> enough to help by reporting issues they encounter, but there are not
>> enough people who are eager enough to help by testing the tip of
>> 'master' before the release.  Are there things we can do to help
>> them become early adopters so that they do not have to scramble
>> after the release?
>
> That's very diplomatically worded, but perhaps let me peel back that
> deflection layer a bit and be more direct...

Sorry, but you are reading too much into it.

I am not worried about individual bugs; bugs happen and that is an
inevitable part of development.  I have enough confidence in our
developers to feel that we can promptly fix a regression once an
issue is raised and clarified sufficiently to be actionable.

> Now, it's possible these regressions could just be a reflection of the
> fact that I'm focusing more on fixing inconsistent behaviors rather
> than adding new features, which is a type of work where it's much
> harder to avoid fallout and reported issues.

Yes, and as I said already, bugs happen and they tend to happen to
those who touch the trickiest part of the existing code---it is
inevitable.  It is OK to be initially buggy as long as we can fix
breakages promptly.

I am however worried about how the issues often are not raised until
a regression hits a tagged version.  As a piece of software gets
used more and more widely, it would be used in more and more
different ways, and some of these ways may not be covered by
developers' minds; by definition, some regressions are noticed only
after a new version hits end users' hands.

Basing in-house releases a Git developer has control over on
'master' or 'next' would reach audiences that the Git developer has
access to, and as long as the in-house users use Git sufficiently
differently from the Git developer (is that a realistic expectation,
though?), we'd gain more coverage before a tagged release happens
that way.  Basing the version placed in a distro's 'testing' track
on 'master' or 'next' may give us even wider exposure but it would
be much harder to arrange, I am afraid.

People from time to time suggest to merge trickier topics early in
the cycle, and in principle I do agree that it may not be a bad
idea, but given that we do not have enough folks on 'master', I am
not so sure how much that would actially help.

Thanks.



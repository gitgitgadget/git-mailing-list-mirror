Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90CEC34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799DA24655
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yjrfcflh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBSDWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:22:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54486 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgBSDWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 22:22:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B05BC5F12A;
        Tue, 18 Feb 2020 22:22:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BVw5sE5S1c2DDcDE4mDyIc+I0eY=; b=Yjrfcf
        lhFdNivP6NlWs3vC6AKuWWSEfSdWGHhYFUOvj3VZM/wDTgY1BC4hU6bWjtXCNmBH
        FMlYOsf6GGR/8lMzlAnw2HwK/Z580HCsgnCAyYZBnlY0OT9IpRu1cbN64Zn8EP0+
        hKYwV+obN1R++lQ6jzRFVogzJbZ2cqxkuYg8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s9d69hL2Yfv/FsbzTjJYGw0WZbilClVO
        BQ7KG4bsyyrbyuHDbktYHshW8DfikBxYCXlr0/FtDg9dt0uus8FbfwZ1gEvqCy2i
        E9/T6nnezNJq7WaYUV//5TRQREPudLk40RRedaIvHz9qkJ1bB6yNTmGXc9n0i/cK
        RqH5oVCx5iM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6C935F129;
        Tue, 18 Feb 2020 22:22:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03D205F128;
        Tue, 18 Feb 2020 22:22:03 -0500 (EST)
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
Date:   Tue, 18 Feb 2020 19:22:02 -0800
In-Reply-To: <20200219015733.GA81560@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Feb 2020 20:57:33 -0500")
Message-ID: <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0002E08A-52C7-11EA-BE35-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> FWIW, this design came from 212945d4 ("Teach git-describe to verify
>> annotated tag names before output", 2008-02-28).  Shawn was quite
>> explicit that use of the real name was deliberate:
>> 
>>     If an annotated tag describes a commit we want to favor the name
>>     listed in the body of the tag, rather than whatever name it has
>>     been stored under locally.  By doing so it is easier to converse
>>     about tags with others, even if the tags happen to be fetched to
>>     a different name than it was given by its creator.
>> 
>> and I tend to agree with the original rationale.
>
> Thanks, I should have dug into the history in the first place.
>
> Still, I'm not entirely convinced. As a decentralized system, I think
> our first duty is to make things convenient and workable for the
> preferences of the local repository, and second to facilitate
> communication with other people's clones of the same repository.

Yes, and that can be done by either (1) locally moving a tag that is
stored in a wrong location to where it wants to be, or (2) locally
*creating* a tag that suits the preferences of the local repository,
ignoring the tag obtained from outside world that is stored in a
wrong place.  The latter would not help to facilitate communication,
though.

> If for whatever reason I chose to call my version of the global v1.0 tag
> as "v1.0-bob", then it seems friendlier to me to report the name that
> can actually be used with further local commands (and remind the user of
> the global name) than the other way around.

That you can do with "git tag v1.0-bob <whatever object>" locally, no?

> Though TBH the situation is rare enough that I kind of doubt it matters
> all that much either way. It's been like this for over a decade, and
> this is the first time I recall it being brought up.

Yeah, I do not think this is an often-arising concern.  It's merely
what the expected and recommended direction to escape when it
happens, and what the warning message should say to make the
recommendation communicated better, I think.

Note that I started this to play a devil's advocate.  As an object
is immutable, while it can be named with any refname, if easing
communication between project participants is one of the goals, it
seems that taking what is in the object as authoritative is the only
workable way.


Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FEBC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0295A20792
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 18:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQkGLQj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFKSTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:19:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55025 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFKSTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 14:19:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F9F86115E;
        Thu, 11 Jun 2020 14:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SISQBtBfCWEGtye0WkbnUMfAFOI=; b=NQkGLQ
        j8b/yfO6/AjBUHOQCGsxwsjq3ztn0AQKmIRBGAy769dYmhi4yl65YAsezeyEtpod
        H830f1osw9SltJBXAqJuCggSbZXus5u7BkUiJkMhX6uQxULDcTkMNzN2iH9y/B4T
        ZNJHCSc8BZ9EImDgB3dSfDFoAALu4MQEIbELc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZrS9I3mgHHrSNnlZ6NENfrhXSP0D1Y06
        ciNUGBk/PwIKNQqNOIF9bWldLZjfRtdeocTyI3pRRVobWn4F3yflMechj/Kieet3
        ODJ+nTxge7qu7fMyumrOvwJwIwiYAAJUh62FwVdT+CybLcEJ3wOPDKNQniBecdmJ
        87yYBxP4+Qg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72E8C6115D;
        Thu, 11 Jun 2020 14:19:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E195A6115B;
        Thu, 11 Jun 2020 14:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>, sandals@crustytoothpaste.net
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2006111556090.56@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Jun 2020 11:19:42 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006111556090.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 11 Jun 2020 15:57:17 +0200 (CEST)")
Message-ID: <xmqqeeqljwht.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F19B852-AC10-11EA-982D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Matt,
>
> On Wed, 10 Jun 2020, Matt Rogers wrote:
>
>> > -        * We also leave "master" as a special case, since it does not reveal
>> > -        * anything interesting.
>> > +        * We also leave the default branch name as a special case, since it
>> > +        * does not reveal anything interesting.
>> >          */
>> I feel this is a weird thing to do, since you're trying to anonymize the branch
>> name,and now the default branch is identifiable with your config file.  For
>> example, if the default branch contains the name of my project/repo then this
>> sounds like a recipe for accidentally sharing it. I feel a better
>> alternative would
>> be to exclude nothing from the anonymization or the proposed default default
>> branch name
>
> I don't think that the name of the main branch should be subject to
> anonymizing, whether it be `master` or anything else.

"Here is why" is missing ;-)  I think you realized that it needs to
be, after you wrote the "ah, we need two, the default for new ones
and the name of the primary branch in a particular repository", as
we are dealing with the latter here.

Thanks.

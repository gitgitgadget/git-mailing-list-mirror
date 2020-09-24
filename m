Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8073EC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250832395C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBSzpOJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgIXQoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:44:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62293 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQoa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 12:44:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20E628D8A6;
        Thu, 24 Sep 2020 12:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aIRvHkYQVBgxVCezyCJnX6bXpWY=; b=KBSzpO
        JNniOkzQ88Eb9hXVhmdWC3LyVQdRpG1lD2YDSsb+Du8ZGt3XrjgT3cGGCF352yzy
        CR3yhXGx7kNDYceu9JnEdZocYgHo0DtoRNrC7XH8uXMP99njKIsX8vtwp501s1OQ
        nu3lKbBPr6Ybw26l0qW86wV/akRTGaVAnqoNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4J0pMuGQy39b9DukB3R2mBreEylkz+b
        yQGVzWH3EiBs0MGeJcJtFkcfiFpYvAoa6geR+DL4Ep8n214omnGfMp0Jev+d+MEH
        qnIMsiQjx6KUfSlcx1tlZ/mlKXYfQ3h4pt5UK5+1NlNrrXFCvGWgag0PC/jAHx/p
        i9x5mS8TRCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18F638D8A5;
        Thu, 24 Sep 2020 12:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 987B88D8A3;
        Thu, 24 Sep 2020 12:44:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <20200924060344.15541-1-chriscool@tuxfamily.org>
        <nycvar.QRO.7.76.6.2009240947080.5061@tvgsbejvaqbjf.bet>
        <CAP8UFD3HtiAj2yiHBZOeqm-=VxVeV7mpwvFRV_mV8y-vsxgQUQ@mail.gmail.com>
Date:   Thu, 24 Sep 2020 09:44:26 -0700
In-Reply-To: <CAP8UFD3HtiAj2yiHBZOeqm-=VxVeV7mpwvFRV_mV8y-vsxgQUQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 24 Sep 2020 13:08:01 +0200")
Message-ID: <xmqqk0wjgm51.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35E3752E-FE85-11EA-9E50-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> > +test_expect_success 'bisect start without -- uses unknown arg as path restriction' '
>>
>> To avoid the overly long line (and also to re-use existing naming
>> conventions), I replaced "path restrictions" by "pathspecs" here. What do
>> you think?
>
> It's not a huge issue, but I tend to prefer using "restrictions"
> because the tests that check that these arguments are used properly
> are called "restricting bisection on one dir" and "restricting
> bisection on one dir and a file". So I feel that it keeps test names
> more coherent.

Hmph, but in the context of a sentence "use an arg as X", we should
try to pick a well-known word to describe various Git arguments for
X, no?  The one you are using, in order to filter the set of commits
involved in the operation to those that touch specific set of paths,
already has its own established name and the word is "pathspec".

So...?




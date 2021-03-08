Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CFC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB18652A8
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCHR2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:28:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50833 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhCHR17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 12:27:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDDC9B8F07;
        Mon,  8 Mar 2021 12:27:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1LhkEafnoifJNzrEMRn1295m6KU=; b=wCrxgU
        +Qn4qDo0/FdhQkfyPbZDTDR95EDLGkBmrZ3YXSeSXxXDYhDTn5iP/+3Sq/mWo4t+
        8jFhyooEUEFKNoNky7Ppy2gmNNiHNkttXg6fqBTubTB2UyDNNVFOyIiu9JQyiQ/0
        G6rvrYm4qIw1HVqKU2RPgvtH3ct7sVHfjkKaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a/d/YRFN/KlsbXgJbbllw0nEhB7Rzthi
        t+AFDrXqA7oefUocGdzns6E4qMWtgwSehNuVB/WzO7eKaWdcjR3GTU6z4wmKFS7O
        f88LW0OQlSiowieh68QMg2ATbHUH5iCf9xlGnftlQb1JjM0x/DJdZ+tceNunoLt2
        DKPrWL0/hXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5C9AB8F06;
        Mon,  8 Mar 2021 12:27:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 700FEB8F04;
        Mon,  8 Mar 2021 12:27:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabien Terrani <terranifabien@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
Date:   Mon, 08 Mar 2021 09:27:57 -0800
In-Reply-To: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        (Fabien Terrani's message of "Mon, 8 Mar 2021 13:10:25 +0100")
Message-ID: <xmqqlfax7dya.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0396AF2-8033-11EB-9466-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabien Terrani <terranifabien@gmail.com> writes:

> I was recently trying to understand the git-push command's behavior,
> especially regarding the configuration values's resolution. I read the
> following in the EXAMPLES section of the git-push man page:
>
>> git push origin

>>     Without additional configuration, pushes the current branch
>>     to the configured upstream (remote.origin.merge configuration
>>     variable) if it has the same name as the current branch, and
>>     errors out without pushing otherwise.

Hmph, it seems it talks about the branch on the remote side that is
configured for the current branch to integrate with.  Most likely
that is misspelt "branch.<name>.merge" where <name> is the name of
the branch currently checked out.

The text comes from b2ed944a (push: switch default from "matching"
to "simple", 2013-01-04); I am a bit surprised how such a typo
survived this long ;-)


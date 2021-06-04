Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287F9C4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082936140C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFDFIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:08:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58025 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDFIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 01:08:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6B4912DDDE;
        Fri,  4 Jun 2021 01:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsMlFU7tuSxGgx4IaISRmX1bVSoZOY3TTjec8n
        A+z3c=; b=NRiemRlNLIDnKUeuxBLkevi0bzRafOExo/Pz9XVkC2vcymvvhwRCXl
        6KUYtdGtACGdJmmLvoOL2GmHG0XBtYnCINicUpyrIq8zEhK/xBfKViu39Ov1odS3
        neQhnpKHg1yvocloETxtlGzrSQJaSfjh1m2Il/nn2wOTRJ+Fo7TPM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF6AA12DDDC;
        Fri,  4 Jun 2021 01:07:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0EA3712DDD8;
        Fri,  4 Jun 2021 01:06:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?Q?=E2=80=93no-submodule?=
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
        <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
        <YLg/dLqYFEqHZJUn@nand.local> <xmqq7dja6e46.fsf@gitster.g>
        <YLkr+kLdjmHyPjgl@coredump.intra.peff.net>
        <xmqqo8cm4nst.fsf@gitster.g>
        <YLmmIXy/SITKh/Yw@coredump.intra.peff.net>
Date:   Fri, 04 Jun 2021 14:06:58 +0900
In-Reply-To: <YLmmIXy/SITKh/Yw@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 4 Jun 2021 00:03:45 -0400")
Message-ID: <xmqqbl8m2p71.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B14EBBFE-C4F2-11EB-A69C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> The original request, as I understand the clarification posted
>> ...
>> (cf. <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com>)
>> 
>> and with such an auto-pseudo-attribute, presumably something along
>> this line would work, removing the need for the intermediate filter:
>> 
>>     git ls-files \
>> 	':(attr:mode=100755)' ':(attr:mode=100644)' \
>> 	':(exclude)*.png' ':(exclude)*.ico' |
>>     xargs dos2unix
>> 
>
> Yeah, that makes sense.
>
> By the way, another reason (beyond a simpler pipeline) that the "magic
> pathspec that understands modes" is nicer is that it can be applied to a
> more dynamic set of paths.

In the longer term, the project the original request wanted to
invent the "--no-submodule" option for may want to lose the specific
"we know that the only paths we do not want to run dos2unix happen
to be png and ico files in the current codebase" from the above
sample command line, and replace it with something like ':(attr:text)'

Alas, the "text" attribute does *not* work that way, though ;-)
Just like any other attributes, what you assigned yourself counts,
and our "is this file a text?" auto-detection logic only kicks in
when there is no attribute that tells if a path is text or not.

It would be expensive at runtime; even if we were to introduce a
"dynamic" pseudo attribute to tell text files and others apart, we
probably shouldn't use the same "attr:*" magic but use something
distinct (e.g. "dynamic-attr:*") in order to make sure that the
users understand the performance implications.  I think the above
"mode=100755" matic (or anything that requires more than the basic
"which entries in the .gitattributes files does this pathname
match?") would fall into the same category.


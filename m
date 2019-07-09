Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FCD1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfGIOvS (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 10:51:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63856 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIOvS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 10:51:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289EB153421;
        Tue,  9 Jul 2019 10:51:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XlgK+KwZPThCXzpHJ6zoCsywayU=; b=F0NM4N
        +GMD/Mx6ImsNFJXrUFBdg7gZSlQFX7ynWPC1LZrYzj3GR+YtFouktcgXbttMzG+w
        xsaVQMWl2Fc3nia/lCmbXwhwIoPhr+zW6IJUiXQXGQXUQfWO6Pq1zYDk64ArVqno
        Wny3Q4xh2FST4stwnl6JPC0X+EXm3tEPcXy48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B9AgrWDMKPSHu0FY3UKCuD20hsAQ8F4t
        fBtez14rLSYAdXbQXfP9o/z2h3tZJbRdfVRRurhMW3igXC7Q3eV8soTjZ44Q2o7H
        Cy5GjkkDwyuDhISW0rcdeVjAbRoNw45FJX4AOWxxGeTXyzy79d/JE2CB3+NPpZR2
        Z8XofNlW1kc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2172815341F;
        Tue,  9 Jul 2019 10:51:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AE6215341E;
        Tue,  9 Jul 2019 10:51:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     usbuser@mailbox.org
Cc:     git@vger.kernel.org
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
Date:   Tue, 09 Jul 2019 07:51:14 -0700
In-Reply-To: <423596682.8516.1562665372094@office.mailbox.org>
        (usbuser@mailbox.org's message of "Tue, 9 Jul 2019 11:42:51 +0200
        (CEST)")
Message-ID: <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00826B94-A259-11E9-9E48-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

usbuser@mailbox.org writes:

> I'm rather confused about --ff, --no-ff and --ff-only. They seam
> to be all mutual exclusive...

A clean result left by "git merge" can be either a fast-forward, or
a real merge (i.e. 2 possible outcomes).

The --ff option lets you say "If the other history I am attempting
to merge is a descendant of the current commit, not creating a real
merge and instead fast-forwarding is permitted".  As this is the
default, case you actually type --ff on the command line is rather
limited (e.g. to countermand an earlier --no-ff on the command
line).

The --no-ff option lets you say "I never accept a fast-forward as
the result; please make a real merge instead, even if it is
redundant".

The --ff-only option lets you say "I never accept a real merge as 
the result; please fail if this does not fast-forward".

So, the only "real" options are between --[no-]ff (which allows or
disallows one of the two possible outcomes, which is "fast-forward")
and [--ff-only] (which allows or disallows the other one of the two
possible outcomes, which is "real merge").

Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5E3C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 04:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCA821532
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 04:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbz+17FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIHElI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:41:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51936 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgIHElH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 00:41:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D01F2E8437;
        Tue,  8 Sep 2020 00:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2JE6KjjhEJgRgH8gFetKsvH/yVs=; b=cbz+17
        FXniQbnWGGbC5YcRbGrrjpo7MtYuPYc4vdAfJwpavqI+xADIBelz0JAn3Vnv73mH
        iXJmCWPdgSIjG+ZlfK2GI3ZMkZYj6PG4jq9hFePPDAT6dxO1l79uNMwaDuAx25P3
        Ko8dGyv4wbvrxV3dftH7wCi2nog+XmVmwiAks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AA7smUISMSYvSWTC2fuzmaLH2GpeYJYT
        MD9xutus7ln+ffAmuo3K/nLyUTOkqp+7SRnOqZ1AZ5FhYMzg04WAePGpMwp5qZx/
        e6exrehJ4C0tAqLdqHXEhKyCTwuQJ+5k6WM2IvCLXUEZYgStXcx1UT2NkiEmyQpO
        bb0GGroPZc4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8E55E8436;
        Tue,  8 Sep 2020 00:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18FA2E8435;
        Tue,  8 Sep 2020 00:41:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        <20200908011756.GG241078@camp.crustytoothpaste.net>
        <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
Date:   Mon, 07 Sep 2020 21:41:00 -0700
In-Reply-To: <xmqq5z8p12ds.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 07 Sep 2020 18:30:23 -0700")
Message-ID: <xmqq1rjc284j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F9185A8-F18D-11EA-AE0C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> git-status(1) says:
>>
>>   If a filename contains whitespace or other nonprintable characters,
>>   that field will be quoted in the manner of a C string literal:
>>   surrounded by ASCII double quote (34) characters, and with interior
>>   special characters backslash-escaped.
>>
>> Note that that differs from the standard behavior of not handling
>> spaces, which I expect is due to the need to handle renames
>> unambiguously.
>
> Not really.  We use "rename from" and "rename to" extended header
> lines in our output to unambiguously handle renamed paths.

Ah, I think I misunderstood you.  We don't special case SP in what
you called "the standard behaviour", i.e. "diff" output because we
use "rename from/to", but a short format "status" that does not use
NUL delimited output, we do need to give two paths, separate by
whitespaces, and the quoting each path separately does help.


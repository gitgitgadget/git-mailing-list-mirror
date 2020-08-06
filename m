Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48993C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955A7206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qg3AZdNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgHFRbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:31:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57511 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgHFRa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:30:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 095F87E1E0;
        Thu,  6 Aug 2020 13:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uP6aoAeR+yb9pgOjVwh4+2Q++YE=; b=Qg3AZd
        NZaht7jgAd4fPRRzTpHJ1LFHXg/vXZc3Sr3/8vD+HFNTCd4z4Zr+EXx4k0nhiFgY
        UDoUqQQMeqDN6I2idO8mrguBjgxPWYqndHAFZahkhQ8boXh5cQvVohyQjvHxU04d
        oTDNuTO7J5xMVP+s7YiJ5m1fQETQPbpC84T/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nWHZKxZb+ahhf0WbRIm9PyQ+xP/XqERU
        eLdOZu+46gRourqvSPJe333Sqpx0lQ6v6xbUuOh9Lzu+Y7eqxfmOXB61yUJYmumP
        yAaNVdklqd9X298+f2RArIMLpTawKwcxcFQESpEPwpzQimh0ATKhJI6U+MJ/M7jY
        PaRumOZ6tVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFE967E1DF;
        Thu,  6 Aug 2020 13:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BC6A7E1D7;
        Thu,  6 Aug 2020 13:30:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH 1/4] Use $(SHELL_PATH) instead of sh in Makefile.
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
        <1f63b4fc7c2ae1970d7226bbf0b66901528fb9d8.1596675905.git.gitgitgadget@gmail.com>
        <20200806021354.GS6540@camp.crustytoothpaste.net>
        <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
Date:   Thu, 06 Aug 2020 10:30:07 -0700
In-Reply-To: <CAPig+cRe2OUeHXE3XELtkS7b2GrZVxLm0pzduojDB97uLnBZKQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 6 Aug 2020 00:10:09 -0400")
Message-ID: <xmqqeeojlm1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 794983EA-D80A-11EA-BB13-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Aug 5, 2020 at 10:14 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On 2020-08-06 at 01:05:01, lufia via GitGitGadget wrote:
>> > In the not POSIX environment, like Plan 9, sh might not be looked up
>> > in the directories named by the $PATH.
>>
>> I think Git's editor handling assumes that sh is somewhere in the PATH,
>> so it might be fine for us to just ask the user to adjust PATH
>> appropriately before running make.  I don't have a strong preference; if
>> this works on a standard Unix machine, which it looks like it should
>> (although I haven't tested), I'm fine with it.
>
> This does, however, have a bit of a chicken-and-egg feel to it. The
> results of the "uname_FOO" assignments in config.mak.uname are
> consulted later in the file to _assign_ a value to SHELL_PATH on a
> number of platforms. So, making the "uname_FOO" assignments themselves
> depend upon SHELL_PATH is rather circular and confusing.

Is that just being circular and confusing, or does it produce an
incorrect result depending on the circumstances?  We would end up
special casing SHELL_PATH (e.g. exclude it from the variables that
are set based on uname), which I would want to avoid, as I would
suspect that there will be even more variables that need similar
treatment. 

This does have a bad smell.  Even on a not-so-posix Windows, we do
not use such a hack.


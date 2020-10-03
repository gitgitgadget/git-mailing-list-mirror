Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA21C4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 04:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19C9206F8
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 04:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eGaIfS1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgJCE5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 00:57:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58248 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCE5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 00:57:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86DE4EEADB;
        Sat,  3 Oct 2020 00:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=klkdo88dKinaZuG4A0hr7null7g=; b=eGaIfS
        1uvl7aZ3hYPFan/E49SFQ61F8cvp6urD62zlelEWeMocetYDOTRr42dplwBTAMWq
        aaLCVaxJS+Xh8SQsTN41hCeFTQIIFlVo37T0M+B17xHTGWjL8C4XtTdiUqIwYgrm
        R4NcX01KLuf/WOPH3/fyix+AJdDVSDJ8wyrJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=irpUjLfvt5z+ink9qae1e0RJIPVuaBmv
        JNRWqfSGGNsadosHi4TfVjd4Gw5yh0HQOotJ2HRZ2ogzhg6sR+VgNXv5hllLlyNM
        rmVXJEqc64XbYXD82stqN7kdogjFrdDWWNRyzC42gjPY9sVs4AVufUirh4nUEBg2
        Zn6EQJurVLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EC7DEEADA;
        Sat,  3 Oct 2020 00:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C5E94EEAD9;
        Sat,  3 Oct 2020 00:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <20201002061550.GF3252492@google.com>
        <20201002223212.93266-1-shengfa@google.com>
Date:   Fri, 02 Oct 2020 21:57:42 -0700
In-Reply-To: <20201002223212.93266-1-shengfa@google.com> (Shengfa Lin's
        message of "Fri, 2 Oct 2020 22:32:12 +0000")
Message-ID: <xmqqzh537vp5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8F623D0-0534-11EB-86EC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

>>>>> +  git_config(git_default_config, NULL);
>>>>
>>>> Declaration after statement is not tolerated in this codebase.
>>>
>>> If I use the DEVELOPER=1 flag in config.mak and call make again, would the compiler
>>> catches this as an error?
>>
>> Yes, DEVELOPER_CFLAGS includes -Wdeclaration-after-statement.
>
> Got the error from int hide_timezone = 0; but not
> git_config(git_default_config, NULL);.
> ...
>>>>> +  int hide_timezone = 0;

That is exactly expected.

The problematic sequence was

	...
	s.colopts = 0;

	git_config(git_default_config, NULL);
	int hide_timezone = 0;

The assignment of 0 to s.colopts, which existed before your patch,
was already a statement.  So is a new call to git_config() function
you added.  As the existing "s.colopts = 0" were in a place where a
statement can legally appear, the place you added git_config() call
is also where a statement can legally appear.  There is nothing for
the compiler to complain about.

The declaration of hide_timezone added _after_ that statement is a
different story.  Because the -Wdeclaration-after-statement is about
starting a function (or "a block" in general) with all the necessary
declarations before we write a single statement, and also forbidding
us from adding other declarations after we write a statement.  Since
there are bunch of statements in the same block already, including
the assignment to s.colopts and a call to git_config(), we cannot
add a declaration after that.

Thanks.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF22C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfFJV1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 17:27:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfFJV1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 17:27:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD3A46B17F;
        Mon, 10 Jun 2019 17:27:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/WVITKhK0GFvYtR+I9j+GszNwNo=; b=U+ZPsA
        69oJ2BfBg3Snh0QZR31czPb+6lvlPJreySYwGZzK6p8/gv0YT7jh2QI6haPvpGu/
        Kp6ELY02l0imxJlssRmKasLF4PJdRESlPszlremaoLYm15ANrX8iMgFWmFBHzd+X
        UTBUNN7FUbuKGpnHbjoGpjyEWB9VhYZ+8xfsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bTiBMqwpRDhxuKd8GZF/wvaY9b0e5imk
        ygWH2aWlWLHctwp4HuDPwVRVa8RKCPWUkSeHn5Nyx2mNiRwSfJNQvuLNUtAFz79O
        oYbRt/FQGzcpJBFoPF5EVQH06oRz/Mvxi0Io36obS1/9w0cN/R9HyV93AW7gNYcC
        QcFhwV5m0dE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B65BE6B17E;
        Mon, 10 Jun 2019 17:27:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E7E606B17C;
        Mon, 10 Jun 2019 17:26:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
References: <20190607010708.46654-1-emilyshaffer@google.com>
        <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com>
Date:   Mon, 10 Jun 2019 14:26:56 -0700
In-Reply-To: <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 7 Jun 2019 02:21:07 -0400")
Message-ID: <xmqq36khm8rj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB030D0-8BC6-11E9-8D0B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +/*
>> + * "git walken"
>> + *
>> + * Part of the "My First Revision Walk" tutorial.
>> + */
>> +
>> +#include <stdio.h>
>> +#include "builtin.h"
>
> Git source files must always include cache.h or git-compat-util.h (or,
> for builtins, builtin.h) as the very first header since those headers
> take care of differences which might crop up as problems with system
> headers on various platforms. System headers are included after Git
> headers. So, stdio.h should be included after builtin.h. In this case,

Actually the idea is that platform agnostic part of the codebase
should not have to include _any_ system header themselves; instead,
including git-compat-util.h should take care of the system header
files *including* the funky ordering requirements some platforms may
have.  So, we'd want to go stronger than "should be included after";
it shouldn't have to be included or our git-compat-util.h is wrong.

I've started reading the patch myself, but it seems that you've
already done a lot more thorough read-thru than I would have done,
so thank you very much for that.


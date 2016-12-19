Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932B71FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbcLSX1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:27:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61508 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932401AbcLSX1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:27:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F07855A42F;
        Mon, 19 Dec 2016 18:27:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3TL3IhsqRdGHBGwz+yYkJE+74M=; b=uTT8Ah
        kUGDM2TRRhPFNNJrnBOrLZXOvSGnFp5iMJuEkZ62eQawYsahNqdAR15QmzWPGdqK
        ypIgxCIXq7R6kVFr+gDhNSMxyC/g2UCSTHVWpDty8EUiVVET0lxvahWGW6e5tR16
        3g2j/bWE47K3aVdsaLF43V5yWmDtfpZYkXUeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iul9zidEaZVu3f6hOCeRojhJDMI9Fd6N
        1aj8OsuvJR8xZd0NiQQOxcM/yW5OVHZgTO0TSbZ1eF7VAmZgi/8SUIH1rzENwidE
        lJjSkBdrZ5INYhVZQCkoRnXKGp6ivLrSFmwahpxLHZDp2L7cctb6BGdudprYlsT4
        BNg3vdDF5uc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E781D5A42E;
        Mon, 19 Dec 2016 18:27:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 534675A42D;
        Mon, 19 Dec 2016 18:27:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] improve relocate_git_dir to fail into a sane state.
References: <20161219215709.24620-1-sbeller@google.com>
        <xmqqfuljmswl.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZA1HxsdCAQxKiNMQrH9fLrhGKc8Um7x-R7u92ujVBigQ@mail.gmail.com>
Date:   Mon, 19 Dec 2016 15:27:09 -0800
In-Reply-To: <CAGZ79kZA1HxsdCAQxKiNMQrH9fLrhGKc8Um7x-R7u92ujVBigQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 19 Dec 2016 15:14:49 -0800")
Message-ID: <xmqq7f6vmrea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9FE8392-C642-11E6-A863-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Dec 19, 2016 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This goes on top of sb/submodule-embed-gitdir.
>>> When the absorbing of a git dir fails, try to recover into a sane state,
>>> i.e. try to undo the move of the git dir.
>>
>> Are these unconditionally good improvements?  I ask because the
>> series is still not in 'next' and it is the last chance to fold
>> these into existing patches if we wanted to.
>
> Actually I forgot to mark these as RFC-ish as it is a response to
> https://public-inbox.org/git/20161219053507.GA2335@duynguyen.vn.dektech.internal/
> (which was the only review comment this round)
>
> So I'd say these patches are rather experimental in my mind
> unlike the absorb series, which I assume is ok as is already.

OK.  Thanks for clarification.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3E2208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 21:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934589AbdHYVR0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 17:17:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54003 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932374AbdHYVRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 17:17:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D01E8A6834;
        Fri, 25 Aug 2017 17:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eUIzrjJ8pnNEf/RVeyBf7Q1c4IA=; b=tGhyL5
        JbATm/GwqfsKqwg98bV0yoDeRkhUofjDTn3s9rmbwsVMH+dhw+DTmeh63zYfTTPM
        51pI5l4+lLG3DGupHc9t71LoUVP7Fgq/ID0UogAggpqNiFCwUvlGID1wQHndk/pe
        1qbocaP9NkXU3dXjSh9jP7KOWSv9DICxcGI98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HQA3qtUtimnUMlLgVo5zQdaymAPiRnFJ
        9y9DNJJmIfxrHPCuXyIKcRy/KGCs54j/oW3CqJsbFYiRe83rBbm2j4e/+ye7yAN8
        BNjs1Pa1/bZQWVK93VoKD37M1Tlwr7mITkataEoYTSRTUWyiNCwVhfcM6LZGLk9f
        2Z+cSvLG1+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8342A6832;
        Fri, 25 Aug 2017 17:17:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2243EA6831;
        Fri, 25 Aug 2017 17:17:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] usage_with_options: omit double new line on empty option list
References: <xmqqy3q7sge2.fsf@gitster.mtv.corp.google.com/>
        <20170825192813.15697-1-sbeller@google.com>
        <xmqqh8wvs89e.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY6-R4Tt45BfnncH7tE46K8FG7RBDk+qb-tCU97CVQHvA@mail.gmail.com>
Date:   Fri, 25 Aug 2017 14:17:22 -0700
In-Reply-To: <CAGZ79kY6-R4Tt45BfnncH7tE46K8FG7RBDk+qb-tCU97CVQHvA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 25 Aug 2017 14:06:02 -0700")
Message-ID: <xmqq4lsvs5y5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9EAB732-89DA-11E7-A4E7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Upon closer inspection, I have the impression that f389c808b6
> (Rework make_usage to print the usage message immediately,
> 2007-10-14) introduced the extra new line without giving a rationale.

I do not think that is the case.  The code before that patch
collected all the usage strings in a strbuf sb, which had lines with
their own terminating LFs, and then called usage() on sb.buf, which
added an extra LF, so I think the commit was a faithful and bug-to-bug
compatible rewrite.

But that does not matter in the bigger picture, as long as everybody
agrees with the following:

>> The other fputc('\n', outfile) that this version of the patch
>> touches is what I had trouble with, and I still do.  There must be a
>> similar rationale like the previous one, i.e. "We have finished
>> giving the usage, and we have finished showing all the options.  Now
>> we are about to further show X, so let's have a blank line here so
>> that what we have wrote will be separated from it", but I cannot
>> tell what that X is.
>
> Oh. I assumed that this X is the the next command in the users
> terminal, but I checked other commands and that is not the case
> at all (at least ls, vi, tar)

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C9A1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 13:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKMNbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 08:31:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59855 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKMNbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 08:31:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58D5C27DF5;
        Wed, 13 Nov 2019 08:31:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AdOOrV0dauvsVd3mLoNS/vvrtf4=; b=psrk9o
        R0tyjGKR3AJNilb1XnYbWBrk4LYfXZgEftKMv1OPjG1m74Bd9Zj3uPONrHAFlPlj
        MpQFUIGVHLHq23a4DQJHhQ6K2nGwap6S7BQK1o2keCXk8YahHEeAA6IJctC8RN68
        sHK+z+3uY4L43djxF8O4eh7+J0pnWiR84HVAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hMmIgPm+0mn3SMK//qxyR4EpSIe5UWuz
        uQnyUM8zYykCIFualOYd5/MqXSSDi1PH/Ua/JGSiNHNj010r2QMk1GEZ62j+EeYc
        eldNMPtyI51yJ6XD5sPB32SmmOG8VKrBIiT3pOx/1IKE1kRMGIYzOHlemqwB7DDX
        LJsc2zzKG2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E4FA27DF4;
        Wed, 13 Nov 2019 08:31:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEEFF27DF3;
        Wed, 13 Nov 2019 08:31:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
        <20191107184912.GA3115@cat>
        <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
        <20191108165929.GB3115@cat>
        <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
        <20191111195641.GC3115@cat>
        <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
        <20191113111539.GA3047@cat>
Date:   Wed, 13 Nov 2019 22:31:45 +0900
In-Reply-To: <20191113111539.GA3047@cat> (Thomas Gummerer's message of "Wed,
        13 Nov 2019 11:15:39 +0000")
Message-ID: <xmqq4kz7c37i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F083ACEC-0619-11EA-BE7A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> ...  This may want to become
>> 
>> 	git rev-parse --verify :file &&
>> 
>> or
>> 
>> 	git show :file >actual && echo bar >expect &&
>> 	test_cmp expect actual &&
>> 
>> perhaps?
>
> Hmm I just copy-pasted this from somewhere else in this test file.
> I'll add a preparatory patch getting rid of "$(git command substitution)"
> as I don't believe Denton got to t3903 yet.
>
> There's some more opportunities for modernization of this test file,
> but I refrained from doing that to not blow up this bug fix series too
> much.

It is very much appreciated that you aimed to keep the topic focused
on the fixing.  What I meant was merely to avoid making things worse
by adding more of $(git command substitution), not cleaning up the
existing ones.

Thanks.

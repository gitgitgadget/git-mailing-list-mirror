Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B11C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7CF206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fFPnARQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgEMPdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 11:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62843 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 11:33:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4795461A56;
        Wed, 13 May 2020 11:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cPHcfEwdN0lOeGDEEJq0AI7swhY=; b=fFPnAR
        QHFVtUGW9wpQJ9YxsgPS2rDGB7Nc+CXB1sgX4B0JoaF+DBl8Lnms7LFkr+00oi8i
        ZmFvksrIw8JOoGASAakfqK02onedEpx0dLh+i+OOjLlc1Nb9VPhJSuESYcVYYP3M
        hEW1Bkc9LUM4SYe5OKuAIXyKVTT+7Ac/B7laY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dmKBG3Vt7Wjig1fEOmTlq8aKwuvf+24y
        3FQQMx6xj+sUU5t7Lbfj4r/Rkhm+tRqvAkt+TmxZpqj8RAP0wKpdh9kiDMafzmhD
        kLp4+jmrNfVv57ddyHkpCBpixOOTMBTTu4t6TOIvWKdRDti9EeMHcfMRXLQbK9Vw
        TWZ5DemAj8I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D21F61A55;
        Wed, 13 May 2020 11:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5E6461A54;
        Wed, 13 May 2020 11:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] rebase -i: support --ignore-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200429102521.47995-1-phillip.wood123@gmail.com>
        <20200429102521.47995-5-phillip.wood123@gmail.com>
        <7d72953e-83d2-b60e-1a61-f40fde841957@gmail.com>
        <c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.com>
Date:   Wed, 13 May 2020 08:33:51 -0700
In-Reply-To: <c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.com> (Phillip Wood's
        message of "Tue, 12 May 2020 15:47:33 +0100")
Message-ID: <xmqq1rnnx31c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25C0CDE6-952F-11EA-8BD7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> @@ -957,7 +976,11 @@ static int run_git_commit(struct repository *r,
>>>     	if (opts->committer_date_is_author_date)
>>>   		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>>> +				 opts->ignore_date ?
>>> +				 "" :
>>>   				 author_date_from_env_array(&cmd.env_array));
>>> +	if (opts->ignore_date)
>>> +		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
>>>   
>>
>> Perhaps this could be done in read_env_script(), too, instead of fixing
>> up what this function did right after calling it, twice?  Something like
>> this:
>
> Long term I'd like to stop writing the author-script file unless we're
> stopping for a conflict resolution or edit so I'm reluctant to add
> more functionality to it at the moment. Also I tend to view
> read_env_script() it as loading the author details from a file rather
> than setting up the environment for the commit.

Yeah, the author-script, once the program halts and returns the
control to the human-user sitting on the terminal, can be peeked at,
and it should record what the program learned from the commit; it
smells like a premature optimization to rewrite it to what the
program plans to use to replay the commit and lose the information
taken from the original.

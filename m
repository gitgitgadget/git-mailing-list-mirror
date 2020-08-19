Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170C6C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B46207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hWqwDFnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHSRJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:09:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65027 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:09:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 433F57142B;
        Wed, 19 Aug 2020 13:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NdvPgzrKBr7pVBqResllYEcUuqg=; b=hWqwDF
        nPSAo3ZbBIqhsnYxnqS0+7jxTw0AJDCh0xC547op2xGVQosCL5bg3JSiseJlJAME
        ZlczkKLAdvVLFm4UtCSHHKgDLCVKP6f9hxkvAYD8QvkgJxAyUT3DWvu4GnB8P7de
        I0ibHIzc4MaqyCEKExMQvulc0scoMhzmLKNtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sV9xiL1G1QkFWrOe9waRK0y/4riV08HG
        fSsK9YGdKjP9T9OpAOlxGeO107ovaPx4pju9LjQ0F67Q1xVukkL9Bm+BipIiYHRT
        6z24VA/kWRKRQnmgsQ2pbLBQ4zm+QOHzPAtivZGn0uFsABO6BalMlLTXBGKFKzFJ
        to8YAikFNo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B8AB7142A;
        Wed, 19 Aug 2020 13:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAB7F71426;
        Wed, 19 Aug 2020 13:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Aug 2020, #04; Tue, 18)
References: <xmqqft8jwov1.fsf@gitster.c.googlers.com>
        <9bb7995e-4e69-00b3-eb7a-54412638cb7f@gmail.com>
Date:   Wed, 19 Aug 2020 10:09:08 -0700
In-Reply-To: <9bb7995e-4e69-00b3-eb7a-54412638cb7f@gmail.com> (Derrick
        Stolee's message of "Wed, 19 Aug 2020 10:56:13 -0400")
Message-ID: <xmqq5z9ev9zf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1D88614-E23E-11EA-AF6E-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/18/2020 6:50 PM, Junio C Hamano wrote:
>> * ds/maintenance-part-1 (2020-08-18) 11 commits
>>  - maintenance: add trace2 regions for task execution
>>  - maintenance: add auto condition for commit-graph task
>>  - maintenance: use pointers to check --auto
>>  - maintenance: create maintenance.<task>.enabled config
>>  - maintenance: take a lock on the objects directory
>>  - maintenance: add --task option
>>  - maintenance: add commit-graph task
>>  - maintenance: initialize task array
>>  - maintenance: replace run_auto_gc()
>>  - maintenance: add --quiet option
>>  - maintenance: create basic maintenance runner
>>  (this branch is used by ds/maintenance-part-2; uses jc/no-update-fetch-head; is tangled with jt/lazy-fetch.)
>
> Is this "is tangled with jt/lazy-fetch" related to the
> fact that jc/no-update-fetch-head was part of my branches,
> or are we colliding in other interesting ways?

The phrasing is unfortunate but what it wants to convey is that,
when the commits that are in this topic but not in 'master', and the
commits that are in the other topic but not in 'master', are
compared, there is overlap.  If one is a subset of the other, 'used
by' and 'uses' are the words used to describe these two topics.  I
just picked to use 'is tangled with' when both sides have unique
commits that are not in 'master'. 

IOW "shares commits with X that are not in 'master'" is what I
wanted to say, but has been too lazy to find a better word X-<.

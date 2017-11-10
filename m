Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E154F201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 05:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750744AbdKJFAM (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 00:00:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750710AbdKJFAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 00:00:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22FA6BA203;
        Fri, 10 Nov 2017 00:00:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9nT4SxkfN0g/RK8gFNKIF4L1FJo=; b=KF3iF9
        WnpONxdAPTySSCSczXAOi+PVcr5RadLYS6eJCaZAQgccJusG1G53YvMJNCWQpj2S
        JPTD4+4TPSwy0mB8WP4B0rrZrmmf0vJM4k9V0VPVlihydyRjyfLTaKVlbkYJbSkn
        7k84Poz9wK2VnsteffEVqc9aaMN5xUaWmMRQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AYC+fMGvfquRO3q08vo6bENFPxPMheDl
        pLrgUlSZl/pu3b1FyqnsGpxBkNJQccyxK0oMe4bF64YgzhvP5KZfPFLBo603Ubgq
        4PlpViQgcfEJUWtQt3nmn5qCMuZP4l67ytD+9L+M1Ne9wyFyrpey9zu6J4ZnEkV5
        B/hBbSejaO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75A23BA201;
        Fri, 10 Nov 2017 00:00:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D85D2BA1F4;
        Fri, 10 Nov 2017 00:00:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Query] Separate hooks for Git worktrees
References: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
        <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
Date:   Fri, 10 Nov 2017 14:00:02 +0900
In-Reply-To: <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 9 Nov 2017 11:14:45 -0800")
Message-ID: <xmqq60aihgod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05CC9664-C5D4-11E7-96B6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We have no worktree specific config yet, though patches for
> this were floated on the mailing list.
>
> Though recent versions of git learned to conditionally include
> config files. (look for includeIf in man git-config), which I think
> could be used to set the option gerrit.createChangeId  depending
> on the worktree you are in.
>
>> Any idea how I can get around this problem without having separate
>> repositories for kernel and android ?
>
> The proposed approach above might be hacky but sounds as if
> it should work?

If you meant "conditional include" by "proposed approach above", I
do not see which part you found possibly hacky.  It is to allow
different set of configurations to apply depending on where you are
working at, which I think was invented exactly for something like
this.

It certainly is not any hackier than using the same repository to
house separately manged projects even if they may be related
projects.

Where does the aversion of "having separate repositories" primarily
come from?  Is it bad due to disk consumption?  Is it bad because
you cannot do "git diff android-branch kernel-branch"?  Something
else?

If it is purely disk consumption that is an issue, perhaps the real
solution is to make it easier to maintain separate repositories
while sharing as much disk space as possible.  GC may have to be
made a lot more robust in the presense of alternate object stores,
for example.



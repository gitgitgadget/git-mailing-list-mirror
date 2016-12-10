Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85FD1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 21:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbcLJVXO (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 16:23:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54844 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751088AbcLJVXO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 16:23:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B966A54D09;
        Sat, 10 Dec 2016 16:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3f+iFx6whspvtCpuCxJJL3jLEwo=; b=PqzgB4
        HMOyhTNZme0vLsjScTYdspmxzfRB4JibjZ9mzHGiOGMw9dEXomnnmkYIqQKM/vPm
        aBk45zPAOXdzXiwxFULN2f2nbxeaF5daYcCNBM/pGIhZiq+C5/Ql/2Pi7vRPUBMc
        mWv/IeICuE4YV0NV0McVhYbDu933LnADQygmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WpFIRv5OcHScXb5ws4lgBA48HLqvrwuJ
        pojWoWLSTMQoJZV8idzXQ8psspXVkeY6JGjACwQCu8KWdnkxKrpMBCxAJdrt5dSx
        OMQUBNJR54ZGadU1E1NZHqR/Ud75WIRCA36E6xjo+1l2NnUmJpFDrzHQdRmfxkSq
        P3mgpgNpIgQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0A0154D08;
        Sat, 10 Dec 2016 16:23:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 318A154D07;
        Sat, 10 Dec 2016 16:23:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
        <6facca6e-622a-ea8f-89d8-a18b7faee3cc@gmx.net>
        <xmqq8trry08k.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CX0HO=LxcEK3K+pCecgFY=40R+gpFoy7CGeN5zEJFJVQ@mail.gmail.com>
        <xmqq8trprn7f.fsf@gitster.mtv.corp.google.com>
        <e0780f7c-ccb4-29fe-3d72-80e45a202f65@gmx.net>
        <CACsJy8Div=Baenn7c-1wxgvrOh5PG=naeDrEYC8gs+AvJE7wZA@mail.gmail.com>
Date:   Sat, 10 Dec 2016 13:23:10 -0800
In-Reply-To: <CACsJy8Div=Baenn7c-1wxgvrOh5PG=naeDrEYC8gs+AvJE7wZA@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 10 Dec 2016 18:00:56 +0700")
Message-ID: <xmqqfulvpjgh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DACD6FD6-BF1E-11E6-A59C-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> rebase and cherry-pick/revert are not exactly in the same situation.
> When cherry-pick/revert in "continue/abort" mode, there's usually some
> conflicted files and it's easy to notice.
>
> But an interactive rebase could stop at some commit with clean
> worktree (the 'edit' command). Then I could even add some more commits
> on top. I don't see how 'rebase --abort' can know my intention in this
> case, whether I tried (with some new commits) and failed, and want to
> revert/abort the whole thing, moving HEAD back to the original; or
> whether I forgot I was in the middle of rebase and started to do
> something else, and --abort needs to keep HEAD where it is.

OK.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004BBC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4446139C
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhDERsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:48:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhDERsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:48:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B90FA1229FA;
        Mon,  5 Apr 2021 13:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4IVs39yRLPMzPVog0lsLfnDPgKc=; b=jtH8Ef
        nOXaC6iLpedtkO8m+1GRFFWoqflxVusiX+x7IvCcn5cdBlGZ/VlcwzSzeXDnsgU+
        1xpuKlU/XVN2aUfijUiiTYK0SVbymH6N8CntPukHT+0K4XvPv2GPfXNKnRxo6KyN
        PtggnZCUYnoH22f7QONEDk4V0xZbtUtzAT/Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j2XcZ3j7vfWHUtQ4fEcQO/8hCJowsSi4
        uZx7TuDL/9eFd0aDtEDkSXb2Q6QnydcIr/CWgUdTAX0I4yTf2yClB/Dvpp9OSW/M
        vj3UrlXDnxyBlqgNT8C9iwA7Z8+AhsDlliZcCbcuFRfMtq8BDAJnNExEGNmRmEIo
        1cbXfF3Vcug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1AA71229F9;
        Mon,  5 Apr 2021 13:48:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F057E1229F8;
        Mon,  5 Apr 2021 13:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Chinmoy <chinmoy12c@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
        <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
        <xmqqy2dyy40l.fsf@gitster.g>
        <be9793f0-f437-8e42-d463-21a48d2ee948@gmail.com>
Date:   Mon, 05 Apr 2021 10:48:04 -0700
In-Reply-To: <be9793f0-f437-8e42-d463-21a48d2ee948@gmail.com> (Derrick
        Stolee's message of "Mon, 5 Apr 2021 09:08:44 -0400")
Message-ID: <xmqqv99062sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 138836B4-9637-11EB-AEBB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> With your additional comments, I think it is clear that the "fourth
> option" I mentioned earlier [1] is the way to go:
>
>   Finally, there is yet a fourth option: use istate->repo instead. In
>   1fd9ae51 (repository: add repo reference to index_state), I added a
>   'repo' member to struct index_state. This is intended for methods to
>   access a repository directly from the index.
>
> [1] https://lore.kernel.org/git/f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com/

Thanks.  I wasn't following the earlier discussion closely, as the
topic seemed to be in the hands of good reviewers ;-)

> So in this sense, we should always use istate->repo, but we might
> still need the following guard in some places:
>
> 	if (!istate->repo)
> 		istate->repo = the_repository;
>
> in case there are situations where the index is loaded before
> the_repository is loaded. I have hit this in testing, but don't fully
> understand the cases where this can happen.

As a longer term goal, it may not be a bad idea to make sure that
anybody who passes an istate should not have to pass a repo.  I do
not think of a reason why, other than historical inertia, to do so
in post 1fd9ae51 world.

> The way it would change this patch is to drop the 'struct repository *r'
> pointers and changes to the method signatures. Instead, keep the
> methods only taking a 'struct index_state *istate' and use istate->repo
> everywhere.

Yes, and that would result in a patch that touches very limited
small parts of cache-tree.c without needing to touch any caller, I
would presume.

Thanks.

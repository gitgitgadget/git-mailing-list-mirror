Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EEC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C2820784
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VVhid4Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCaSea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:34:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCaSea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 14:34:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C2B7B9CFE;
        Tue, 31 Mar 2020 14:34:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YhkryQBdKpchvfQOHGLTKHVI590=; b=VVhid4
        DwUTon72ZT1gWkjpJmluGRn0E6Qvt1dgWRJhxfrGvfvPubbN4kGqhPqtzDeI1G0T
        zHeHxZwntrdDx7Gj5tuf/p0svoEaYaAVbhXPNVMq9DHMB+F2sMdKwx9OS/9Yje/E
        bDZLUqeMYJbhNXX8RHIRm2ndxg1zZApeP5TFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iJoR+uP/bhasj/QyCP997L0OPO/+VmWK
        81oxt1Q9vwxAUaboc/9BzqOYvxn7RHtvoee+XZgjsE7bWG9iL7vPCNkDV3ALD9yu
        nCFZAgEFwVAw6Y08nG24KOIHxRPioLjwvFPT4KRN0Knss3gFiKwzHv97OpLWUd0M
        BozylTYAjdQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53D53B9CFD;
        Tue, 31 Mar 2020 14:34:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9DB73B9CFC;
        Tue, 31 Mar 2020 14:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>, congdanhqx@gmail.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200330040621.13701-1-jonathantanmy@google.com>
        <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
Date:   Tue, 31 Mar 2020 11:34:24 -0700
In-Reply-To: <CABPp-BGew8HWChsMVH3ZNS4DuH=nE-GF5ouifP7DhLP-xQ_xbg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 31 Mar 2020 09:27:11 -0700")
Message-ID: <xmqqh7y474r3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F7F31BE-737E-11EA-A067-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> +--keep-cherry-pick::
>> +--no-keep-cherry-pick::
> ...
> I'm slightly worried that "keep" is setting up an incorrect
> expectation for users; in most cases, a reapplied cherry-pick will
> result in the merge machinery applying no new changes (they were
> already applied) and then rebase's default of dropping commits which
> become empty will kick in and drop the commit.

Yes.

> Maybe the name is fine and we just need to be more clear in the text
> on the expected behavior and advantages and disadvantages of this
> option:
>
> If `--keep-cherry-picks` is given, all commits (including these) will be
> re-applied.  Note that cherry picks are likely to result in no changes
> when being reapplied and thus are likely to be dropped anyway (assuming
> the default --empty=drop behavior).  The advantage of this option, is it
> allows rebase to forgo reading all upstream commits, potentially
> improving performance.  The disadvantage of this option is that in some
> cases, the code has drifted such that reapplying a cherry-pick is not
> detectable as a no-op, and instead results in conflicts for the user to
> manually resolve (usually via `git rebase --skip`).

True.  So instead of letting the machine match commits on the both
sides up, the end-user who is rebasing will find matches (or near
matches) and manually handle them.  It would be a good idea to
describe the pros and cons for the option (which I think has already
been written fairly clearly in the proposed patch).

> It may also be helpful to prevent users from making a false inference
> by renaming these options to --[no-]reapply-cherry-pick[s].

Hmm, yeah, that may not be a bad name.

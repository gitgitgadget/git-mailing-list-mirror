Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B659320281
	for <e@80x24.org>; Tue, 31 Oct 2017 02:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbdJaCiT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 22:38:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54291 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751619AbdJaCiT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 22:38:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72385A8FBC;
        Mon, 30 Oct 2017 22:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mgSS6VSdvzvdmfVYwoIWJ45QHgs=; b=r0FgYH
        KwsvOR60EE/b6dDke8Awl2gZn903U/KPcbripMevSf3z6/URrMgukHw6I7lSSwFs
        +Q0SBOQmbC7DPwII5wsZ9rNgZF2OjOjUYWIWH+A1YGOtDe6LyK6Kg7qug3ZYgFnX
        yFtZA//p2x6mQpvxgF+0lhQwhAsxnr0VMyOv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FW4bWY7zmRnXkecpueoo+P2JF4YNiBvt
        yaFdgaNW571y6uJGWJpA70LzWuefAeeTFiouDUBxdUlX3EIVNvZeTdsuz5XZZBmM
        9t0yEzMMyS1v3s1MtPliqQYds7s5p07TGnkGieOZbFmykEdW4z1x6Gtf2FFM5+bN
        xGIHxJLBzK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A23AA8FBB;
        Mon, 30 Oct 2017 22:38:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE7E2A8FBA;
        Mon, 30 Oct 2017 22:38:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301827000.6482@virtualbox>
Date:   Tue, 31 Oct 2017 11:38:16 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710301827000.6482@virtualbox> (Johannes
        Schindelin's message of "Mon, 30 Oct 2017 18:28:19 +0100 (CET)")
Message-ID: <xmqqy3ns2g9z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D5297B6-BDE4-11E7-9B3C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 30 Oct 2017, Junio C Hamano wrote:
>
>> * jc/branch-name-sanity (2017-10-14) 3 commits
>>   (merged to 'next' on 2017-10-16 at 174646d1c3)
>>  + branch: forbid refs/heads/HEAD
>>  + branch: split validate_new_branchname() into two
>>  + branch: streamline "attr_only" handling in validate_new_branchname()
>> 
>>  "git branch" and "git checkout -b" are now forbidden from creating
>>  a branch whose name is "HEAD".
>
> Question: should we respect core.ignoreCase and if it is true, compare
> case-insensitively? Or should we just keep the comparison
> case-sensitively, in preparation for a (hopefully near) refs backend that
> does not inherit filesystems' case-insensitivity?

While I do think it would be good if the system as a whole somewhere
we had a safety to say "We do not allow hEaD as branch name as you
are using the files-backend as your reference storage on a case
insensitive filesystem", I do not think it is a good idea to do so
in the layer the above patches touch.  Once a more capable ref
backend comes (Shawn's reftable, anybody???), platforms with case
insensitive filesystems can allow refs/heads/hEaD as a branch whose
name is hEaD that is different from another branch whose name is
hEAD just fine; having the "we are on icase system, so reject" check
at the layer would mean we need to remember we have such a check at
a wrong layer and revert it when such an improvement happens.





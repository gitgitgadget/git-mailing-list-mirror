Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FAA202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbdKQByP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:54:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60569 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755013AbdKQByM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:54:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF2199EF0E;
        Thu, 16 Nov 2017 20:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GAzRHVpfBuIFsAiU0CV+ZHXckXs=; b=jqrfPq
        hURh7YEoBrN1jBzo6AoGZ6vIpjOEzzJan0PC56q6wQt1ENmNgHrmbzBJrEtcshjZ
        5fpMXYaXgK8nS5b526gpbjOL71aITHUq/wMyQREqsksVzPxT45AV1cgX87wQJvpr
        Kwg9gI7lWwq4rsVXT7pOdADdmeDiAtYFv3sLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C0a/vLV0GADgecWyds1e6cRIFKY+49jH
        WahXkREEe8l1RjjdghwtoqRmPDy98tK2FDUrHP21fGq+0uo2nwvzwZ1WxUJyGO/q
        bez5LWtQIAyhW6axZgd3cDrJPW8sFzgHaqhVM90hS/tGU810vRy6vfobEX8XU3VF
        zZth9YDEL1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A63C99EF0D;
        Thu, 16 Nov 2017 20:54:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 245129EF0B;
        Thu, 16 Nov 2017 20:54:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 2/3] am: semi working --cover-at-tip
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
        <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de>
        <xmqqbmk54cy3.fsf@gitster.mtv.corp.google.com>
        <325a3a6f-9916-29cb-48c0-69aa59e5913d@suse.de>
        <4bbaaf33-3796-4aa2-6434-ab79182274f5@suse.de>
Date:   Fri, 17 Nov 2017 10:54:09 +0900
In-Reply-To: <4bbaaf33-3796-4aa2-6434-ab79182274f5@suse.de> (Nicolas
        Morey-Chaisemartin's message of "Thu, 16 Nov 2017 17:21:40 +0100")
Message-ID: <xmqqlgj5u0u6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34C0838E-CB3A-11E7-AAD8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:

>> I thought about that.

>> Is there a use case for cover after the last patch works and
>> removes the need to touch am_next (can be done out of the loop in
>> am_run).
>
> Do you have an opinion on that ? It has quite a big impact on how things are done !
> Single series only would mean a simple flush at the end.
> Multiple series makes things a whole lot complex.

I am not sure what you even mean.  Are you wondering what "am"
should do to a mbox with, say, these messages?

	1: [PATCH 0/2] Cover for series A
	2: [PATCH 1/2] patch 1 of series A
	3: [PATCH 2/2] patch 2 of series A
	4: [PATCH 0/3] Cover for series B
	5: [PATCH 1/3] patch 1 of series B
	6: [PATCH 2/3] patch 2 of series B
	7: [PATCH 2/3] patch 3 of series B

Running "am" on the whole thing and expecting covers to become the
capping empty commit at the tip is crazy, I would think, for such a
mbox, as there is no way to tell the command (after it processes 1,
2 and 3, to create commits out of 1, 2 and then an empty one out of
0 to finish one topic off) that it must create a new branch to store
the next series, and building the second series on top of the
capping empty commit at the tip of first series would not make any
sense---the "tip empty commit" for the first series will no longer
be at the "tip".

What I was alluding to is a different case, in which additional
patches are sent as a follow-up later, ending up in a mbox like
this:

	1: [PATCH 0/2] Cover for series A
	2: [PATCH 1/2] patch 1 of series A
	3: [PATCH 2/2] patch 2 of series A
	4: [PATCH 3/2] patch 3 of series A

Naturally, the cover letter may not list 3/2 in its short-log
section, but the description for the overall goal and approach
of the series in it should still be valid even with patch 3/2.
The total number of messages mailsplit gives us would be 4, your
subject parser would read "2" as the number of patches, which would
make the number of messages for the series to be expected "3"
(i.e. "2" plus cover), but "am" would want to create commits for
patches 1, 2, and 3, and then cap it with the cover material.

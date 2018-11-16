Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6801F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 06:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbeKPQnL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 11:43:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50371 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbeKPQnK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 11:43:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5113510A41A;
        Fri, 16 Nov 2018 01:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5lCwYVcMTtyk
        n9zujS/BazO6EMo=; b=RlM8sswE29aw/PfQ4aZJaOfFgMSiUAeZDU2WX+HdyWrK
        l6gUXsEIBiDdVWJ7kZJVYDdXuoiNU7b7mXIh52qTbAMqYsKbanORqHM/nxenvcsy
        ednjFt/w+XrjgdqiNgGHYn/ya+iuI7of6HsVZGsT/6h+wMQJS4l41EFMAMzPU0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NMOQcF
        +JSyq1TyUPrmYBag99MhSB1GlEkyiKSzspUuPW913oOoqZOgo+Yog5qwd2NdPvTt
        t0oSf4G/ONuK8ntZXU6QaPGz4uLEGx5DM478yCU7tqJ2nz/bfeREh+R9R0ji/BJz
        SCjN4+hy9w+m017vFH1HLDZ4KIwbtzybnKlaY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 494CB10A419;
        Fri, 16 Nov 2018 01:32:07 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB88010A417;
        Fri, 16 Nov 2018 01:32:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222524.2624-1-slawica92@hotmail.com>
        <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Nov 2018 15:32:05 +0900
In-Reply-To: <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Nov 2018 14:55:08 +0900")
Message-ID: <xmqq5zwxjzx6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 568E2A40-E969-11E8-AD01-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Slavica Djukic <slavicadj.ip2018@gmail.com> writes:
>
>> +test_expect_failure 'stash works when user.name and user.email are no=
t set' '
>> +	git reset &&
>> +	git var GIT_COMMITTER_IDENT >expected &&
> ...
> Anyway, we grab the committer ident we use by default during the
> test with this command.  OK.
>
>> +	>1 &&
>> +	git add 1 &&
>> +	git stash &&
>
> And we make sure we can create stash.
>
>> +	git var GIT_COMMITTER_IDENT >actual &&
>> +	test_cmp expected actual &&
>
> I am not sure what you are testing with this step.  There is nothing
> that changed environment variables or configuration since we ran
> "git var" above.  Why does this test suspect that somebody in the
> future may break the expectation that after running 'git add' and/or
> 'git stash', our committer identity may have been changed, and how
> would such a breakage happen?

Just a note.

"git var GIT_COMMITTER_IDENT" has timestamp in it, so a na=C3=AFve reader
might wonder what would happen if "git add 1" and "git stash" took
more than one second.  But it won't be a problem in this case as the
committer date comes from the environment GIT_COMMITTER_DATE, which
is set to a fixed known value and is incremented only by calling
test_commit helper function, which does not happen between the two
"git var" calls.

In any case, I am not sure I understand the point of comparing two
output from "git var" invocations we see ablve in this test.

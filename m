Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB91D1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 10:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbeKPUYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 15:24:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50694 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeKPUYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 15:24:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D526F12B5BD;
        Fri, 16 Nov 2018 05:12:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JYmh3dK1Gac3x8890SVd55ry7YE=; b=tqWLRy
        IKX1Yc48vGyCWGRkw39vdbu0xISIw9G0mz7eZHgEkXIF/nbYe8gKdxGbbDR51CWw
        7PeG0rXc0D6/+Hu3saCnWZOzGnPf9axM930Wt7Ppz1+UFpknYzglf+cQn237sBN5
        uGfFWf6Hl6QBy9jIZ3HuiwkzAMDslTyh9xYzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XeuAMPu+/F3Cq3RR5ctJfEbL2RCNRa/g
        gIm7Dv/5zIwkAszWnAu5CryZ0x/WRODcTkMXFPu5+awT6TjYtJKkdSW17ttOk3q1
        iwfBdZ8cRCRRsNSDzAj7tD/ndpf5DWzrb1cTYXgMbEXpuIUKWn1TNqNQmJFPv6ik
        +YCZCDm1dmE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDE3C12B5BC;
        Fri, 16 Nov 2018 05:12:43 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A23C12B5BA;
        Fri, 16 Nov 2018 05:12:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222524.2624-1-slawica92@hotmail.com>
        <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
        <2f3612b8-5f26-adae-9a7f-05d16040938e@gmail.com>
Date:   Fri, 16 Nov 2018 19:12:42 +0900
In-Reply-To: <2f3612b8-5f26-adae-9a7f-05d16040938e@gmail.com> (Slavica
        Djukic's message of "Fri, 16 Nov 2018 09:28:07 +0100")
Message-ID: <xmqqsh01ib51.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2825C306-E988-11E8-A2CF-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

>>> +	git var GIT_COMMITTER_IDENT >actual &&
>>> +	test_cmp expected actual &&
>> I am not sure what you are testing with this step.  There is nothing
>> that changed environment variables or configuration since we ran
>> "git var" above.  Why does this test suspect that somebody in the
>> future may break the expectation that after running 'git add' and/or
>> 'git stash', our committer identity may have been changed, and how
>> would such a breakage happen?
> In previous re-roll, you suggested that test should be improved so
> that when
> reasonable identity is present, git stash executes under that
> identity, and not
> under the fallback one. 

Yes, but for that you'd need to be checking the resulting commit
object that represents the stash entry.  It should be created under
the substitute identity.

> Here I'm just making sure that after calling
> git stash,
> we still have same reasonable identity present.

I do not think such a test would detect it, even when "git stash"
incorrectly used the fallback identity to create the stash entry.

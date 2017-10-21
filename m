Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176A0202DD
	for <e@80x24.org>; Sat, 21 Oct 2017 08:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbdJUI5I (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 04:57:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63528 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752885AbdJUI5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 04:57:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D59DB8DCD;
        Sat, 21 Oct 2017 04:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0+a+LtkTwH7G5yOLvdkrMdTGPb8=; b=Xg3EZv
        mCYXtRYxgE//x0g0sk+A8w9fAoEJYcfIUMFm2cumQnTDpQmE79O+nOd+fsaCd37C
        wQuVdRKteF7CNyhRCvzHqoC/By72JedUNwQ9Tn2GD7MiidURxIYNLnqTneLJ2tZ2
        MW6t28D8vVT9h3FeGFcYXcnSRRuRPhW4GTmyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NKq3aWvqFq78K5YZ0ceK9urem5e1u4Ne
        wgiGQlJINbJJNM/5NIuBY1kaO65t1DqLOP5R8ukvOEt1tr0YTOnwYg/rug6zadnP
        Ogb1ALHBWWGlGEYf5C/P3d5QL8qCgypLXnxRV33AL9u6dNx6dvm0hnNseeuk5yyO
        Op9ruvZny5M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3585CB8DCC;
        Sat, 21 Oct 2017 04:57:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA2A1B8DCB;
        Sat, 21 Oct 2017 04:57:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] branch: forbid refs/heads/HEAD
References: <20171013051132.3973-1-gitster@pobox.com>
        <20171013051132.3973-4-gitster@pobox.com>
        <20171013131501.3qarwhanktfvgjqd@sigill.intra.peff.net>
        <xmqqefq6v5qj.fsf@gitster.mtv.corp.google.com>
        <xmqqa80uv5b8.fsf@gitster.mtv.corp.google.com>
        <1508561424.2516.19.camel@gmail.com>
Date:   Sat, 21 Oct 2017 17:57:05 +0900
In-Reply-To: <1508561424.2516.19.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 21 Oct 2017 10:20:24 +0530")
Message-ID: <xmqqpo9gg9pa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D09A2D8A-B63D-11E7-B881-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> The only difference is improved tests where we use show-ref to make
>> sure refs/heads/HEAD does not exist when it shouldn't, exercise
>> update-ref to create and delete refs/heads/HEAD, and also make sure
>> it can be deleted with "git branch -d".
>
> In which case you might also like to ensure that it's possible to
> "rename" the branch with a name "HEAD" to recover from historical
> mistakes.

Perhaps.  I didn't think it was all that needed---as long as you can
delete, you can recreate at the same commit with a more desirable
name, and it is not like users have tons of repositories with
misnamed branches that they need to fix.  The code may already
handle it, or there may need even more code to support the rename; I
didn't check.

>>  int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>>  {
>>  	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
>> -	if (name[0] == '-')
>> +	if (*name == '-' || !strcmp(name, "HEAD"))
>>  		return -1;
>
> I guess this makes the check for "HEAD" in builtin/branch::cmd_branch()
>  (line 796) redundant. May be it could be removed?

Perhaps.  But I think that is better done as a follow-up "now the
lower level consistently handles, let's remove the extra check that
has become unnecessary" separate patch.

> So, may be the following test could also be added (untested yet),
>
> test_expect_success 'branch -m can rename refs/heads/HEAD' '
> 	git update-ref refs/heads/HEAD HEAD^ &&
> 	git branch -m HEAD head &&
> 	test_must_fail git show-ref refs/heads/HEAD
> '

Yeah, that would be a good material for that separate follow-up
patch.

Thanks.


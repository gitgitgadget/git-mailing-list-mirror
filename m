Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C091F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGJSk6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:40:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52678 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfGJSk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:40:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECE2263160;
        Wed, 10 Jul 2019 14:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFHfbPho/u3obPO+tx8XXmvuAIE=; b=YqucaN
        V+/C4o7gERK1H9EPoql3xXzvAulxCLNPs82TKWsZczU4qNClBGoAyLVxF1RTTg54
        YQPTRWvlsDXPi6VIH/Pe3ulHr+SlC1niQCu0LqG7k2psCbeyiMjpHKNM7BLG3EpL
        t7AmzX2E4I/VhZPSVx1RoRV86qiIPxrc4Q81s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MTR5icj220w0/HAYH7xbrohnLPvGpbVk
        krIR2ZDRMa5ossY+I6R2rjYDjKxI2thATnXDVmIDFxh5pA3R9b0Hm6xi5sGby0Tb
        Ehnt8ryJWCr8JSdEj5KGwyzfiwt8ZkhFRciZLulaDW1I4bwiC54Ry+3gdx/g0kaX
        0xzPIHPFqz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E60FC6315F;
        Wed, 10 Jul 2019 14:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D2326315E;
        Wed, 10 Jul 2019 14:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
References: <20190704080907.GA45656@book.hvoigt.net>
        <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
        <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
        <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
        <20190710075835.GB65621@book.hvoigt.net>
Date:   Wed, 10 Jul 2019 11:40:50 -0700
In-Reply-To: <20190710075835.GB65621@book.hvoigt.net> (Heiko Voigt's message
        of "Wed, 10 Jul 2019 09:58:35 +0200")
Message-ID: <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EFB11F2-A342-11E9-A42B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> behavior. How about '--all-include-head'. Then e.g.
>
>     git rev-parse --all-include-head --all --not origin/master
>
> would include the head ref like you proposed below?
>
> What do you think? Or would you rather go the route of changing
> rev-parse behavior?

Depends on what you mean by the above.  Do you mean that now the end
user needs to say

	gitk --all-include-head --not origin/master

to get a rough equivalent of

	git log --graph --oneline --all --not origin/master

due to the discrepancy between how "rev-parse" and "rev-list" treat
their "--all" option?  Or do you mean that the end user still says
"--all", and after (reliably by some means) making sure that "--all"
given by the end-user is a request for "all refs and HEAD", we turn
that into the above internal rev-parse call?

If the former, then quite honestly, we shouldn't doing anything,
perhaps other than reverting 4d5e1b1319.  The users can type

	$ gitk --all HEAD --not origin/master
	$ gitk $commit --not --all HEAD

themselves, instead of --all-include-head.

If the latter, I am not sure what the endgame should be.  

It certainly *is* safer not to unconditionallyl and unilaterally
change the behaviour of "rev-parse --all", so I am all for starting
with small and fully backward compatible change, but wouldn't
scripts other than gitk want the same behaviour?  

To put it the other way around, what use case would we have that we
want to enumerate all refs but not HEAD, *and* exclude HEAD only
when HEAD is detached?  I can see the use of "what are commits
reachable from the current HEAD but not reachable from any of the
refs/*?" and that would be useful whether HEAD is detached or is on
a concrete branch, so "rev-parse --all" that does not include
detached HEAD alone does not feel so useful at least to me.

I am reasonably sure that back when "rev-parse --all" was invented,
the use of detached HEAD was not all that prevalent (I would not be
surprised if it hadn't been invented yet), so it being documented to
enumerate all refs does not necessarily contradict to include HEAD
if it is different from any of the ref tips (i.e. detached).

And if we cannot commit to changing the "rev-parse --all" (and I am
not sure I can at this point---I am wary of changes), as we know
where "--all" appeared on the command line, inserting HEAD immediately
after it at the script level is probably the change with the least
potential damage we can make, without changing anything else.



>
> Cheers Heiko
>
>> 
>>  builtin/rev-parse.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
>> index f8bbe6d47e..94f9a6efba 100644
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -766,6 +766,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>  			}
>>  			if (!strcmp(arg, "--all")) {
>>  				for_each_ref(show_reference, NULL);
>> +				head_ref(show_reference, NULL);
>>  				clear_ref_exclusion(&ref_excludes);
>>  				continue;
>>  			}

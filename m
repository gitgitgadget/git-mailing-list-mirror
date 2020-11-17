Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D7EC5519F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2909C24181
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZjIHottX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKQTJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:09:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50532 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKQTJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:09:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEE32FF323;
        Tue, 17 Nov 2020 14:09:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=keR/zk05kqRi6s9G3mJNLW1LHBU=; b=ZjIHot
        tXweKkfI1BR5wx606SipgjA9ZA0+Aa5hNMliIPq7zedzVI68jtt82NyjFZrhBa2V
        gcsJH8cLy+krLLu0ZE37thDR9caPYcagkwNVdOQK5X0NFlsIgZgx5DI/E3knPghH
        FleLWpnR0sHOZcD9icUPCXxaBMjC0/w/GTslc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ahu7rzkzCZ+auybig4tivfna8qCLsJje
        s18ovQUsOiZvGl09NblLbU/GohgCkiV9zIgzGOhAPouN0yZjYwwYfxjmVi5roL0L
        qumFlWh3H7G8evTfIEl4VJBseFqZ8LX5ZhMO5xtzo0TMa0gZz2tmzPpf+b46oXcf
        bHXliDCyVP0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7782FF322;
        Tue, 17 Nov 2020 14:09:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00E9EFF321;
        Tue, 17 Nov 2020 14:09:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <xmqq361ccvot.fsf@gitster.c.googlers.com>
        <xmqqr1ot84fr.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011171651130.18437@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Nov 2020 11:09:25 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011171651130.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 17 Nov 2020 17:10:12 +0100
        (CET)")
Message-ID: <xmqqpn4b6bru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 696D3918-2908-11EB-8B6E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 16 Nov 2020, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >    Some test scripts may require setting init.defaultBranch='master'
>> >    at the top in the 'setup' part (I've shown how in my response to
>> >    t4013 patchset) if the body of the test relies too heavily on the
>> >    primary branch to be 'master'.
>>
>> Ah, I realized we have much better mechanism already in the form of
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment.
>>
>> So, my three wishes in this message now become
>>
>>  - lose PREPARE_FOR_MAIN_BRANCH prerequisite as quickly as possible
>
> Okay, we're on the same page here.

Yeah, you may have noticed after reading my recent messages to this
topic, my initial reaction was mostly triggered by "eh, are we
losing test coverage too much?" before re-reading what the patches
(both what we have already merged and these 28 final stretch
patches) actually do, and realizing that they aim at preparing us so
that we can flip the fallback default any time we like.  So we are
very much on the same page.

> That's precisely what I do, incrementally, by adjusting that `case`
> statement in `t/test-lib.sh` whenever a range of test scripts has been
> transitioned. In patch 2/28, it looks like this:
>
> 	case "$TEST_NUMBER" in
> 	[01]*)
> 	       GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> 	       export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> 	       ;;
> 	esac
>
> By patch 26/28, it looks like this:
>
> 	case "$TEST_NUMBER" in
> 	3404|4013|5310|5526|6300|7064|7817|9902)
> 		# Avoid conflicts with patch series that are cooking at the same
> 		# time
> 		# as the patch series changing the default of
> 		# `init.defaultBranch`.
> 		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> 		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> 		;;
> 	*)
> 		GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> 		export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> 		;;
> 	esac

I actually am not a big fan of the centralized table of "these want
to run with main".  My ideal would be to have an explicit assignment
of either master or main for tests that absolutely require the
default to be one of these names at the top of these script, and any
test scripts that do not care what the initial branch is called
(perhaps because they begin by switching to a branch whose name is
picked by them immediately after they start and use that name
throughout) won't have GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME in them.

I think we can live with a centralized "case", but I have trouble
with seeing only two arms in the above case statement, whether which
one gets the asterisk.  There may be ones that need to force
'master', there may be ones that need to force 'main', but hopefully
many do not even have to force and can work with either.  And seeing
"everything else works only with 'main'" is a bit disappointing.

But if you must have a case with only two arms, i.e. "these are
exceptions" and "everything else", I think the above (i.e. we
refrain from touching these and force them to 'master' as
exceptions, but everything else is forced to 'main') is better than
having them the other way around.

Thanks.



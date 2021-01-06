Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B24BC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1312313B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 21:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbhAFVQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:16:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51389 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFVQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 16:16:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46FF0B3BD9;
        Wed,  6 Jan 2021 16:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FpCzvyj5vKFz
        zCZxyvoH2Al+Q2k=; b=jef6VJyNgg8pygaIzSaE+XxCMmQfgO8dEuUHH3ZJ1158
        BroxWrWOV8WkvDLuwpKQ9hKB+EVHWeZuSJoDQNziyL9azBXV1tVZZBhjfPxSU6zg
        NjSQ2Er3rrHOgbyoDWLDu/ZUfDApLv0ldvkIivjSB2X8wmMEseTeUsbOO9dnRq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MQKoxG
        Z8rJ1IaykiShmTNq0DLsqkvhK9rznYbgNBefFFFJ5ZLNPX0+l/sPix3SSomU0bW0
        F+cVNaGMdXevBAHVJ6+c7T2S0osOcW+JWHKNfFK5DeVxpg77DO+2jmNr/qFb0HCD
        oKKKzYCrfn4WolgKkBKcGDDJMJBUTLoJLM8DA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C064B3BD8;
        Wed,  6 Jan 2021 16:15:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4C33B3BD7;
        Wed,  6 Jan 2021 16:15:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        pudinha <rogi@skylittlesystem.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] mergetool--lib: fix '--tool-help' to correctly show
 available tools
References: <pull.825.git.1609179751864.gitgitgadget@gmail.com>
        <pull.825.v2.git.1609184505071.gitgitgadget@gmail.com>
        <20210106131651.GQ8396@szeder.dev>
Date:   Wed, 06 Jan 2021 13:15:43 -0800
In-Reply-To: <20210106131651.GQ8396@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 6 Jan 2021 14:16:51 +0100")
Message-ID: <xmqq5z49rclc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 562BEC68-5064-11EB-90DF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Dec 28, 2020 at 07:41:44PM +0000, Philippe Blain via GitGitGadg=
et wrote:
>> To prevent future regressions, add a simple test that counts the numbe=
r
>> of tools shown by 'git mergetool --tool-help', irrespective of their
>> installed status, by making use of the fact that mergetools are listed
>> by 'git mergetool --tool-help' on lines starting with tabs. Prefix the
>> `git config` commands used at the beginning of the test to remove the
>> fake tools used by the previous test with 'test_might_fail' so that th=
e
>> test can be run independantly of the previous test without failing.
>
>> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
>> index 70afdd06fa7..ebd3af139e5 100755
>> --- a/t/t7610-mergetool.sh
>> +++ b/t/t7610-mergetool.sh
>> @@ -828,4 +828,14 @@ test_expect_success 'mergetool -Oorder-file is ho=
nored' '
>>  	test_cmp expect actual
>>  '
>> =20
>> +test_expect_success 'mergetool --tool-help shows all recognized tools=
' '
>> +	# Remove fake tools added in previous tests
>> +	test_might_fail git config --unset merge.tool &&
>> +	test_might_fail git config --remove-section mergetool.mytool &&
>> +	test_might_fail git config --remove-section mergetool.mybase &&
>> +	git mergetool --tool-help >output &&
>> +	grep "$(printf "\t")" output >mergetools &&
>> +	test_line_count =3D 30 mergetools
>> +'
>
> This new test fails when the topic 'pb/mergetool-tool-help-fix' is
> built and tested in isolation, because 'git mergetool --tool-help'
> lists only 29 tools instead of the expected 30.  The reason is that
> 'pb/mergetool-tool-help-fix' doesn't include commit 6bc9082c0f
> (mergetools/bc: add `bc4` to the alias list for Beyond Compare,
> 2020-11-11), which added that 30th tool (and is already part of
> v2.30.0).
>
> It also makes me wonder whether this is the right way to test this
> fix, because we'll need to adjust this test case every time we add
> support for a new merge tool (which arguably doesn't happen that
> often, but since we are already at 30 it doesn't seem to be that rare
> either).

Yes, that is a very good point.  Also I can imagine us allowing some
tools to be excluded depending on a build/installation option and/or
which platform you are on, so hardcoded 30 smells a bit too fragile
as an approach for a project like ours.

What was the symptom before the fix?  Is it just missing only some
tools among 30?  Was there some pattern in names of missing one and
the ones that still got output?  Or was it more like "we see nothing
shown"?

Thanks.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F8AC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbiCCPXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiCCPX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 10:23:29 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B9427CF
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 07:22:42 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p8so1363149qvg.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hI3GwAPnNvmEaYqeogDX44UTXAICCal3YlxZnRxM27s=;
        b=SR/coCQuRw4yReuFUgq0DFaUfaGQZ5lRCebLe5pA2IBZH81gCB5y6LyHlpi2ngUeSE
         IDkd7ZOYvFLQen7Zj1g8i+yD7BMWjnqZ2vIWnx7HplLx0C7ZeOyyyBsUolR3V1CNMXuL
         8r/S6eJYkfWzW2GTBzhOw4N4A584cS/OtYbNuqsWuha4HNoE5ssHMB2SbIh79zql9eZF
         Iog/DFNulJ6sI0MWFYtykFkZMexszTbLGJxoSJ0IwFiXiolJD9CsPPbLR6n0dihu1O/q
         gFriFGz0dS1lHfRzYs+OoSojacwAd1olZHXx2aO+Zzsq0g81Ny/JEP4jBNOV3YP6kO4c
         CoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hI3GwAPnNvmEaYqeogDX44UTXAICCal3YlxZnRxM27s=;
        b=2ALshyDx/hD67rKng5QVoWH9Y9l76IKWWTovIRcdQFDQMNlZFerjAq4KDtYZ+kvJjS
         em3mrLZ93vAEAUmsvnn3krhCUmcFNunFRlei1ERsvymcwZNmW7cx8Gdqphx3k/eJ3OfI
         LABsp0png1XzTx6cEQH0V2KVpB8guKaphnqZCgM9ac6UpT6o25lU/KNPPM4IOqQNyIVg
         iR48ZDa6QmOaiK1uKhq+bDu1HjaahH5FQ8aD16qb6qSY0Pu4UPyRgF/xaBxzAq9qNtBb
         N/zVKKDWTYelf+jcvttszVmlkZlM6Fs46TI/Mml/ffHaZ0f87WdDnZ7vhN0ANGU4YGny
         Csdg==
X-Gm-Message-State: AOAM532VcfohHhuCy3JbgvLWQ0PnFrX8h97va5FzwlDdrlTA1PxtPm1s
        l+BgsdJ9i9MG485QyVkOjm8=
X-Google-Smtp-Source: ABdhPJzIgGjI3aavG8U7qg3ghRbBbNXT0KuT3PuDU2+GuJFyXbYsGwY6djNhQN/c/tldW6+zBnzuGw==
X-Received: by 2002:ad4:5fc7:0:b0:435:3fea:ca29 with SMTP id jq7-20020ad45fc7000000b004353feaca29mr1280452qvb.112.1646320961871;
        Thu, 03 Mar 2022 07:22:41 -0800 (PST)
Received: from [10.37.129.2] (ool-ad03998c.dyn.optonline.net. [173.3.153.140])
        by smtp.gmail.com with ESMTPSA id z14-20020a05622a028e00b002dc8e843596sm1588105qtw.61.2022.03.03.07.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:22:41 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite --updatref behavior
Date:   Thu, 03 Mar 2022 10:22:40 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <3F09AD9D-5A14-4F04-A9C5-D16C33B88101@gmail.com>
In-Reply-To: <xmqqlexsexse.fsf@gitster.g>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 2 Mar 2022, at 18:32, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> There is missing test coverage to ensure that the resulting reflogs
>> after a git stash drop has had its old oid rewritten if applicable, an=
d
>> if the refs/stash has been updated if applicable.
>>
>> Add two tests that verify both of these happen.
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  t/t3903-stash.sh | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index b149e2af441..a2f8d0c52e7 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -41,7 +41,7 @@ diff_cmp () {
>>  	rm -f "$1.compare" "$2.compare"
>>  }
>>
>> -test_expect_success 'stash some dirty working directory' '
>> +setup_stash() {
>
> Style.
>
> 	setup_stash () {
>
> but more importantly, is this really setting up "stash"?
> "setup_stash_test" or something, perhaps?
>
>> +test_expect_success 'stash some dirty working directory' '
>> +	setup_stash
>>  '
>
> OK.
>
>> +test_expect_success 'drop stash reflog updates refs/stash' '
>> +	git reset --hard &&
>> +	git rev-parse refs/stash >expect &&
>> +	echo 9 >file &&
>> +	git stash &&
>> +	git stash drop stash@{0} &&
>> +	git rev-parse refs/stash >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash wi=
th rewrite' '
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		setup_stash
>> +	) &&
>
> Hmph, so this is done inside the subdirectory.  The implementation
> of the helper in this iteration does look cleaner than in the
> previous iteration.
>
> But these many references to "repo/" and "-C repo" we see below
> makes me wonder why we do not put the whole thing inside the
> subshell we started earlier.
>
> i.e.
>
> 	git init repo &&
> 	(
> 		cd repo &&
> 		setup_stash_test &&
>
> 		echo 9 >file &&
> 		old=3D$(git rev-parse stash@{0}) &&
> 		git stash &&
> 		new=3D$(git rev-parse stash@{0}) &&
> 		...
>
> 		test_cmp expect actual
> 	)
>

makes sense to me. Is this worth a re-roll and sending out another series=
 to the list? or is it sufficient to make the change on my branch?

>> +	echo 9 >repo/file &&
>> +
>> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>> +	git -C repo stash &&
>> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>> +
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $old_oid
>> +	$old_oid $new_oid
>> +	EOF
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	test_cmp expect actual &&
>> +
>> +	git -C repo stash drop stash@{1} &&
>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>> +	cat >expect <<-EOF &&
>> +	$(test_oid zero) $new_oid
>> +	EOF
>> +	test_cmp expect actual
>> +'
>> +
>>  test_expect_success 'stash pop' '
>>  	git reset --hard &&
>>  	git stash pop &&

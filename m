Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiBWVud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241027AbiBWVuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:50:32 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246A50067
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:50:03 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id e22so480311qvf.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzMptS0GIeo3jWTbEp9zw5v5UA+p44oHQM4im6rxfVY=;
        b=jeJFqZJuqZgJAgcWD2pF7kG17YhrJzcThRMD1WFIpXbylUzG51G8wBuTLdV/i6HRkD
         DMVjX3vEeNpAd3X46e52r6iPPyF1fOcLouVaLxM4I49JLyWPc149Omik9Gc9V100E/VC
         mt0VrDu5f64fik7fniE/5Y6R6/kvNW0ZKK3O3500OUtGYdcx0AvvGD1yiDgjrsj1M6Br
         7oINnuE8YzDmZOYZID8SbTGSb+CXK2fIsp1kZXXcyr2rqfVuxsHuheRdbIIm5p9T/bgv
         0wcd/g1K0QH6ZptRUDOXyMYjvyTHXVOBUMYIA0X5fSU/0787k73IJlW9K0d/W4gVowLr
         +reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzMptS0GIeo3jWTbEp9zw5v5UA+p44oHQM4im6rxfVY=;
        b=FAhcmGyjFgWo11rfyN4MRoPa0iJImi0I6dzO5MMqIPI3kxcdEbBGU1WjmmWBehlVJ4
         iWCzI22k3tLoUnXxzfri1nn/GGcwc2oD3SX3OiXlOjTHzouxD3BA7upFJMmwDUkz/vi9
         96MGnFgsTvX8ufjFuuzjpgjOTSpRtEwe13OlvHz9bIAxrCASkqkieuWxQyi2SWnn5xC0
         40ttvWHmN1oS00SQspkfY+ai/xUGa7mL+hdIZduCm9G71TsxQ4JUzaMl89mmj0HdcxiB
         YNS/+GHMBUPlPMwRPfpKg9Y0PK85om1IcjxJY3wLem+OFcwfkB6+1Z/PXdQ75ZSRHT7t
         kdJg==
X-Gm-Message-State: AOAM530+CpMteAn2g94b72TpM5LwCVTFN2c8LMLqjGjK7P4S5+np4rLX
        r7dTU92hafF14ecrmN5xG9Q=
X-Google-Smtp-Source: ABdhPJyFCXfflCaJJZ50JHXrTmZwSJlFodz7YQ2xhYoNPy0dlFwPp/OVBfgJIJmI9tPI8inYTW4zNg==
X-Received: by 2002:a05:622a:547:b0:2dc:edb1:6c28 with SMTP id m7-20020a05622a054700b002dcedb16c28mr1788572qtx.398.1645653002921;
        Wed, 23 Feb 2022 13:50:02 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id q8sm424088qkl.65.2022.02.23.13.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 13:50:02 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] stash: add test to ensure reflog --rewrite --updatref behavior
Date:   Wed, 23 Feb 2022 16:50:02 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <8A0E2968-8324-4A73-B857-F5D8E5C5EACD@gmail.com>
In-Reply-To: <xmqq4k4ptgsv.fsf@gitster.g>
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <6e136b62ca4588cc58f2cb59b635eeaf14e6e20d.1645554652.git.gitgitgadget@gmail.com>
 <220223.864k4q6jpr.gmgdl@evledraar.gmail.com> <xmqq4k4ptgsv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 23 Feb 2022, at 16:27, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> This test was already a bit broken in needing the preceding tests, but=

>> it will break now if REFFILES isn't true, which you can reproduce
>> e.g. with:
>>
>>     ./t3903-stash.sh --run=3D1-16,18-50 -vixd
>>
>> Perhaps the least sucky solution to that is:
>>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index ec9cc5646d6..1d11c9bda20 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -205,13 +205,19 @@ test_expect_success 'drop stash reflog updates r=
efs/stash with rewrite' '
>>  	cat >expect <<-EOF &&
>>  	$(test_oid zero) $oid
>>  	EOF
>> -	test_cmp expect actual
>> +	test_cmp expect actual &&
>> +	>dropped-stash
>>  '
>
> If "git stash drop", invoked in earlier part of this test before the
> precontext, fails, then test_cmp would fail and we leave
> dropped-stash untouched, even though we did run "git stash drop"
> already.
>
> Why does the next test need to depend on what has happened earlier?

Ideally it shouldn't, but it seems like the way these test have been writ=
ten
makes subsequent tests depend on what previous tests have stashed.

I'm wondering now that while we're at it, if we should just clean up thes=
e tests
so there are no dependencies between the tests. Otherwise it's quite pain=
ful the
next time someone needs to add a test here.

We could follow the pattern in 5ac15ad2509 (reflog tests: add --updateref=
 tests,
2021-10-16), where =C3=86var set up the tests and copied over the repo so=
 each test
is isolated from each other.

>
>>  test_expect_success 'stash pop' '
>>  	git reset --hard &&
>>  	git stash pop &&
>> -	test 9 =3D $(cat file) &&
>> +	if test -e dropped-stash
>> +	then
>> +		test 9 =3D $(cat file)
>> +	else
>> +		test 3 =3D $(cat file)
>> +	fi &&
>>  	test 1 =3D $(git show :file) &&
>>  	test 1 =3D $(git show HEAD:file) &&
>>  	test 0 =3D $(git stash list | wc -l)

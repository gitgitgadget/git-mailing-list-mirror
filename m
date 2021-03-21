Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D8C433E0
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9896194F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCUWoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 18:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhCUWoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 18:44:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C3C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:44:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so17083088edt.13
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KCoOF5R8KKw9HFKuv3Ahp71dtH6nbu7KmNkh9K7ANmI=;
        b=nRlOD+qhtqcD8hloILqW/ygx6Xnz+hwWvPq69KOpvg/abmnajAxCAsMNPdgowvYAez
         JOslEJpV2swaWnvqRI0ZyYBAoaCMjuCfuf3JTqo9aAPUWQXqZbP3938qH6+PkObpL81L
         KEsPvqDUO/d7BwWPK5iYWmtnZOJxmPjJrvbXKPt9uY1bH9Z67GBokAgRbaf80Wv8BFpy
         XOh8nxIbf8eQuKa3YFqr3qV+cACM/kkH7pTISAOlL/yzmS7iTxsMUOhFiB2vlbteMPBV
         DdC/iHgGe7WGGmvnzTzET3xwpdF15M1z41Sxhca6XLFSF8NdqsXOP+IcydiSzeNXKrKe
         6oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KCoOF5R8KKw9HFKuv3Ahp71dtH6nbu7KmNkh9K7ANmI=;
        b=Ie/1et7OEBeYZNy6ELmnQ5zVBqlIqPeUxmUYLnmXJXbsFzwLKQBuyVETLu4eXww4Yy
         gld9Q67th3jTXpW5pREgjZOBoFG33NbAyo36gCzRwKP+5eg84mJycDT9jL7vzdtf7b3+
         YSxObHDPiPL1LtG0fjKTppo/vVKojcp0omt6Zbs+9QcJx5dO6O+tMtTBuZ8Mtu+U5jV7
         G7+oyxh4qqHVKVA+w4A7MAyvqvC96W7Drc4mO76vM1ItwrvL3YPDkT7tPo6iPkYAgBOe
         jk+0uyneKs0ZlXw5mHvD7kZt/qQ0400hcLF6GzST6weWHYnEv3RG0T09cad1+/X2V7Y/
         ig/A==
X-Gm-Message-State: AOAM532spkWnb55eQHiPqJfg42EhoFPQqy3tI7jZZBTcaEpMwuE03LaD
        CSwBZseFpt0IMRjku73CCTDu5H1xKIv9Rw==
X-Google-Smtp-Source: ABdhPJw0QmPzIyjHBNCGGzhMfzZny0x3EzKk0m2Xky/+pau/GU3D34NJYGCm/o1JKzzjtZwtOEQYKw==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr22646612edd.91.1616366664286;
        Sun, 21 Mar 2021 15:44:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm9448691edt.35.2021.03.21.15.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:44:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff --no-index tests: add test for --exit-code
References: <87wnu0r8tq.fsf@evledraar.gmail.com>
 <cover.1616330120.git.avarab@gmail.com>
 <a6e4ed6c3f1d37170d7e99a2fab9c90662cceb19.1616330120.git.avarab@gmail.com>
 <29da572f-8d94-000e-ffc0-fded4b56d3c3@ramsayjones.plus.com>
 <xmqqa6qw9op2.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6qw9op2.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 23:44:23 +0100
Message-ID: <87k0q0qg8o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 21 2021, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> On 21/03/2021 12:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> Add a test for --exit-code working with --no-index. There's no reason
>>> to suppose it wouldn't, but we weren't testing for it anywhere in our
>>> tests. Let's fix that blind spot.
>>>=20
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> ---
>>>  t/t4053-diff-no-index.sh | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
>>> index 0168946b639..9b7a8ebfd3f 100755
>>> --- a/t/t4053-diff-no-index.sh
>>> +++ b/t/t4053-diff-no-index.sh
>>> @@ -16,7 +16,12 @@ test_expect_success 'setup' '
>>>  	echo 1 >non/git/b
>>>  '
>>>=20=20
>>> -test_expect_success 'git diff --no-index directories' '
>>> +test_expect_success 'git diff --no-index --exit-code' '
>>> +	git diff --no-index --exit-code a/1 non/git/a &&
>>> +	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
>>> +'
>>> +
>>> +Test_expect_success 'git diff --no-index directories' '
>>
>> I assume that s/test/Test/ was not intended. ;-)
>
> ;-)=20=20
>
> Love to see reviewers are more careful than submitters' shells that
> are too lenient to allow such a test to pass before such a patch
> gets submitted.

Sorry about that, and thanks Ramsey for spotting it.

FWIW I don't think there's any shell you can run the tests with that
would catch this. We won't run the tests at all with "set -e"[1], and we
don't use "set -e" in the tests themselves by convention.

So you'll see a notice about an unknown Test_expect_success function in
the output if you're not blind to it as I apparently was, but the the
test will succeed, CI will pass etc.

1. In this case the thing holding it back is the structure of the sanity
   check added in 2006f0adaee (t/test-lib: make sure Git has already
   been built, 2012-09-17), we'd proceed if it was part of the "if",
   hrm...

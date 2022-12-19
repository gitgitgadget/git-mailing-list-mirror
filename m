Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76FC10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiLSPb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiLSPbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:31:43 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F7626A
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:31:39 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id x22so22320424ejs.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IcCRkSGvWtOGoUMUku2maqlGbiLVhRlt7evAAIPXqKs=;
        b=QfbuRV5lHS1zKSZmpkkdgMnr5oVvwNVo67sZB5sZATVavkcqJUb7KozR9Heyg2xuKq
         TJMBUOfrquPkEAUaJ67O7YjobWLmTdURtmcSqMXf4jULrWtbqHCYBAl/HDyU/0X9kqT7
         3KcHT+EdTOIRUVZOHuJbsUf0CYrXypiMbWgNZL462v/p3Xg5avJmUsHl/ino5Y5cFBIn
         jA/lrPb+Af2XkJwKnBs+Qndy2S2CZo+FJ2BRC+cNZYl4ngBml0tH60Qji36PbUOd3zGH
         TDlMbcIQM6tKuA2sOWzJyXd1Slh2FPpW3CjGZsObDE4gf4RZ46EnNsFWDOKTwjXsAN8b
         V68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IcCRkSGvWtOGoUMUku2maqlGbiLVhRlt7evAAIPXqKs=;
        b=uSFR64EkSjMIORU/oMh2gfRiMQ0NZJyu7Gx6EB4GSpoQom0BpibjgovgFCf5iOSrL/
         Bl/ym3C7RlQV5ZX4EIst0y+v/Hgt9e3hOOgVq4n9QZUMDSFcgt859X0xlI1sDzxVHz+R
         dT9P9HcMa3vfgEii+ASY2JOOWwE4YuHti3Hw+3HpymvDMnymUjyt7l0WB1f9fzPmxvfb
         lHNE+xyt0ucNoMt5ZdEOiFb2uEChV3ut6eFsrphQOespRQArSizi7I06DCKASeUna7xS
         kZDAOTyWXzeIW2zkl7V/uyubVLqRJysl5vp6BSncZq767hAIHVXMo/NuIaH8gPOquDEu
         t7kg==
X-Gm-Message-State: ANoB5plBisOO9UDnQs37ogmIHFA0qoSkzQJzcf1xLUXL90PqZIbpsnRV
        84PwZzBNWurzj405wptXIhpDYGxIo2C9gA==
X-Google-Smtp-Source: AA0mqf59IbS8YQcbBYYa4QUrDjSz/BcKlFIKPjPgyhhNjO77OeFB3EFrtSeUgS6eVBHnqunWx1do1Q==
X-Received: by 2002:a17:906:ae82:b0:7ae:4de9:68ff with SMTP id md2-20020a170906ae8200b007ae4de968ffmr35515415ejb.64.1671463897422;
        Mon, 19 Dec 2022 07:31:37 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906769500b007aee7ca1199sm4614956ejm.10.2022.12.19.07.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:31:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7I76-006blI-24;
        Mon, 19 Dec 2022 16:31:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
Date:   Mon, 19 Dec 2022 16:27:12 +0100
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221218162905.3508164-1-szeder.dev@gmail.com>
Message-ID: <221219.864jtrz9yf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 18 2022, SZEDER G=C3=A1bor wrote:

> Unlike other test helper functions, 'test_oid' doesn't terminate its
> output with a LF, but, alas, the reason for this, if any, is not
> mentioned in 2c02b110da (t: add test functions to translate
> hash-related values, 2018-09-13)).
>
> Now, in the vast majority of cases 'test_oid' is invoked in a command
> substitution that is part of a heredoc or supplies an argument to a
> command or the value to a variable, and the command substitution would
> chop off any trailing LFs, so in these cases the lack or presence of a
> trailing LF in its output doesn't matter.  However:
>
>   - There appear to be only three cases where 'test_oid' is not
>     invoked in a command substitution:
>
>       $ git grep '\stest_oid ' -- ':/t/*.sh'
>       t0000-basic.sh:  test_oid zero >actual &&
>       t0000-basic.sh:  test_oid zero >actual &&
>       t0000-basic.sh:  test_oid zero >actual &&
>
>     These are all in test cases checking that 'test_oid' actually
>     works, and that the size of its output matches the size of the
>     corresponding hash function with conditions like
>
>       test $(wc -c <actual) -eq 40
>
>     In these cases the lack of trailing LF does actually matter,
>     though they could be trivially updated to account for the presence
>     of a trailing LF.
>
>   - There are also a few cases where the lack of trailing LF in
>     'test_oid's output actually hurts, because tests need to compare
>     its output with LF terminated file contents, forcing developers to
>     invoke it as 'echo $(test_oid ...)' to append the missing LF:
>
>       $ git grep 'echo "\?$(test_oid ' -- ':/t/*.sh'
>       t1302-repo-version.sh:  echo $(test_oid version) >expect &&
>       t1500-rev-parse.sh:     echo "$(test_oid algo)" >expect &&
>       t4044-diff-index-unique-abbrev.sh:      echo "$(test_oid val1)" > f=
oo &&
>       t4044-diff-index-unique-abbrev.sh:      echo "$(test_oid val2)" > f=
oo &&
>       t5313-pack-bounds-checks.sh:    echo $(test_oid oidfff) >file &&
>
>     And there is yet another similar case in an in-flight topic at:
>
>       https://public-inbox.org/git/813e81a058227bd373cec802e443fcd677042f=
b4.1670862677.git.gitgitgadget@gmail.com/
>
> Arguably we would be better off if 'test_oid' terminated its output
> with a LF.  So let's update 'test_oid' accordingly, update its tests
> in t0000 to account for the extra character in those size tests, and
> remove the now unnecessary 'echo $(...)' command substitutions around
> 'test_oid' invocations as well.

I'm inclined to like this, as it certainly makes some examples better,
but e.g. here:

> @@ -826,7 +827,7 @@ test_expect_success 'test_oid can look up data for SH=
A-1' '
>  	grep "^00*\$" actual &&
>  	rawsz=3D"$(test_oid rawsz)" &&
>  	hexsz=3D"$(test_oid hexsz)" &&
> -	test $(wc -c <actual) -eq 40 &&
> +	test $(wc -c <actual) -eq 41 &&
>  	test "$rawsz" -eq 20 &&
>  	test "$hexsz" -eq 40
> [...]
>  '
> @@ -838,7 +839,7 @@ test_expect_success 'test_oid can look up data for SH=
A-256' '
>  	grep "^00*\$" actual &&
>  	rawsz=3D"$(test_oid rawsz)" &&
>  	hexsz=3D"$(test_oid hexsz)" &&
> -	test $(wc -c <actual) -eq 64 &&
> +	test $(wc -c <actual) -eq 65 &&
>  	test "$rawsz" -eq 32 &&
>  	test "$hexsz" -eq 64


If we have sibling tests we really should try to make these
consistent. These are still understandable, but it's rather annoying
that we aren't consistent here. I.e. we have 64 changed to 65, but not
32 to 33 etc.

I also vaguely recall (although probably nobody worries about such a
platform anymore) that POSIX utilities left themselves room to not work
on things that weren't \n-terminated.

>  test_expect_success 'gitdir selection on normal repos' '
> -	echo $(test_oid version) >expect &&
> +	test_oid version >expect &&
>  	git config core.repositoryformatversion >actual &&
>  	git -C test config core.repositoryformatversion >actual2 &&
>  	test_cmp expect actual &&
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 81de584ea2..37ee5091b5 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -195,7 +195,7 @@ test_expect_success 'rev-parse --is-shallow-repositor=
y in non-shallow repo' '
>  '
>=20=20
>  test_expect_success 'rev-parse --show-object-format in repo' '
> -	echo "$(test_oid algo)" >expect &&
> +	test_oid algo >expect &&
>  	git rev-parse --show-object-format >actual &&
>  	test_cmp expect actual &&
>  	git rev-parse --show-object-format=3Dstorage >actual &&

This sort of thing is much nicer though, so maybe it's all worth it...

I wonder though if we shouldn't just have a test_cmp_oid, which would
abstract this away, and not care if it's \n-terminated or not...

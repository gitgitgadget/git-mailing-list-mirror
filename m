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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E26C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1BE64E2B
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBOUHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBOUHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 15:07:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29070C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 12:06:52 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bl23so13226317ejb.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 12:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HKW8TBRl/FxEIWhyRsKy1HjpvW7LtWkYt0P6lO+jtvY=;
        b=nGIksfVwtWaqfobF/7ieEjxVDSKr4+MHoDFw5TgaWBpJWRLGO9qR0bd882z+dlIZIV
         K9Vr0hO21Y7ujmEDBcpQeN15Ws5duMzNPHuuoIoOg7qJGcu0OlAOT3QUFvgqJPlAJhoN
         YfpwQDc9nSOMXpXJN7uRq4Fj1btEKGHUAiHURzxYBA4TEcoQspcFaxdxdkbnPfLbiEfE
         RhfykEbnHvUP4gfg/rnnQTr4OPP+MB8AGc1ODP/7RNm0mYL3bDF+SFQAFeWIeGhGefOU
         eq73e9W+kRJXZ8pmuWpxo0yF/vJDuOnPYZsrY8kreSEVt04Ly8dXqh+YCJab3+fAA1CB
         +Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HKW8TBRl/FxEIWhyRsKy1HjpvW7LtWkYt0P6lO+jtvY=;
        b=jRveX26ol2NAeA6XzH6wsgdkIL2PaqS2MrL5vcVMhIBybEaoXxmWNfiA8n97yQ3t1C
         ADH54g8812zBSpSEk3qcgi/pugk7AKgtMaKLtkAIoD9tsASFW9t3JZyx4PhT6pCBueu7
         umLyqIYUx7UJjV2Ulwyqt8h50cjSCN8tYM9Nla+IGvbRPMf5HGDrZ3d55ZWd62T3DfFq
         MTFXhCkW6NEPYXfoNInhjCEOSdeM/kdzDVujD3nc8GaurXsHau2ShgCWL4e753NxHcc+
         /WILWMmnYMt7gK/HOZET0q5VgojlR0HLAs3cPIsXUWfT+PAFHJUqA3qXq/fY1W/hcvIP
         s0FQ==
X-Gm-Message-State: AOAM533VEC0BOcIillkj+yIZTw6/f6/nwFsVTl+kjewmfk1bVrAeQbYa
        sXcS4MNBLPEFfZX6dliFqFw=
X-Google-Smtp-Source: ABdhPJyVazFI+hg2c1jPLtxwHaEiaaETeHeZ5Q/W1Z8E9P4zUz1ncvMhsQW6rLsXWgaQWHjTF6zdFA==
X-Received: by 2002:a17:907:75c6:: with SMTP id jl6mr16724058ejc.243.1613419610840;
        Mon, 15 Feb 2021 12:06:50 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id op10sm1713295ejb.98.2021.02.15.12.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 12:06:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 12/27] userdiff tests: rewrite hunk header test
 infrastructure
References: <20210215005236.11313-1-avarab@gmail.com>
 <20210215154427.32693-13-avarab@gmail.com>
 <0f70d5e4-cf35-1e67-be02-2baf3036d471@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <0f70d5e4-cf35-1e67-be02-2baf3036d471@kdbg.org>
Date:   Mon, 15 Feb 2021 21:06:49 +0100
Message-ID: <87ft1xayee.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Johannes Sixt wrote:

> Am 15.02.21 um 16:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Rewrite the hunk header test infrastructure introduced in
>> bfa7d01413 (t4018: an infrastructure to test hunk headers,
>> 2014-03-21). See c228a5c077 (Merge branch 'js/userdiff-cc',
>> 2014-03-31) for the whole series that commit was part of.
>> As noted in an earlier commit that change introduced the regression
>> of
>> not testing for the full hunk line, but just whether "RIGHT" appeared
>> on it[1]. A preceding commit fixed that specific issue, but we were
>> still left with the inflexibility of the approach described in the
>> now-deleted t/t4018/README.
>> I.e. to add any sort of new tests that used the existing test data
>> we'd either need to add more files like the recently added (but now
>> deleted) *.ctx) files, using the filesystem as our test datastructure,
>> or introduce more parsing for the custom file format we were growing
>> here.
>> Let's instead just move this over to using a custom test
>> function. This makes it trivial to add new tests by adding new
>> optional parameters to the function. Let's still keep the relevant
>> files in the "t/t4018/" subdirectory instead of adding ~1.5k
>> lines (and growing) to "t/t4018-diff-funcname.sh"
>> If this diff is viewed with "--color-moved=3Dplain" we can see that
>> there's no changes to the lines being moved into the new *.sh files,
>> i.e. all the deletions are moves. I'm just adding boilerplate around
>> those existing lines.
>> The one-off refactoring was performed by an ad-hoc shellscript [2].
>> 1. https://lore.kernel.org/git/87wnvbbf2y.fsf@evledraar.gmail.com/
>> 2.
>> 	#!/bin/sh
>> 	set -ex
>> 	git rm README*
>> 	for t in $(git ls-files ':!*.ctx')
>> 	do
>> 		lang=3D$(echo $t | sed 's/-.*//')
>> 		desc=3D$(echo $t | sed -E 's/^[^-]*-//' | tr - " ")
>> 		if ! test -e $lang.sh
>> 		then
>> 			cat >$lang.sh <<-EOF
>> 			#!/bin/sh
>> 			#
>> 			# See ../t4018-diff-funcname.sh's test_diff_funcname()
>> 			#
>> 			EOF
>> 		else
>> 			echo >>$lang.sh
>> 	        fi
>> 		(
>> 	            printf "test_diff_funcname '%s: %s' \\" "$lang" "$desc"
>> 	            echo
>> 	            printf "\t8<<%sEOF_HUNK 9<<%sEOF_TEST\n" '\' '\'
>> 	            cat $t.ctx
>> 	            printf "EOF_HUNK\n"
>> 	            cat $t
>> 	            printf "EOF_TEST\n"
>> 		) >>$lang.sh
>> 		chmod +x $lang.sh
>> 		git add $lang.sh
>> 	        git rm $t $t.ctx
>> 	done
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>
>> diff --git a/t/t4018/bash.sh b/t/t4018/bash.sh
>> new file mode 100755
>> index 0000000000..69144d9144
>> --- /dev/null
>> +++ b/t/t4018/bash.sh
>> @@ -0,0 +1,160 @@
>> +#!/bin/sh
>> +#
>> +# See ../t4018-diff-funcname.sh's test_diff_funcname()
>> +#
>> +
>> +test_diff_funcname 'bash: arithmetic function' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +RIGHT()
>> +EOF_HUNK
>> +RIGHT() ((
>> +
>> +    ChangeMe =3D "$x" + "$y"
>> +))
>> +EOF_TEST
>> +
>> +test_diff_funcname 'bash: bashism style compact' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +function RIGHT {
>> +EOF_HUNK
>> +function RIGHT {
>> +    function InvalidSyntax{
>> +        :
>> +        echo 'ChangeMe'
>> +    }
>> +}
>> +EOF_TEST
>> +
>> +test_diff_funcname 'bash: bashism style function' \
>> +	8<<\EOF_HUNK 9<<\EOF_TEST
>> +function RIGHT {
>> +EOF_HUNK
>> +function RIGHT {
>> +    :
>> +    echo 'ChangeMe'
>> +}
>> +EOF_TEST
>> [...]
>
> That is not my dream of "simple". But I'm not a userdiff author
> anymore, so...
>
> I don't know, yet, where this is heading to what the advantage is. At
> any rate,[...]

I originally started writing this because I noticed I could break the
userdiff.c patterns and still have all tests pass, i.e. if you screw up
the capture grouping you can go from:
=20=20=20=20
    @@ -2,3 +2,3 @@ function        RIGHT   (       )       {
    @@ -2,3 +2,3 @@ RIGHT   (       )

to:
=20=20=20=20
    @@ -2,3 +2,3 @@ function        RIGHT   (       )       {
    @@ -2,3 +2,3 @@          RIGHT  (       )
=20=20=20=20
And we wouldn't care because we just "grep 'RIGHT'". In this case we
really care about the difference between "^[ \t]*(.*)$" and a broken
"^([ \t]*.*)$" so not having the tests structurally hide the difference
makes sense.

> [...] "trivial to add new tests" was also the case when each test case
> was in its own file[...]

"trivial to add new tests by adding new optional parameters to the
function". I.e. aside from the s/grep/test_cmp/ change in 09/27 the
existing tests were OK if you wanted to test exactly what they expected,
and no more.

I think it just makes sense to have a test helper function instead and
little bit of boilerplate, as seen e.g. in 14/27 and later in the series
we can add new test modes and set per-test config without needing the
top-level dispatch loop to be aware of it.

> [...] Without the boilerplate!

I realize that's a matter of taste, i.e. when to come up with some
custom format v.s. writng a function.

FWIW as someone who didn't author the format I've come across it N times
over the years and each time ended up being more confused than when
reading any custom test function we have.

For those you can usually just look at the definition/arguments, whereas
this always required a careful read of t4018-diff-funcname.sh.

I also find it easier to have one ~160 line file in my editor than ~150
lines spread over 15 files, as in the recent addition of bash support in
2ff6c34612 (userdiff: support Bash, 2020-10-22).

It also depends on how you're counting boilerplate, if you're looking at
it as a patch on the ML it would be ~160 lines of bash.sh, v.s. ~150
lines of the same content, if we're counting the boilerplate diff of 6
lines for every new file :)



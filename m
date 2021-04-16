Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E159BC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD13613CD
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbhDPVGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbhDPVGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:06:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F755C061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:06:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e7so33763010edu.10
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GD1X0+/fM+P2ctRBIs2guAk8RjVg0GzdQ6dNrqVI2go=;
        b=K6LRAjQ0I3KwNEccRXnvIiUk2DD6xCNumjNET46fQeNufZHhUdMqSikLyJwNLmJVh1
         yqIqU5/dD+fIcevv5BMCuj/eMhUel2HtqGAKjBeN7H+P8Mt6d8aRVsWOf/IUNM9Z0fAY
         uzOuSMqD2sTpIdtLrlv+zKWogSriEjVnwKcJxQBT0N2Pcd1QT14FQ5bzwMW42CKkm0yj
         8cPR6KKXxPxDq9aanyaCEBGBWFgMUlutTWMHS8rfUuj4kFm5l7B7JZUguv0soQNIZbkd
         vsxv7Wb9RIakc7UWaMTTAzBCX2/xUgJBV4jPssdlycse7zn4Zz1MnCmIfr9ITihFp5jn
         gAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GD1X0+/fM+P2ctRBIs2guAk8RjVg0GzdQ6dNrqVI2go=;
        b=WTVe+vtnCXtb7Zd7hY/dnFfaxtcvjxR77+o4HhbvjaarkifbZ81P5wUK1uQDniBy6/
         P2bvXDRcgBYqY7ZmPLMaaolyi/xMZMESk6MQqYE+VncvrXEtGCzlc1BcucAPCmN8+bRN
         CyPbSpDthLEBqEE/GEo1Ptdqxk1t6pNJs5Oj3eXXzFXUuT/M4t48ips3WoiBHvD1fSJw
         MzOjszkHB7YbxyT9U8KJ9PkofUSrWGxF/IQky85I6G5noBFLmZ8UmVUJvnvO0V4FSgMm
         WXi2tx6PqaCy9xkQyZ6Hx/aN6cF2Pd+JwDutrq360i+id0oDy2xl8dkiT5Zs6+kSk7of
         MbDQ==
X-Gm-Message-State: AOAM530Z2hDDYftp0cGuRN6Sgik6YU/BsjyxLkOGbyFDStMpMYNUBht7
        G2ppeRjozujoe51M7YolkSc=
X-Google-Smtp-Source: ABdhPJz4acIqocW/OSVKkzgCr6Wxyb/mSzVHtKmRRrUqFfaM7Y1qk4Hu1iKj/EKO1BYzePnI0avC5Q==
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr12135085edc.143.1618607175263;
        Fri, 16 Apr 2021 14:06:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e16sm407886ejs.85.2021.04.16.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:06:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
 <xmqqa6q3cn0s.fsf@gitster.g> <87blafvl49.fsf@evledraar.gmail.com>
 <xmqqh7k7qttn.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqh7k7qttn.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 23:06:13 +0200
Message-ID: <87zgxy0wje.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 15 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Apr 12 2021, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>>  test_path_is_file () {
>>>> -	test "$#" -ne 1 && BUG "1 param"
>>>> -	if ! test -f "$1"
>>>> +	if ! test -f "$@"
>>>>  	then
>>>> -		echo "File $1 doesn't exist"
>>>> +		echo "File $@ doesn't exist"
>>>>  		return 1
>>>
>>> What does it even mean to call
>>>
>>> 	test_path_is_file Documentation/ Makefile
>>>
>>> with this patch applied?
>>>
>>> If there were three files "COPYING Makefile", "COPYING", and
>>> "Makefile", what would happen when you did
>>>
>>> 	test_path_is_file COPYING Makefile
>>>
>>> (without dq around them)?
>>>
>>> I think this particular medicine is far worse than the symptom it
>>> tries to cure.
>>
>> We'll error with:
>>
>>     test: foo: unexpected operator
>
> Ah, so use of "$@" was intentional.  That's clever (I thought it was
> a common typo people make when they mean "$*").
>
> Of course, it would not work if the caller did a nonsense like so:
>
> 	test_path_is_file foo -o ok
>
> but as long as we trust that the callers would not make stupid
> mistakes, this is OK.  Is that the reasoning behind this removal of
> the BUG?

The reasoning is to get rid of verbosity in the trace output, while
still effectively retaining the error checking.

Yes you could do "foo -o ok", but as my already-on-master fixes to the
few misuses showed we only realistically have to worry about them being
used with many normal looking file names (if that).

>> I thought guarding just for the one-off development error of not using
>> the function correctly wasn't worth it, but I thought it made sense not
>> to litter all of this with:
>>=20=09
>> 	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> 	index 28b8826e565..0bd7367a07e 100644
>> 	--- a/t/test-lib-functions.sh
>> 	+++ b/t/test-lib-functions.sh
>> 	@@ -690,6 +690,7 @@ test_expect_success () {
>> 	 test_path_is_file () {
>> 	 	if ! test -f "$@"
>> 	 	then
>> 	+		test $# -eq 1 || BUG "Do not call test_path_is_file() with more than=
 one argument!"
>
> But this breaks our assumption that the caller would not be making
> stupid mistakes, so I am not sure if it is worth it.  If we were to
> have a sanity check, shouldn't we do the check upfront, like the
> original?

It's fine to do sanity checking if it's in the "else" branch where we're
already emitting an error, and we only do so in the BUG case.

I.e. if it's written like e.g. this:
=09
	test_path_is_file () {
		if test $# -ne 1
		then
			BUG "Do not call test_path_is_file() with more than one argument!"
		elif ! test -f "$@"
		then
			echo "File $@ doesn't exist"

Then with e.g.:

    ./t3600-rm.sh  --run=3D1-3 -vx

We get:
=09
	+ test_path_is_file foo
	+ test 1 -ne 1
	+ test -f foo
	+ git ls-files --error-unmatch foo

But if we, as my patch does, piggy-pack on the test-built in to panic on
too many arguments we get the much more succinct:
=09
	+ test_path_is_file foo
	+ test -f foo
	+ git ls-files --error-unmatch foo

I think that's the only trace output that matters, having "test 2 -ne 1"
or whatever in the case where we're just about to invoke BUG anyway is
fine.



=09

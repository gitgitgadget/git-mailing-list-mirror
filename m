Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37DCC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A515E61027
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhDOLdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOLdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 07:33:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8651EC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:32:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so36298992ejz.11
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=V60oHRndBRM7WI4W9G0G/WZfiCDAPtFNlG2HYUb7POw=;
        b=DJbRM/heINL5BUGSG1t2Ly6FyEKLLr6EaoSzpah2Wi7LzC4/WwMhvjwBN+PqV659kR
         s7D35WWdIbEeeLGl2HfFwtPcSf9Xd3/6jiMWrdB4pyNMrY7EtdHEp+qwAf9UKSB2aPTg
         2jRT+8CPyKLiB4DptlGV2h1O9cVnNz/fZd9BL2Qd6lC7JAwE0fTDMrXWnLMpXBhHsCTI
         +Q/ZZ7SHjk4jsaW/lCnS46vOarjjDr/KOE8ZgQDK4ymFPrbnVbtK/w4mwqfRz6WfLQxi
         DL6WY90DFdencolHfmYPsQVA7LVpYHunII7FqTwOpfoKX49p9J1emRMHNxVh22m6I1kw
         aYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=V60oHRndBRM7WI4W9G0G/WZfiCDAPtFNlG2HYUb7POw=;
        b=VI8DW6Rs4xCnXNxl1c22lKUedy/thLgKb5vaseQsfyDHOZ7rrEvVnRJeTVr/ih9XqJ
         LqRJbzoHrgzm9dI+4bdb2GILix87iB7R1e1z4megVFSMzFGqmf4w+/GFLPIQUj49KKxI
         HjChLUzSEiiiSsqxOnSMzI88ZQi0dSUNl4eNvh0rWKKvPDGSMZtwXDvJcFMRfB40WPn3
         /8Lr4HUDsVBECNtX3dVkyPS7Hgt267wAsU+tbSVI4cpOOrm20f4EGeeelnnyDShreGwL
         8ytwgM1MZt/DHP3o0mLT+HBjrAtyevFmXP5kOdm1VhgXzixnBD3NvIaXTtM5EKqrW4G3
         faYw==
X-Gm-Message-State: AOAM533S64+2lwmQUU9SN1GHufazCDIPMdGi0zA5LHddbBOXHNAN+7Vo
        IIakqd6hYOnhZuXKxBpTdpR0oFQ7Tjg=
X-Google-Smtp-Source: ABdhPJyD+v0ysau5qkts5hpb6UqYaH4zLaR/CNKS7p6PUHHbUQwv8H2PXBPAwyEJYrJfZdOOSqs3kQ==
X-Received: by 2002:a17:906:3c45:: with SMTP id i5mr2861257ejg.368.1618486359287;
        Thu, 15 Apr 2021 04:32:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ay3sm2243503edb.2.2021.04.15.04.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:32:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
 <xmqqa6q3cn0s.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6q3cn0s.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 13:32:38 +0200
Message-ID: <87blafvl49.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  test_path_is_file () {
>> -	test "$#" -ne 1 && BUG "1 param"
>> -	if ! test -f "$1"
>> +	if ! test -f "$@"
>>  	then
>> -		echo "File $1 doesn't exist"
>> +		echo "File $@ doesn't exist"
>>  		return 1
>
> What does it even mean to call
>
> 	test_path_is_file Documentation/ Makefile
>
> with this patch applied?
>
> If there were three files "COPYING Makefile", "COPYING", and
> "Makefile", what would happen when you did
>
> 	test_path_is_file COPYING Makefile
>
> (without dq around them)?
>
> I think this particular medicine is far worse than the symptom it
> tries to cure.

We'll error with:

    test: foo: unexpected operator

And then say:

    File COPYING Makefile doesn't exist

I thought guarding just for the one-off development error of not using
the function correctly wasn't worth it, but I thought it made sense not
to litter all of this with:
=09
	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
	index 28b8826e565..0bd7367a07e 100644
	--- a/t/test-lib-functions.sh
	+++ b/t/test-lib-functions.sh
	@@ -690,6 +690,7 @@ test_expect_success () {
	 test_path_is_file () {
	 	if ! test -f "$@"
	 	then
	+		test $# -eq 1 || BUG "Do not call test_path_is_file() with more than on=
e argument!"
	 		echo "File $@ doesn't exist"
	 		return 1
	 	fi

But I could do that if you think it's better.

We could also just emit $1 in the "echo". I don't feel strongly about
that, but think that's arguably worse, since having it be $@ means the
developer is more likely to notice the invalid usage right away.
=09

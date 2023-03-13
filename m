Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EFBC6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCMV4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMV4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 17:56:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F98C51F
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:56:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso2924516pjb.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678744597;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sn82k9BNKeCsED0V2rs5G+Lk79DtszI/qMNMlvtaZVY=;
        b=P/8G1ULq0/y2amL7Jgjf9jxwT03qwOYNsLt1az2o8mQkVbDM1I0wP8kCEXDeiKNlIi
         D0OiUvsG7r0GPwq2kkElozhST0CkBkh/Q9GLBpEBqGKP7+H/KfEwTGAceqmG9CednsRS
         t86kxC0vge+nq5ksYiLksCKyRlp2w1Hyyxxoq9Rb2raLi2RLrgXFY7+Hjc4pNaCuK3Hn
         TKYy60aPyINtWgsjYyYY04479LM8b0rDU0OwkYjANMuKB8tOceQPdyWYLMayGd3ie/zF
         xlPm8npvkc/l3CL6HiPG/dHHf9k6ELjjiTe2dNrjHw1Z4p2warZoQxGIXj2NN80BEsY7
         eqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678744597;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sn82k9BNKeCsED0V2rs5G+Lk79DtszI/qMNMlvtaZVY=;
        b=r+vlOay/NuHAhIo3NGFwAL3Y9JIYFeCSRp/Id9lNyaBqYBRoBrF5x+YcYkbPephYFp
         K8MPwXNZU1ejAmAS1C/T82lQNiajCoHnKDd3r58rIuBosS3FwP1eXP8605IJmUPnQTH1
         dirya3SUQMHOBbIRo3cW5tiaQusHf7HJ7BmGyaTBI79tNFoUsmVUbdQEyzD6EsLCW1Kl
         XeZkshpgM8BpeIiwrJkl37F8jFtaJvKS2yZsSG9NIpcPCXv/vorm2v9Ej4klunM4L907
         socFJl6MICv/5W5J9BGhvqxq2wERt5t5POuUU7WV0H/b5d0u8KhpUwb69qLGRuVao/5Q
         4/PA==
X-Gm-Message-State: AO0yUKW+jJNCeKbf6vAEN9NaWPmgRT7w1KrEqAIQPjZydoV/g9AuvQtU
        E3Iale3Rwm/5OvUrMF3htug=
X-Google-Smtp-Source: AK7set/yilYB3cnfOtyUR+GaPeKaoX10rXDz4qjf0qOWnAoJ9p0nkY37rqVA+tFa1z+ozdby1FBGPg==
X-Received: by 2002:a17:90a:7895:b0:23b:5454:738b with SMTP id x21-20020a17090a789500b0023b5454738bmr5776428pjk.43.1678744597152;
        Mon, 13 Mar 2023 14:56:37 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 134-20020a63038c000000b004facf728b19sm215636pgd.4.2023.03.13.14.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 14:56:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1 6/7] t1404: don't create unused file
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
        <20230312201520.370234-8-rybak.a.v@gmail.com>
Date:   Mon, 13 Mar 2023 14:56:36 -0700
In-Reply-To: <20230312201520.370234-8-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Sun, 12 Mar 2023 21:15:19 +0100")
Message-ID: <xmqqo7ows4bv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Some tests in file t1404-update-ref-errors.sh create file "unchanged" as
> the expected side for a test_cmp assertion at the end of the test for
> output of "git for-each-ref".  The filename conveys the expectation that
> the output won't change between two invocations of "git for-each-ref".
>
> Test 'no bogus intermediate values during delete' also creates a file
> named "unchanged".  However, in this test the reference is being
> deleted, i.e. it _does change_.  The file itself isn't used for any
> assertions in the test.

I think the name "unchanged" is a reference to: the state recorded
in this file is before all the interesting changes done in this
test.

So another for-each-ref, after the "lock, start a process that waits
for and then removes the ref" begins but while the other process is
still waiting, whose output is compared with "unchanged" may have
been another way to perform this test, but we have "it could be $D
that is what we want, and two plausible 'wrong' answers are $C and
undefined" that is sufficient.  So I agree with removing the line
that creates "unchanged".

The other test to the file added by the same commit 6a2a7736 (t1404:
demonstrate two problems with reference transactions, 2017-09-08)
creates the "unchanged" file in the same way, but it does get used
after running "update-ref" that is tested.  I would not be surprised
if the one removed by this patch was created by a cut-and-paste by
mistake.

Thanks.

> Don't create the unused and slightly misleading file "unchanged".
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  t/t1404-update-ref-errors.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index b5606d93b5..937ae0d733 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -551,7 +551,6 @@ test_expect_success REFFILES 'no bogus intermediate values during delete' '
>  	git update-ref $prefix/foo $C &&
>  	git pack-refs --all &&
>  	git update-ref $prefix/foo $D &&
> -	git for-each-ref $prefix >unchanged &&
>  	# Now try to update the reference, but hold the `packed-refs` lock
>  	# for a while to see what happens while the process is blocked:
>  	: >.git/packed-refs.lock &&

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F3C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13616100B
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhDOV02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhDOV01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:26:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC771C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:26:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u21so39023860ejo.13
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i0EehdW4FJjf3SaXtZtNaZ4RUzQXvnsO4qJq9RrvP3s=;
        b=uRO76NLj9aj5DU2CKvGF+yZHxuwTI45godIKiIrBzgZZ6zSpLE9DfaLHs/c50aI7QZ
         tpLPqFXi/XDcrBiVoDjqrcihH4YOkmHRWXhHrw4hN8wWLlmVa8UQb5l17sff1qUomj1Z
         UR7wcFh9K1KyBY8ooFpPn91j0fPaqjDJFvb/3pEGmnICjyYVgkkjIJQHZaTiJpuFi9Jf
         EFA7oiPLUnsyJuinOYJdSRrntrNPvsOgti9ivkemXbAxuJoH0HSJYI+q7ExZdIi6jutH
         KwGLbnzvmjnWJQbhJv/Jngk0zhQ0KvY9XP8IiBtACIeUPZzUWQWDa6sZHpyH3GqPUR9u
         VDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i0EehdW4FJjf3SaXtZtNaZ4RUzQXvnsO4qJq9RrvP3s=;
        b=N7ZnQfzvia0LxxZmW7/xrH/iVjql6NVlTg249mBUzx8cnbvH6NckNQHcCjGBh3mpV2
         L6E1c8n7BXTG24MngigCv00RbK9fWsPU+MdNAnpFnLXJkJMwHQbTwTAv+twf9OD18qxV
         RZctANki7XUVNLNYnttC+6p5ABoysZBs6EHH2BIstJsNHkYM4u7jrIUw1oV3WPmzSakP
         K8wO//53tNLDYV/Sq3VfcM5Atn2F98YadtNsmHMSF3Oe68mzw0KvYfrabtlnAgtKL9R9
         ekmDNAD8QlLF8wnwWn486RuaeroCBMOqtL6dmvuPQArffjDkfVozJkVWuI9XVwAVQS6x
         Js3Q==
X-Gm-Message-State: AOAM530oqwHv3akusmERZxGz7vLtpY8bETWUqK9m4zx1LHIDg5p57b4j
        2jKTMLXnxN+HJ/L6re2pS9c=
X-Google-Smtp-Source: ABdhPJzZiLjuV50Y1YQfTCR8v3HwHytxT8o84efLt76i6zkDFNF+qiokmIrYWkahrlf6pndFYG3xZA==
X-Received: by 2002:a17:906:170a:: with SMTP id c10mr5352052eje.493.1618521962596;
        Thu, 15 Apr 2021 14:26:02 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id q16sm3529031edv.61.2021.04.15.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:26:02 -0700 (PDT)
Date:   Thu, 15 Apr 2021 23:26:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
Message-ID: <20210415212600.GN2947267@szeder.dev>
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
 <87fszu2elw.fsf@evledraar.gmail.com>
 <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 04:55:23PM -0300, Matheus Tavares Bernardino wrote:
> On Tue, Apr 13, 2021 at 4:01 PM Ævar Arnfjörð Bjarmason
> > >> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> > >> index 67f6411aff9..228ff100c61 100755
> > >> --- a/t/t4013-diff-various.sh
> > >> +++ b/t/t4013-diff-various.sh
> > >> @@ -200,10 +200,12 @@ do
> > >>         esac
> > >>         test=$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
> > >>         pfx=$(printf "%04d" $test_count)
> > >> -       expect="$TEST_DIRECTORY/t4013/diff.$test"
> > >> +       expect_relative="t4013/diff.$test"
> > >> +       expect="$TEST_DIRECTORY/$expect_relative"
> > >>         actual="$pfx-diff.$test"
> > >>
> > >>         test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
> > >> +               test_when_finished "rm $actual" &&
> > >
> > > Nit: before these two patches, "$actual" was only removed when the
> > > test succeeded. So, in case of failure, the failed output files would
> > > still be there for debugging. It might be interesting to keep this
> > > behavior and only remove "$actual" at the end of the test.
> >
> > Either I'm missing something or you are, that's how test_when_finished
> > works.
> >
> > It's skipped under e.g. "--immediate --debug". See b586744a864 (test:
> > skip clean-up when running under --immediate mode, 2011-06-27)
> 
> I was mostly thinking about the `artifacts` zip we get from our CI
> when a test fails. I find the final trash dir quite useful for some
> post-mortem analysis, especially to debug WIP tests that only fail
> occasionally or test failures on OSes I don't have quick access to.

On Travis CI we run tests with '--immediate' for exactly this reason;
I don't know why it's done differently on other CI systems, and,
unfortunately, 'git log --grep=immediate ci/' didn't turn up any
insights.


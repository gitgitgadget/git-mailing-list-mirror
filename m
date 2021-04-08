Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E2C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AEC61105
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhDHWN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhDHWN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:13:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C25C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:13:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so5509134ejc.10
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fxMup2hQNR3YyNObyJPC9HKFHK01Cec0NMebSrn7Cpw=;
        b=TLB9DwczRr24CBqMgn+fGoqdtyNXhturjDFgD63jGcPS1mdbbJ/vsfLjt8k6pUI91y
         vLDRc4TEpaJecYcagIvilZT9r8LVE0hDV0wDfLKhdwECzvtbUoAwGbaeyah/XPPRKvrQ
         tN14gsvdq9qfEX9VyyqCsW5rIfPP26B++l23L+PZ+xocuOXdLFWOFHUulwd6L9Rmu3UM
         QhF+UE90ak09qKdEnj6MAO/YiM6pXH0stDrkL3jz+4ibAn18ZwVYbnL+tcQm3BzkETy0
         uPr3uJWhrNaIBz524+YRaXtIwC49TuUykylVmi3e9vcVFQHauR+lDHqj3gBQOBsAud5R
         Fndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fxMup2hQNR3YyNObyJPC9HKFHK01Cec0NMebSrn7Cpw=;
        b=UXOwo6VBowZqWBolxVGt29Cd+f1MQ4DVTa+SRJ9TjoVZGAzBczUl6n9Z9toLm0yDOn
         WRBlzWGRXTss8tDpGzCVdRaPI0yHw9SbLQgEmXiDuWY7cf/Aezn4gD6/5PYlg9UgMiSf
         CdzAfTwn75j1oUu6sV88NmT9P1EtIkca2Mvfa7eQXfHfmcfWSZ46ZsqFc/KHBmhATAd9
         QaAX+xixPDfUydTUl+Dmmgi+ILG3VcYPXBLmlrzNCBBHZRbqHr3wH4sJF0SM4Sv20KA6
         kt/7r+uckvOT/tUaviGrZYQGzf9VPf57PD6MNbnNGWugGCJ4Moi5DtrLaOhg7cIcGcO8
         IPwQ==
X-Gm-Message-State: AOAM531eFxSDqHbW/gFJ6C8HD4OTVUF9b9dfD44/JYn3Pd9cIWFKlVJW
        umsqW6O+f2bSj3G4N9ATYzI=
X-Google-Smtp-Source: ABdhPJxKkKJHqnz2XRmi+QvppfXLylvKI6XkFwfaVOXoY5vJ5iJkuT+vY0fQ/DIazvV3HL4bJxAjmQ==
X-Received: by 2002:a17:907:9614:: with SMTP id gb20mr13078281ejc.108.1617920025458;
        Thu, 08 Apr 2021 15:13:45 -0700 (PDT)
Received: from szeder.dev (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id n3sm297013ejj.113.2021.04.08.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:13:45 -0700 (PDT)
Date:   Fri, 9 Apr 2021 00:13:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] t9902: fix completion tests for log.d* to match
 log.diffMerges
Message-ID: <20210408221343.GC2947267@szeder.dev>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-8-sorganov@gmail.com>
 <87y2dtitlp.fsf@evledraar.gmail.com>
 <875z0wdekf.fsf@osv.gnss.ru>
 <87sg40imit.fsf@evledraar.gmail.com>
 <87k0pc7cap.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0pc7cap.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 11:26:38PM +0300, Sergey Organov wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Thu, Apr 08 2021, Sergey Organov wrote:
> >
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>
> >>> On Thu, Apr 08 2021, Sergey Organov wrote:
> >>>
> >>>> There were 3 completion tests failures due to introduction of
> >>>> log.diffMerges configuration variable that affected the result of
> >>>> completion of log.d. Fixed them accordingly.
> >>>>
> >>>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >>>> ---
> >>>>  t/t9902-completion.sh | 3 +++
> >>>>  1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> >>>> index 04ce884ef5ac..4d732d6d4f81 100755
> >>>> --- a/t/t9902-completion.sh
> >>>> +++ b/t/t9902-completion.sh
> >>>> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
> >>>>  	test_completion "git config log.d" <<-\EOF
> >>>>  	log.date Z
> >>>>  	log.decorate Z
> >>>> +	log.diffMerges Z
> >>>>  	EOF
> >>>>  '
> >>>>  
> >>>> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
> >>>>  	test_completion "git -c log.d" <<-\EOF
> >>>>  	log.date=Z
> >>>>  	log.decorate=Z
> >>>> +	log.diffMerges=Z
> >>>>  	EOF
> >>>>  '
> >>>>  
> >>>> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
> >>>>  	test_completion "git clone --config=log.d" <<-\EOF
> >>>>  	log.date=Z
> >>>>  	log.decorate=Z
> >>>> +	log.diffMerges=Z
> >>>>  	EOF
> >>>>  '
> >>>
> >>> Commits should be made in such a way as to not break the build/tests
> >>> partway through a series, which it seems is happening until this
> >>> fixup.

Well, actually no: it _starts_ to break with this patch, because
'log.diffMerges' is not documented yet, and it will pass again with
the last patch in the series that adds that missing piece of
documentation.

> >> Yep.
> >>
> >> Could these tests be somehow written in a more robust manner, to be
> >> protected against future additions of configuration variables that are
> >> unrelated to the features being tested? If so, I'd prefer to fix them as
> >> a prerequisite to the series rather than adding fixes to unrelated 
> >> existing tests into my patches.
> >
> > Hrm? I mean if you have a commit fixing up failing tests in an earlier
> > commit then that change should in one way or the other be made as part
> > of that earlier change.
> >
> > Yes we can skip the tests or something in the meantime, which we do
> > sometimes as part of some really large changes, but these can just be
> > squashed, no?
> 
> I mean I don't want this change at all.

You'll definitely need this change, though.

> I didn't change completion mechanism, so completion tests should not
> suddenly fail because of my changes.

We auto-generate the list of supported configuration variables from
the documentation and use that list in our Bash completion script to
list possible configuration variables for 'git config <TAB>' and 'git
-c <TAB>'.  And we want to make sure that this feature works as
intended, so we have a couple of tests that try to complete real
config variable sections and names.  You are just unlucky to introduce
a new configuraton variable that happenes to start with the same
prefix that is used in some of those tests.

> I did entirely unrelated change and
> noticed the breakage only by accident, as tests even don't fail unless
> you *install* git, not only make it. So, for example, just "make test"
> doesn't fail, while "make install; make test" will.

It might be related to a bug in the build process that doesn't update
that auto-generated list of supported configuration variables after
e.g. 'Documentation/config/log.txt' was modified; see a proposed fix
at:

  https://public-inbox.org/git/20210408212915.3060286-1-szeder.dev@gmail.com/

> It looks like something is wrong here, a bug or misfeature, or even two,
> and if it's fixed before these series, I won't need this in my series at
> all. Besides, that's yet another reason *not* to squash this change into
> an otherwise unrelated commit.

The introduction of the new configuration variable, its documentation
and this test update should all go into a single patch.  The whole
test suite must pass for every single commit.


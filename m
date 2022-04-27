Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F7DC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbiD0Rdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbiD0Rd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:33:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B42152493
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:30:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v12so3454940wrv.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oFTEhlEwwqiLeX8yBV9ZgJiVFTqc990Yy/Z96a7V8pI=;
        b=EIszlSdaYh0YOhD2AIQpavMOXpVc5f25bVyyR7njvWqLobHrfLdL60CudDSkh/x7kL
         /2kmaTHy7cWx3iJENNyp3hZCPq2ABiqbH/IyF/MdUlL5E8IID+a5U7ZwevSaprdms7kZ
         0IaK1XcLRF15dPkvVjSlfMM+sHSVwZZ8c9/pqeHDFbRy2TK4R+PQx9U+LGb/QMy6KFLg
         7W9lMcNF+WtE3ReMhPriUOTTymYrGkxCAFMJ0lQR6BtJtTe5eLJaFh8RbLgcs2ilF/JB
         p6U+nMzXSsAmjGMyMy/oBpYsqbYoWH9YuUzc5OVzpZFbwlj6QbDDxqpGwi4iAzEcidRs
         9UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oFTEhlEwwqiLeX8yBV9ZgJiVFTqc990Yy/Z96a7V8pI=;
        b=mvM6B7vsRCiQp/xtlLG1SAawtMNzOG119WLL9LizncFeXtJjjovptCHLOyyVKC42XU
         ztuyiGGZZjUsogUeSoP2P8mOWVpRJuQsKYRx6hBSYWLFYA7+cl7hwZBDNOhjGqLHxdBB
         TpZh/bQHX5rFbYV9E705qmoI9d1q+62n/b3SL9RgPhSCjTgxx013BBscAnoa/4g/Ao0Z
         J4RqhZF7opmtdDQz+R+lIpli61rFDd6s6Ii/CIkXVYHlXJEkdU0/JIdU7QzZFCl9heTx
         RZwvo8bZuVbCms1U4zM18POEZRZwjrQW3+lvhWqRroe076CK6W2V19xi4lNkm0GZlqCB
         yl4g==
X-Gm-Message-State: AOAM530x/iw1QMItqLDxtgdX4t6Z38g1mBec/g03c1ZgALWXgItXQkBa
        /ivKlX0znSuNEAL/Bdp2D5A=
X-Google-Smtp-Source: ABdhPJxYFqy6MsVgbZtI1JVrcrd/yPvYawbBNueVkZGpDbMcNoP5F7pu4/YeQNKGFdCN/FSkDjOA2w==
X-Received: by 2002:a5d:4645:0:b0:20a:db5d:258f with SMTP id j5-20020a5d4645000000b0020adb5d258fmr12864077wrs.135.1651080614295;
        Wed, 27 Apr 2022 10:30:14 -0700 (PDT)
Received: from localhost ([2a02:2149:8ba4:e400:b4f9:19f2:e54:30c8])
        by smtp.gmail.com with ESMTPSA id w5-20020a7bc105000000b0038eb9932dacsm1922717wmi.48.2022.04.27.10.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:30:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 20:30:02 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 6/6] test-dir-iterator: handle EACCES errno by
 dir-iterator
Message-ID: <20220427173002.srn7cidveao7pk55@compass>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-7-kioplato@gmail.com>
 <220411.86wnfvj2q6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220411.86wnfvj2q6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/11 01:04PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Apr 10 2022, Plato Kiorpelidis wrote:
> 
> > Handle EACCES errno returned by dir_iterator_begin() by printing the
> > "EACCES" string instead of printing "ESOMETHINGELSE".
> >
> > Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> > ---
> >  t/helper/test-dir-iterator.c | 8 +++++---
> >  t/t0066-dir-iterator.sh      | 2 +-
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> > index c92616bd69..fd07429f90 100644
> > --- a/t/helper/test-dir-iterator.c
> > +++ b/t/helper/test-dir-iterator.c
> > @@ -7,9 +7,11 @@
> >  static const char *error_name(int error_number)
> >  {
> >  	switch (error_number) {
> > -	case ENOENT: return "ENOENT";
> > -	case ENOTDIR: return "ENOTDIR";
> > -	default: return "ESOMETHINGELSE";
> > +		case ENOENT: return "ENOENT";
> > +		case ENOTDIR: return "ENOTDIR";
> > +		case EACCES: return "EACCES";
> > +
> > +		default: return "ESOMETHINGELSE";
> >  	}
> >  }
> 
> Please stick with the git coding style, see
> Documentation/CodingGuidelines.
> 
> It's forgivable to "fix style while at it" to some extent, but in this
> case it's both moving away from our normal style (by indenting case
> labels), and in doing so making the diff larger/worse.
> 
> This should be a one-line addition of your new EACCES case.

That's true. I should've consulted Documentation/CodingGuidelines in more
detail. I mainly copied the local style and mindlessly indented these case
labels. I'll be more mindful of the coding style. Thanks!

> I haven't read through the rest yet, but please self-review those
> patches with a keen eye to diff size & seeing if there's similar
> issues. E.g. are they the same lines changed under "git show -w", if not
> are you sure you're correct in making the style change?

That's great, I'll make the use of "git show -w" habitual.

> > diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> > index 974bb13092..4bf6456735 100755
> > --- a/t/t0066-dir-iterator.sh
> > +++ b/t/t0066-dir-iterator.sh
> > @@ -861,7 +861,7 @@ test_expect_success POSIXPERM,SANITY \
> >  
> >  
> >  	cat >expected-no-permissions-out <<-EOF &&
> > -	dir_iterator_begin failure: ESOMETHINGELSE
> > +	dir_iterator_begin failure: EACCES
> >  	EOF
> >  
> >  	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&
> 
> I see this is changing the ESOMETHINGELSE added in your 3/6, if you make
> this patch come first then presumably we won't have that churn.

Yes. I'll make this patch come first to avoid that churn.

> And if we don't have a test that's relying on ESOMETHINGELSE (maybe we
> do, but don't test_cmp it, I haven't checked) shouldn't this "default"
> case just be:
> 
>     BUG("unknown errno %d: %s", errno_number, strerror(errno_number))
> 
> I.e. if we have OK coverage here we'd presumably fail the test case
> itself anyway, so shouldn't we fail here too?

We can probably do that. I don't think we've got a test whose output isn't
test_cmp'ed anyways. There are two reasons I'm hesitant about this:
  1. I'm not sure whether or not the test suite t/ behaves correctly in case
  this macro triggers. I suppose you are positive it does since you suggested
  it. I need to check and figure this out myself because I haven't used this
  macro before.
  2. How does this improve testing? If ESOMETHINGELSE is returned when some
  other errno is expected then test_cmp will fail and the test suite will output
  an error. How will the introduction of BUG() macro as the default case for the
  switch statement in test-dir-iterator improve that?

Thanks,
Plato

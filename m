Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF52E94136
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjJFW6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJFW6g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:58:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58993
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:58:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c88b46710bso13796945ad.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696633114; x=1697237914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1uoDgCMCVGZTEw8WFjOAJlHfrAksr7KvGmurNt/q1M=;
        b=ZOLPGAfAG//McLpki09yDCHVAVfdqcNriF655RRhZsbqFlS2xRbFEtoMOE7DLJ6L2s
         4164gIZy+PMxKPVWfGCxOXbkiUrSsrd9RGfU5GlqRzjcm1aSv+E7IJ2hSmD42eHjcPn1
         z1kSDmDbxOuawlUdkR8uVnh4UfsYQULBQ+4qqRmcDgmDgTdpYaIGHcIlSWnKvCdLIZ52
         dhLU3zPmMxo1qIZlXEa1jzDwusAThT7MHOM2Qi8mmo1EjIL4LAAsAJkG/8JsgBikWPdm
         9FR91V5ySi+btkn6G8PdRFGzfm2o0yFXw4xoYjEPkOV3Q4FBc7vb7L1BBn1IVg7S2E8i
         BTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633114; x=1697237914;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1uoDgCMCVGZTEw8WFjOAJlHfrAksr7KvGmurNt/q1M=;
        b=kCz4fgOf9ice7fu2PNm+6K7D+hKVfQCYAfB8fqgxZgRlaPtuA+bTZVnjayYVTKyUbm
         9a1gKDlUWEXwgDeEso24n3wTtH1Z6j9vKVMU6eOm1xlYY60MwVaEypdkx6LvlSw5h8jG
         siw2ZraEyVAiIFTfAXwtTI2KfZWJULPH0A8Wxuxol/+wB2BiMqd6Z2HdbLwBzrPBUJXP
         zyuLxPdVOAceUEkoJkyhIYSWnws5ETwqQBLR4l4rY6VDLBeWNWEHwcyvU4OD/vrsJQjF
         /pO1Cf9hq4SkGWDdFttARd15nfqCe6OqYeyrYvixGYjaHy7UtuEtBbgVBZV7PY93a/iC
         5CeQ==
X-Gm-Message-State: AOJu0YwvHP3g7127la9KP64xMgEAjFCgocES5SB4dsvFK3cQ+FTX3E1m
        P0ngfCV7o4fislnklo35NXn1AQ==
X-Google-Smtp-Source: AGHT+IExX6DQlx51pOusBqohMcCP34fAbLKfLE2g5zRnWkJkZksBqkr5Wg2UxrBnoM6l9TTseDV0Xw==
X-Received: by 2002:a17:903:234e:b0:1c6:1fc3:6857 with SMTP id c14-20020a170903234e00b001c61fc36857mr11547120plh.27.1696633114160;
        Fri, 06 Oct 2023 15:58:34 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:41d5:64ab:795d:9f3c])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b81a97860asm4439727plg.27.2023.10.06.15.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:58:33 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:58:28 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        linusa@google.com, calvinwan@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/3] unit tests: add TAP unit test framework
Message-ID: <ZSCRFNkzXZb3fBaU@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
 <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
 <xmqq350hw6n7.fsf@gitster.g>
 <xmqqa5te0y9r.fsf@gitster.g>
 <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.09.24 14:57, phillip.wood123@gmail.com wrote:
> On 22/09/2023 21:05, Junio C Hamano wrote:
> > Any thought on the "polarity" of the return values from the
> > assertion?  I still find it confusing and hard to follow.
> 
> When I was writing this I was torn between whether to follow our usual
> convention of returning zero for success and minus one for failure or to
> return one for success and zero for failure. In the end I decided to go with
> the former but I tend to agree with you that the latter would be easier to
> understand.

Agreed. V8 will switch to 0 for failure and 1 for success for the TEST,
TEST_TODO, and check macros.


> > > > +test_expect_success 'TAP output from unit tests' '
> > > > [...]
> > > > +	ok 19 - test with no checks returns -1
> > > > +	1..19
> > > > +	EOF
> > > 
> > > Presumably t-basic will serve as a catalog of check_* functions and
> > > the test binary, together with this test piece, will keep growing as
> > > we gain features in the unit tests infrastructure.  I wonder how
> > > maintainable the above is, though.  When we acquire new test, we
> > > would need to renumber.  What if multiple developers add new
> > > features to the catalog at the same time?
> 
> I think we could just add new tests to the end so we'd only need to change
> the "1..19" line. That will become a source of merge conflicts if multiple
> developers add new features at the same time though. Having several unit
> test programs called from separate tests in t0080 might help with that.

My hope is that test-lib.c will not have to grow too extensively after
this series; that said, it's already been a pain to have to adjust the
t0080 expected text several times just during development of this
series. I'll look into splitting this into several "meta-tests", but I'm
not sure I'll get to it for V8 yet.


> > > > diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
> > > > new file mode 100644
> > > > index 0000000000..e292d58348
> > > > --- /dev/null
> > > > +++ b/t/unit-tests/.gitignore
> > > > @@ -0,0 +1,2 @@
> > > > +/t-basic
> > > > +/t-strbuf
> > > 
> > > Also, can we come up with some naming convention so that we do not
> > > have to keep adding to this file every time we add a new test
> > > script?
> 
> Perhaps we should put the unit test binaries in a separate directory so we
> can just add that directory to .gitignore.

Sounds good to me.

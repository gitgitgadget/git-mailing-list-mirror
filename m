Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CAC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 22:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjHOWzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjHOWzN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 18:55:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF2B173F
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:55:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc5acc627dso39850865ad.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692140111; x=1692744911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qlsAA1QYbglbRDhWrqHMtmpadeoKUjN5J8dj47T32VU=;
        b=uOf2VWx3wvd7g9HDIMqMTOJSXjgS/SbhRLqaPkX0v1lpzI37l6YGNoZIUOLIQeRXPZ
         4hKkgR4QgVvOWW1qnluVjfCU4TFdhZJTzaxB2ZM8uauhCJfFhIhnXgxrDrrmeZmu8QGD
         b20ywByR8MMwn9yQ51AHzSRnk3P7ohg1tJpJ+2r8TKtvOqJ0SoG/IBRK5Ya+x0dr1a6p
         i1UVSeWLP/Pr+RwjjvKzpp63kSj6MuP6PpSMZKvWLpu+DQzoCOEpYiqZ+kmvTe+uZg31
         gnrZBCQsXXEjPrk6EJF9pbiwgjY+qxEX1AiJnP1253D6kB4wBUYHvB41puDerCbUtIH+
         ZdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140111; x=1692744911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlsAA1QYbglbRDhWrqHMtmpadeoKUjN5J8dj47T32VU=;
        b=a8LEcpoQB1+uk8g85DYp0ZLMR6QjtIRTqny1IiNrpd+JKIRPOR0+WlvFF82MxTh/fU
         tBxp/Si4eXBdpS1QggZAkdQ/mSx53UqDthJKOl/bPtYvEYlJ9mc0TaRnnY6/t6uyAgMX
         wwEzUWaIKEll+8hADSvtubzf9UaRyeyVSKFqYsFqiVPqeJ6B7woR/nx+t/eNpzasCgJF
         qky/Qzfu5+raW/RwQVJChEWebQdVSr79vOqLVpiBOn7SIL9LPF2+/7noS0JDZBh2EMbG
         xFoVmhXUaCYAJTg74cEE0mW3rhrJ4XebqHdL4/dbQNmUdCZXALnsdD+jub3wOu6centZ
         tEnw==
X-Gm-Message-State: AOJu0YxbFezeyBQzyKlJG5ufH/Yn9H10o6/ryCTjTcUAdY8/KsHOlzdW
        Ji6CSo+iBxjoTcJcQlDra/CT4w==
X-Google-Smtp-Source: AGHT+IHxnMfVGOMAI35G9QelJVWOsQCOf9FwvAlJd+sAtlAEj7YAmuATwQBFH6eo7c17dywxUNdojQ==
X-Received: by 2002:a17:903:1c3:b0:1bc:10cf:50d8 with SMTP id e3-20020a17090301c300b001bc10cf50d8mr244306plh.23.1692140111354;
        Tue, 15 Aug 2023 15:55:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ee2:a58e:8d76:12cb])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001bc35b14c99sm11529477plr.212.2023.08.15.15.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:55:10 -0700 (PDT)
Date:   Tue, 15 Aug 2023 15:55:05 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v5] unit tests: Add a project plan document
Message-ID: <ZNwCSdrbuG3K/iMP@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org, linusa@google.com,
        calvinwan@google.com, gitster@pobox.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <c7dca1a805a16fd4fd68e86efeec97510e3ac4b8.1691449216.git.steadmon@google.com>
 <90651b2b-6a7a-2ed0-716a-fc87adc957ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90651b2b-6a7a-2ed0-716a-fc87adc957ba@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.14 14:29, Phillip Wood wrote:
> Hi Josh
> 
> On 08/08/2023 00:07, Josh Steadmon wrote:
> > 
> > Reviewers can help this series progress by discussing whether it's
> > acceptable to rely on `prove` as a test harness for unit tests. We
> > support this for the current shell tests suite, but it is not strictly
> > required.
> 
> If possible it would be good to be able to run individual test programs
> without a harness as we can for our integration tests. For running more than
> one test program in parallel I think it is fine to require a harness.

Sounds good. This is working in v6 which I hope to send to the list
soon.


> I don't have a strong preference for which harness we use so long as it
> provides a way to (a) run tests that previously failed tests first and (b)
> run slow tests first. I do have a strong preference for using the same
> harness for both the unit tests and the integration tests so developers
> don't have to learn two different tools. Unless there is a problem with
> prove it would probably make sense just to keep using that as the project
> test harness.

To be clear, it sounds like both of these can be done with `prove`
(using the various --state settings) without any further support from
our unit tests, right? I see that we do have a "failed" target for
re-running integration tests, but that relies on some test-lib.sh
features that currently have no equivalent in the unit test framework.


> > TODOs remaining:
> > - Discuss pre-existing harnesses for the current test suite
> > - Figure out how to evaluate frameworks on additional OSes such as *BSD
> >    and NonStop
> 
> We have .cirrus.yml in tree which I think gitgitgadget uses to run our test
> suite on freebsd so we could leverage that for the unit tests. As for
> NonStop I think we'd just have to rely on Randall running the tests as he
> does now for the integration tests.

Thanks for the pointer. I've updated .cirrus.yml (as well as the GitHub
CI configs) for v6.


> > Changes in v5:
> > - Add comparison point "License".
> > - Discuss feature priorities
> > - Drop frameworks:
> >    - Incompatible licenses: libtap, cmocka
> >    - Missing source: MyTAP
> >    - No TAP support: µnit, cmockery, cmockery2, Unity, minunit, CUnit
> > - Drop comparison point "Coverage reports": this can generally be
> >    handled by tools such as `gcov` regardless of the framework used.
> > - Drop comparison point "Inline tests": there didn't seem to be
> >    strong interest from reviewers for this feature.
> > - Drop comparison point "Scheduling / re-running": this was not
> >    supported by any of the main contenders, and is generally better
> >    handled by the harness rather than framework.
> > - Drop comparison point "Lazy test planning": this was supported by
> >    all frameworks that provide TAP output.
> 
> These changes all sound sensible to me
> 
> The trimmed down table is most welcome. The custom implementation supports
> partial parallel execution. It shouldn't be too difficult to add some signal
> handling to it depending on what we want it to do.
> 
> It sounds like we're getting to the point where we have pinned down our
> requirements and the available alternatives well enough to make a decision.

Yes, v6 will include your TAP implementation (I assume you are still OK
if I include your patch in this series?).

> Best Wishes
> 
> Phillip
> 

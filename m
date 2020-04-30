Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC04C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9CA2082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hefHYqgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD3BLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD3BLB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 21:11:01 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CEC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:11:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t20so3633129qtq.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qjNMW8tH+z+V6xhcZQ9lmI8bvYRk7MQVaHW9+2R6ZvI=;
        b=hefHYqgtmpq72F4FrKDYmRFnGzLJogMxK6vS+Xf7+maRsoNoZQJ4Sc7wtX7lQBndn7
         oohrV27mPU318F6GdmHJ2TP43sXic48C2yyB162yIJdPCFsj/cYNEj9IpZxTGXgwzrCs
         xgfk7GfBajOvbVCS6fPTRuEvN1ycyQ/5c++du/Xy25IHfZbsumS7MPPSOeOpK5POqiEV
         5TmwhupIiKmsuQBYcXdtCzheP9/9fWvyPV1CbaySagRnH9fr4j7Bs7Ygu19uQt/gJBGG
         lbO8I4ONGNf/U5l3nEZUncDHgRJD27W0Dcfythx/iApjXCMv8MnkHN+EZP0CpKZ9Iyf/
         FBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qjNMW8tH+z+V6xhcZQ9lmI8bvYRk7MQVaHW9+2R6ZvI=;
        b=t3JGuhYvx6J1k8/8yC9kCN33Pyd2JQgnwCQzskrbcD8MC+2iN4lru5nU8eR92R0rEe
         2+QsqXac4FLpQ+niKynRmus+hxzGvATldC2GdxUgmqGSQPW/ewN5Bxg5oHBh20vvgatI
         ttxriE5oEy0aTqCvj0Wkedc+9GSqz9/+biyBx9y4MHEx8daV9lqsJL753SRZIMPzYe5h
         g7nU2doMJIfWK2fkJd18hdU4SFYLPXGQIceMREvUFzRmBk0P2cHtc5lqVO+MCubgpzEo
         i0VTqntA3FjOn2PFfwjSJi+SZzzHYiMCaTpTDsuS0Mq2I3Hz4OpJENMyvh0W2eoeMp8q
         tM3A==
X-Gm-Message-State: AGi0PuZgxrtHhnv4ic+ixFm/ZOg89nZFohgIfCz9RosHoeJtSoHxOG52
        3X4Pv/rP0v2z080aUeXgOgP2zl2X
X-Google-Smtp-Source: APiQypJFF1P4brsQIyXzeTblmdhPyZPCdHDQH92hiD0IG4Q7fDyFAOwzckKkVHRPxq3/+tEMBBcD5g==
X-Received: by 2002:ac8:bc8:: with SMTP id p8mr1184967qti.135.1588209059882;
        Wed, 29 Apr 2020 18:10:59 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id i4sm641048qkh.66.2020.04.29.18.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:10:58 -0700 (PDT)
Date:   Wed, 29 Apr 2020 21:10:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] lib-submodule-update: pass OVERWRITING_FAIL
Message-ID: <20200430011056.GA3036@generichostname>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
 <xmqqpnbqw0vz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnbqw0vz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Apr 29, 2020 at 12:24:48PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > We are using `test_must_fail $command`. However, $command is not
> > necessarily a git command; it could be a test helper function.
> >
> > In an effort to stop using test_must_fail with non-git commands, instead
> > of invoking `test_must_fail $command`, run
> > `OVERWRITING_FAIL=test_must_fail $command` instead. Increase the
> > granularity of the test helper functions by specifically choosing the
> > individual git invocation which is designed to fail.
> 
> Sorry, but I do not know why this is a good idea.

This is useful because currently, when we run a test helper function, we
just mark the whole thing as `test_must_fail`. However, it's possible
that the helper function might fail earlier or later than expected due
to some side effect. If this happens, then the test case will still
be reported as passing but I think that it should be marked as failing
instead since it didn't actually display the desired behaviour.

> >  test_submodule_switch_common () {
> > +	OVERWRITING_FAIL=
> >  	command="$1"
> >  	######################### Appearing submodule #########################
> >  	# Switching to a commit letting a submodule appear creates empty dir ...
> > @@ -443,7 +446,7 @@ test_submodule_switch_common () {
> >  		(
> >  			cd submodule_update &&
> >  			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
> > -			test_must_fail $command replace_sub1_with_directory &&
> > +			OVERWRITING_FAIL=test_must_fail $command replace_sub1_with_directory &&
> 
> Here, $command may or may not be a git command and more importantly,
> it could be a shell function, right?  Then we need to take it into
> account that 
> 
> 	VAR=VAL shell_function args...
> 
> will not work, no?
> 
> Some shells do not make this a single-shot environment variable
> assignment that will not persist once the single function invocation
> returns.

I looked through POSIX specification and it says under 2.9.1 Simple
Comamnds,

	If no command name results, variable assignments shall affect
	the current execution environment. Otherwise, the variable
	assignments shall be exported for the execution environment of
	the command and shall not affect the current execution
	environment (except for special built-ins).

which makes me suspect that these shells are not POSIX-compliant. What
are some examples of shells that behave this way?

That being said, I know that we live in the real world and POSIX
standards don't justify breaking test cases. I'll reroll this to add an
`OVERWRITING_FAIL=` after the command to ensure that the variable is
cleared.

Thanks,

Denton

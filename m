Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C420C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjD1U02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjD1U00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:26:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326793
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:26:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b8b19901fso516924b3a.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682713584; x=1685305584;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IUCIAtg4f7W4isto4jFCrP9x+Rtj4hhxrsOy4gPmXg=;
        b=GC1ey08XyuIPj/Nl9zuWnATa1XBQLLLlNMmA4rgbZTxpY94zqOfAjdiJXPI1ev3dLM
         1ut1q7dX5C0FOQsChbJKU2r6god/4817EFSjMPWf9xwGuEUmy8BXFiX1Uc6H6b12bHB2
         resetQtI1Wd/ZxG6pvSpH8xv735//6ymT8vVwkqAQB5pxldqythVdhtx0AWjj9mvDQj4
         /8hIuFWtOd24+jkmvNBkOhGsWkcO7uKtngAALwizmYCEs0mjIRW3rGgsTu2+rMIBsoVn
         CiqL5VfLy5wNEy12eg3PLqQQGAgwXPn9Ssuh7T43J52A9Oh4yiTT6b0dyeX7zq6jeXsm
         BtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713584; x=1685305584;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9IUCIAtg4f7W4isto4jFCrP9x+Rtj4hhxrsOy4gPmXg=;
        b=gR2lrTQVQDnTWbCaJL7A6RyhoVQzhEj5GwFedzmNoT819xOh+zdhOU68rffKH/m2CI
         88lV9rp+tLfRju/P03CeGedOWt8RzM0s5Hhe7PduxgnYigcPcjpUsSwdUJIKFTWoOD7M
         eTYm5q9utCzdaDq5XtRWaaqw3o+uFiOPCW5SEUrr79WUkb85RcpbIh943y7RwkUvZ/Hu
         dUlwSl7djQMOm7au48IYHmBPfbGK62KtWUCkyV9L5txXJIAK0sEhqrTllTq2CFdpVEjy
         INTFUqI7oodoeJGznceWMpYXlLZAnifMMlrAT2Absg+AI5CRuJJ6i6QXzYp6MD1lpDua
         vsJw==
X-Gm-Message-State: AC+VfDyJPf+HE36bX1mneLbYvHnz7uQAhEBqkfVTFNcKobsadEqby7qp
        rp6D8QMaTnuX7PtkvqLq6/o=
X-Google-Smtp-Source: ACHHUZ7WhhBVgwvK24CZEk/lBUptW38FJW+gCQYU9so0S1S896bRHn7A7m1EGGhuE8bSYHJbHk04BA==
X-Received: by 2002:a17:902:c946:b0:1a6:e564:603c with SMTP id i6-20020a170902c94600b001a6e564603cmr7915978pla.11.1682713584440;
        Fri, 28 Apr 2023 13:26:24 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902b18700b001a814fcbd7dsm13627995plr.185.2023.04.28.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:26:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
        <xmqqttx1gcmr.fsf@gitster.g> <ZEv8AcxQW7B2H8uJ@google.com>
Date:   Fri, 28 Apr 2023 13:26:23 -0700
In-Reply-To: <ZEv8AcxQW7B2H8uJ@google.com> (Josh Steadmon's message of "Fri,
        28 Apr 2023 10:01:53 -0700")
Message-ID: <xmqq354jda8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2023.04.27 15:54, Junio C Hamano wrote:
>> Josh Steadmon <steadmon@google.com> writes:
>> 
>> > @@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
>> >  '
>> >  
>> >  test_expect_success 'safe.bareRepository unset' '
>> > -	expect_accepted -C outer-repo/bare-repo
>> > +	expect_accepted_implicit -C outer-repo/bare-repo
>> >  '
>> 
>> Perhaps futureproof this test piece by explicitly unsetting the
>> variable before starting the test?  That way, this piece will not be
>> broken even if earlier tests gets modified to set some value to
>> safe.bareRepository in the future.
>
> Actually, explicitly setting the variable here is equivalent to the
> following test case, so I'll just remove this one.

I meant explicitly UNsetting, though?

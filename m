Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81449C77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjEARVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEARVA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:21:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0ED173F
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:20:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bb01bac9so1787940a12.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682961659; x=1685553659;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnIv7RGVdDPMH86JDCBV8L93W3F50tGwln95Zm3vSMQ=;
        b=6A1NDKEJx6OaXYPw97Os5bVxed038KvyteUiCbmBV18Uknb03ikvw6WqFf4UEXogLB
         PH7juoou3kLAt6u/AAXp/XUrzqm5yitJavQpGYvJfDANLQQV6+nFiKMc2buz/lb9PZuI
         6Ym8o96GTEMGntQKgc0a3wuw4/UfNETJNie/THbqa1aHsxG99f7BqZjkgF6gnSFet4aK
         jkAPG4uE37SwX57kneCjYJQTONesr7QjNnq6u4SZkrSx7aTN6ZuBsj5LN+anxwVoLVfV
         11YIrU2GOtIP+kOWcpzxakvnzEEDq3gXnrTjjcDdSN7iwXpZJDSgnJBpdIkZAiawc6Fl
         TF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961659; x=1685553659;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnIv7RGVdDPMH86JDCBV8L93W3F50tGwln95Zm3vSMQ=;
        b=gaFYGqFabWtHpgv2Ffx43wJQ/YxvRlTHzmRNTqwfmivLZGQ7YczJoK0Fi1gq3x2TKv
         FKhiMApImKmZ8S4DILG00OSAaDoqSilxnwhJWUBoBDkrcP45BsKERrcdbLXnwpvzjCbl
         A7vYWEAPoxwmT5+O5kxNJInzoTzRqNZ2fLikdOR7mo3xkmEgOU5UECKtWKGr8gAJ7kP5
         cL475d883m9eTJiU3XBg4tN3auqQZMyqHka319ugL7oyM/MHhJZmNS3DrFEbW3uJgBxl
         byUscs6FzX1uqoFhf9TMYEZGQlr9HpWVq/t8JeqQnooQLDdbcvAIwnJBuEb2Y/23qdQ7
         EdbQ==
X-Gm-Message-State: AC+VfDxkH7Dl2qpFbX33FDCKvAlwCaAKlA9fhtf3z1B5ZBOgkPtIPLdf
        PUqBMrEkvXCbtkJ4pwHd7+wNPsAcjCFxJ8E8Av0gYg==
X-Google-Smtp-Source: ACHHUZ4IGeoBFBJVi8fFYA36AtEszDum0TNsBYgkJONzWkAuED41kurJsIM2MuTPAVzQB9Nle7yURg==
X-Received: by 2002:a17:90a:ae84:b0:240:f8a6:55c7 with SMTP id u4-20020a17090aae8400b00240f8a655c7mr14913161pjq.20.1682961659120;
        Mon, 01 May 2023 10:20:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:38fe:5256:e952:c2a3])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001aadd0d7364sm4085209plt.83.2023.05.01.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:20:58 -0700 (PDT)
Date:   Mon, 1 May 2023 10:20:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
Message-ID: <ZE/03oSVAmSFLh7c@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <xmqqttx1gcmr.fsf@gitster.g>
 <ZEv8AcxQW7B2H8uJ@google.com>
 <xmqq354jda8g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq354jda8g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.04.28 13:26, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > On 2023.04.27 15:54, Junio C Hamano wrote:
> >> Josh Steadmon <steadmon@google.com> writes:
> >> 
> >> > @@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
> >> >  '
> >> >  
> >> >  test_expect_success 'safe.bareRepository unset' '
> >> > -	expect_accepted -C outer-repo/bare-repo
> >> > +	expect_accepted_implicit -C outer-repo/bare-repo
> >> >  '
> >> 
> >> Perhaps futureproof this test piece by explicitly unsetting the
> >> variable before starting the test?  That way, this piece will not be
> >> broken even if earlier tests gets modified to set some value to
> >> safe.bareRepository in the future.
> >
> > Actually, explicitly setting the variable here is equivalent to the
> > following test case, so I'll just remove this one.
> 
> I meant explicitly UNsetting, though?

Ah, sorry for misunderstanding. I've restored the test along with a
test_unconfig line for V3; however, doesn't this just turn into a "change
detector" test whose only purpose will be to fail if/when we change the
default value for this config option? 

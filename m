Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD25C2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503ED610FC
	for <git@archiver.kernel.org>; Fri, 28 May 2021 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhE1TA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhE1TAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 15:00:25 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95425C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 11:58:50 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso1158261ooh.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 11:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4pAytLm401bGy4WMJ2SjHdbPDXLjPinEkNLJ9A44lz4=;
        b=BYwFb8rNVtLGJ7I4YwF16AH7Ekr5TX+ZXFWWcFrcXXEoBm3ifPoSeJxrVDD3k/5sBU
         zuTFs8u5iuV/Hm8/MKMVSROFAg2qa9CnuQw9rQIAVQp/W2thJnfslXeyykIH4rOvPDac
         Ju+AWePn3oe17N8SzcIcIc4iIQ3PADFA8YPuYFuZyzRTJwGx1ajWNWsvWZgYd/AVMFVe
         0iUnIw5wevfJavw34TVUhCCRi6/xkoyz3mDL7Gs3q0IWcKoVFFd7NTtxvZEaG9Nl0yKV
         w9lEqrkf7rBLhbvPz25g32QQ9PbEt4YIKGtUZ2EcuR9iutkwRSwnc83LkEB6vzJwn+kz
         C/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4pAytLm401bGy4WMJ2SjHdbPDXLjPinEkNLJ9A44lz4=;
        b=bUqu2XnyrB7+qWQv79O19ORJtmGFvFNe4nCcdCBScjlNwEVNgOIdJexBAU3ROVfAn7
         FQDhC0BzPaGN15HEW3snN9WJqcckc6idCXSJbSdXR65K0NDrRyUv0KrsBeE0uc0uHU9X
         pv5ZLhRIyf8EpTScg+uE9NDY2yABdO0xZ9Hh8bqIeeePj5d253Gu/lBVTCgs8lNS5P4D
         V8/nJKheVRWsTeaBJKg8vgZnK+Nskv3v5GFT8OnLc+MjPK275PJENfOKFIkEYgSRAFuq
         5VkVqwB7tVuzGiGnQ0Sr25EG1zrfw87dOuyPYZimx+paHaKzSw4RcC3ZO8K6WuhIAg+b
         lkDA==
X-Gm-Message-State: AOAM533nYFHBBIn93NIgU2IoBYmwGSSHyQulLML3LR3fNWNejJzvDk9N
        /nD6gVk+RGqq6no8Eyh8Vdq7BruAoqC2Ww==
X-Google-Smtp-Source: ABdhPJznzY9S0EKzEsm2gW84/YY5VF3e4p8z9AcMpIT55BdxFcZWFuFxlJ4/eLeCgmctxDHlB+K8/A==
X-Received: by 2002:a4a:cb15:: with SMTP id r21mr8034278ooq.38.1622228329861;
        Fri, 28 May 2021 11:58:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f9sm1313427otq.27.2021.05.28.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:58:49 -0700 (PDT)
Date:   Fri, 28 May 2021 13:58:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Mathias Kunter <mathiaskunter@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60b13d67cb8a7_e545b20876@natae.notmuch>
In-Reply-To: <CABPp-BEd2GAOSSAaUwMLhftiKsbFXmuszH_fXBbTY9nU=yWg9w@mail.gmail.com>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
 <CABPp-BEeqqGwN3=MbWCYnsyryBm3WoaX5GZyXTWy18UiYUT4zg@mail.gmail.com>
 <60b126e8cf42e_51908208d4@natae.notmuch>
 <CABPp-BEd2GAOSSAaUwMLhftiKsbFXmuszH_fXBbTY9nU=yWg9w@mail.gmail.com>
Subject: Re: git push doesn't use local branch name as default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 28, 2021 at 10:22 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

> > Perhaps:
> >
> > --- a/Documentation/config/push.txt
> > +++ b/Documentation/config/push.txt
> > @@ -29,8 +29,8 @@ push.default::
> >    different from the local one.
> >  +
> >  When pushing to a remote that is different from the remote you normally
> > -pull from, work as `current`.  This is the safest option and is suited
> > -for beginners.
> > +pull from (typically "origin"), work as `current`.  This is the safest option
> > +and is suited for beginners.
> 
> This is certainly an improvement.  I wonder if it might still be
> considered ambiguous or hard to parse, though.

I am sure it is, just like plenty of the official documentation.

> If so, maybe something like:
> 
> If you have a default remote configured for the current branch

This is still very hard to parse, especially since there's no command to
"configure the remote of a branch" (AFAIK).

> and are pushing to a remote other than that one

And you've lost me.

I have to do a mental model of what's trying to be said:

  x && pushed != x

If x is nil, then I can't push to it, so this is the same as:

  pushed != x

> (or if you have no default remote configured and are pushing to a
> remote other than 'origin'),

So:

  !x && pushed != 'origin'

Altogether:

  (pushed != x) || (!x && pushed != 'origin')

So:

  pushed != (x || 'origin')

And we can use an x that is more friendly to users (and there are
commands to set it):

  If you are pushing to a remote that is not the same as the upstream
  branch, or 'origin'...

> then work as 'current'.

And now I have to read what `current` is.

The current documentation is trying to replicate what the convoluted
code is doing, your version is a little better, but not by much.


This is much more straightforward:

  pushes the current branch with the same name on the remote.

  If you are working on a centralized workflow--pushing to the same
  repository you pull from (typically `origin`)--then you need to
  configure an upstream branch with the same name.

When you describe the situation clearly (and not simply transcribe the
code), it becomes clear why users like Mathias don't see the current
behavior as sane.

I'm working on some patches so the issue becomes clear for those who
don't speak user.

Cheers.

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ACAC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61246135A
	for <git@archiver.kernel.org>; Mon, 31 May 2021 21:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaVRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 17:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhEaVRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 17:17:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE21C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 14:15:54 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so12224796otg.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YqHBJPp9GFWrdtYxqWo4XFJ4812Pri1LXFuHr7MGkxI=;
        b=NBfPdSlU6MqGB29DXuTkmEmxv1zD4v9gEQddyGHRLpJKkSrQPvj3Yihb3i1PuOn+Nf
         vBaRtG3Qu6QpLHSsntSvDF5Kcgmeq+VbM12FINpiZOxwWiaCpkB4oRuNIoXx3dqAUOTc
         KXSZyvFJy8KbscgQXPM6q8FMMGVwyZRe7Klh6GaUhYiHDv7j1w/VKQl0vVMyiwEgKnM+
         4p59FDaKrYzuBg032ug14dMjvjcM5Aufe7smf1oa6U9Y/TCwOzPyMC34TJxZqm5ZQGK7
         cgb2jZscNddcOntVxvkv/MpE9zkJT7HDMC9ZXrZ/iSbP1DRbf3VJQvjfIwiccBha316w
         Zeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YqHBJPp9GFWrdtYxqWo4XFJ4812Pri1LXFuHr7MGkxI=;
        b=l6Zfrl/i/3TW7r8lNK/WFdAJYplzR0TYxoHJ9ERRlA4SMnw34EFAnrrNh2Af4sws5I
         bNp5Rm90PC1TNJfaq9483qcxBD5z7fo05/2O9CU5kMfKS8RkzPXe14jvKPininMTGAWl
         2qGaqKzmxTJXtxIh12qyug2zuTI37fef6R6ArvpNQ3us2WI2goaKYxT5wk0bVkX86Pcf
         06QRV1K0hpMuC9zposFCWQPwttUD9UzD7ZA0BMQlVefL/K3dzVZ0dHbErVUzHXgm9trq
         hX1MMSuWqNxkVOiPPCeXruuwM+6mx0KXmcVLwyxeNo2gxf7toY5/Qg+Hhyno5MAsx6b+
         mKTg==
X-Gm-Message-State: AOAM531xaVS2kXdntOEoGgMGBKz9yY8yynPt9VLGtJcH3sH+Cv1CbkG3
        MgD8gNbcOQsyXoJNFlK5ndw=
X-Google-Smtp-Source: ABdhPJyrplBrBSV5LfNmBgCE8uuVU/+K+EXb4Sg5aKME+VrlfzA6GDUHAGbhHZM6Qj8PJfExotZgcg==
X-Received: by 2002:a9d:69c2:: with SMTP id v2mr18624413oto.186.1622495753480;
        Mon, 31 May 2021 14:15:53 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r2sm3289531otq.28.2021.05.31.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 14:15:52 -0700 (PDT)
Date:   Mon, 31 May 2021 16:15:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b55207adad1_36bff208c9@natae.notmuch>
In-Reply-To: <c4bb335c-4909-8525-cbdb-bb214d18d8fd@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529071115.1908310-7-felipe.contreras@gmail.com>
 <acfafe6e-b0f3-ba2e-71f0-9bcc09b9d612@gmail.com>
 <60b3e2ceee840_ee4c20823@natae.notmuch>
 <3e5c2303-030e-928e-af57-8e2be8f3ce86@gmail.com>
 <60b4fd4db5dee_24d282088c@natae.notmuch>
 <5fa7e3f4-60a0-c3b1-83f2-054ed38e5683@gmail.com>
 <60b51d6c93c7d_279c820856@natae.notmuch>
 <c4bb335c-4909-8525-cbdb-bb214d18d8fd@gmail.com>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Am 31.05.21 um 19:31 schrieb Felipe Contreras:
> > Once those patches are merged, then I will probably send the one to
> > change the behavior.
> > 
> > I will include you in the Cc list when I do so.
> 
> Thank you very much.
> 
> > In my experience you need to convince either Junio Hamano, or Jeff King
> > for any change in behavior to happen, and until they do comment on this
> > one it's fair to say it won't happen.
> 
> I assume they are on this mailing list?

Of course, and they are also on the Cc list of this mail.

> I'd say it should be quite an argument if the related StackOverflow 
> question dealing with this exact issue is one of the top-voted git 
> questions of all time. [1]

That seems to be a different issue. Related, but not quite the same.

That question is answered at the time the user tries to make a push:

  fatal: The current branch fix-1 has no upstream branch.
  To push the current branch and set the remote as upstream, use

      git push --set-upstream origin fix-1

That's literally the top answer in SO.

> It seems that millions of developers (judging by the number of views of 
> that question) wonder what they need to do so that "git pull and git 
> push will work immediately" on a newly created local branch.

Yes, probably many people do wonder that, but not necessarily all of
them (at least of the ones that participatd in that SO question).

> If that would "just work" out of the box and with the default settings 
> of git, without having to read up the solution in StackOverflow first, 
> then it would certainly be an improvement for a huge number of people. 

I agree, but I have already tried to improve the interface in a number
of ways to no avail.

Inertia is a powerful force.

We'll see how this one goes.

Cheers.

-- 
Felipe Contreras

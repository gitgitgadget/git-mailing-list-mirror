Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF28613A9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFQOV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhFQOV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:21:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C723C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:19:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so6296835otl.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ONSXqYkZD0O9CqBBSt0DfJvRskcKCEvBKtLFtbp48p4=;
        b=opRVbjEFmmwXh5VbpxbAIQujM1uKG+gVfOSZiwfxUF62uSFI/qDz+sYV3QsWetCUv/
         flwFxFBFI29p+LeWNlaPasdP44iCHmLLvOv3HsAh6FTGCQtYjHamLED7K9AkrhumzM9U
         2XVRkS7Vo/IVmc6YKW9m29HBmwPCAwcZtkYKVqVMoVA3hGGo2LIi/nXBAAR/F7gSjKmj
         T4I/F7iAhRzpHjWkqIqfFgQCUy9+XBo2f6zSM8dhtutc3PA/MfmNYqz+bkNlXpNG9qru
         bGyGOb+Clwco/+jlIrCnbtdB4jHGyCbdsVs5vQ0IqbJ5TyqSvcpx4jBVaTp8MnF+rAVd
         LfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ONSXqYkZD0O9CqBBSt0DfJvRskcKCEvBKtLFtbp48p4=;
        b=LQsb1oqaIwWr3ffJW5GCDVA7IcZgcRIqBjvcyYBGvlbPAGkAQJPMjlveKmYzREHGVH
         mAU5DhIPlmi7CVwXRqlWPNJneXX4Fh8xbf60v5HdJ4Gi+WPToVpRGQlmjONavqNu1kLn
         iO86o0aw2UvEwR265pAjNbeVFoEW4tNwTmD246BI9GSWUD5/ef67U2jsRSy/7F697Xmw
         dOwfvG4DwaGYip7bnvrlc/uLVUoEa2d8/4vE+N/EmcqZdeWm4gwTkOs8t54XbpOgF5l9
         VNClk3gNobwWpQ1X+J40wUzAPXynSZX6RRYEKa05CLLxWmCD9ew884qLw2rlnBQTAyEY
         pAYg==
X-Gm-Message-State: AOAM532XrX7MbtZOAaUou8H7eIYyQfphDXd/fPjq790ND7L4eNyaVTre
        JvlMhmy53yEqx+zuXbldyAU=
X-Google-Smtp-Source: ABdhPJybOgoVfKQjbuIdtFw4xcLTXoh6aOVjCGku9Zwv3JJ/UvCN9XvXW/miU3zkl6BC7+Je0Y0BTA==
X-Received: by 2002:a05:6830:19f4:: with SMTP id t20mr4913493ott.103.1623939588786;
        Thu, 17 Jun 2021 07:19:48 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q11sm1173170ooc.27.2021.06.17.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:19:48 -0700 (PDT)
Date:   Thu, 17 Jun 2021 09:19:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60cb5a02f1b31_1259c2086f@natae.notmuch>
In-Reply-To: <CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com>
References: <xmqqr1h1mc81.fsf@gitster.g>
 <CABPp-BG53Kd7MhzE3hdq5fjBQVV2Ew3skcUCAuTfM5daP2wmZA@mail.gmail.com>
Subject: RE: Contributions which I feel are dangerous and/or deceptive (Was:
 Re: What's cooking in git.git (Jun 2021, #06; Thu, 17))
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> I hate doing this, but...
> 
> On Wed, Jun 16, 2021 at 7:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > * fc/pull-cleanups (2021-06-15) 3 commits
> >  - pull: trivial whitespace style fix
> >  - pull: trivial cleanup
> >  - pull: cleanup autostash check
> >
> >  Code cleanup.
> >
> >  Will merge to 'next'.
> 
> Please don't.
> 
> Let me quote from four recent emails, three of which will look
> unrelated at first, and then I'll tie it together:

This is called an ad hominem attack: you are attacking the person
submitting the patches, not the patches themselves.

Do you see anything wrong with these particular patches?

You are mentioning another completely unrelated thread with completely
unrelated patches. I already said I did my best on that other thread,
and I wished you good luck with those patches.

Now you are coming here to personally attack me. This is harassment,
and it goes against the code of conduct.


These are examples of what constitutes positive behavior:

  * Demonstrating empathy and kindness toward other people

This is definitely not happening from you.

  * Being respectful of differing opinions, viewpoints, and experiences

You are disrespecting a differing opinion.

  * Giving and gracefully accepting constructive feedback

You are not giving constructive feedback.

What do you want me to do with the 3 patches above? Be constructive.

  * Accepting responsibility and apologizing to those affected by our mistakes,
    and learning from the experience

I believe your personal attacks merit an apology, but I'm not even going
to request that, all I wish is that you focus on the patches at hand.

  * Focusing on what is best not just for us as individuals, but for the
    overall community

You are not doing this either. Forget about me and think about the
community. Do you see the patches above helping or hindering the
community?

If they hinder, please state how, and I'll fix them.


Examples of **unacceptable** behavior:

  * Trolling, insulting or derogatory comments, and personal or political attacks

This is a personal attack: it's directed towards me, not the patches.

  * Public or private harassment

This is public harassment.


I have a pretty thick skin, and I rarely do use my emotions for the
basis of anything, but your personal attacks are draining me
emotionally. I receive personal attacks in a multitude of media, but I
did not expect them on the git mailing list, and especially not from
you.

I have no problem soldiering through personal attacks if doing so is
going to result in a better outcome, in this case better patches. But I
don't see any better outcome on the horizon. These personal attacks are
gratuitous.

Once again, please focus on the patches, and I'll be happy to address
any and all of your concerns.

Cheers.

-- 
Felipe Contreras

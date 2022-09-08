Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC4C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 16:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIHQ5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIHQ4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 12:56:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3CF1AF0D
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 09:56:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k19-20020a056a00135300b0054096343fc6so1280524pfu.10
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VYbf1OPNzZPodamv98BL4lGNUh1u+yt/W840k8FFYL8=;
        b=cHTp9GFKeQggHEUsz0oe3DiSU6cGzy0/uVLWu/R9+FH+a9ifMVosNSOB1uynXCx6hO
         J0OPtZzhZqyUT53IfhkL4IYHJO0cNmKwdwZ/3XKYwEnu2BKr4vkIe2RC6u4RfFYYFn/+
         s+d6pp0cc0fOp0M/pbzEdHj2Dzv+1WI86fCp5jNw40LNL+6zcdwg5CcsuJO6Xc33prrE
         03iVdF0Lyiv1vUMk/n9kWkYYMNSDbeBRy3ygSt6j+iyKyV18JYKkdIv2DlAypdToOsol
         wtuZBjJczYiwNcFrNv0Ns2/LWx/TFa4aOwgfKL63CqFB34sUgh4qPInkZaVUKG65xPu+
         rn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VYbf1OPNzZPodamv98BL4lGNUh1u+yt/W840k8FFYL8=;
        b=PokyC+H2sGAXY8sWuQfQoTyrnKPrRxvVcvN+HnN8FHKSL7SB5KHOz3mdZ4+wJ9Extz
         0fc3L6xDD7JK5VKjFMaLsOjXUe3Z9OJmiXebYedIWGH9KoZ52gyJ9D4AWViGJHqWKm4B
         1FETPI43bAjpueKEjMiegfDbdkOQ4r9VGZlo2dB8Og26Kfp1/Hj3gdYUkKLYjo4q+Q+m
         1lJYsGhsNiO/dXSXXh1u0onZsv68sA6u03+xL0lihM3tAD2/qb5CqvEENYHdGdISEF8v
         OLZSk1Ch+GUrPeY0H5WrkeitbNjDcxOUaROpLv2GPk12YZF6IGOzvvfzGIgayXQyEq3b
         51aQ==
X-Gm-Message-State: ACgBeo1JXuXckKCnbradhyXxSl+dHKt7V1RhGBiykwDHAMOQxxhA7mqu
        nlyWx34VSR+UBvLmtpP/a0eQc6Rq+cnLGA==
X-Google-Smtp-Source: AA6agR502Yw5fg+x8Xc82A+WXpPlm440WdcvaNi84RZNzVJvv6DtiTfxxnMisiE+7zBYaZxALHBthlDNu+TNYg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP
 id c6-20020a056a000ac600b00530319748b6mr10016356pfl.80.1662656197094; Thu, 08
 Sep 2022 09:56:37 -0700 (PDT)
Date:   Thu, 08 Sep 2022 09:56:35 -0700
In-Reply-To: <aeb235f7a914539ad50eff96479106f8c8ec8d48.camel@scientia.org>
Mime-Version: 1.0
References: <4e9ad5486e8a887f1e92cc4e401ca61be5f2bb9a.camel@scientia.org>
 <6sq30r84-1s65-91n4-5qoq-23s9q433sno1@tzk.qr> <c209dc21f6826bbb60d75450e6f7f9ff2258d18c.camel@scientia.org>
 <4697o162-0pop-4715-150r-2317p0n69581@tzk.qr> <aeb235f7a914539ad50eff96479106f8c8ec8d48.camel@scientia.org>
Message-ID: <kl6ltu5h954s.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: status on security of embedded repos?
From:   Glen Choo <chooglen@google.com>
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christoph!

I'm the original author of safe.bareRepository. I didn't chime in
earlier because I didn't have anything to add on top of Johannes'
excellent answers :)

Christoph Anton Mitterer <calestyo@scientia.org> writes:

> Hey Johannes.
>
>
> On Tue, 2022-09-06 at 15:56 +0200, Johannes Schindelin wrote:
>> But libgit2 and JGit, two separate Git implementations that are in
>> wide
>> use, too, probably do not have support for this.
>> 
>> In other words, users of libgit2 & JGit will likely be unaffected by
>> setting `safe.bareRepository` and sill still need to take manual
>> precautions.
>
>
>> If you are using applications based on those projects, you might be
>> interested in porting support for `safe.bareRepository` to those
>> projects
>> and contribute the enhancement.
>
> Well I'm not really in any way experienced with git's code ... so I'm
> rather just wearing a user hat.
>
> Wouldn't it make sense if someone really experienced within git
> development to kinda follow that up for other projects, too?
> Sure, it's other projects,... but still, the vulnerability seems rather
> critical and many people using git also use such things like libgit2
> (potentially even without knowing).

In a world where we had someone who headed all of the Git ecosystem
making these decisions, that sounds like a great outcome. Unfortunately,
I don't think such a person exists.

Perhaps this sort of "really experienced person working with other
projects" has happened before (I'm relatively new to the project), but
it sounds very very difficult to do in practice. For example, you'd have
to answer questions like how do we know which projects to engage with? 
e.g. we'd probaby need JGit and libgit2, but what about smaller
implementations like gitoxide, editor plugins, and the long tail of
other projects in the space? The technical fixes probably aren't hard,
but communication and collaboration with so many projects sounds really
difficult.

> I can however open a ticket over at libgit2, if that helps you.

It would help all users :)

> Also, even with default settings, git, AFAIU, would be still vulnerable
> for the majority of people (many of whom likely haven't even heard
> about the issue).

Yes. We've talked earlier about finding a safer default for
safe.bareRepository; but it hasn't been highly prioritized. Feedback
like yours is very valuable because it gives us a sense of how important
this is and can definitely have an impact on prioritization.

>> 
>> Yes, indeed, `.git` entries in Git's tree objects are forbidden.
>
> And I blindly assume that this is not only checked and forbidden when
> trying to commit, but also when cloning/fetching/etc.?!

Yes, the checks are quite extensive :) `.git` isn't allowed in the
index, so you cannot checkout a `.git` anywhere.

>
>
> Thanks for your answers :-)
> Chris.

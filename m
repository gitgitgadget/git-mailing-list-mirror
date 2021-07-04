Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536D8C07E9B
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3801D613B1
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 17:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhGDRZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhGDRZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 13:25:55 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B512C061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 10:23:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so3752486otp.8
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JK9V7Y4+uOC0ea1jMz0CtVrkAbn0yhHWvyaFqf4xKEQ=;
        b=vUdttkDFLXKBV71O+39LDCIiGkDzmjQOfdMnxUUapgUUwovLulV+OIXSRgM0Y7+ZTw
         Wd56wY33PN5hLVxQCedyKs6ELfP8kyqctmM91k13GPatiFhsw+AC4DJCollOP+kDcHiX
         NTh1hE2rurQMkTMpX+uwg+UQWLbxfPl0t+7FskaN+xcOp3VQCSp0FiKrRN2cHFqdKlgv
         4HoBlPgn/yRnYRGSvc9rbJL60QemSJ651fVDOXrGwFp2NdRVMojIOXqOIQ6gYJy6uhpG
         Pgds0gS7puGIP/dBMm42g6A7LCSeu3kXAl+TsvhPTWLj2GZdLGirvj4bcGUitFi5Ox5j
         zPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JK9V7Y4+uOC0ea1jMz0CtVrkAbn0yhHWvyaFqf4xKEQ=;
        b=uU3/p2/OW6BECO+tlg1zjZj3HDFcQ/FPVNuvHGFsvX4uYmr8mg558X/Zo9N+yBoEg5
         Kn5qVWI/8d+WaVKvINsOBim+CxPbUTFpzI0m055CV8wZhFUmNVPZDwHAmz/SAV7pPTGD
         g6uKwznj+/0t9rVj0x5hQe3/c4G3k9IDmJgowZEUlkHm/nW82J6fUdEyEj+Gg+NnUQIM
         /G+F7i59T27xKANpXKzFJIZozFASaCv4N6u39FQkpgzCtasktycB1R2pynvuTjU7Wm1X
         vct8rtVEhi9dLm1NTmxQFtV38XadxJ4derbQf+Hg1FEQMOURdg6HADKRnZEggk3WRPhm
         Womg==
X-Gm-Message-State: AOAM530fpJPH+4fTpynFggwU0YwVhCeNKmsWe2+yDmvQ4Xx0L+kCyOhb
        wK1RfZ4K+8PW1vYNcRK7U6/1EjSinon1SA==
X-Google-Smtp-Source: ABdhPJxMNgsHWKFyZcFuJg34pxf9vgm6A30PP6XQeLlxAUKlxPGdFFvthJTM6iLtbDfMjR/XtjyIfA==
X-Received: by 2002:a05:6830:314b:: with SMTP id c11mr7758532ots.358.1625419398024;
        Sun, 04 Jul 2021 10:23:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l10sm2043005oti.9.2021.07.04.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 10:23:17 -0700 (PDT)
Date:   Sun, 04 Jul 2021 12:23:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Git List <git@vger.kernel.org>
Message-ID: <60e1ee7a3cfbc_6d11d20811@natae.notmuch>
In-Reply-To: <YOEEjwbMPRmWOmrM@mit.edu>
References: <60df97ed24687_34a92088a@natae.notmuch>
 <C19D6C61-D62A-4344-BA1C-A532EB4FEFFE@gmail.com>
 <60e0a9707e09a_2f7208f2@natae.notmuch>
 <YOEEjwbMPRmWOmrM@mit.edu>
Subject: Re: The git spring cleanup challenge completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o wrote:
> On Sat, Jul 03, 2021 at 01:16:16PM -0500, Felipe Contreras wrote:
> > Atharva Raykar wrote:
> > > I can imagine aliases like 'co' only adding to the overload of
> > > information if an instructor is not careful. FWIW, I have never seen a new
> > > user complain about the length of the typing, it's usually with the plethora
> > > of unintelligible (to them) options that each command has when they open the
> > > Git man pages, which adds more fear.
> > 
> > This is one of the reasons I suggested to split git into two binaries:
> > git for normal users, and git-tool for all the plumbing not many humans
> > use.
> 
> It might be that the answer for the problem Atharva has described
> would be for someone so include to create a new front-end to git ---
> call it "sg", for simplified git", or "gt" for git tool (different
> from the "git-tool suggested by Felipe), etc.
> 
> It could be an extremely opinionated subset of git's functionality;
> for example, it could be one where the index is completely hidden from
> the user, so you never need to type "sg add" when modifying a file,
> but only when adding a new file to be under source code management
> (e.g., that "sg commit" would effectively imply "git add -u ; git
> commit"), and so on.  Since the index doesn't conceptually exist in
> the sg interface, then "sg reset" would only have the meaning of "git
> reset --hard", etc.
> 
> By definition this simplified front-end to git would have a subset of
> the functionality of "full git", but that's OK.  The whole goal would
> be to make something super newbie-friendly --- the equivalent of a
> "Mac OS-like" interface, that perhaps doesn't have the power of
> someone who opens up a shell and uses tools like awk or perl, but is
> good enough "for the rest of the human race".
> 
> Note that this doesn't have to be an official "git" ccommunity
> initiative; anyone could try to create such one of these things (and I
> believe a few things exist already).
> 
> Making it a non-goal that this "user friendly" front end doesn't have
> to have the full functionality of git, and its main goal is to allow
> the use of different user interface design choices made by git, might
> be much simpler than trying to change git, which would require having
> the argument over which functionality is used by "normal users", and
> which features should be exiled to "git-pull" as being "fringe"
> features.

I think there's some value in that idea but that doesn't solve the same
problem my suggestion solves. Basically there's too many commands in
`man git`. Splitting the git binary would allow us to only put the
important commands in `man git`.

I think having too many commands overwhelms many newcomers, because they
don't know which it's important for them to learn and which are
basically noise.

-- 
Felipe Contreras

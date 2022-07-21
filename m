Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB2C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 02:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGUCD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 22:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUCDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 22:03:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A576E97
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 19:03:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g1so354170qki.7
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSBVUYhJmzsCWoVf31+prtSUTCGNMAxdPH0Ru2hp7f8=;
        b=osi7N2dN5c6ab48MoDMi8n+mwrIKELnv14WiJoeXX6pzpyfDOxtyNoIzoEXF4yycm5
         Nrf3EflgBcjIJoxQwADnca1EVhOqYlahElRW8R+dlz3dmOUtZ4nAVF8chpW/CJuk6O1y
         0YaAE+7nEMwZe/CvuWn7Vt3Au6ERksAEQrUGMGtQYiRgE9gPrbbM+9hvalsUHMxgKylK
         EAUYUukGCplbfzYL30uwQMCKBdlfjNu2Rq0IKr+5InDQI7VGk+47wMghIJTQ8+fbc7CJ
         +TsKI1noCPp8MEk5fphM0Hbn2hwib1n6LByQICqaJu2lj0Hflk6k/QFUaY8uWyu3Mp0b
         7Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSBVUYhJmzsCWoVf31+prtSUTCGNMAxdPH0Ru2hp7f8=;
        b=SgByv0KGPALQi2UQTkX3RI4n6rPi7Yy0HbolUG+SMzzBASo7i1H6CmooozmDKx3SWZ
         Eh+4qwWOSDlLju50ckY/dPkDzjJ0hXHFanlWuAqYZ2o/UNMgj8cvSVCFPt5WKVGXF+bF
         jW7+mNiVaU8nhW4YatfoBY+69koCmGjWV2vxd/LiRMUql8uRtxqbq3yPMvYsdj+/w9yb
         0ziC4wCM1Wnfq5A/kshZZS/H0GpivEj859LTNb4cC0gTcItR5SLMLV0pwRtQrMasrVGt
         HMjmzhOkyi9B3FwmEQfxj/8pQG9NUYkADvZtYA4TYhrp78PiultXfSV6JdrAJ/2MbsDm
         Yg2w==
X-Gm-Message-State: AJIora81YTpjJluicavtHXIJnzIVfswdXv+0epz5QF7jPBssGJzpZL4H
        d82+EdGl3MQ0jw0Gfsz0g0Io6LC1wdcFBhu3qkc8U3OecVo=
X-Google-Smtp-Source: AGRyM1t/qz0xwXgK/GYjNneKRzKypdtlIFAFHGEzRuaGJq6FTtj06rLFu+tD6cFQhp+kHO2ZkNZOS5Qaw00fAakJO20=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr11296220qki.131.1658369004108; Wed, 20
 Jul 2022 19:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <a03075167c1f4410a1b4f415313f11a7e1c3a594.1655621424.git.gitgitgadget@gmail.com>
 <xmqq7d487lsq.fsf@gitster.g>
In-Reply-To: <xmqq7d487lsq.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 19:03:13 -0700
Message-ID: <CABPp-BH0kWHNtwjX7HsBztP_MRB3xEQsGNmZzNj-WGxFTYuhfQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] merge: ensure we can actually restore pre-merge state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 3:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Merge strategies can fail -- not just have conflicts, but give up and
> > say that they are unable to handle the current type of merge.  However,
> > they can also make changes to the index and working tree before giving
> > up; merge-octopus does this, for example.  Currently, we do not expect
> > the individual strategies to clean up after themselves, but instead
> > expect builtin/merge.c to do so.  For it to be able to, it needs to save
> > the state before trying the merge strategy so it can have something to
> > restore to.  Therefore, remove the shortcut bypassing the save_state()
> > call.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/merge.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 2dc56fab70b..aaee8f6a553 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1663,12 +1663,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >        * tree in the index -- this means that the index must be in
> >        * sync with the head commit.  The strategies are responsible
> >        * to ensure this.
> > +      *
> > +      * Stash away the local changes so that we can try more than one.
> >        */
>
> The comment explains why we limited the save_state() to avoid wasted
> cycles and SSD wear and tear by looking at the number of strategies.
> But because we are removing the restriction (which I am not 100%
> sure is a good idea), "so that we can try more than one" no longer
> applies as the reason why we run save_state() here.

I should probably change it to "Stash away the local changes so that
we can try more than one and/or recover from merge strategies
bailing".

In regards to the "good idea" side, I don't really like it either, but:

  1. Merge strategies are allowed to make whatever changes they want
to the index and working tree.  They have no requirement to clean up
after themselves.
  2. Merge strategies are allowed to bail and say, "Nevermind, not
only can I not successfully merge this, I can't even leave conflicts
for the users to resolve; I just can't handle it at all.  Try some
other strategy."  (See the "exit 2" codepath of commit 98efc8f3d8
("octopus: allow manual resolve on the last round.", 2006-01-13), for
example)
  3. Merge strategies can bail with the "try some other strategy"
response _after_ mucking with the index and working tree.  octopus
does (again, see the commit mentioned above)
  4. builtin/merge.c previously would _only_ cleanup for merge
strategies if there was more than 1.

This combination is clearly broken.  We need to fix either item 1 or
item 4 (or maybe item 3?).  Since 1 might run into issues with
user-custom merge strategies which may have been written to mimic
octopus and thus rely on the assurances in items 1-3 above, I figured
fixing item 4 was the easiest.

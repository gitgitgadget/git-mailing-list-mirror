Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE9C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiF3Aol (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 20:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiF3Aok (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 20:44:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824332EFF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:44:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so661464wmq.0
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 17:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGKZC8Yk9a4K1xQUIR32NKLL+a1T4QuK8qDvY9ng/Tg=;
        b=l4r1AIDY4RTbdKSBNVvoeuhG8spZeIHoBbOgbnGIyLghnzlkX1ytReZeUS+j+ac6Gl
         r4TJRYEa/LQL+RhFGmUUtjEPaIRxpeelXyfYzqVYCN5oE8nvq/DlPbc6oMfeVJaO9AJ+
         m4pvtonxKUHBvRy7cnDou9RCLRnIYOpjeZYufTwENZjGsliUXjGknSC+dixd+0TMGsD8
         wOiLfs3OtcenjO+w2KMioFtHYt6sBPvwx2tOKtFx/k19wdgfCddxg5FQ6A1fI6afjIMF
         Jg0w+CTx2VXsK4Kf1DVqENQ9H/RHO654Dsa/HnXs29ZzSbU61bM2JUq5kNzoNMWRsDNm
         2QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGKZC8Yk9a4K1xQUIR32NKLL+a1T4QuK8qDvY9ng/Tg=;
        b=qIewBRAja8bhNniNcvan6pXa2l+vebXO2x9cdCQ6I610XslcYdyNy8CUaUU69+mk4j
         lxvLiYoe0bSvioBlB7hq/tOHTz3jSZmAP1GcOAQAsQY3F8UKRzCy61r0AVGsDwsjFE9n
         QPNjopZ99l2+McxMkIWvnk7B3nAbs62U9CJ/mc5qUX7uvwtgS0QnZDoleC60yrD+bsgW
         nMjvysP3T5dXA07cxJv/DOVxJlpjAlApqYhu7vVFzmZAcnIfrCecBEdZ4BaPYMqZGyXX
         P3KwHGw9wWvk9jtIROpJnv9S7HoxkG0RtZkR8k2cQki9Rzroc4FSicBRrK2uX3Cxh32c
         B5Sw==
X-Gm-Message-State: AJIora9h8aKk/wddy/PowQCiZDit4SURCyJRuwvavLZ/zNhqN6kEfb9Y
        O39tpunNwRHdBYhPCrbS1FKHLM7myYUph4XRI18UqjJw
X-Google-Smtp-Source: AGRyM1u5XrtKRsMG5rdPnOmne2nbM7lx+M1Jm+eoX2WFO2Vdpnm3nKEWofTa3OELA5rpfUK3XZnMlRUC1NFnvD2QKyM=
X-Received: by 2002:a05:600c:3492:b0:3a1:70dd:9a14 with SMTP id
 a18-20020a05600c349200b003a170dd9a14mr4844172wmq.177.1656549877130; Wed, 29
 Jun 2022 17:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local> <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local>
In-Reply-To: <YryKCl5J1Em89d3e@nand.local>
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Wed, 29 Jun 2022 17:44:25 -0700
Message-ID: <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 10:21 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Jun 29, 2022 at 10:16:38AM -0700, Gregory Szorc wrote:
> > > In either case, my recommendation would be to keep those unreachable
> > > objects which haven't yet aged out of the repository around for longer,
> > > which will decrease the likelihood of seeing the race.
> >
> > We had to lower gc.pruneExpire from its default of 1 hour because
> > otherwise this would result in the creation of thousands of loose
> > objects. This is normally acceptable. However, on NFS, the churn from
> > lots of file creation and deletion resulted in acceptable performance
> > degradation. We had to lower gc.pruneExpire to minimize the damage.
>
> Makes sense. Having a shorter gc.pruneExpire makes the race much more
> likely to occur in practice, so I'm glad that we have a plausible
> confirmation that that's what's going on in your repository.
>
> > > See Documentation/technical/cruft-packs.txt for more information about
> > > cruft packs.
> >
> > Yes, I saw this new feature in the Git release this week and am hoping
> > to roll it out to better mitigate this general problem! With cruft
> > packs, I anticipate being able to restore a longer gc.pruneExpire
> > value as they should mitigate the NFS performance badness we're
> > working around. Thank you for confirming it should help with the
> > problem.
>
> That should definitely help. Let me know if you have any questions, and
> thanks for trying it out!

Revising my initial post, not running `loose-objects` is insufficient:
we also need to prevent `incremental-repack` from running while a `git
gc` / `git repack` is in progress. If an `incremental-repack` runs
concurrently with `git repack`, `repack` can error after bitmap
generation but before the temp packfile is renamed with "could not
find 'pack-*.pack'." I suspect this has to do with
`incremental-repack` deleting packs that were initially in place when
`git repack` started running. But I haven't looked into where exactly
repack is failing.

I deployed Git 2.37 and enabled cruft packs via `gc.cruftPacks=true`
in the global gitconfig. I simultaneously increased `gc.pruneExpire`
to 1 day (as we're no longer concerned about each unreferenced object
turning into a single file). And I changed the frequently-invoked `git
maintenance` code to not run `loose-objects` or `incremental-repack`
if a gc.pid file is present (this is still racy but should hopefully
work enough of the time). This appeared to work: `git gc` created a
cruft pack and didn't complain about anything disappearing out from
under it, despite `git maintenance` running `commit-graph` and
`pack-refs` tasks during the long-running `git gc` / `git repack`.

However, I think there is yet another bug at play: running
`incremental-repack` appears to be able to repack the cruft packfile.
In doing so, it deletes its .mtimes file and the metadata inside. This
behavior seems wrong to me: I was expecting the cruft packfile to
linger until the next `git gc` and/or for its mtimes metadata to be
preserved across future repacks. Otherwise, what is the point in
retaining granular mtime metadata? Is this the behavior expected? Or
do cruft packfiles just not work as intended alongside use of the
`incremental-task` maintenance task / multi-pack index in Git 2.37?

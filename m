Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239EC43219
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 23:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiKVXJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiKVXJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 18:09:56 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7341B7017
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 15:09:53 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:09:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1669158591; x=1669417791;
        bh=+MH9OOjhVj2gESxi5saSS8TcngqJvtBp+ltJIv95nuw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dCpfwDwSUCJ0FBQr/F+Mfgm61qfG95I6YjeHD3dIwp5f625alhQ589Am8EOTg7LB0
         VYD9ngtvDbrmEDN3vnGTbPj1GsCv9QKXS+2uv80XIWJx9LKooSnTP94ESz1AEMIyqh
         2EXuPu7jfsGbKhS9Z8gZiMt0AwrRR6wIcUXBrM8/NUJWRa63LRdJ+A+huV2wUoP1O4
         A1kmNVKj7UWn0jfLRlL5x/KOl2OppvzuN8buDtsGk27F14TUY7tW/nI5fvgbet4QFo
         B8VXK1B9GOOGrlNmydYIyU+M1hu937Vwz4V53cY7oSD0caAmV94v2b6XOQmHWxi9TP
         xDFa9HkK5Hp3w==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] worktree add: add --orphan flag
Message-ID: <20221122230931.4ndzcu6lz3mop665@phi>
In-Reply-To: <CAPig+cSU-Fh3BnBMhomFr2ZEQZ3Cw=toVZETVY4k42-jqiHY=Q@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221110233137.10414-3-jacobabel@nullpo.dev> <221115.86iljfkjjo.gmgdl@evledraar.gmail.com> <20221119014436.737kqsmcezkck3do@phi> <CAPig+cSU-Fh3BnBMhomFr2ZEQZ3Cw=toVZETVY4k42-jqiHY=Q@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/11/22 01:00AM, Eric Sunshine wrote:
> On Fri, Nov 18, 2022 at 8:44 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> > On 22/11/15 10:08PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > > +   test_must_fail git worktree add --orphan existingbranch orphand=
ir2 &&
> > > > +   test ! -d orphandir2
> > >
> > > I'm not sure about "worktree" behavior, but maybe this "test ! -d" wa=
nts
> > > to be a "test_path_is_missing"?
> > >
> > > In general we try to test what a thing is, not what it isn't, in this
> > > case don't we fail to create the dir entirely? So "not exists" would
> > > cover it?
> >
> > Ah yes that would be preferable. I've updated it for v4.
> >
> > This shows up in the file in a few other places in this file as well
> > (from before this patch). Should I make the changes there as well and p=
ut
> > those changes into an additional patch in this patchset?
>
> With my reviewer's hat on, my goal is to help the series land in
> Junio's tree, which means I'd like to see fewer changes with each
> iteration. Adding a new patch which is only tangentially related to
> what the series wants to achieve isn't a priority, and could end up
> delaying acceptance of the series if problems in the new patch end up
> requiring additional rerolls.
>
> So, yes, you could do that cleanup as a preparatory patch in the
> series if you want to tackle it. It would be an appropriate cleanup
> since you're working on code nearby. Or it could be done as a follow
> up to this series. Given how small the cleanup patch would likely be,
> it may not make a difference one way or the other, especially if the
> commit message explains the change well (for instance, by paraphrasing
> what =C3=86var said about "testing what a thing is, not what it isn't").

In that case I'll make a note and send in a cleanup patch with that change
(referencing this thread) some time down the road after this series.


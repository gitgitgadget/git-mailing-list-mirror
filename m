Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4189EC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 17:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbjAIR0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjAIR0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 12:26:14 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4239217
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 09:26:11 -0800 (PST)
Date:   Mon, 09 Jan 2023 17:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1673285169; x=1673544369;
        bh=vlMq3UMXzyQl0+5EesdknbXhWiXVOHFlKWEBil5RGAM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZDf1D6i+vqpZK3F9LLYdznN03eFKeFuCyiEFnW5h3ezgxS7rBybgdWlPNvblyGMGZ
         L6qupmevf7QtfDeU0ophw8fQTvOXO2r9qCWzUtgNnBNMARBNCFkJ4Q+vNXq9UoBtVX
         zxugouPKLyLvJC/DlTWEtXeWHb/0BtwWD2Zo7S7SHlda+2KU/lo2GSJN4Y4lcnHUIy
         jh5HceUQc4Ji4tY2KHo4+MIhArpX72YxM1tkr7qSfNXNwN1iMqrGISi47hcOr5Uo3C
         tcBgQlRrESffYpxikuG686wtELw7YAR3AHQDJ1xFNg4jddmVSOXE5oKGhDdtfy2nzI
         1kBmh+nWHsupw==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/4] worktree: Support `--orphan` when creating new worktrees
Message-ID: <20230109172555.7rgv6y4vijnxyh3x@phi>
In-Reply-To: <230109.86ilhf1v1m.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20230107045757.30037-1-jacobabel@nullpo.dev> <230109.86r0w328nu.gmgdl@evledraar.gmail.com> <20230109171100.6jj65aktyohtykid@phi> <230109.86ilhf1v1m.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/09 06:21PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> On Mon, Jan 09 2023, Jacob Abel wrote:
>
> > On 23/01/09 01:26PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>
> >> On Sat, Jan 07 2023, Jacob Abel wrote:
> >>
> >> > [...]
> >>
> >> This round looks good to me, except for a small tiny (and new)
> >> portability issue that needs fixing:
> >>
> >> > [...]
> >>
> >> Good to get rid of this.
> >>
> >> > [...]
> >> >     ++=09=09grep -P "fatal:( options)? .* cannot be used together" a=
ctual
> >>
> >> This is the new unportable code, the "-P" option is specific to GNU
> >> grep, and here you're relying on the "?" syntax along with other
> >> ERE-like syntax.
> >>
> >> It looks like the minimal fix here is to just change -P to -E, which w=
e
> >> can use, you're not using any PCRE-syntax, but just syntax that's part
> >> of ERE.
> >
> > Understood. I have made the change and prepared a new revision already =
if this
> > is all that needs to be changed. I can submit it at any time however I =
was
> > unsure of whether it was considered bad etiquette to submit new revisio=
ns so
> > close to each other.
>
> It would be good to have that new revision soon in this case.
>
> Generally, if you submit a series you're expected to wait to give more
> comments time to trickle in.
>
> But as a series gets more "ready" a re-roll can come sooner, e.g. in
> this case where at least I'm fairly confident that this is (knock on
> wood) "the last bug".
>
> So once that version's in Junio can hopefully queue it for graduation to
> next soon-ish.

OK. That makes sense. In that case I'll get that sent out right now.


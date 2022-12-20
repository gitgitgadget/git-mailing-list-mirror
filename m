Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98251C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 23:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiLTXYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLTXYr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 18:24:47 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5EF4F
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 15:24:45 -0800 (PST)
Date:   Tue, 20 Dec 2022 23:24:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1671578682; x=1671837882;
        bh=wzPKOzSpC30bM+W4mn71iB4FjmWyp0gaL8q2PPDAI8E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=D2XuDS4whFiLogfzN/Q8qAOQ4qf1/NCoSUA4YaHRIM2dCFFLW5WG40HpC1A6mJDrL
         rzGE2yBv2/k+NWE9ZKfphXPYAqXshF9sMQlAdB6MwJcVYIau9J9ve/+lhMWoNxHVbE
         WsGpkDxUh3lrqMV2ahS7DBGEVgj6HW1cYE3l/94g5obyx97sPeyLGkxyQULQS+Oiax
         zeG+UOsMd2GcK6eVrsmWQC8+hFMLsWDZw7S8dzdd3qpTehpfXxgv/FKmRemcBZaMBn
         6Q5Zr6NZGqV1XSh2xkcb8dmbz+CNh7j+1Qq4g73Cv+B3UOg7dVxwAN9BChSbohwZ5S
         WlP8TBAc2qeUg==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v5 1/4] worktree add: Include -B in usage docs
Message-ID: <20221220232417.v3tvugyav36m32ry@phi>
In-Reply-To: <xmqqo7ryyc4f.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221220023637.29042-2-jacobabel@nullpo.dev> <xmqqo7ryyc4f.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/20 12:42PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> > Subject: Re: [PATCH v5 1/4] worktree add: Include -B in usage docs
>
> s/Include/include/;

Done.

>
> > While -B behavior is already documented, it was not included in the
> > usage docs for either the man page or the help text.
>
> Good.
>
> > This change fixes
> > that and brings the usage docs in line with how the flags are documente=
d
> > in other commands such as git checkout.
>
> We often just give an order to the codebase to "be like so", before
> describing the effect of following such an order.  I.e.
>
> =09Document "-B" next to where "-b" is already documented, to
> =09bring the usage docs in line with ...

Done.

>
> >  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <str=
ing>]]
> > -=09=09   [-b <new-branch>] <path> [<commit-ish>]
> > +=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
>
> This is wrong, I think.  We want
>
> =09=09   [(-b | -B) <new-branch>] <path> [<commit-ish>]
>
> instead.
>
> [ a-thing ] means "a-thing can exist here, and it does not have to".
> [ a-thing | another-thing ] means "a-thing or another-thing can
> exist here, but neither has to be here".  [[-b | -B] <new-branch>]
> would allow <new-branch> without either -b or -B, which is not what
> we want.

Ah yep, my mistake. Changed.

>
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 4a24d53be1..fccb17f070 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -17,7 +17,7 @@
> >
> >  #define BUILTIN_WORKTREE_ADD_USAGE \
> >  =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason=
 <string>]]\n" \
> > -=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
> > +=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]=
")
>
> Likewise.

Done.


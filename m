Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA49C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 03:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC3D4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjC3D4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 23:56:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A4468A
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 20:56:42 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e21so18282913ljn.7
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680148601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay88i21N5XyKhoCyj+HmOAgPbh3LvX1RTaU5bai3+kg=;
        b=mm3u4k3wePgjFzoA0kqiDFv3d5g1OIdv0oRAgVUfCF6u451L5Pi014K2Eim0TDmo/N
         uFG0mSz3/8MVP+TMg2JA0Hdgo8UzeMIHoW/Qns4lcMgfdYuGnqBTN6xduX1KMNtmCyB7
         OldbrIvfeFf9xEIYt2xb4BOEGVKsQr2CWHf0cyV3pn4xKEZLW04mPuxFILf7CvxoWg87
         czSC0zUiWG+SxnWv9W47UwuEMmucGY5fdVV56BolbsonYwRKWSXgOrDPlqZNTy4IJIJ9
         Ug6kWYM9MbazJ+frm+btumUAzxqyjQFYdMPxcGRidPS78YUUX+5siN5OTUnQm5A/b9DI
         1mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay88i21N5XyKhoCyj+HmOAgPbh3LvX1RTaU5bai3+kg=;
        b=ewjMSYObHuI/6NkiuCUp+ssABiZieXVjDeQZQf/iTOZxA/QYGZgZtFObTRUHh/ENuq
         BxyoKgJrdPif1LdEUGGPi3rQwdV9t3fcS0AyO7zsP614Zy2wUqWQqh0MXQZtuzWniEQ3
         Us/tjz9TVdfuFBBGeuM2+eZzRMudrDqltlE+cTEpWABlrv+WweJq/AJ+iMQMZgq9XqpZ
         TGhHthTSp5psttUDXrLSchIaRkp/kvLt2QipJLLiFgDoSR670/J2yEZzq6dAOyhieMyG
         VTqIcL2Tq+sXEmzbo35h21rGwh11EHN15vGeZ4coCmHsVOI8i11BVBN1SQteuLKKWHFA
         hkUw==
X-Gm-Message-State: AAQBX9c2g8XqEU64oWhvKfgpg0rVqo7QTIuCo+pQV2ouxoSSgRcZJJbk
        uzZhBziyTWInwtISVh6WgbxlcafzjQlunQGLsow7RUsF
X-Google-Smtp-Source: AKy350bsK794rZOpoT+5UrtBdRMuk74UpBJ1ZY9bLYlE9fgYEmnSuayMcFb/NSaRw6yV7WpNIh0Z932lWoDRHPiqlxE=
X-Received: by 2002:a05:651c:113:b0:299:a9db:95 with SMTP id
 a19-20020a05651c011300b00299a9db0095mr6726744ljb.1.1680148600707; Wed, 29 Mar
 2023 20:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
 <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com> <xmqq355n9y9m.fsf@gitster.g>
In-Reply-To: <xmqq355n9y9m.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Mar 2023 20:55:00 -0700
Message-ID: <CABPp-BEzykyoFLVkftsQ-+AXs4y6hQDm2CRy3+kROq0gcinYnA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 12:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> >  1:  c167bde3c0c !  1:  e1e27490d60 cocci: remove dead rule from "the_r=
epository.pending.cocci"
> >     @@ Commit message
> >          cocci: remove dead rule from "the_repository.pending.cocci"
> >
> >          The "parse_commit_gently" macro went away in [1], so we don't =
need to
> >     -    carry his for its migration.
> >     +    carry this for its migration.
> >
> >          1. ea3f7e598c8 (revision: use repository from rev_info when pa=
rsing
> >             commits, 2020-06-23)
> >  2:  1b1fc5d41f5 =3D  2:  5ac9d5b8905 cocci: fix incorrect & verbose "t=
he_repository" rules
> >  3:  34c6b8afd6c !  3:  a3fcd19d744 cocci: sort "the_repository" rules =
by header
> >     @@ Commit message
> >          rules. This will make subsequent commits easier to follow, as =
we'll be
> >          applying these rules on a header-by-header basis.
> >
> >     +    Once we've fully applied "the_repository.pending.cocci" we'll =
keep
> >     +    this rules around for a while in "the_repository.cocci", to he=
lp any
> >     +    outstanding topics and out-of-tree code to resolve textual or =
semantic
> >     +    conflicts with these changes, but eventually we'll remove the
> >     +    "the_repository.cocci" as a follow-up.
> >     +
> >     +    So even if some of these functions are subsequently moved and/=
or split
> >     +    into other or new headers there's no risk of this becoming sta=
le, if
> >     +    and when that happens the we should be removing these rules an=
yway.
> >     +
> >          Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
> >
> >       ## contrib/coccinelle/the_repository.pending.cocci ##
>
> After removing the rebase noise from later steps, the above two are
> the real changes compared to the previous round.
>
> Are people happy with the result?  I think the previous round was
> both read carefully on the central piece of the series, with some
> spot checks to mechanical parts, and with the above clarification
> the series is ready to be merged down to 'next'.
>
> If I am grossly off base in the above assessment, please holler
> soonish.  Thanks.

These two changes address the only minor points I had with the series.
My other comments were either being happy about the changes, or noting
some other things outside the scope of this series that would also be
nice to cleanup.  So I'm happy with merging down.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7EC77B76
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDPLPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDPLPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 07:15:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467126BE
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 04:15:33 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id k39so1257848ybj.8
        for <git@vger.kernel.org>; Sun, 16 Apr 2023 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681643732; x=1684235732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICUD5ia5Zkj6HUBDSBSG6Dqm071wIVKzDIsmsRrHbAg=;
        b=FPg4ynUtJMqhbFHa+j9uqQGUl4ufwstjp2ADVwYnKgIFXO/UXo57YJX8iCvf4CgU9u
         A8Bn03vMJCi0L5VVtCGw2nlXOvmnpiHNGv4r+KWXpy8z/lfNpj/QXn1nO6DcL9s/9rvm
         +7UnH0ITvKCjmzw0FghVk6wMmnERdP4fzbwwqNiaXxxVDzv2+bOHXORv1INNBGIzEwZ9
         O7nvFyM63fhLssiM9NuOMcKvrMMdE9PD9VOktVzUY7UqE4PPZVKu4ENQFRFjtP1B5ENQ
         XxO53AAENQ/al+SBOZHuC+vZP7CsMJUdTjOO8fvu+9pnSibp9ETt9tH9KLqejlX9N6tq
         crLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681643732; x=1684235732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICUD5ia5Zkj6HUBDSBSG6Dqm071wIVKzDIsmsRrHbAg=;
        b=OOWRXE3D6V3SbSYuCyvYDRLl9oHuslMTHI0Q0BILAYd+c1be5OUv2qeT1rb+evveJz
         vyG//d8pzyW9uwlkIyzfZ6bEnunnUsrgN88B6jPQ9jjtPu918iOAdxALaNv+sLdnZuze
         Wymq6eXoVge5KFRvNMgVXWtjGTh7bsRUfUWRUY2Oy5BCiLu8Hp7cjzA0hbGeVXa4WtuW
         eYFiYK9aLG50s5yclKJ4jDN9TpP0kOTKb8EwBdyL+c48thX3nqQcF+tRMS16T6aJYLZK
         x2OK+yFFcMSAezEbwGkEeu+StWpnNtNgPbyOpDurViAAppGT7hjeiBPvln5k3xK6k/UY
         2a5w==
X-Gm-Message-State: AAQBX9fSaRI+ly+jnYMmlJk+BVWTbunnGRbMY1vH5+QmLqRIEauXCpUm
        T6Q0SS+ENXVTGtnytz7t1iSivyKUqWSI3un4zwA=
X-Google-Smtp-Source: AKy350YThH9fWJmbM+PMFB9k+/Fdgyz+C2vkEllkIKpa5km7a/Q7cZ7qbHD+PTuvOUKO3nkfKReV4uJbRtJ+KAnxba0=
X-Received: by 2002:a25:718a:0:b0:b8b:f61e:65ff with SMTP id
 m132-20020a25718a000000b00b8bf61e65ffmr7244231ybc.5.1681643732269; Sun, 16
 Apr 2023 04:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net> <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net> <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
 <20230414073035.GB540206@coredump.intra.peff.net> <CAOLTT8SEeY1tfU39xHPJ21F7o3dmgEFwNCny=Z2F4Y2HFR3DzA@mail.gmail.com>
 <xmqqh6titpzk.fsf@gitster.g>
In-Reply-To: <xmqqh6titpzk.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 16 Apr 2023 19:15:47 +0800
Message-ID: <CAOLTT8QS8VzepLid7V4FXMfGJpiQL6P5_Bd+2=YygfNoZrPU7w@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=94 23:58=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Oh, you are right, this could be to prevent conflicts between Git objec=
ts
> > with identical content but different types. However, I always associate
> > Git with the file system, where metadata such as file type and size is
> > stored in the inode, while the file data is stored in separate chunks.
>
> I am afraid the presentation order Peff used caused a bit of
> confusion.  The true reason is what Peff brought up as "Or worse".
> We need to be able to tell, given only the name of an object,
> everything that we need to know about the object, and for that, we
> need the type information when we ask for an object by its name.
> Having size embedded in the data that comes back to us when we
> consult object database with an object name helps the implementation
> to pre-allocate a buffer and then inflate into it--there is no
> fundamental reason why it should be there.
>

Yes, I think I understand the point now. Since Git addresses objects
based on their content, if type information is not included in the object,
we cannot easily understand what type of Git object corresponds to
a given object ID. Moreover, if we don't include type and size information
in Git objects, We would need to maintain a large number of external tables
to record this information, in order to inflate and identify the type.

> It is a secondary problem created by the design choice that we store
> type together with contents, that the object type recorded in a tree
> entry may contradict the actual type of the object recorded in the
> tree entry.  We could have declared that the object type found in a
> tree entry is to be trusted, if we didn't record the type in the
> object database together with the object contents.
>

Yes, that may not be crucial, but including type information
in Git objects can help validate the correctness of tree entries better.

> I think your original question was not "why do we store type and
> size together with the contents?", but was "why do we include in the
> hash computation?", and all of the above discuss related tangent
> without touching the original question.
>

Yes, but I think these two problems should be similar.

> The need to have type or size available when we ask the object
> database for data associated with the object does not necessarily
> mean they must be hashed together with the contents.  It was done
> merely because "why not? that way, we do not have to worry about
> catching corrupt values for type and size information we want to
> store together with the contents".  IOW, we could have checksummed
> these two pieces of information separately, but why bother?

 Thank you. I think I roughly understand.

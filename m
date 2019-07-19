Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D471F461
	for <e@80x24.org>; Fri, 19 Jul 2019 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfGSSN4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 14:13:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44564 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfGSSN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 14:13:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so33082961wrf.11
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odibUAFhvDDiXbGSHInV6YmxYe4RP8xuMtmnSvxEZGk=;
        b=sFUYS7AYV8yp+A4JPSU4SnDKBCLmwZZGg50jljRg3THJavWrCgA65Aef2eljBd9yGd
         5uDLeQsYwkRR1LXLcoCrWTXIAFrUhX/u0TAMTYM6ROPcjYFx3pk6N86j5CJ1yPnhF//M
         +pjS/t4tZFANfucr4glKq0AFhjGlh7PfrcS0GUcsGZUibd9JvAkJRkHpDazITtiXm/BO
         ntTv0sPaECVd1JW/5f7zgPFj3GrX3Td53GXkWE/wj6d5pliOmUjfS1OY0J4l61Y5qhb9
         A6c+zvQADDRYvUsNNdg7nRV03sPooBvDtNLFjHhc4Gq/NQn/eHb+K7EQsGIIq5hBYP8Q
         rcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odibUAFhvDDiXbGSHInV6YmxYe4RP8xuMtmnSvxEZGk=;
        b=J+aaSTcGDYf0rfoI9SMlXMw/uo2NsiRn7mK7Z3OH224FqYpPegKQRO+AnaD9aOBtg1
         XD826P4dY+hBZa7XxD34y0U0pDSDlVOPkiEQUGUDzcSiTFhueuBnz2m6iIfa1gIJEURj
         NVGYHNm4ZwICCyh39vX/I1pvWbSrwUDLgnXSz7QhqxYNJguI9uv5OAWAXH7t2E2GMTlC
         WQ4Bt/6EbITSErw6SSlpLav0jXFhmyW+37WN7hBFhNw+oU3IL7Pz+Lp2HxPM5BNpPaPV
         91QcLrPmwqijtBFierMcX1bMNc5LoFLiMy+YcH2vjyQjhRtLZgn3oOW3dLfx1EWuvzw0
         LETg==
X-Gm-Message-State: APjAAAXk8Xar4wzRPNhZ7ENdWqGsGedX7FC2E96eBNFgTjuPpGlHzIEH
        Ef8pudDGK91bCSUG4ooXE18=
X-Google-Smtp-Source: APXvYqxM1Q+Ahm7O1gCCJv2KDienGyJ1Dr8jiDjvUnDc45fMtzPc6uXMWrTaCD5ru48+olotpkkjsQ==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr29927383wrv.326.1563560034078;
        Fri, 19 Jul 2019 11:13:54 -0700 (PDT)
Received: from andromeda.localnet ([80.214.30.27])
        by smtp.gmail.com with ESMTPSA id x11sm22225189wmi.26.2019.07.19.11.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 11:13:53 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 4/9] sequencer: update `done_nr' when skipping commands in a todo list
Date:   Fri, 19 Jul 2019 20:13:44 +0200
Message-ID: <1732521.CJWHkCQAay@andromeda>
In-Reply-To: <xmqqo91rxgm7.fsf@gitster-ct.c.googlers.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com> <20190717143918.7406-5-alban.gruin@gmail.com> <xmqqo91rxgm7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 18/07/2019 =C3=A0 21:55, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > In a todo list, `done_nr' is the amount of commands that were executed
> > or skipped, but skip_unnecessary_picks() did not update it.
>=20
> OK.  Together with 3/9 and this one, any increment of total_nr and
> done_nr in the existing code is not removed; does it mean that
> nobody actually cares what these fields contain?  IOW, there is no
> code that says "if (list->total_nr <=3D i) { we are done; }" etc.?
>=20
> Or are these fields used later, but somehow the lack of increment in
> the places touched by 3/9 and 4/9 is compensated?
>=20

`total_nr' is not used for this, because it=E2=80=99s not necessarily the n=
umber of=20
items in the todo list.  That=E2=80=99s the role of `nr'.  So the compariso=
n is more=20
like "if (list->nr <=3D i) { we are done; }".

Same think for `done_nr'.  Each time a command is executed, git prints=20
"Rebasing ($done_nr/$total_nr)".  These two variables are written to the di=
sk,=20
and might be used by a shell prompt (eg. git-prompt.sh, oh my zsh=E2=80=A6)

And this is actually how I found this.  Originally, I wrote what became 5/9=
=20
and 6/9, without touching to `done_nr' and `total_nr'.  All rebase tests=20
(t34??*) passed, but t9903.15 ("prompt - rebase merge") failed, because the=
=20
value was incorrect.

The reason is that, before I changed sequencer_continue() in 6/9, it called=
=20
another function, read_populate_todo(), which would recompute `done_nr' and=
=20
`total_nr', then write them to the disk.  With my changes, these values wou=
ld=20
not have been updated after adding `exec' commands or skipping picks in=20
complete_action(), so the numbers written to the disk were incorrect.

tl;dr: it does not impact how the rebase works, but it might impact the=20
messages printed while rebasing or shell prompts.

> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >=20
> >  sequencer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index e61ae75451..ec9c3d4dc5 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4939,6 +4939,7 @@ static int skip_unnecessary_picks(struct reposito=
ry
> > *r,>=20
> >  		MOVE_ARRAY(todo_list->items, todo_list->items + i,=20
todo_list->nr - i);
> >  		todo_list->nr -=3D i;
> >  		todo_list->current =3D 0;
> >=20
> > +		todo_list->done_nr +=3D i;
> >=20
> >  		if (is_fixup(peek_command(todo_list, 0)))
> >  	=09
> >  			record_in_rewritten(base_oid,=20
peek_command(todo_list, 0));





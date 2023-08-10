Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26167C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 07:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHJHPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHJHPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 03:15:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206310C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 00:15:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso87849466b.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1691651706; x=1692256506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp0da3/C7PDINzvnsWNJMzPoUbC9k9icniI38933Ttg=;
        b=Z+SMJYRLXohQgrlBM4nMkMIH0xRixdwknL4zD3uiev6hL9gG4Dtgc0PqzX5cfz4Slu
         Wt8HgJU2nWStgwHvd/KqzXdD5rdqD6Zzlq5ft3Uo4ULc8MbBAOnGAjZFISteT25Hl7QA
         Zs1EapK/rwTY8MC6VKqvwc1tn4NiQq1FE3tHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691651706; x=1692256506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp0da3/C7PDINzvnsWNJMzPoUbC9k9icniI38933Ttg=;
        b=gVh7A37IMk8pQ/evaTAwLDyuh77tHkv/DzXj2Rjxp2eIPgsDn7PDhgbkQU2fUTfFMY
         4XnG7kIV4qwgphxjcgrBmJaB0QrM1R31FVaheJ09Ksqv9dZWz7oeXUfrKIxBwfg9HL5l
         fpaFkunpZ9XxmgXhC6tmm464+ied0nscoeBaFSDepxtavFUFgf3UYVXjdw0qtmWahUlx
         vfqTAu1nwAblwxIXUWvhNqgRK5aH+gAVrDWsqht7WwsrqMYWjo1hGo6IxpohqZYnPGbs
         xDjgHkUflW0ELPk7WSmZGxGKxhGxfT87I/7jREbdbsZkQRUWlr5qWSawJGWUTeo1TDit
         ANNQ==
X-Gm-Message-State: AOJu0YyqDJ1Zu+GBu+BLcbxkk23peNB2vUs2QuiLQdFIBZIfoVh9QxF8
        G7DnE4Vqi+zFIEsSXnWuGm2hfgKO+JUTG7YgDS06alAdpgwjPmK3Omd1+A==
X-Google-Smtp-Source: AGHT+IEJ2rM/aFZoknIx8k7mQoFz8wShsZ5wwK7Nyep5zWW2gj8SLDSBYRs6Qwj+vFLXYoqmV4KQ0E3+bqgvZC2327E=
X-Received: by 2002:a17:906:3d21:b0:99c:b0c9:4ec7 with SMTP id
 l1-20020a1709063d2100b0099cb0c94ec7mr1248187ejf.26.1691651705628; Thu, 10 Aug
 2023 00:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoiJ4cNcAR9gO5d-749N3YW-88p1gMnX8ySGgz84Mr9coA@mail.gmail.com>
 <CACf-nVfUotaTYeCC9XMvnYYNhjX+EW89z7fhUX0Ok9TpsVTRTw@mail.gmail.com>
In-Reply-To: <CACf-nVfUotaTYeCC9XMvnYYNhjX+EW89z7fhUX0Ok9TpsVTRTw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 10 Aug 2023 09:14:55 +0200
Message-ID: <CAPMMpoh9xP8PomAUTHGZfYAMAgHb_BF74EVgmo1C-DQh22-cUA@mail.gmail.com>
Subject: Re: "git fetch --refetch" and multiple (separate/orphan) branches
To:     Robert Coup <robert@coup.net.nz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

Sorry about the extended delay, I haven't had a chance to do "git
hacking" in a while.

On Sat, Jun 3, 2023 at 10:18=E2=80=AFAM Robert Coup <robert@coup.net.nz> wr=
ote:
>
> On Fri, 2 Jun 2023 at 22:23, Tao Klerks <tao@klerks.biz> wrote:
>
> > What I believe is happening is that *if* there are refs to be updated
> > (or new refs, presumably), *then* the objects returned to the client
> > are only those required for those refs. If, on the other hand, there
> > are no updated refs, then you get what is advertised in the doc: "all
> > objects as a fresh clone would [...]".
> >
> > I've tested a couple of different scenarios and the behavior seems
> > consistent with this explanation.
>
> Do you have a repo & steps that could reproduce this easily? Otherwise
> I can try and work up something.
>

Does the following work? It shows that with a change to the orphan
branch from another client, a refetch in the original client gets
about half the objects (the ones for the orphan branch that was
updated), and in another fetch right after, with no new changes, the
refetch gets all 600-or-so objects.


create_n_commits() {
  for i in $(seq $2); do
    echo "another new line $RANDOM" >> "$1/datafile"
    git -C "$1" add datafile
    git -C "$1" commit -m anothercommit -q
  done
}

mkdir refetch-testing
SERVERFOLDER=3Drefetch-testing/server
git init "$SERVERFOLDER" --bare

CLIENTFOLDER=3Drefetch-testing/client
git init "$CLIENTFOLDER"
git -C "$CLIENTFOLDER" remote add origin "../server"

git -C "$CLIENTFOLDER" checkout -b main
create_n_commits "$CLIENTFOLDER" 100
git -C "$CLIENTFOLDER" push origin HEAD

git -C "$CLIENTFOLDER" checkout --orphan orphan
create_n_commits "$CLIENTFOLDER" 100
git -C "$CLIENTFOLDER" push origin HEAD

echo "---HERE IS A NORMAL FULL REFETCH---"
git -C "$CLIENTFOLDER" fetch --refetch
echo "---NORMAL FULL REFETCH ENDS---"

OTHERCLIENTFOLDER=3Drefetch-testing/otherclient
git clone "$SERVERFOLDER" "$OTHERCLIENTFOLDER"
git -C "$OTHERCLIENTFOLDER" checkout orphan
create_n_commits "$OTHERCLIENTFOLDER" 5
git -C "$OTHERCLIENTFOLDER" push origin HEAD

echo "---HERE IS A WEIRD PARTIAL REFETCH OF ONE BRANCH ONLY---"
git -C "$CLIENTFOLDER" fetch --refetch
echo "---WEIRD PARTIAL REFETCH ENDS---"

echo "---HERE IS NORMAL REFETCH AGAIN---"
git -C "$CLIENTFOLDER" fetch --refetch
echo "---NORMAL REFETCH ENDS---"

rm -rf refetch-testing

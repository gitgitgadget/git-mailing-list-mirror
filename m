Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15493C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B8560174
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 08:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhJZIOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJZIOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 04:14:42 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCAC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 01:12:18 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 20so3928495vkc.8
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 01:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jnuPJSbrjZCZH00A7auEqGgm7qvWRuV6/kOJ+Exkbu0=;
        b=gkaO9X82YX9mbDaY36qEkayYWguXhXowf3fedEGmgwRWx2aIkYcaaZGtyE2du1pc7H
         AvfHPbFBf9OvM7TUzzW7MXeb4Pp5GICa6KobaPyo+WZOqmjpPGK3dZBTpQmGeuJeqQlU
         KyqLluRIi3OykjrSX40mbMf0//LRX/RZwWa9WKcc0sxn9JQ92/BpsynuZsRwnYV6YtIY
         8UVsY3YnGNadQhVyNZH/eQ+RQvuGmOxCu9VqBPBxRHyXezwnm7Z4Il5tSnFxA0l6HbLP
         wvT4DTxtAl+8CV4s41ksbtz5GUoDmbwpTw7RDRxMlie6c0JtJcn9ls1eo6r8ryxdWCWb
         3P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jnuPJSbrjZCZH00A7auEqGgm7qvWRuV6/kOJ+Exkbu0=;
        b=Fkqn5siWyZ/ZCYueWdmvSnCz8I0XvIbjwivKoLGWdjnUvt+buDtXAsdVGSbjqL/yta
         ZexhSflZp3w1AMiEp5S+2aDkGQEdlqRvNZTl8MyM1g4qLrUG++kLuvenMnMJxD2TuQlg
         kQGgdcZTdXuVfK3U1IHqfQXM8i5kkZe1hzbCGOMrsaB7Gk5kq4bdDsnZO6KhAyyCsyg0
         /wSzU9+ULOTX6cLjTd+dofCfANXtWf7+BGqEG81129utHPAJl2L0UE8f29Ya6JuG2TbY
         QN3VgZHzHy42SkVoMkzDJer5H2l4s4k8rXxLvf4Wk1exphi8PA/dBRUezWrxfRbzAdAf
         uYBw==
X-Gm-Message-State: AOAM531lT2oMdmhn4cQmuFDrZD3boRzo9VjvGTbwnxQVzbGZ9Xgc2Jvt
        +RKrstK+ALg9IXSRHYrW+mkm43nWg09f+r4Hx3RLjpjsb1WStw==
X-Google-Smtp-Source: ABdhPJx+jv5Wt9S6lGrop+6lVLtKF8vP34MJdkZPkuKT+YG4Cnbb4RJxGOceFSeapYxOi0CcPvqW0FbgCzx3/wrOb4E=
X-Received: by 2002:a1f:784b:: with SMTP id t72mr19553735vkc.15.1635235937879;
 Tue, 26 Oct 2021 01:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet> <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
 <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
In-Reply-To: <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 26 Oct 2021 10:12:06 +0200
Message-ID: <CAFQ2z_OfWe53zh-Eu09M=7pxD4=AMiWrNvwqv_HB7NFNRX+dhw@mail.gmail.com>
Subject: Re: [Summit topic] The state of getting a reftable backend working in git.git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 12:16 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> From memory I think the more general concern Philip Oakley was also
> expressing (but maybe he'll chime in) could also be addressed by a tool
> that just un-reftable-ifies a repository.
>
> I think such a thing would be useful, and I think we don't have that
> already. Isn't the files backend or reftable usage now an "init"-time
> setting.
>..
> Maybe there's more complexity I'm not considering than just the *.lock
> dance in .git/*, but if not such a tool could also convert freely
> between the two backends, so you could try refable out in an existing
> checkout.

I added a convert-ref-storage command to the JGit command line client
for exactly this,

$ jgit convert-ref-storage  -h
jgit convert-ref-storage [--format VAL] [--help (-h)] [--ssh [JSCH | APACHE=
]]

 --format VAL          : Format to convert to (reftable or refdir) (default=
:
                         reftable)
 --help (-h)           : display this help text (default: true)
 --ssh [JSCH | APACHE] : Selects the built-in ssh library to use, JSch or
                         Apache MINA sshd. (default: JSCH)

See here[1] for implementation. It's not safe for concurrent use with
other git commands, but that's hardly a common use-case.

[1] https://eclipse.googlesource.com/gerrit/jgit/jgit/+/1825a2230c06e7a6cbe=
23c69b63c3b7ecd2ceac6/org.eclipse.jgit/src/org/eclipse/jgit/internal/storag=
e/file/FileRepository.java#806


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

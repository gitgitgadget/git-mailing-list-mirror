Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC043C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E621775
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vsa820Gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBFTPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:15:17 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43705 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:15:17 -0500
Received: by mail-wr1-f41.google.com with SMTP id z9so8531315wrs.10
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vnGVMeonW3UkPfezVTpfI5zbwXINiJ/O5inotWsqpLc=;
        b=Vsa820GpM3lY3YGlbxNyTtevbyAtC4VkVx9GIK2xC2/S85/NFgDvpM8PPUYDYSBuSF
         wOTJMz0BE8aL+x+Rkvx36e3a9Qps1uJfnbrAPDmhUiHb6+6b2LEkW1P812VjbBgF1E3/
         qABqQVXFiVTVhaN72/IB2X5Jz1CzREreXPPXGSRoGgKkksmos/20qG7KsB24NeCMtIN2
         P8bMJVfa49QKs4fkcIOh/Matw5a8jN68x+9br/BRZ3B8ccT3jynOg+pfmKMbqvGhap3S
         KQoSVZyS8LR/zAIvnkJMlpMO4v2fHdVGvypJHdI861QBO06YzwopcO5oQ3cTqBTSdEG6
         eeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vnGVMeonW3UkPfezVTpfI5zbwXINiJ/O5inotWsqpLc=;
        b=etZqQgS+Bbg9MLNYcmgAJlMoXQHA5GoSHdpIzr7qr8nErxWzywdhDw0VYH50kHYAKJ
         xZvUuRljmPkmYyPXsTZtMW8XUb07KJoKhJeFl1IGtq4LkFJc1tEAJYXYteyD8fIkVNFr
         pDgRfD+4omIGDfXkxlfK7LNbM7bGRzHwljOw+20xSgCS3zy9TaRZ2gZZysS23QrxZAUP
         Sy9aIV6GB/1p9Ja9FSAZ316/s8TC9bzoFFhytwRk7GxAbx2d8r4TMcMxKWWdu/kUBBDo
         YwEN50Igk+5qlVuO3rDq8ME/HRhWEumPrrIfZW9wxdQPq2xj2rchcSQCm/KvuN2zmrgr
         v1lA==
X-Gm-Message-State: APjAAAVlmMjX4ZNeaTSRclY3kvQXWn3a6avmQ6tgRtVSCJ0ijAysPpNj
        7pMxtEx70RRx4btCSvssY4hhHetX9JevHVMcwe30Jrst
X-Google-Smtp-Source: APXvYqz2FFa5aKDXmxh5QbQGuNKoffYVwSTpz8U75H2UkDRRMrRIfbdJs8EEkywgdH9RPIRKPUkWP59pdEOnd0iFoVs=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr5369209wru.6.1581016514784;
 Thu, 06 Feb 2020 11:15:14 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
 <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com>
In-Reply-To: <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 6 Feb 2020 20:15:02 +0100
Message-ID: <CAFQ2z_Mez4khfvXx6R2K9JPagmoQWD-ZnT7rFiAW9Avjt=4PpQ@mail.gmail.com>
Subject: Re: Printing a uint64_t portably in Git?
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 6, 2020 at 7:00 PM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:
>
> On Thu, 6 Feb 2020 at 18:54, Han-Wen Nienhuys <hanwen@google.com> wrote:
> > What is the right incantation to do printf of a uint64_t on OSX ?
> >
> > Apparently PRIuMAX is to be used for "uintmax_t", and not for "long
> > long unsigned int".
>
> You could cast it? Grepping around, that seems to be how PRIuMAX is
> used:
>
>   printf("%"PRIuMAX"\n", (uintmax_t)var);

Looks like the inttypes.h standard has the defines that I want.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

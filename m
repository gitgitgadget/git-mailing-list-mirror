Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4576CA0ED0
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348934AbjIKVbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbjIKUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:37:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FD6127
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:37:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52f1f1f5125so892a12.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694464628; x=1695069428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB5hDAkzX390hNVe1/oAij/L7aqVH4TmBX55RWudUaA=;
        b=athwx1h16+PU7GHkW3mAvw5X9IvRsbEMhDl4ud3Da/xRtzwBdAHXOPuJPiexvwDW+c
         0UqPkLa5MGd0PXJL/nrBXJ0tdfHuu4yNnlJWYLo4yeUXbMc2TDBAmHTlVvMp9aJxZbNE
         pNI6Dsamv869Wx1O2hFmaJHWX4W1MRwSEZPvKoexdpu57tlsp99NOF8d1Y32C+v/1VJE
         Ery/nS8LlMQE0sBFSMgJ1Nj/pzN2BH0gdU2DiKNY6nK16Pq6JqbKFgV9ilZ8v6BEIBSD
         VT1eHsye5ohfiH7RQ+KuWzFhpyIBTHMOaeFYr+95bZaF7tVwQMLtfk3Hft0K13EYDWew
         Rxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694464628; x=1695069428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB5hDAkzX390hNVe1/oAij/L7aqVH4TmBX55RWudUaA=;
        b=UEbZO9d6BNHNgWhG01WZzbznNiwK9hnQO12ki6uSLe0MMq2p0mGeOhkW3VbNrpoH21
         jclOFBjOSdDFCfVJPBuCiwMTXdl9YAuwdgtCrt+OrsxuRKKGf8/h3R809DOQ5v3dcFdV
         hcn+2Lr3WRNSedliRmV7lLPSfWL1zQ9m554g8g47ayyzXdUMWHuOkasNmXIefSNN+Wf1
         dYKwVWJtfSjaV0PzE0b50Ypyb1VC6+/1XD4cI85FtugGek12ATSomVL2T9fw8cWXsUZ2
         G5LEb6dWNaWOada2YF9nPGDIewlKXBBUp28bTaSqdn2hOZTDf1Phc6CGnkbT/M8+uuxG
         oxiw==
X-Gm-Message-State: AOJu0YyOpibhEP1cQ6eKglEwMgCtrGm9N3jy3qyyMlM4BBGoMmFNI6uX
        OGS1YTSOOh4/0S9SamShucMoGCOm9fUkUI8v8LjywCmct9H8k7rY23PqOw==
X-Google-Smtp-Source: AGHT+IFNuYksK4ImR/i8Hj3foDI9IghgztSdYvP76xPN3ky3HUQLIzG/XzfqliNq0EOfVA2Q9DZrSY37wIeGLmVCGpo=
X-Received: by 2002:a50:8713:0:b0:52e:f99a:b5f8 with SMTP id
 i19-20020a508713000000b0052ef99ab5f8mr5742edb.7.1694464627762; Mon, 11 Sep
 2023 13:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZMATKIaU1A1D0wJg@nand.local> <ZMFfRiTSXcrkzdAJ@nand.local>
 <CAJoAoZkNRa+WREeXsr6fi-wxk_67mY+RL6WWsViwoPvyCbc5ZQ@mail.gmail.com> <ZMgVMYemepJCqXLs@nand.local>
In-Reply-To: <ZMgVMYemepJCqXLs@nand.local>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Mon, 11 Sep 2023 13:36:55 -0700
Message-ID: <CAJoAoZner83_xBnvqp3Ctn97LCkLmkAMo0h-od_Q0grTL5Fx+Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2023
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 1:10=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Jul 31, 2023 at 10:56:35AM -0700, Emily Shaffer wrote:
> > On Wed, Jul 26, 2023 at 11:00=E2=80=AFAM Taylor Blau <me@ttaylorr.com> =
wrote:
> > > >   http://bit.ly/git-contributors-summit-2023
> >
> > Since it's virtual this year, my team is considering hosting a "watch
> > party" in Silicon Valley, to get at least a few folks to be able to
> > meet face to face, even though we can't travel. Basically, we'd book a
> > conference room at some Google office, invite local contributors to
> > come along, and dial into the summit from that room - nothing fancy,
> > no extra programming, maybe catering.
>
> Sounds fun, thanks for organizing. I think my only request would be that
> attendees sign up through the forms linked above, and that we limit
> attendees to folks who meet the criteria (active Git contributor, or
> planning on becoming one).

Now that we have dates (thanks Taylor!) I'm happy to confirm that
Google is indeed able to host a "watch party" at one of our offices in
Sunnyvale (specifics TBD). As Taylor emphasized, we're only able to
invite people who already meet the criteria he named and have signed
up on the main sheet. If you are one of those people and haven't
already gotten in touch with me, please do so, it would be fun to
spend some in person time :)

For those who did already get in touch with me, I'll send details
without the rest of the list shortly.

Thanks!
 - Emily

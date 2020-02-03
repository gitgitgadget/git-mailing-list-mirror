Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B8C33C9E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AD52082E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H41cdUYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBCGYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 01:24:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36425 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBCGYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 01:24:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so5428180plm.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 22:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qd+JW33B0JtjsSI+BkLppSASNXhGPVsLnprj0NBpFIY=;
        b=H41cdUYtMxA/7AC3yC255BOjUg4nTtM3/4LfaF1ey8TaJjHYEHb/J3DTaIPfAag/Ft
         LLENHavU2TRHdwWxc0Ip8JYiD88lcGu1wzI4GNQKI1udmeCAQ+aVIg9F06HssdRrGSsC
         H3F1tPeDAV7MUv6ctuKn0jcm9YRo3fQiTdQeh8bMhyDPF1VOTfpADhAJsQz57yCwU2Eh
         3bqZn28RQOH8bljuOlPxYkkh2VZl6NrwF1Qsph0mSQOoJ0nT4VFJWZzvWJAKlnVrY4MQ
         C1ovdNATJaxT49UYbFF9zG4Ezd0O2LGP9nOY/XoHN1zuF+EaUq0zz5O7wtNba1F9maYq
         9wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qd+JW33B0JtjsSI+BkLppSASNXhGPVsLnprj0NBpFIY=;
        b=N73604vLc2HVuSww/6b1tuFutPzzlQzkgh9NVR4rw/64eJyFbPKvcpY3/1usp/qf8n
         E1y5HHY6/FrkVvGk9MMD9JGOF/VbJ44HALfyu3whfC4iLrkm+Oy+6zBomj31/Bphgtmw
         dK4JMlAm+2EHAh2uKwwtvsuISf3zXaVWMnn0oOlWR8BmeeBPuAzMIihyTlN8AFl578vd
         X9lg+HdyVXTSbGQbW45uZx1wZFwCwGReT9yz78g7RqjSlzDO5E+nB7CGPDDGR4mUgZet
         uhmGeNhzZRek78co1a0fzT7ipQJ4GXjT3WXzvRV5s1RI0whhw4hx5+ZG/78Y7pvghk9Q
         Uswg==
X-Gm-Message-State: APjAAAW/dzhMILEiYl0KPIiiWO+b6447SjCiIGHy3IvawVlCQh/NxHW+
        2CvmFxkwLjdKNCsq5JLRNeDC0ex8+xjsEKlOByA=
X-Google-Smtp-Source: APXvYqwYouu5pTT/BH1MxqdtPcGaQwKQkIwmmP7D0O7JNOZgEnNXUp1+KwgH8v43E0lauw5eYXPVuL5IL85zGHb0JDE=
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr21639934pln.178.1580711053620;
 Sun, 02 Feb 2020 22:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20200202192226.29176-1-adam@dinwoodie.org> <CAN0heSoxgsNDbi_tbxEoSSaGOxoJYArqYa-cLu1sPWVvH6wkFg@mail.gmail.com>
 <20200202204739.GA24686@dinwoodie.org>
In-Reply-To: <20200202204739.GA24686@dinwoodie.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 3 Feb 2020 07:24:00 +0100
Message-ID: <CAN0heSpDV2N2L4ukgdWxWJYJC1Hg9KYYkMC9MrqMGkuiv34AmQ@mail.gmail.com>
Subject: Re: [PATCH] diff-options.txt: correct command syntax
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Phil Hord <phil.hord@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2 Feb 2020 at 21:47, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> On Sunday 02 February 2020 at 08:45 pm +0100, Martin =C3=85gren wrote:
> > On Sun, 2 Feb 2020 at 20:24, Adam Dinwoodie <adam@dinwoodie.org> wrote:
>
> Ah, thank you!  I had completely misread what these examples were trying
> to achieve.  I think your example (or indeed anything from a different
> domain) would have avoided me getting confused in the first place.
> Although I'm much less fussed now I realise the problem here was
> entirely my understanding rather than an error in the docs.
>
> > BTW, I wonder what "in the same file" tries to say -- my hunch is we
> > could drop those words without any loss of correctness or readability.
> > Would you agree?
>
> I think "in the same file" is meaningful here: as I understand it both
> forms would find a commit that removed a line from one file and added it
> back to a _different_ file, but only the -G form would pick it when
> removed and added lines are in the same file.

You're right, it is needed. At least the way the example is given now,
where there's some arbitrary amount of left-out context between the "+"
and the "-" line, it's necessary to limit that by saying that it's in
the same file. Because this is an example, we're allowed to make it as
concrete as we see fit. For example:

 To illustrate the difference between `-S<regex> --pickaxe-regex` and
 `-G<regex>`, consider a commit with the following diff:
 +
 ----
 -    hit =3D !frotz(nitfol, mf2.ptr, 1, 0);
 +    return !frotz(nitfol, two->ptr, 1, 0);
 ----
 +
 While `git log -G"frotz\(nitfol"` will show this commit, `git log
 -S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
 occurrences of that string did not change).

Or does that make it too specific, i.e., could this give readers the
wrong impression that -G and/or -S and/or the difference explained here
only apply to such "trivial" cases?

Martin

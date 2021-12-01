Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFEC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhLAOjv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 1 Dec 2021 09:39:51 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:53846 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243090AbhLAOhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 09:37:47 -0500
Received: by mail-pj1-f51.google.com with SMTP id iq11so18155876pjb.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 06:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fKFiPhZUM+elzDWHANA56W7f7dDzvnXWKD8CkEPRsJA=;
        b=NEaMnUEM+X++vks53BzaG4SvkV86KcOlw1wuUHZEKLj+AP+6er6VQX+T7QgVNTOI+L
         5G6gIUSUKcVR9k4VFvO8go75aRCPMDWQRW8TVje9G0WXla6HBRb6yJ8BYYYY1x01TPik
         DnrQazaHdz6X37tAs1S2bsFSAuLx+6ujWXFR76uZXubr3OGpfvCHRBlWVukVCz7MNRHz
         FbqfDl2QR7iQkCpj+eh8YvYKsjiwtXcyeAGDpRGIIEzUWZJiW3+tlIIaI5Bc3kCm+GAW
         bdi6KeDrMB1+MIK9NDCIpiTH7yRXhzI7X1AUbxv7NmNfsIUkwrm8Gz1iKlJKg8HZX4ky
         7vsA==
X-Gm-Message-State: AOAM530HEA+lbwXklGmXsXxactxEG4l1jxP28Vq8Uq+1CgNIOydbdwVe
        PgNgjyxAL8OekXoiw2+sMEwWfLc/7TVrPPGuGMw=
X-Google-Smtp-Source: ABdhPJwGFugg9VbKnGA+mUVStZz3ZflVgAus2aSo1YCOiRTFXm6NdjvVZFaliu5sVeDfQLVNITBvOziiv80Hv4WPjTU=
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id
 s15-20020a170902a50f00b001437dec0567mr7952457plq.18.1638369266290; Wed, 01
 Dec 2021 06:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net> <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
 <CAPig+cS1ozLSJQgEJemDb+==NdB0ru5p4xknN11dkp6GJJM9iA@mail.gmail.com> <211201.86h7bsbf4l.gmgdl@evledraar.gmail.com>
In-Reply-To: <211201.86h7bsbf4l.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 09:34:15 -0500
Message-ID: <CAPig+cQ56HV0fjPkhiWgv3EbRABo2J1-PMxDVmmfjh=t7=6LuA@mail.gmail.com>
Subject: Re: "breaking" command output message parsing (was: [RFC PATCH]
 vreportf: ensure sensible ordering of normal and error output)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 8:59 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Tue, Nov 30 2021, Eric Sunshine wrote:
> > On Tue, Nov 30, 2021 at 9:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> (2) With git-worktree being four or five years old, for
> >> backward-compatibility concerns, I worry that "that ship has sailed",
> >> where 'that' is the freedom to relocate those status-like messages
> >> from stdout to stderr. I don't want to break tooling which exists
> >> around git-worktree.
> >>
> >> I'd be happy to be wrong on the second point -- indeed, git-worktree
> >> is still marked "experimental" in the man-page, but that may not mean
> >> anything this late in the game -- and submit a patch which places
> >> git-worktree's status-like messages on stderr instead of stdout.
> >> Thoughts?
> >
> > If that ship has indeed sailed, then perhaps the best and safest thing
> > to do is admit that git-worktree is an outlier in terms of sending
> > status-like messages to stdout, and just sprinkle the necessary
> > fflush(stdout) around in builtin/worktree.c and live with that
> > localized ugliness. Thoughts?
>
> I really don't think that ship has sailed at all. We're at full liberty
> to change these error messages, and have even done so for some plumbing
> in the past (being sensitive to what sort of messages, sometimes they
> are important).

Just to be clear for other readers, I wasn't talking about changing
error messages but rather changing the destination of the "chatty"
messages from stdout to stderr. (I think you probably understand that
even though you typed "error message" above.)

> From some brief skimming of the worktree.c code that doesn't seem to
> apply, i.e. it's just chattyness.
>
> I doubt anyone cares if it's blathering about "preparing a worktree" or
> whatever, it just matters if "git worktree add" and the like fail with
> non-zero, but perhaps there's cases of conflated states, as in that case
> of "git remote" and "git pull".

Peff had already managed to allay my worries about that ship having
sailed[1], so that I decided[2] to drop the RFC patch and resubmit as
a patch which moves the git-worktree "chatty" messages from stdout to
stderr. Nevertheless, it's nice to hear an independent confirmation
about that ship.

[1]: https://lore.kernel.org/git/YaaN0pibKWgjcVk3@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/CAPig+cT+YfgBG3Aqszp+y7iy_megboECZy3NkMqUjBj7=Z661A@mail.gmail.com/

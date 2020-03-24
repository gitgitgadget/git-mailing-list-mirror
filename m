Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1456C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF85920786
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 11:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4clJM6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCXLS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:18:59 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41340 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCXLS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 07:18:59 -0400
Received: by mail-ed1-f44.google.com with SMTP id v1so6106278edq.8
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWfdAFNmZX1Htp5LLNO+tmbwepH1tKPTRbLRpQicuKw=;
        b=a4clJM6HKibi/4YxYByepxvAmw1azkSa9T5pOHAmc6Cp3rMjJgPIspOqpGj3/kuV06
         LNTcyY+3IxUIJI8YDt/tTc+mL7Mnn4wiUCaEWDW62907zWz1RqInybh660S07RTOxTnL
         R6OUEm6qHUmth3srcLbeekdn07k2N7HG+sQTeXv+SQbQqmL32nJWjAGbp54VlhDKZ7C6
         PQ3NOjJxZ2bpgmAa3bhNgefQxM7zJQSKo6QDCEWQAEtZcaU5EON5DxNDSTFczbNuTa+T
         TNSVn7NCo6gYlpgKLhue36qximWrOg0YN/FJtFtXQ7KCSzGFROeOOjF2IZ/Z2w7bMeB1
         JaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWfdAFNmZX1Htp5LLNO+tmbwepH1tKPTRbLRpQicuKw=;
        b=BiS5tXrrLtPCg9ikHLC3oQG2c0F0i1lJFq06apPbE5GgqY+IW85RTwKDEDPLPNj/kj
         EE8N4YSwptF5kt8GAWxrSYsD7gRW9jjSkcO3J9cWSsJXsrR2XNQ11OU34Q3CDFGdaImM
         PIYLiS2xqjh6vdV+TDIiiJYdciueetDc0bmEvoOjwSaoke0mrN5j53Rbwe/dSVujlJIL
         Vj3Vd1EZW2szEx2Xygm7MJeFFHY3XG1QMPmj45VQHQ8FPc2QJiqPucFZg51tGeUmYS1b
         eHNQ8B3Pv/7ba7kyw8qCb20bi48tHOnDklFWBTsphOSKmY0umdCvfy0u54TnpprsbT1j
         9LGg==
X-Gm-Message-State: ANhLgQ1z0CD2sjr6fXkJ5fqWd6/Km+KPCtChCjZbhvOtRnU1M8EmnI3i
        xNprIXIX2j7BwO6sL4JAUQNr1DtfNORiTFxDFy4=
X-Google-Smtp-Source: ADFU+vv6Si4cembjAjo5fvkscx9VdvWNwZqQC3WkQn7xqoB0sa5jkkEuEt9DXiSDynpl17RX5DnpXCXwEzZE8h7q+AY=
X-Received: by 2002:a50:eb4c:: with SMTP id z12mr26129596edp.387.1585048737762;
 Tue, 24 Mar 2020 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CkUQ-dhyd_5ey1z-v59FzNyWFFVosMBfunSnN5t1EqxVMvVw@mail.gmail.com>
 <CA+CkUQ__JPsLCkkdHg7gh8J7VvXLA+v2j3NgV6cZAw94if=9mA@mail.gmail.com>
In-Reply-To: <CA+CkUQ__JPsLCkkdHg7gh8J7VvXLA+v2j3NgV6cZAw94if=9mA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Mar 2020 12:18:46 +0100
Message-ID: <CAP8UFD2nVnrudUWtNzq4Lc-zyXPU8r9wjvtnBgVTY4vQxsqLzw@mail.gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL v3] Unify ref-filter formats with other
 --pretty formats
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Mar 22, 2020 at 3:56 PM Hariom verma <hariom18599@gmail.com> wrote:

> I would love to get my proposal reviewed and have suggestions from you al=
l.

Sorry for the late reviews.

[...]

> My task is to change formatting logic in pretty.c. Actually, to remove
> the current formatting solution and reuse solution from ref-filter
> (maybe without changing pretty.c logically).
> As Thomas<t.gummerer@gmail.com>
> [suggested](https://public-inbox.org/git/20190331184930.GV32487@hank.intr=
a.tgummerer.com/),
> I=E2=80=99ll start by first looking at what actually needed to be replace=
d
> (for example by studying the PRETTY FORMATS section in 'man git-log',
> what which verbs you can use in the ref-filter ('man
> git-for-each-ref') to achieve the same thing.
> Then I=E2=80=99ll research how one format is implemented in 'pretty.c', a=
nd
> see how a similar thing using the ref-filter is implemented in
> 'ref-filter.c'.
> e.g. the "%(objectname:short) %(contents:subject)" (this is missing
> coloring, but just to get you the idea) is similar to
> '--pretty=3Doneline'.  Now one can try to find how 'oneline' is
> implemented in 'pretty.c', and could translate that to use the
> 'ref-filter' API.
> The idea is to use various atoms present in ref-filter to implement
> pretty format options.

Yeah, I think that's a good idea.

> Valid atoms in ref-filter:
> https://github.com/git/git/blob/master/ref-filter.c#L474-L520

[...]

> ## Blogging about Git
>
> I have always been reluctant to articulate my opinions and broadcast
> them to the world in any way. I have a long way to go as a writer,
> thinker, and as a human being before my opinions on matters of
> personal significance to me will be worth sharing. (Whoa! I have
> opinions about my opinions! Ad infinitum!)
> Having said that, I think GSoC and Git might be a great couple for
> facilitating my first foray into technical blogging. And over the
> course of the summer and beyond, I would love to write about my
> progress and experiences contributing to Git.

Good. If it appears to be too much of a problem, it's ok to just send
weekly email updates to the mailing list.

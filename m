Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274EEC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiC1SEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244897AbiC1SEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 14:04:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB52447380
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:02:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dr20so30304171ejc.6
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMlSk0bz9irlPdGb6qj3lgvQcYUN5Btz9bNiNnRgEsQ=;
        b=EPc8dS8rtLTWwcILGttsNl3/kdZR1E0mHepb9HYOndWfydcUB5PaQIPmUWdPfjDXGp
         JG1mp2VS8fEqs/FzVrVr53escOV631kz3Vm7FpXxFYJy2SBpvKO3z43kmuwZ6KCC6JLs
         K+1cEVH1zJ+ua9XKj92iDAxEkYjHAqhgAys1nYIofe/2k7AG5Vd3vjLgnDihrVOuKsZr
         PmUcN18KB5ewOK3lVX5/3SJqWXQ0tSr5NU35a40BamedeSC+YbpH6HdXVGBmzoO9Zllc
         Dzg5vNLqnkpCqkBkWJgRYrF2AggKtaTPAqxQIw8GNi8USd6aOLq1WQB0rgNiAMRp/PMW
         bQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMlSk0bz9irlPdGb6qj3lgvQcYUN5Btz9bNiNnRgEsQ=;
        b=kF/eFLUs3AsO2f7WwZhohQXEcfONYDJOKeYrTmG3W5bq35DxIHCZytJWps+l8fGJHy
         KizCT3D/SRP+mr0y6GYsTezxw40I023S7TXUGz0KxFwWkE/C8eMgXAuz6jsd/tJMijU1
         Huh8ZruWQbX0XyrdI+RK319GZ9hOdvdZJRfPOhd0iY8Tj8BVpimTAubzPoge6G7e6ZcX
         hM0V02UVJ+xhMQku4+CingTuszciqojIE7Wiwq4IU6jsUKL2PxLrbbvCXRl6RdZwQ49l
         87491swJWE96M1q/FuisglIt0Es/HXPEBuZSqgQ+k8dK4t77ApkEXh+8doDbXbgBrm0a
         jmxQ==
X-Gm-Message-State: AOAM532869OWU/MX2JHJ6csrlqd8Jv28TTIzVV3wf/F/pkJPSJfK8Qu+
        N2OjPXAHHlM1yIpcbm8gmU+67A413mUF1sHKKwvhgA==
X-Google-Smtp-Source: ABdhPJwRnc1sdbMvJ9f+ZtTWqq4FU81S+Ikpsu3AnBjzZL1laZwJYEj5zrnZ5orV9YhUkLjN/PoYOvccCL71uOhFstM=
X-Received: by 2002:a17:906:7d52:b0:6df:a6c7:2c5 with SMTP id
 l18-20020a1709067d5200b006dfa6c702c5mr30085609ejp.540.1648490541385; Mon, 28
 Mar 2022 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
 <pull.1183.v3.git.1648450268285.gitgitgadget@gmail.com> <xmqqwnge2ghe.fsf@gitster.g>
 <kl6l7d8et314.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqilry2dq7.fsf@gitster.g>
In-Reply-To: <xmqqilry2dq7.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 28 Mar 2022 20:02:10 +0200
Message-ID: <CAPMMpojYJ9sB7nbAAt1b_yH0Um1O-+TpSRYXTkZ6aDHobhS59A@mail.gmail.com>
Subject: Re: [PATCH v3] tracking branches: add advice to ambiguous refspec error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Glen Choo <chooglen@google.com> writes:
>
> > Hm, what do you think of an alternate approach of storing of the
> > matching remotes in a string_list, something like:
[...]
> > then construct the advice message in setup_tracking()? To my untrained
> > eye, "case 2" requires a bit of extra work to understand.

Interestingly, that was what I had in the original RFC. I started using
the strbuf later, after =C3=86var confirmed that a single "advise()" call i=
s
the way to go. I understood building the string as we go to lead to
simpler code, as it meant one less loop. On the other hand I
understand Junio is more concerned about performance than the
existence of a second loop that we should almost never hit.

I'm very happy to switch from strbuf-building to string_list-appending,
but I'm curious to understand how/why the performance of
strbuf_addf() would be notably worse than that of
string_list_append().

Is there public doc about this somewhere?

> Having said that, as long as you do that lazily not to penalize
> those who have sane setting without the need for advice/error to
> trigger, I do not particularly care how the list of matching remote
> names are kept.  Having string_list_append() unconditionally like
> the above patch has, even for folks with just a single match without
> need for the advice/error message is suboptimal, I would think.

Again, I'm new here, and not a great coder to start with, but I'm
having a hard time understanding why the single extra/gratuitous
strbuf_addf() or string_list_append() call that we stand to optimize
(I haven't understood whether there is a significant difference
between them) would ever be noticeable in the context of creating
a branch.

I of course completely understand optimizing anything that will
end up looping, but this is a max of 1 iteration's savings; I would
have thought that at these levels, readability/maintainability (and
succinctness) of the code would trump any marginal performance
savings.

To that end, I'd understand going back to string_list_append() as
Glen proposes, and building a formatted string in a single place
(setup_tracking()) only when required - both for readability, and
in case some aspect of strbuf_addf() is non-trivially expensive -
but is the "only append to the string_list() on the rare second
pass" optimization really worth the increase in amount of code?

Is "performance over succinctness" a general principle that
could or should be noted somewhere?

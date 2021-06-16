Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5582C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9401D613BF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFPUvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhFPUvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 16:51:06 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA9C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:49:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c13so3896745oib.13
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yUrLIjlWow99pQ2tNEIO0TrEMqFXPeZf2JxMAujHYiU=;
        b=CN8TN/oJSz7q/Ts4neguvTJsP+4+hsu/ix6WZVzj/gmaE5rO4eRYjw6dpwJj6ldxUm
         lGUzMXcWN1HOtL1bOMC+srpMC/KXWK9dXrGiVzTCsfEDSDa2oyb/XZgTDg28NXevP0Gh
         9rrnq+RCEEFEVPwaCEUTaLGKSUa5DgizZwovcvQzH5S5uHs7IeOcssDLxhzqeZLt0ZoJ
         GRs2GCndlYj0dhz6C4wavBRDhP/jOuY5kelLd4Qtf/KqKANYozGU5KhzZb21gzCUq4IS
         3dLKcMimeh6nZWOPpJcAxM1K1v6Tai/ZRL2cvaikdOjRhDqn5t1TQXpgYfL/B+6g3A6J
         0aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yUrLIjlWow99pQ2tNEIO0TrEMqFXPeZf2JxMAujHYiU=;
        b=DPWZejfN95CAKqsZyUhqOTPmsdOoIxKTkk3XJoLOT5j5kzj3WU2mNivqRsgibI9auA
         AtWjOKXyQjRVFTyAqCnpv0he9O9abCdcXT1muINuXqbRvgHGKr0B6bq5iNEv1ZiNtJPa
         mvKhojvxxd+fu62XOV4QLke97dl3FWfO7dBfJ66M+g0WOYcB56Zt1NBcLqFpTZD0Y/G6
         Sf8mlUJYQNIotdVX7F458gY7PlprpMkHgXkCl04y5E7nQuDIL6wdbe3lPLTpU1lxy+97
         TA1fAUxo0l6WabkPmqd9SmxkKNhwrXCbBz6FR7Bc756HsS4aVv7Mz9/zccQ1eQ/MDIJF
         PmSQ==
X-Gm-Message-State: AOAM5335lsw+CD6eQ4DlKBsoT4P+J6t6X/UwjBMz5X4ogCyGcMwnLII1
        XxW6YhslMzFIkOg6AED0fyI=
X-Google-Smtp-Source: ABdhPJxEfJFQ3ufvVU1nKk3wLjbZ4H2KruB91teArVJtFN34r3L/pUxgdBMDOXK6Ax3ohAL8sfAeqQ==
X-Received: by 2002:a05:6808:1d5:: with SMTP id x21mr8111510oic.159.1623876539815;
        Wed, 16 Jun 2021 13:48:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c11sm709236oot.25.2021.06.16.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:48:59 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:48:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@lukeshu.com>
Message-ID: <60ca63ba201b6_602720884@natae.notmuch>
In-Reply-To: <xmqqim2evdyx.fsf@gitster.g>
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
 <87tum0zfub.fsf@evledraar.gmail.com>
 <xmqqim2evdyx.fsf@gitster.g>
Subject: Re: [PATCH 0/2] extra: new concept of extra components
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > On Sun, Jun 13 2021, Felipe Contreras wrote:
> >
> >> This patch series introduces the concept of extra components. These =
are
> >> components which are not yet part of the core but are good enough fo=
r
> >> distributions to ship, and in fact, they already do.
> >
> > I like this direction.
> =

> I do not mind change, but it is fuzzy to me what direction you are
> in favor of.  Is the gist of the idea to split what is in contrib/
> into two bins, ones that are closer to "official" and others?  If
> so, I see sort-of merit in such a distinction, but whom is this
> trying to help?

Everyone.

  1. People who download the source code and want to install git in a
     similar way to how distributions do it
  2. Developers who have no idea what's good in contrib/
  3. Distribution packagers who want to know what's good enough to be
     distributed, and don't want to manually copy files (i.e. all
     distribution packagers)

> Distros would rather see what they use unmoved, and would not care
> where those that they do not use move to, I would imagine.

That is not true.

Distributions do not want to decide where to place
`contrib/completion/git-prompt.sh`, they want the git project to decide.

Obviously it has to be under '/usr/share/', preferably
'/usr/share/$project' (i.e. not /usr/share/git-core), but other than
that they do not care.

> So I suspect that it would help them more if we kept the ones that are
> closer to "official" in contrib/ and moved the rest to a new
> hierarchy?

Sure, that would help, but they still would want an install-contrib targe=
t.


A distribution packager that is maintaining 20 packages (or more)
doesn't want to keep track where every single file of her every
single package goes. She just wants to do `make install` and be done
with it. Any package that requires to manually copy some files to the
destination is simply a hassle to maintain.

-- =

Felipe Contreras=

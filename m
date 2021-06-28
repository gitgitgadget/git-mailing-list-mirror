Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0B8C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428E861CF6
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhF1VLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 17:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbhF1VLb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 17:11:31 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FEC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 14:09:04 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so23639282oih.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=azUFZYhsrmhRlnZzcXQm2wDY8SqrPcad3PhOdYJE7zE=;
        b=dkIV3dEx8lCDue/Y7k7uK0uGEwCMQBEePqQ5nn0p3GunpnJQWOnRj3vcrLopNws7Av
         BobvEiadsivUro9gFL4oh92nu2GVDRee9nCn8Gg6NLsk3/vnE73pNTA3k/V8FqFo6RF9
         4BaTzDcTW8TtJ5ArOLz9X9v3+9ORctSxewVXc1OvF5m9XFQbQdOEN7Saigong4pejtDU
         pi3rLYOsurrwvcg34mzi0wWpDwf/0WwcJCVrAyBnxkEDzJmy+uJlj3O0r4Z2vnMPbheB
         Jc4VDm/W7KPI19eTo3a7FZIDBs7MWU2t8Ex+mK+gKz7Nn7YGuM8BMXTq25xOQ5+trB+N
         5iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=azUFZYhsrmhRlnZzcXQm2wDY8SqrPcad3PhOdYJE7zE=;
        b=MTV9q1J+oODOB6Sg2J9uzGOSr5+b2ygoPupxFypz7m1nET9gBmlWozBzDw8qXjjtEQ
         vZ0qkLxQ5DQUbQmnkxsSPe08gC1U0o2YG5hGteSC1ryFqFk0h8CNxvq8WJL4/fO0VQSb
         yTZnCOQc7O9nKN437UvWn+siDvusHC2YTc0QCdwfqRJG3Ut93HY0yiO2NQfLcIIK5VUu
         xeK43/xbeS4yUyP0EHnp6iIBOgu0BjwJEwDZB/JuIh6F01ZZqgZXywCTaV8qx/sLb0eG
         qgQlv0Dji6nPZRdc4IXSN2huIZKWJXuUpf0GJxltikoyjCYB97er3DkDMVaCSgVtnvLX
         zK9A==
X-Gm-Message-State: AOAM531FEHK9PisSGOMH421iHxw1vmlY5T4JbKE9o7bCCmzSk/dDj+ok
        HO+aHai1MoyrymfE3F2TnV4=
X-Google-Smtp-Source: ABdhPJwXEOgTyeqQ7fz5uiknbSj0ISLOqZ2pPAZQXrNYRX2pDqgTZWDtCBYW5K4gWVqPJosY4/kUBQ==
X-Received: by 2002:a05:6808:610:: with SMTP id y16mr19288940oih.96.1624914543899;
        Mon, 28 Jun 2021 14:09:03 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 94sm3634404otj.33.2021.06.28.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 14:09:03 -0700 (PDT)
Date:   Mon, 28 Jun 2021 16:09:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Jeff King' <peff@peff.net>
Message-ID: <60da3a6e157de_1de4220874@natae.notmuch>
In-Reply-To: <029a01d76c60$24ad0ce0$6e0726a0$@nexbridge.com>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
 <60da10df509f0_1b95d2089c@natae.notmuch>
 <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
 <60da1c8de0ca7_1cdb420832@natae.notmuch>
 <029101d76c54$9f713c50$de53b4f0$@nexbridge.com>
 <60da2692e8029_1d6fc20855@natae.notmuch>
 <029701d76c57$f4d42f60$de7c8e20$@nexbridge.com>
 <60da2e775c3fb_1da1f2086c@natae.notmuch>
 <029901d76c5d$6137bc80$23a73580$@nexbridge.com>
 <60da363b3c532_1dcf420821@natae.notmuch>
 <029a01d76c60$24ad0ce0$6e0726a0$@nexbridge.com>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On June 28, 2021 4:51 PM, Felipe Contreras wrote:
> >To: Randall S. Becker <rsbecker@nexbridge.com>; 'Felipe Contreras' <fe=
lipe.contreras@gmail.com>; git@vger.kernel.org
> >Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; '=C3=86=
var Arnfj=C3=B6r=C3=B0 Bjarmason' <avarab@gmail.com>; 'Jeff King'
> ><peff@peff.net>
> >Subject: RE: How dow we educate our users to configure less?
> >
> >Randall S. Becker wrote:
> >> On June 28, 2021 4:18 PM, Felipe Contreras wrote:
> >> >Randall S. Becker wrote:
> >
> >> >I'm saying the **opposite**. I'm saying this should be done in buil=
tin/help.c *not* .profile.
> >> >
> >> >> Admittedly, I am in a highly complex situation, but it is a real
> >> >> one (ok, two because of a diverged path between NonStop and MVS)
> >> >> and there are hundreds in a similar situation.
> >> >
> >> >My patch [1] should work in all your environments.
> >>
> >> Your patch will work in the environments but not in the use case I
> >> tried to explain. I do not want a single configuration of less colou=
rs
> >> in .git/config or ~/.gitconfig. That is not going to work in my
> >> situation. I have multiple less colour values that would apply withi=
n
> >> a given arbitrary timeframe. The configuration depends on the specif=
ic
> >> terminal type set in the environment, either dumb, vt220, t653x,
> >> xterm, cygwin, all of which may happy in short succession. I do not
> >> expect it to be practical to change my git settings to conform to th=
is
> >> patch, so I am trying to point out that I do not see how it can solv=
e
> >> my issue.
> >
> >Are you talking about color settings? If so, what are the values of
> >LESS_TERMCAP_* that you have configured?
> >
> >> The current support, using the TERM environment variable, which is
> >> passed to git in all situations either by the system itself on throu=
gh
> >> scripts as is the case with Jenkins, is mostly sufficient for less a=
nd
> >> git to find its appropriate termcap on all platforms that I use on a=
n
> >> ongoing basis (Windows Cygwin, NonStop OSS, NonStop GUARDIAN, Ubuntu=
,
> >> MacOS, MVS, USS, Jenkins). The NonStop GUARDIAN environment does
> >> present some paging issues that do not work correctly in some cases
> >> with some terminal emulators, but that's the emulator's problem, not=

> >> the termcap specifically.
> >>
> >> So what am I missing?
> >
> >You still have not explained why this would not work on any of your
> >environments:
> >
> >  setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
> >  setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
> =

> I am not saying it will not work technically. Suppose I have a
> terminal session using t653x, which is not vt220 compatible - meaning
> it does not use GIT_COLOR_BOLD_RED or even have the concept of bold
> red) and do a git log or git help. I have another session using vt220,
> which works as configured. I have a third session running in Jenkins
> that keeps things up to date and is a terminal type dumb.

Does `git grep` show colors?

> Your patch appears to imply that I need to run git config to change
> the values associated with colours to make things work, correct?

No, you just need to enable color.man

  git -c color.man=3Dtrue help git

> So how do the three sessions all work simultaneously or do I only get
> to use one of them at a time and reconfigure when I want to use a
> different terminal?

Do you need to reconfigure anything for `git grep` to show color?

-- =

Felipe Contreras=

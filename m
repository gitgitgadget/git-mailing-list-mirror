Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADFC7EE26
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjECRKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjECRK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:10:29 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C227A8D
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:10:06 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6a5e905e15aso1995232a34.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683133788; x=1685725788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffUdhlBVuq/yz//ftWD5L7jW4AYWkG2+mNe5s+qOR7k=;
        b=a/NkS73hsLR4amPxMDGlaHCMt2FjflptpFiAJnQrPpCQj54pV5IVr3xs6d0RAeRTXF
         sFrjg1Pq4UmwRzalKCHX32kltOjfOZNZw9nf7PmW2v8/5NVMwLjKzsiLvp5jG49K8TAW
         KJugmHhGKZ7U1LhU9k2fvZp28A5GVWuFnANJTj3PaCJJMG9iBReocA9SemVTvPHfOelb
         yysxstUsZXoXeutY7J2V1RldpvmsAJcYNzvab0YsezlvlQRdfFfnfekAzY8p7EjCpPcv
         cqn4D4Ymtj978fY34gcwP05qQC90uVfkOcy95oFxSYA0UM9J0nVnptYv7iXvQWD2Q+HI
         xuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133788; x=1685725788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffUdhlBVuq/yz//ftWD5L7jW4AYWkG2+mNe5s+qOR7k=;
        b=aLe+5P1CtWAEnZIIEuRMpJ8m2s4TaWz4QWZ16MshpaJguXXaczygM/saD0ljgCOHLc
         3wc1ZoVQTbpiUAX8tElS7yE0jeqrLIptu15tFvgeSBzfK6MbvU5OozjmNHEvZgTFdwxS
         scKzzcOHRHCD9HFsOFnhGwHfYmg3fTXRZfVi9bgGxzQl46ETpAtS0P68zYI50h99R0lE
         I+cggE7Rv97QpV1GVjLQBUnEXR08E9t0K3YdY0RE/YNflMt4Gjz1RbyweQEZduXnyplJ
         O725E07boGv8FapF/sXJUvWIvLQH0yIvAlct83fmVnYmffvX8HBB1a34gdeQsgLQL2Os
         IjmQ==
X-Gm-Message-State: AC+VfDyNiOeqkQckXJMfDy3vbBi3HV9kzKvG5BUGcQsnW0ntz5N5tGXd
        lCQ1ju4ZLeni8qp1+xAFku+wKUeTbfc=
X-Google-Smtp-Source: ACHHUZ7IaN8Q8t8Mk1yvdKqUOQIGqcajDJ8gTL3zKslxSj3uYVykrhcjf6kPIuEVIqx6UtETjREhcw==
X-Received: by 2002:a05:6830:1e33:b0:6a6:f2e:d7ee with SMTP id t19-20020a0568301e3300b006a60f2ed7eemr11137427otr.23.1683133788325;
        Wed, 03 May 2023 10:09:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u12-20020a056830118c00b006a30260ccfdsm784874otq.11.2023.05.03.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:09:47 -0700 (PDT)
Date:   Wed, 03 May 2023 11:09:46 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <6452955ade0c9_1df7294b9@chronos.notmuch>
In-Reply-To: <20230503164354.GC1789686@coredump.intra.peff.net>
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
 <20230503164354.GC1789686@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: manpage: remove maximum title length
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 02, 2023 at 11:29:26PM -0600, Felipe Contreras wrote:
> 
> > DocBook Stylesheets limit the size of the manpage titles for some
> > reason.
> > 
> > Even some of the longest git commands have no trouble fitting in 80
> > character terminals, so it's not clear why we would want to limit titles
> > to 20 characters, especially when modern terminals are much bigger.
> 
> Makes sense.
> 
> Since the manpage header shows the name twice, along with "Git Manual",
> the practical limit for an 80-column terminal is somewhere around 35
> characters. If it's not hard to do, it might be worth setting the value
> there,

It's not hard to do, but that would create a discrepancy with asciidoctor
manpage backend, which doesn't do that.

> I could also see an argument that the truncation is worse than any
> wrapping or other ugliness that the user might see on a smaller
> terminal, which implies that "no limit" as you have here is the best
> option.

I think it's best to remove the limit so there are no surprises and the output
is consistent among tools.

> > For example:
> > 
> > --- a/git-credential-cache--daemon.1
> > +++ b/git-credential-cache--daemon.1
> > @@ -1,4 +1,4 @@
> > -GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
> > +GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)
> > 
> >  NAME
> >         git-credential-cache--daemon - Temporarily store user credentials in
> > @@ -24,4 +24,4 @@ DESCRIPTION
> >  GIT
> >         Part of the git(1) suite
> > 
> > -Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
> > +Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)
> 
> Your patch can't be applied by "git am" because of this diff in the
> commit message (it thinks the commit message stops at the first diff,
> even if it is before a "---" marker). The usual practice is to indent
> the included diff.

All right, I'll send an update.

-- 
Felipe Contreras

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F266C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjELTTh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbjELTTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:19:36 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBAE7AB8
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:19:31 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-54fd5aae4e7so2829855eaf.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683919171; x=1686511171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5pCpbbRab6byIgVKxazgPCY+Bx5JdoNIq701Rcpc6w=;
        b=gu1vnmiNWzL8wrvYVciqz3O8Ml1a5Z0tpva7kzBv/fuusYBcVn8RiOsBtUJqwVQ4gF
         FgYdx95uM1SOSaq6i5TRSunFdtf1HVjqx5oiEE8pntgGyZi4LNI5y513MmXSreUtRgDc
         3D5g3qOkhHwF0bwtNGuTciXZ7WgJ0zdFFlhs+6ma0NLbCoXROb2OT/BYvTtNRUKlo8M4
         1h0i2AMxEN+97h7VMECkwTxcfQ6qlLyhuD/nCyC3EACUwoqfsr2xPTwM5f+HCPGk7zEP
         MLHB49pJVb/uQ4JM3oTORTxcbA/eg3ulL2wYnPxI8Jom4y+896TxuWAensSzF4D7hLru
         2Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683919171; x=1686511171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5pCpbbRab6byIgVKxazgPCY+Bx5JdoNIq701Rcpc6w=;
        b=EH2xSKsiRyW7pBNbzCzLv3DO6XA8FxhlkmdjCRBz8OOySP/cXxXI8Xbuvt9ZswHbGL
         TuXmKmfvQEXUCYOhDaH2NR/j4tcNKs+BfCvT5iuRmMLqCxznXpm2GyTUVyA8N65TGzwT
         I/SpZpWGOLYHJ3D543qxkieNSFx4Xr+fRTug8LZPgCQ9+Caxbm1APeRcm/GTlVvTu2kF
         ThV5H7aRiWFMMDjfelsi5fDHhpUFZuZzuJYHn6z0gW0vUuXLDOg4N5DPwUymbH67e4jC
         6b9Fa7VVFUjUkSdahYf6S9aHS3uothWZzfVfej7+l9I6w3OiLwbKd6KeqdfwdD6t5XoH
         V3qw==
X-Gm-Message-State: AC+VfDycSMQvLgutdbMy79t5eMJzopFEIICgYpnLYFKoc8TIPyVH0znL
        sVvN5M8DMPiJuWiQHlBvJLE=
X-Google-Smtp-Source: ACHHUZ6UHfDeTMK8Gal2+KiyPaikSVGz8ShrLHxXOz0cOVcbSZgjRznl33o7j+bHN8kKfgyKIXeamQ==
X-Received: by 2002:a05:6820:5b:b0:54f:5c56:a0c1 with SMTP id v27-20020a056820005b00b0054f5c56a0c1mr6702559oob.1.1683919170458;
        Fri, 12 May 2023 12:19:30 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v24-20020a4ae058000000b00549f4d87eecsm4437136oos.30.2023.05.12.12.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:19:29 -0700 (PDT)
Date:   Fri, 12 May 2023 13:19:29 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645e91411e4e5_21989f294de@chronos.notmuch>
In-Reply-To: <873542j638.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <645d28e112294_26011a294b2@chronos.notmuch>
 <877cte200m.fsf@osv.gnss.ru>
 <645d3dbf785a5_26069229463@chronos.notmuch>
 <87wn1ezms9.fsf@osv.gnss.ru>
 <645d480be344d_260ff5294c@chronos.notmuch>
 <87mt2azkdp.fsf@osv.gnss.ru>
 <645d572a47e5b_57c4e294dc@chronos.notmuch>
 <87fs82zdny.fsf@osv.gnss.ru>
 <645d7a153ac66_1ba85a29451@chronos.notmuch>
 <873542j638.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > No, it's very different.
> >
> >  cur: git diff --raw --no-patch # no output
> >  new: git diff --raw --no-patch # raw output
> >
> >  cur: git diff -s --raw # no output
> >  new: git diff -s --raw # raw output
> >
> >  cur: git diff -s --patch --raw --no-patch # no output
> >  new: git diff -s --patch --raw --no-patch # raw output
> >
> > I've no idea what makes you think these are exactly the same.
> 
> I was discussing the behavior of defaults rather than the behavior of
> particular option sets, and we already agreed about the latter from the
> very beginning.

OK, but that's a different topic than:

Subject: Re: Can we clarify the purpose of `git diff -s`?

I think if you want to discuss a different topic you should change the title.

I'm not sure I'm interested in that discussion, but I'm glad we agree on what
`-s` and `--no-patch` should do.

Cheers.

-- 
Felipe Contreras

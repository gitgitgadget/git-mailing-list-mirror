Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFEC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 17:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A38611F2
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 17:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhJURmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJURmu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 13:42:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9AC061570
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 10:40:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w19so504623edd.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=l1sCsp+Q7gIAKkW6uZ3LD2yYB0bWchmnq+Uf3du9TGQ=;
        b=M9YgDVr8Xdat4I1vjPXkOiyrIeVtM/lkIQahu1sar2Lr08ec9IPktaxA2qGz+n/d76
         sIb0wYtoC3YNYqSwe7Za/rkbzrEA88VYmCY7laBDOcXpQ3C1bCgQBEQyg1xu5wat0i/e
         qCt/K/uGadZymgqBvxA2vUwDhkoG+4d3ggWfdj36dLEoDw479va3nNqlF9qc9Nm3X9CA
         ZAThmIy1yfgLVvF81ZTw/g2194KyhzvgDKickqWMnnRc+acdi+LjWH098mvy7RxxjrhK
         ZPMf8zUPhfrTcIuzX6lc5N6f+Dt7ymRdLXvsbl3KxHwFO1B0gGAbXIy8i04uGFPRpnsT
         SC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=l1sCsp+Q7gIAKkW6uZ3LD2yYB0bWchmnq+Uf3du9TGQ=;
        b=qnmEtbKrtqvJcnklcoVOAmCiBMxVs2r5o0pO8OhAJaCm6JAPAQfMGEhBwKg49BhusX
         kCElih/xKloTMCJ0+NOx6wZPVXkYhwtT2nz9zJDLfM+yLfS9kTK7UvfRtc+3ZjhmAS+d
         0ewcTQ2zj875q/1S94Jji1XXkngJJusJXfK1e7bczZ8WDgUstp24EpGhszabzoFuYdRw
         B+J3yP96H/7eVVjOByQD1lwEBNDQwO3RqdBZ4FDSy1ibPpgVVLUwLxKzE7bIDtJZIRmz
         EEzfQtKlfvymanLg7OTbjvql54UV4qTHLN95KE2h0bpeBunl7vaAaHSjhLol7AZJvqjw
         klvg==
X-Gm-Message-State: AOAM532te6h84e4I2NGmR8y8dNDOccEQ8MZodnOQvBI8fjfpbJxvK3yT
        fQWKD9LegufTBs6WdQTpTlBbAPljC5zxMg==
X-Google-Smtp-Source: ABdhPJwHxFxquGfk7mfns/apJz23NlmiP0Lbbvb44Q/Ldq/0SEGngfFrdK3D2bQaow6ZxEUur/XBJw==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr9275460ede.142.1634838032135;
        Thu, 21 Oct 2021 10:40:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j22sm2790311ejt.11.2021.10.21.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:40:30 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdc3K-0012bd-7k;
        Thu, 21 Oct 2021 19:40:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
Date:   Thu, 21 Oct 2021 18:45:44 +0200
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
Message-ID: <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Johannes Schindelin wrote:

>  7.  =C3=86var: On switch/restore in particular, there was a recent discu=
ssion.
>
>      1. Ultimately came down to inconsistency with other commands in the =
same
>         area
>
>      2. I gave some suggestions

Those suggestions are at:
https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/ copying
the most relevant part from that:

In summary, I think it should be changed to act like this:
=20=20=20=20
    |---------------------------+------------------------+-----------------=
----------|
    | What                      | Now                    | New             =
          |
    |---------------------------+------------------------+-----------------=
----------|
    | Switch                    | git switch existing    | git switch exist=
ing       |
    | Error                     | git switch nonexisting | <no change (erro=
rs)>      |
    | Switch with --merge       | git switch -m branch   | git switch --mer=
ge branch |
    | Create                    | git switch -c new      | git switch -n ne=
w         |
    | Create from existing      | N/A                    | git switch -c ne=
w [<old>] |
    | Move & switch to existing | N/A                    | git switch -m ne=
w [<old>] |
    |---------------------------+------------------------+-----------------=
----------|

>      3. Some patches started, there was some trepidation about making cha=
nges,
>         though

I was thinking of this patch, i.e. it implements the "-n" option for
"git
switch": https://lore.kernel.org/git/20210709174310.94209-1-felipe.contrera=
s@gmail.com/

We could then add the same to "git branch", i.e. "git branch foo" could
also be invoked as "git branch -n foo".

We'd then need to have a hard change in the semantics of the
(experimental) "git switch" commant to make "-c" mean "copy" (like in
"git branch").

We'd then reach an end-state where these two commands would behave in
the same way for these common options, with the difference being that
"branch".

Whatever anyone thinks of my specific suggestions there I think that in
general we should be trying to aim more towards that in git's UI, even
to the point of slowly phasing in deprecations for non-experimental
commands. E.g. the "-n" option to "git fetch" comes to mind, which isn't
a synonym for "--dry-run", as in most other places.

I realize that doing that is hard, e.g. Josh Steadmon has a patch
on-list now to add a configurable "inherit" mode to "git branch[1].

I noted in a similar vein as the table above that it would leave us with
another inconsistency between "branch" and "checkout"/"switch" in [2].

Does that mean we shouldn't take that patch and others like it until
such UX inconsistencies are addressed?

I really don't know, but I do think that the most viable path to a
better UX for git is to consider its UX more holistically.

To the extent that our UX is a mess I think it's mainly because we've
ended up with an accumulation of behavior that made sense in isolation
at the time, but which when combined presents bad or inconsistent UX to
the user.

1. https://lore.kernel.org/git/9628d145881cb875f8e284967e10f587b9f686f9.163=
1126999.git.steadmon@google.com/
2. https://lore.kernel.org/git/87a6j6tbsv.fsf@gmgdl.gmail.com/

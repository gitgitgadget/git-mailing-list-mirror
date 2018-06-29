Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A621F516
	for <e@80x24.org>; Fri, 29 Jun 2018 20:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeF2Uvf (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 16:51:35 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36623 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932526AbeF2Uve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 16:51:34 -0400
Received: by mail-yw0-f182.google.com with SMTP id t198-v6so4121999ywc.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+wQEyryKf9ZRchI6RzyxHyDCizmXVnHk1EthVyufyo=;
        b=NJTNKHFBWq+yesPoratzFlQKQNa2tQIrUveSIeR76ZHiCGFOosPdosXAiytvt5WR2j
         Eg1JaIU8Ty63RMhIhLiGw8xd4zQyRld2VdPLmisKaJTpNcEloiNfW2zUDxXHffHM89S/
         SKUAF8jJzps70NXN5gPQaV9wkdbawpTucKrJ3yumhB+KjZ4nJK2yfHvycQAqHptBV/gi
         G9H7qzCTwoo2gGBDca+nmV6GNQNLT4D22YvRxhNb7tUjahI4pO197UIWIykWT2ruWBv7
         jcBoWEOGCKjljopxdYinAFvsicMadDKvOuO9OGv36m8rUt/0mDIqPGd8cHFbFHgFxj60
         qSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+wQEyryKf9ZRchI6RzyxHyDCizmXVnHk1EthVyufyo=;
        b=iD5auQ25xx0T+DBMWDyPBWNVdDmaJCoLzqomo/VadXBVTYqTL7aTGGXo0ck7iTzATk
         L5fgHsPBVDNMNLnjhYq/3lCImJNep/qO5gCeULM/qhYM/RUSeLVqK2dEzK2mmNCWfucb
         qVNQAoF5ftzu8tYJvWCYAxUb52tjesQlblDAbuygavN+X4/2zHxCggpG9Qc1QGosdJ7X
         oRvo2MkRa0TxDGujWVpx6uTDHi6yt+DnozPBfvZ0fmVGJ/QWEWm8bQ5+Se+wpjeN1tsC
         U4ww7WMWMyJm0Bstly9j5xXWfKU8PDi6IBz7NHahJWnTo3X7LmNTBr5Hx4xmINtnoUlB
         MUEw==
X-Gm-Message-State: APt69E0FiqYUxpcvOTElWNw566darS8o8PU2LnuQ+o9PWRXYRceWhSWY
        VkAW3Qifa2fXr/aQYAzdY1W0Fba40exqMVdJmwCHHg==
X-Google-Smtp-Source: AAOMgpcLHZG38G7fbsGg9oPTH/1hbRhV1xl5KawSUTslbVQ+06t0iFR1p34WY40c8S5qhcUajprmcR+l/4xVUZKVYUY=
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr8535226ywa.421.1530305493250;
 Fri, 29 Jun 2018 13:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180629094413.bgltep6ntlza6vhz@glandium.org> <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
 <20180629203904.GA27566@sigill.intra.peff.net>
In-Reply-To: <20180629203904.GA27566@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 13:51:21 -0700
Message-ID: <CAGZ79kYSFnKhMPi3J=C-XHMuAg90J76Vir6ocv0uKWoKts4P-w@mail.gmail.com>
Subject: Re: fast-import slowness when importing large files with small differences
To:     Jeff King <peff@peff.net>, quark@fb.com
Cc:     Mike Hommey <mh@glandium.org>,
        Jameson Miller <jamill@microsoft.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Jun Wu, original author of these patches

On Fri, Jun 29, 2018 at 1:39 PM Jeff King <peff@peff.net> wrote:

> > Interesting pieces regarding performance:
> >
> > c420792217c8 xdiff: reduce indent heuristic overhead
> > https://phab.mercurial-scm.org/rHGc420792217c89622482005c99e959b9071c109c5

Going by the mailing list, the first patch was not brought over yet,
so sending it here was warranted.

Jun, you may want to take ownership of
https://public-inbox.org/git/20180629202811.131265-1-sbeller@google.com/
as I merely resend it to the git mailing list?
If not, that is fine, too.

> >
> > f33a87cf60cc xdiff: add a preprocessing step that trims files
> > https://phab.mercurial-scm.org/rHGf33a87cf60ccb8b46e06b85e60bc5031420707d6
> >
> > I'll see if I can make that into patches.
>
> Apparently the second one is not so trivial as you might hope; see
> https://public-inbox.org/git/1520337165-sup-4504@x1c/.

Thanks so much, this saves me further effort to dig there.
So I'll just stop porting this.

Thanks,
Stefan

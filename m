Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40138C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA8D64E68
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 23:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCNXHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 19:07:20 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:43304 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCNXHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 19:07:20 -0400
Received: by mail-ej1-f48.google.com with SMTP id p8so63198729ejb.10
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 16:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KU1I/uXy6+il91btI5taVoae0BiJLRQGvgcAQhif++w=;
        b=Maze7EZHB1VH2XyRIa8JDvA/sQn53dT+m5LxibtHpauAU9ExJvUCMvtnDStc7N0Wlb
         wXp5tR6tpvBg5BHVRUlnOHQQGTlFf+PktjklAXavmtK83BvpwBgfbEzpbfM8lDJh8XgO
         zjkRrh8v07M4nNNPE2qLslnQwE1D2id5xIOnbKiOd1TnPQ1+3jDtk+IfZra0wTZXXT7n
         7pCBqh5JkCkCSMl9MIhUyJKyfsH4SIdkPDmgJRRWOoE5hfFNz9kXTt4ICa6bRGu6xjXG
         SpY0NYLjMa2y/y15DCu2gABLW/7F3nLTcA8pp8n0I5nMjTNZj8+Z9bsTUWrdfG1F3h1w
         9UbQ==
X-Gm-Message-State: AOAM531uf4RjghvLt4MYNx0bntNzh+tKlJ/t1lL/VVPkZa7kVqXqU3zf
        MuB+VbIBxrhKtA8FmEcBvsiFBoQa1qHBapmVUdM=
X-Google-Smtp-Source: ABdhPJxNSeb43yq5TXYBBT1xnnw+ib+My0f1XHoExyd6+B+I7m1vZvnIQF87qwzGlsCZXi5FB2Koes5+tldeJSSYEeg=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr20583677ejg.482.1615763239127;
 Sun, 14 Mar 2021 16:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
 <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
 <xmqqft0y4gl5.fsf@gitster.g> <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
 <xmqqblbl4aro.fsf@gitster.g>
In-Reply-To: <xmqqblbl4aro.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Mar 2021 19:07:08 -0400
Message-ID: <CAPig+cTO0umN4nAQi_qZEvTByCHFVavM-KbtfhkukXEUdzLPhg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 14, 2021 at 6:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> FWIW I am also fine with Eric's simpler "open code it right there"
> suggestion in this case.  Just like the "skip alphas" suggestion, it
> makes the logic to parse subcommand name out isolated to a single
> place without asking readers to refer to the implementation of a
> helper, and it would be short enough.

Likewise. If you're going to re-roll anyhow, the open-coded:

    char *p = fixup_mesage;
    while (isalpha(*p))
        p++;
    if (p > fixup_message && *p == ':') {
        *p = '\0';
        fixup_commit = p + 1;

would be perfectly fine with me too (or any simple variation on that
theme). Whether or not it's worth re-rolling again, I leave up to you
and Junio.

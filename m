Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438AC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbhK3PGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:06:41 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:34531 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbhK3PBI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 10:01:08 -0500
Received: by mail-pg1-f179.google.com with SMTP id 200so20055049pga.1
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcbR+Z0L2wpAZ1k3SV6ig9bC6YALxS0TpK/M0+rGqqU=;
        b=BE0jF/ibCfTQNh9uuLvSpfmGtFg2v7ozRxCbpG/k0mkzUMaSwA5hO5n2DRFmC+2H3I
         oNFXfwjwPki11UdHbTBemN+cA9kmqwS7PSr8MIjnKM02Dl8cfwEAb5OlLFb1DciyYINf
         wTQfGCmXunviKwlAIYGUCRBtWusdOEDItRq8lX8LxDBhkA6NNHhrA7SuFqQ74lkHnnds
         +un5ZNUyzTF3sNqJFfoOdzR50qXw5tR1MuNvnuH5Q1Ca3YifIxI9fN/5bkSwtdaVfBMS
         HoETd7yJPidrMyREnYDCy1edKYl3pWwtyGH2h3rPM1nKArJOT9FIrFLTK88CYgyJFroA
         Hg4w==
X-Gm-Message-State: AOAM533f/JVekP/mffnIdSBJzIm26Ce43lO63DCkwj967+eEOYTEHbNW
        iSbijV/ehJF/yOxQv0Sp56XhslJqQK2DjSh9rjI=
X-Google-Smtp-Source: ABdhPJzXXel8ZmmiEzR4P4nRA0TRSypU3Hd84tMFhBM3bnK8iGuscVe+nyJDyvPIvXmwBd/J0//J25Dz0Nu0ZqnKp6o=
X-Received: by 2002:a05:6a00:2171:b0:47f:d231:25f6 with SMTP id
 r17-20020a056a00217100b0047fd23125f6mr47135926pff.4.1638284264878; Tue, 30
 Nov 2021 06:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net> <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
In-Reply-To: <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Nov 2021 09:57:33 -0500
Message-ID: <CAPig+cS1ozLSJQgEJemDb+==NdB0ru5p4xknN11dkp6GJJM9iA@mail.gmail.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 9:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> (2) With git-worktree being four or five years old, for
> backward-compatibility concerns, I worry that "that ship has sailed",
> where 'that' is the freedom to relocate those status-like messages
> from stdout to stderr. I don't want to break tooling which exists
> around git-worktree.
>
> I'd be happy to be wrong on the second point -- indeed, git-worktree
> is still marked "experimental" in the man-page, but that may not mean
> anything this late in the game -- and submit a patch which places
> git-worktree's status-like messages on stderr instead of stdout.
> Thoughts?

If that ship has indeed sailed, then perhaps the best and safest thing
to do is admit that git-worktree is an outlier in terms of sending
status-like messages to stdout, and just sprinkle the necessary
fflush(stdout) around in builtin/worktree.c and live with that
localized ugliness. Thoughts?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF0C1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeCRW7d (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 18:59:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34844 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeCRW7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 18:59:30 -0400
Received: by mail-qt0-f194.google.com with SMTP id s2so1094931qti.2
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=O41+7iwU2OoNxfXz4v9g8aMcxnbxhDeuxLd9UlI1svU=;
        b=YnT4HZzNolWh0DU/g7X1aIhdyk1Q2+WVpzqLSkUoe8O7jRy4XBvOPfusz08XieIslN
         tEDmRtgfhbznWYBvXm2v7GOUyIdnhq1xeiOQcLEvxblMNEoX0AYRpeuGnB6Fv0a28i7n
         3AqJBhq5u3UzcXlOBPbknw1zWJU7nQ8nrcr4jvL7IL729JgmJV/YrquBcPfcw2+pvBN4
         +aOSFlRJfWq8o2RVOkeLuUwHg8yC85mVEGVeuPwjOb7TBTN5AxUcNmllBxqGwDeT9AIr
         k8qzMXJBudRoOH4BXme/XUbchjjNkG3Mv/WFXuI0uKbtaspYL4gm8wahqNqbtUlzSY8/
         ZrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=O41+7iwU2OoNxfXz4v9g8aMcxnbxhDeuxLd9UlI1svU=;
        b=BELEzry8hXAUMp28Qrq53tpnh1dWn2pVgQp5e63dOSpJsc+LtsOmrrD8C3EupVN/lA
         EJYjx59RGTAD3CQEA7ys/X8ma87V/8d4sv7CxClAx+/zB2p/fyC3sQ/BIA8HFsckv7S9
         vB2ScLdQUlnqBtOq0PnFEvlF+vvokoRO4grNCtH6Z0wHabFN7whtyP1e7MoLfnKkE4jM
         7fnvkDtddD7gVQpHLnBP9Sf04CiK65y2nnLjSY2DXhWZXoE5fJtc3Qg4Q8rNPyIgib2C
         zIukusK63FvNWDHoosrdyoIzrGhEhuk6JXADTvTIyYR7d51kZFyjMfBmoX3AhucGzVhv
         /uaw==
X-Gm-Message-State: AElRT7E0ganPlqkAZMo6dtosGHjPcVGCf2/Oo6oPDaO761kvRQcJBFZN
        vlhHPRorRhFGeiQohA49Az5Nu+/fuPRJ+7Gfpds=
X-Google-Smtp-Source: AG47ELujuqnWW98oAHxJY3GoATPTUooD0WxsSsxcu7sFkfjDgqR6ugzn0e/T90AacLhyNmqJ6fFmC37rVLgVxGvAvK8=
X-Received: by 10.200.50.174 with SMTP id z43mr14556282qta.250.1521413969250;
 Sun, 18 Mar 2018 15:59:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 15:59:28 -0700 (PDT)
In-Reply-To: <20180315164412.14697-4-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <20180315164412.14697-1-pclouds@gmail.com>
 <20180315164412.14697-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 18:59:28 -0400
X-Google-Sender-Auth: 6MeSWAvw1540TdpHk1fRttsox44
Message-ID: <CAPig+cTwFCtNNJomC-8RHNYErkbZ821hm3mWGBXATedEcy44Jg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] worktree prune: improve prune logic when worktree
 is moved
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 12:44 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Automatic detection of worktree relocation by a user (via 'mv', for
> instance) was removed by 618244e160 (worktree: stop supporting moving
> worktrees manually - 2016-01-22). Prior to that,
> .git/worktrees/<tag>/gitdir was updated whenever the worktree was
> accessed in order to let the pruning logic know that the worktree was
> "active" even if it disappeared for a while (due to being located on
> removable media, for instance).

This is my fault since I suggested this rewrite[1], but other
documentation calls this <id>, not <tag>, so: s/tag/id/

(Again, not worth a re-roll; perhaps Junio can tweak it when queuing.)

> "git worktree move" has come so we don't really need this, but since
> it's easy to do, perhaps we could keep supporting manual worktree move
> a bit longer. Notice that when a worktree is active, the "index" file
> should be updated pretty often in common case. The logic is updated to
> check for index mtime to see if the worktree is alive.
>
> The old logic of checking gitdir's mtime is dropped because nobody
> updates it anyway. The new corner case is, if the index file does not
> exist, we immediately remove the stale worktree. But if the "index"
> file does not exist, you may have a bigger problem.

Makes sense.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

[1]: https://public-inbox.org/git/CAPig+cQG8yEqunNUjoEAPY-W9+TtzWADhgjdL6ud=
nyrG0YEOVg@mail.gmail.com/

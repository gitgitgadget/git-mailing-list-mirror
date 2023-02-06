Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC08C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBFTFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFTFA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:05:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064E22A2C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:04:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bg10-20020a17090b0d8a00b00230c7f312d4so2977093pjb.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U7YUSiLezbsPh7dGqIvF/ohbx6E5EMS6G+zb2LpYq4=;
        b=qxWVsNDyZE1LmXrXGqtp8ekzHDfSzw2vdhvwtCV1vQvK1GnymndS4PlHI1AkOpDHzM
         u0+9a8BHVb/bbVuwTkzkezor8zU0BbVmdAMnhgEN1Gdd3o3CY3whu8ney0YisEG7jZHy
         sCu0jFcjKk8xg0OoY3VZChx4uSis+XSinLHWKKNl6SM8wtyaVNk+bQtEoTZ5pz8eiEo1
         zXk9a3SJcsnLRA5uDCZgx9CYpRqPrNGAI+3+ZxaB+u771MoaOV4/rV6CnDkZ6ib0FOyF
         WqkLsmp3Pa96gZWJxsaiXE4047Mfyractm2uH2hqicOMD/JfDZSMehAkZUtVY924xugv
         msyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3U7YUSiLezbsPh7dGqIvF/ohbx6E5EMS6G+zb2LpYq4=;
        b=7m1pjjdG9TPTwMcY6K57ABqXJBFXmWxVzCuuEYHjUIdO5te9kohpjzVuBYLww7ID9R
         P8c75nQaMoHT4kNEX3NuFx3GArC0941RykMv7CqWUsDbG2leivoDA6um2zsCqmKNS2mE
         Bg8qRbjJgd1zBwtOMXLp8B7AtobEBxEz+ogl7BRagFbUbI40Moo6JTxgwMrr9DGBBF48
         D+UautQtT84VmFXSs+IP80OyvAeaailmBKbQadewEtrVpdMN8WsBwREVj++17gMbWBDC
         xmlEZN9xFkiFso6fZ4nutVvvTrou7V953r+2Z5jn0f+SHReJoWmNEOl1IBYLs0kHVQZl
         K7VQ==
X-Gm-Message-State: AO0yUKUJj9Jr1N4lLVcO8TO9Q/SstvrrEayHqEkMrYTkr7JEXXX3QWdj
        OwLej2gMC8xC9+5I1BK1Sa8=
X-Google-Smtp-Source: AK7set/VG7NbLo0XoB+s1wpkgTw4UxnMiKf9ReUQh+ZfNqmAN3NsKL1OeCWBjhGRrnesER7yTHFDlQ==
X-Received: by 2002:a17:90b:1a91:b0:230:7dcf:f094 with SMTP id ng17-20020a17090b1a9100b002307dcff094mr7921987pjb.11.1675710299018;
        Mon, 06 Feb 2023 11:04:59 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090b051300b0022bb3ee9b68sm6755114pjz.13.2023.02.06.11.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:04:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
        <xmqqo7qqovp1.fsf@gitster.g>
        <0d04f8ed-6933-9354-1f64-24d827424c71@gmail.com>
        <xmqqzga5b4yz.fsf@gitster.g>
        <a66218a3-919d-eca2-1859-41ac02aa38e7@gmail.com>
Date:   Mon, 06 Feb 2023 11:04:58 -0800
In-Reply-To: <a66218a3-919d-eca2-1859-41ac02aa38e7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 4 Feb 2023 23:46:47 +0100")
Message-ID: <xmqqwn4u7gyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> The devil is in the details: "git branch -m", "git branch -d".
>
> We're not ready to have BISECT_START pointing to a deleted branch, or
> renaming a branch pointed by it.

It indicates that the callers of find_shared_symref() to see if "is
this branch being actively used by checked out, bisected, or
rebased, and I shouldn't touch it?" need to know more than what
find_shared_symref() interface gives them---namely, "can I repoint
it to a different commit?" and "can I make it disappear?" are
different conditions they need to be able to learn.

Until that distinction becomes expressible, I am actually OK with
forbidding both operations, i.e. while a branch is being bisected
elsewhere, we should be able to update its tip to point at a
different commit, but it is OK to forbid that because we cannot
allow the branch be renamed away or removed.

Thanks.

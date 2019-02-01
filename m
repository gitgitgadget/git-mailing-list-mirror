Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84901F453
	for <e@80x24.org>; Fri,  1 Feb 2019 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfBASGI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 13:06:08 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35139 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfBASGI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 13:06:08 -0500
Received: by mail-wm1-f54.google.com with SMTP id t200so7196610wmt.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jW51zXoqi8NLKvNeU11/n+WNW2s+bWu6ngPOgqSBAwo=;
        b=hP72/Y+VPe6g0nsnvQc9+G88DAHeheOlAvUW9nWX5dSM7r5Oy+KF8wgu3/eMwk6o/o
         B1s6vQLV1FZV2AqujNxW8DZu4t1OBRGgG0sP4Yp0NDxsdJeKYu9TNQUuMKxG9YpkbdtD
         ZoU6rHmiLV5ynWq/umhPkoNPkv163Px9s5Gw1FyntPl7lE6tTYTPEzIxmE5YtEMScaXh
         6VDOD/3BBRgKVzmgNUNdWw3VsN0vHdWZWi2BEReRbnlfFEkyn57LtMLmprXU2rwJ44nA
         6JS47ED1TmXW3c6sKBAPuYKBEXoc589OFle9C7fSw5lep6Rml3Qg1cpX5wN3rxZYY/mi
         2BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jW51zXoqi8NLKvNeU11/n+WNW2s+bWu6ngPOgqSBAwo=;
        b=tRF9fzJI3xL9Rku8YGMsTpWnQzHi1dIBBWgIETtHSv6yp6u/SvNEvNpGfRWDbxG/wc
         B2OoFjJQyiZhTUi5PQHPEQO1vfc3/UjjVXGzcWBx809jED+ZKmfturcSKQXvLN5YH1c5
         20H0rozXipD/K051770Wy8WhCJsZLP/6Paz6FrUKyDbiFThx1jjiCuAF5Lle1UQqwclM
         5KizN9yUcVG4g2HSS0nx0+vXkiWqPVJy42HLZjclsd5JPWupCZHsKYYbE43fklWYJNRd
         v/a1JJhVr+EXQ2UD2IsNN9ztN3DfIRQxNMX144ka/1ri7pIYjcTZcRs+6wl2azIfrGxh
         6U6w==
X-Gm-Message-State: AHQUAuZJFVL0SrhoorHBBbnozA2lGBeUNNkEdpvh6dfs4+ffvSfli7Jn
        QpSFqwBWtRm5494Yf89JcdA=
X-Google-Smtp-Source: AHgI3IaKNLoMox6uPYwz8crhbTOnpEWrGul9oggm5ihFMFn0l4QeSYPiFAAD+zwby2dofhSwnKH6dw==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr3427554wmc.35.1549044366101;
        Fri, 01 Feb 2019 10:06:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i13sm6998156wrw.32.2019.02.01.10.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:06:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Worktree creation race
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
        <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
        <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
Date:   Fri, 01 Feb 2019 10:06:04 -0800
In-Reply-To: <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 1 Feb 2019 01:27:31 -0500")
Message-ID: <xmqqh8dnz8mr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Another possibility would be to skip the stat() and instead do the
> mkdir() in a loop, incrementing the sequence number each time through
> the loop. That should eliminate the race entirely (I think).

Yeah, I think that is the only sensible option to rely on the
atomicity of mkdir() call.

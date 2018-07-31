Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951E11F597
	for <e@80x24.org>; Tue, 31 Jul 2018 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeGaNHf (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 09:07:35 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33079 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731639AbeGaNHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 09:07:35 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so5991082ybb.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 04:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yngJO6aeAOjRRQxeg47sCOz3N5H2cw7nauzpNdMyRw=;
        b=YxqU//iVG+nm799GHNBXwje3PeOGrZ0ZcHn7nMok7LB8i2MSYw9xkACqSE3zeeCGWU
         Z0zCTiGbfGkZBVNUKk3xClH65qQVAwORMxuvte3wSgJ4ty6+8B7wdxQAcO+rG7yGWq2d
         SztIEsBXax7gu+3jozfxzPK3ZAFEwC2e7JRYNi8JZbTDP9qQVyTs1z0vvQCWWeNT8cK2
         yj+qTc5w9tmnNeFefmeQqVXU+Goh/uCH0iPQsiBziXGIR3yVladAwLH1B5l5z0JIdW+6
         ggstdkcsc/qhm0WfjJewJJAkaTDjmIwro7ibTqz2mNE0RZ/xFfJ5MdTvS1wU552tgLsl
         4lfw==
X-Gm-Message-State: AOUpUlHGSuiqN6CKBoIxTIL/YU50EDxW1XqNw38PpIlbmroncCfadmmi
        KjN0UNM0AxPYKtEo9SH1640FZKvCd8X+uNia9CQ=
X-Google-Smtp-Source: AAOMgpdiB70HlRoHjcPPkEFz7FvDeMbbGGCBwlagUwyGjIyiRmuc1eJJq5Ao9l30ClsFD4QNezW4uhktjiZjx40mkns=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr11346086yba.263.1533036462998;
 Tue, 31 Jul 2018 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <f9a7e77d-3c67-082e-ed8d-701f4d0d1759@talktalk.net> <CAPig+cRkdAoV7gsEeKMcvhckifRxU32+ec2zxY7MgNGmJp5Sug@mail.gmail.com>
In-Reply-To: <CAPig+cRkdAoV7gsEeKMcvhckifRxU32+ec2zxY7MgNGmJp5Sug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 07:27:30 -0400
Message-ID: <CAPig+cRERb+87YoQK_p_vVwPoHDQ0K+t519NuJK4xHzewYC0GA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 6:46 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Anyhow, thanks for reading over the series. I appreciate it even if
> our "sense of priority" doesn't always align (as evidenced by your
> review comments and my responses).

To be clear, the changes you suggest all make sense, and would be
welcome (especially the bug fixes), but I consider them lower priority
than the fixes in this series, and here's why:

The commit object corruption caused by the bugs fixed by this series
are unavoidable. Anyone using "rebase -i --root" to swap in a new
commit as root is going to end up with a corrupt repository no matter
what. There's no way to side step it. And, most people won't know how
to fix the corruption, assuming they even notice it.

If I understand correctly, the issues you describe are unlikely to
come up in practice. The only way they can arise is if someone hand
edits the script (something only power users will do) _and_ botches
the edit in the process, or if the person's name contains an
apostrophe (possible, though perhaps uncommon?). Also, (if again I
understand correctly) they are only data "corruptions", not genuine
broken-repository corruptions, thus are more likely to be fixable by a
typical user.

So it's not that I think your proposed fixes and suggestions are
unimportant, I just don't think they belong in this series, and would
be happy to see them atop it.

Thanks.

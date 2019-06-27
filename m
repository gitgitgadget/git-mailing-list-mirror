Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BE81F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0FUi (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:20:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45090 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0FUh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:20:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so856757wre.12
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BXJDf0467lAw4Ef7pw5bJ/o8aSpf39J8/6acr75VgY=;
        b=eigclXLJzAhhoeZRGo8WtWHE7r6r6ULGhgH325YTUXc0xlO9A5HoNXd3XbnR/Zz/ZJ
         Ufzt+c7Kw3wF1IFnc7G0UW1i4ZQj/kPu6cmp0lmEuCfsIea6mDY1c+LQ5CLufDIzU76I
         9SkKoDxR8tYvTqQ7jpmdrztrSOGmvfM4vLu5x1jiFT1CfoCEWlByxJ5vxhFd44aCBnVR
         x2uos4hTwro3P0O9ece0LXfEoHPPoMm9YUCgjr0QLgawrFFc6Gc3cHjEhSlutIMeexBA
         2g2r0Qxhto/IsN16uPg4CmNjHCfuwsvOYOek+ncM+vp6YGfV0ckEhbiT9rj8XHL3+83v
         NbOA==
X-Gm-Message-State: APjAAAUuSR7QLgErWiMCwEez0K+JRKM9OS9okIqV90p9vHk1+1wwDSFg
        Fv42DmL/DKN7SsNugS2gUsZfWCELpk9o1/efBVQ=
X-Google-Smtp-Source: APXvYqx9NkdwVasbd/Boy9wdCZeNlCQ5KWUZlfdO/wnxvLd6BMHx7HBMYEDVWdR9NBudLXt6qgtghizTt1DpFds/gnY=
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr1303022wrw.231.1561612835940;
 Wed, 26 Jun 2019 22:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-8-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-8-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:20:25 -0400
Message-ID: <CAPig+cQQCXA-WsbQrC6XoejjF-roqhmcB7iVH1nA+zUDYTN3vQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/13] walken: filter for authors from gmail address
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> In order to demonstrate how to create grep filters for revision walks,
> filter the walk performed by cmd_walken() to print only commits which
> are authored by someone with a gmail address.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -60,6 +59,10 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
> +       /* Add a grep pattern to the author line in the header. */

This sounds as if we are adding something to the author line, which is
confusing. Maybe say instead:

    /* Apply a 'grep' pattern to the author header. */

> +       append_header_grep_pattern(&rev->grep_filter, GREP_HEADER_AUTHOR, "gmail");
> +       compile_grep_patterns(&rev->grep_filter);

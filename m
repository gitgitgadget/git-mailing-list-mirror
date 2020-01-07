Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C02C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762E4208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgAGPvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:51:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44028 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgAGPvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:51:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so54496223wre.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 07:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDXJQr/9PJKKpQ8WDaL8c+jQe2CUzhqpL+y5Zjosp0Y=;
        b=Ix8+H4w0qGbuIy3F8FCKkFrtgBxIyTF5m315VrPS/Dbhx6L6XOxXf9nKzWWe9sbf9C
         bOmuwG4ongsaNfGbO5QElp8Cqo/QucRS5irpHAqhI5lgZZJLonpSu0bQzQpgmkavhT4F
         6fbaRXiSKgCnuaAaDKoh58WV0icBCjLi0QRiGbjDBdippX5kezcrf7PzEwmcrLJp1cbZ
         KperNCcFUaPQtk/KekHetehT6+vEexh7J8q5Wo88Un58l2X6nu4aEbZn3MkY3nwtwo7z
         dJyhdRdMa9eUiyLfYAOUZ64/oWXWyggSquUsNTRsg7XOMeVbI1kbMvRkiijxJNrIBr8i
         XkKw==
X-Gm-Message-State: APjAAAWIbkPWo1PfWYAt9f6mo1SJhD8/4xrEK+nEHNGJjueXxfudPqqL
        +TTppFF6bonxutawzS0otLciWMhITnbowsskeGc=
X-Google-Smtp-Source: APXvYqy1PGkUg2TrNxBdjt8KiRZcbwkXAUx/uzlXifzUnxmNGV5/AAOiSDRbv3RV+ouQ5xv6Vx3J1ZUCXdyONqJ1GxQ=
X-Received: by 2002:adf:f382:: with SMTP id m2mr110204105wro.163.1578412310540;
 Tue, 07 Jan 2020 07:51:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <5dd305d2f0de43a70b46336c8f1a62437e0511e1.1578408947.git.gitgitgadget@gmail.com>
 <20200107153651.GB20591@coredump.intra.peff.net>
In-Reply-To: <20200107153651.GB20591@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Jan 2020 10:51:39 -0500
Message-ID: <CAPig+cTu=iAeQNm8z53cyG8C1dgokpZBvRVgev091nBFg8tCXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] graph: replace assert() with graph_assert() macro
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Bradley Smith <brad@brad-smith.co.uk>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 10:36 AM Jeff King <peff@peff.net> wrote:
> On Tue, Jan 07, 2020 at 02:55:46PM +0000, Derrick Stolee via GitGitGadget wrote:
> > The assert() macro is sometimes compiled out. Instead, switch these into
> > BUG() statements using our own custom macro.
>
> I can buy the argument that compiling with and without NDEBUG can lead
> to confusion. But if that is the case, wouldn't it be so for all of the
> assert() calls, not just ones in the graph code?

This wasn't just a matter of potential confusion. It's one thing to
have assert()s in the code in general, but another thing when a
scripted test specifically depends upon the asserted condition, as was
the case with the test as originally proposed. Since the final patch
series removes that particular assert() altogether, it's perhaps not
that important anymore.

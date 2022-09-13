Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D37C6FA83
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIMAjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIMAjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:39:40 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49585B95
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:39:39 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id b136so15371023yba.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LSXWQ6+0YKLA0TADrJ8x5iMEjWKoF2c/j1M8mLSdjQM=;
        b=4vHdRszjNbbsltAXSC6NvYXv+slsIYSm7VR/QziZ5DK/A8eWH5xom5KTEvwp7onBNS
         fj1NLUhGADWg0DQerTZsPFeO8JQjPOqI9koXrg/FwAFjxkCSfqNK4diVixy/gIv2Q2on
         PmV3zr37VqI760eACHx3LDmbUZ2OKfVgvDbpl1GwvLhwgoXiA+l/f4xNhnIiQ2BMPT9P
         wo9uraLK6zAcuyNfJP0Oe/E//fvo/G33aoS7zzZ/O5w9EAOK/fXekPJvjM+dM+XCDKfx
         QFb7+Rnjh8k4xtA63NIzg9BsCqvZbvxXuIHv1nZyp/rDqadV0L57XAWf2gfNpuzt2WGz
         jxbg==
X-Gm-Message-State: ACgBeo1IsgMaxMCus5jQBqd0uA/p/xfSGgpF7IUAQTMg0WdxeyRPrU/D
        p2gkDePiHXYxtuvfhefE8KG1r1edMsRAgVDSZOI=
X-Google-Smtp-Source: AA6agR6L61PwslFP2pzay0ZkiJwufdSfCweINvSmjSqmvq5+6XhiK9Un8gL9P4cryBAV2xY1+H6qF8du1Wz1Tkdc6pI=
X-Received: by 2002:a25:4884:0:b0:6ae:b301:daf3 with SMTP id
 v126-20020a254884000000b006aeb301daf3mr10641167yba.372.1663029578440; Mon, 12
 Sep 2022 17:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <xmqqsfkwb12i.fsf@gitster.g> <CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com>
 <xmqqo7vkazuh.fsf@gitster.g>
In-Reply-To: <xmqqo7vkazuh.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Sep 2022 20:39:27 -0400
Message-ID: <CAPig+cR4neH_FU+tTr3qzyPp=5WJUfFydw7Y4CMJn4k+iSQs6A@mail.gmail.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test delimiters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 8:21 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > (2) In practice, I found that even after coloring those annotations in
> > red, it was still easy for the eye to glide right over them in the
> > output without really noticing them. Switching it to bold red helped a
> > bit, but my eye still glided over them sometimes. One possible reason
> > that the eye was able to glide over them may be because the "?!FOO?!"
> > annotations are very short bits of text buried in the much larger and
> > textually noisy test body.
>
> Maybe partly because I work with black-ink-on-white-paper terminal
> setting, and maybe partly because my color perception is suboptimal,
> I learned to use "[diff.color] old = red reverse", because non-bold
> red letters do not stand out enough.  Perhaps you may want to try
> reverse output to see how well it makes them stand out for you.

Hmm, yes, that might be worth investigating. I also typically work
with black-ink-on-white-paper terminal, and although the problem is
perhaps worse with that color scheme, I nevertheless found that my eye
would sometimes glide over the red annotations even when I tested with
other color schemes (i.e. light-ink-on-dark-paper).

Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4660C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683A22074D
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II8XKzOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIETwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIETwW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:52:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44092C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:52:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z15so2668663plo.7
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kaci144wwqJh61xpQbUIzwDsuDAuXrQJafYuKuD7Ou0=;
        b=II8XKzOHlJsYiv8j4LoHkzcvQpoZrQ1iG3dH3ZimkogJJ6iJgNuixB63JVWq8Fuf+8
         CJnpvxKDAFrwX7JUAEkhOLBF+h8wB8IW8hcI4pHBlb+uA765tspjAGHO01c1xcdTTlJG
         VFDgDPH/rOZkIvnTVdSJ7vL/nrkPFtIhoRPS325sUzFEZTiksFJwNv2UECZ0I9GRZCxn
         rCowJidaR3iMvGwddP9at3wbJUIhZGcPDoHkyw8gyYMizPTobSz9bHBEpa/6nKPRzAuJ
         pljMqOYjCtP2WECeIjqjWBntpUa1Be3R3FvZGP+gqbVIgmW6/aVJoEmdC0dFIfR5plZX
         2EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kaci144wwqJh61xpQbUIzwDsuDAuXrQJafYuKuD7Ou0=;
        b=JMFN+EDnMAPmO2WhC5ujIT5GiVAfkMBcoHSVXQXqUCii+/CISJ3//uCal8I02VuFxq
         B+r/LIublrItOQSCocN2WWLH511gRIBZYH2i5mswV1trRCMxj6RtNNLOMegR0ut9gkdf
         /tdlnX963JcVYjWYtOVed4ZyWY6L8QB8OhSnSt30CdOPlgXgUrisw5nWRHgQSEh9sReO
         tA3j6FadhecTmoiYwWuU5ri6k5wVk/YdxlZDOB22zJ1ztBQf3EmJQCKbakNCXC6OvwoS
         9VrEa9ExlbMJ8qD7oeTJ+A8UBQc7Nxhty4an80tYy0xPnTZcrCsx2g4H/M2SMe5+t6Ic
         ZkNA==
X-Gm-Message-State: AOAM531GlguFzlXkrMn5ARTiE7FHy7+QSOP10WG5TTJbS00cpLXMuNAY
        UACkLQFZ/tIf8PfBCx3JW+RuXqo+BRI=
X-Google-Smtp-Source: ABdhPJyr+fFr+H7Yd4j2R64Th2glO2griYqeISkkQ2A9wxhZNpdeMjCuscghyHrDXEe1LrOkjthg/Q==
X-Received: by 2002:a17:90a:e015:: with SMTP id u21mr7712241pjy.33.1599335541045;
        Sat, 05 Sep 2020 12:52:21 -0700 (PDT)
Received: from generichostname ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id h65sm10586556pfb.210.2020.09.05.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:52:20 -0700 (PDT)
Date:   Sat, 5 Sep 2020 12:52:18 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] pretty: allow to override the built-in formats
Message-ID: <20200905195218.GA892287@generichostname>
References: <20200905192406.74411-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905192406.74411-1-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

Thanks for doing this. It was on my todo list but I've been quite busy
recently.

On Sat, Sep 05, 2020 at 09:24:06PM +0200, Beat Bolli wrote:
> In 1f0fc1db8599 (pretty: implement 'reference' format, 2019-11-19), the
> "reference" format was added. As a built-in format, it cannot be
> overridden, although different projects may have divergent conventions
> on how to format a commit reference. E.g., Git uses
> 
>     <hash> (<subject>, <short-date>) [1]
> 
> while Linux uses
> 
>     <hash> ("<subject>") [2]
> 
> Teach pretty to look at a different set of config variables, all
> starting with "override" (e.g. "pretty.overrideReference"), to override
> the built-in formats. Note that a format called "override" by itself is
> not affected. The prefix was chosen to make it clear to the user that
> this should not be done without thought, as it may cause issues with
> other tools that expect the built-in formats to be immutable.

Hmm, I'm not sure how I feel about being able to override formats other
than "reference". Perhaps we could special-case "reference" instead of
providing users with a possible foot-gun?

> [1] https://github.com/git/git/blob/3a238e539bcdfe3f9eb5010fd218640c1b499f7a/Documentation/SubmittingPatches#L144
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v5.9-rc3#n167
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
> I intend to also submit a patch to gitk that will use "git show -s
> --pretty=reference" if it is available, with a fallback to reading
> "pretty.overrideReference", so there's a single point of configuration
> for the reference format.

Very good, I'm in favour of this.

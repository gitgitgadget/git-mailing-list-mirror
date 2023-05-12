Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533D6C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjELVgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239542AbjELVgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:36:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A8E66
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:36:17 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a2cb9788dso152357097b3.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683927377; x=1686519377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPg0uO6Zbv4d615Ea4GGakvMa1Crx1tX1JUhqjMz4+s=;
        b=HApyfUF6WYc6b86mtCbVJ6Hy42GMJbQBbwHfErTkW0MuyzBF3zUP+zO1jbbJmBwhkR
         BpzvSxPl1nWrS6QreNsVCH2A5D3INgbzkMDUV5oOmt+Sfdg2K3OcfRY9G49hNn/Fw1ax
         PxwG7x1gkeo3VWxMhZn/COna8PfJniFohJBZccxm5eR3LOhM4nLXHWNO3qTMyp4B34BO
         Vnt70llBsU2j/ZRBivhPzRM234ixjnJVOuEOm8ouyuLDuGiOn9fC0Fbg0XaJc5tq9HZI
         EiRbUpc5HxR8jmjI8SMd6sVTR+x3mdyUpKizW0tRNQ/UmWeIvdsEqPM8e8dyE1R5AFdK
         ljpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927377; x=1686519377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPg0uO6Zbv4d615Ea4GGakvMa1Crx1tX1JUhqjMz4+s=;
        b=X6cSGnwlqN85LFtBuqD2CCGqxgjv6AcXtOuJ2WG7zwgZ7KPipX2YMpyTmutGfsdTdO
         OvHTvnJeQH/J72LuJRO2QXIMjnYuvzrwQPTQn0yPfu7flFWl4D1p0oQ3FfebYASDvTQb
         CAMKH4cEeCH0GGiCciqv0fk4+naVQYUJuFSzKo+m4V0FciGVn1wmNPbmwNVvNZ/9eshY
         LhUZozJ/7mgeIwE7mdz4+BD9C6YAwHSMWRWF3ZNrY+XEMa4r586kH4nErvRqZNdp5K38
         tDyW1If2adsX8qWWRoOj7Tg+ddjVAKD1oEzBhGt3UJfelQrd/KCyKRqmfZIu+jCAw8rd
         Wg/Q==
X-Gm-Message-State: AC+VfDzxOx3EnmAJFUEvqj0OCMX8ibR7k1HHeAACQLCQdLYQF5t9Y1e/
        gEUrPMN1WvEBO3eVq+gQBp6fTA==
X-Google-Smtp-Source: ACHHUZ6cZ6Y47AnDzjeWFgr4AhTdFb4F2xwR2gJo6l31ISHpABhoPEdocpT1L9+YuXhtsw6uCO4TRg==
X-Received: by 2002:a0d:d516:0:b0:55a:f428:e8ea with SMTP id x22-20020a0dd516000000b0055af428e8eamr26463308ywd.41.1683927376919;
        Fri, 12 May 2023 14:36:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b5-20020a0dd905000000b0055a931afe48sm771015ywe.8.2023.05.12.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:36:16 -0700 (PDT)
Date:   Fri, 12 May 2023 17:36:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <ZF6xT34/Zq5pT9fG@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512212456.GA2495860@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512212456.GA2495860@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 05:24:56PM -0400, Jeff King wrote:
> > This patch introduces a new configuration, `pack.recentObjectsHook`
> > which allows the caller to specify a program (or set of programs) whose
> > output is treated as a set of objects to treat as recent, regardless of
> > their true age.
>
> I was going to complain about putting this in the "pack" section,
> because I thought by touching reachable.c, we'd also affect git-prune.
> But I don't think we do, because it does its own direct mtime check on
> the loose objects.
>
> But I'm not sure that's the right behavior.
>
> It feels like even before your patch, this is a huge gap in our
> object-retention strategy.  During repacking, we try to avoid dropping
> objects which are reachable from recent-but-unreachable things we're
> keeping (since otherwise it effectively corrupts those recent objects,
> making them less valuable to keep). But git-prune will happily drop them
> anyway!
>
> And I think the same thing would apply to your hook. If the hook says
> "object XYZ is precious even if unreachable, keep it", then git-prune
> ignoring that seems like it would be a source of errors.
>
> I suspect both could be fixed by having git-prune trigger the same
> add_unseen_recent_objects_to_traversal() call either as part of
> the perform_reachability_traversal() walk, or maybe in its own walk (I
> think maybe it has to be its own because the second walk should avoid
> complaining about missing objects).

I might be missing something, but I think we already (kind of) do the
right thing here.

AFAICT, the path is:

  - cmd_prune()
  - for_each_loose_file_in_objdir()
  - prune_object() (as a callback to the above)
  - is_object_reachable()
  - perform_reachability_traversal()
  - mark_reachable_objects()
  - add_unseen_recent_objects_to_traversal()

That only happens when `mark_recent != 0`, though.

Thanks,
Taylor

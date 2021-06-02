Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D054C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A7D60FDA
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFBLqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhFBLq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:46:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50567C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:44:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1457057pjx.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T5EAoUMeqfCkNrej2q7GTcYv5j4tBPXk0bZcwvRB09Q=;
        b=SITLa7Jdt4ucqaUueAsNnn/vfKH3qBj86+oerR8eKMfg2HcJlKYRitSFjv4lxJw7i6
         7rUv9um4d71ovM3vPL6EXCphi7euOWyMYvhjV/AY1Hury9AJ1dr/VjTMfMr71CrnvoDh
         MWW4SrYPK9Qhk0GgUojQ4XrAxTL5VFPgVdY9pV01rTUWu78NeAdT3NCoEA3mkpwaktOT
         CS1WaMklcjgi6X8wb79iQBCSre9rVZkVNcpSCUKcpXI9Y0jmf6w4RZz1s3HlgoSCxl86
         4Op1SGNGxVUnaw0kDGih+fWMImQYjuMlIXN7616VRtbCKZdj3fKr9K1oCw92YLPeoYqs
         /o+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T5EAoUMeqfCkNrej2q7GTcYv5j4tBPXk0bZcwvRB09Q=;
        b=h4xiPizIOiAUD18WKUbyB9M3rEqrLDiBN+q1eABQsLmLxIjJkA/wx/19lB3wnU+2bA
         O4XzEQa81b/re9QfFOqxm87Kpryu8cDKrnWI3U7XRrDTvq724VfMDY3hMkC6ktih9ClX
         jzBWQsq3+IfTBD9zurb8v/v7Y1kRzOshCxWy1K8Md/kO3MHCYgyVGmf2rPhdCjU1IbnI
         l3bqPJVaV/b3XEeclAZqyhGKjzNvbjl3aGvH0OkzpALNvY4Q5n/V3E5SLJp+J+LoRGLD
         x+k+TwUSzZw1X+GwC0bNt479NnXz6uBIl93SIOCs6velZVY1nQF1gElmGROwdEaAt4nA
         8pYg==
X-Gm-Message-State: AOAM532XdBhntypOCKh4f4ezKYpvNP1S8AeD7QU/tOWwSwHdb/ZECOWz
        moRbiY7Meyxp1HzfOKgMbc0=
X-Google-Smtp-Source: ABdhPJxf7UA0ujdluO7LLFnZUBKDn65oFy7zntYuZbbJna/c9IZmbF9Ohh4PUZsicYGec5qd75Xplw==
X-Received: by 2002:a17:90a:9e6:: with SMTP id 93mr14711977pjo.6.1622634282748;
        Wed, 02 Jun 2021 04:44:42 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id g8sm15382677pfo.85.2021.06.02.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:44:41 -0700 (PDT)
Date:   Wed, 2 Jun 2021 18:44:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Subject: Re: The git spring cleanup challenge
Message-ID: <YLdvJ0G19LNcbDSD@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
 <xmqqzgw9qky5.fsf@gitster.g>
 <xmqqv96xqjyr.fsf@gitster.g>
 <60b6c642ba65b_4044208ca@natae.notmuch>
 <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
 <xmqqo8co7cqe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8co7cqe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-02 20:00:25+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > rerere.autoupdate erases the information which files had conflicts.
> > ... So, I'm strongly opposed to enabling it by default.
> 
> Exactly.  "checkout -m" can use resolve-undo information to
> unresolve the conflicts, but to make effective use of it, you'd want
> to know which paths had conflicts to begin with.

I don't know about this one. I had been bitten by rerere.autoupdate
sometimes. And I need to wipe out the rerere record to start over.

I guess I should turn it off, then.

-- 
Danh

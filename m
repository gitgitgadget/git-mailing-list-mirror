Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A49C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13C82076B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgjOBITI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgIPFfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgIPFfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 01:35:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31891C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 22:35:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so767564pfg.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 22:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dirgf2nWWDG0j6FzeXB+2QhW0JRLPXUr81rh80iEAEU=;
        b=QgjOBITIDbjKT33fpDr9d7qiL9uTuPzAkatB/QRqeJ38DtjZY/vo3Atj0k99nq8IP7
         NKgDex+0IhWHUCs03LZRG0UtPEUVssaVP/kH3jsr+Wr6RsLVcYqZDA6MWSACtblaS4V5
         wiMtsIuHpgb8PRs4+akRNCTIm8F9BFpaxKxTqOfq0w3xeUibKWGwqR1JSkwGZNCJOv1C
         Hw7diFDg8IBMECU+bx+VCFXwuyCgEah9ofVriaWJWO4/c+a2VRHnq2ag6DbM+Mtv7BOC
         eog8/Tu1Vr/joMxBYpznje5OOZTV2sOpX/TGCMmPgxnopBdYZw29Yvac8ZdO73maOvXm
         NcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dirgf2nWWDG0j6FzeXB+2QhW0JRLPXUr81rh80iEAEU=;
        b=bHs/OQdRU8o0XcVAtbDJf1yPoOyxzRUKN4FvD0L/TPNPSHsML9Ds3EYPLORy/LlLek
         hct/yKR6c95YG8rhPjI0gvtXP7otPQjdaXiMVl4dUxy3yidSKekDYwQVqkGGGn9suDZB
         k7BoNtRmC5VyEQz8oJYgmNp0PFmgXRIu1L3DTOrocgOIn2dz/aJsfuFiwPkw7K71M5qj
         VUnFOuigam43+AixF0E3ySYyxtux2IW+i4L7FY21AAT7Xh1OYJwD2Qidj6TDdjwbt5MD
         LQFPWkHhHFpHcmuZjkH4cUKwnr1xnmxV2vJFcdqsgHuMG4/E4l04qvOG6DuTGTrbceQx
         UcMg==
X-Gm-Message-State: AOAM5306sVpHQBuZBIMkzrB9yQZC1rHxOyhskqqelnLVaR+NpulawUHW
        J+L4PmUMIjcF/PnQGXfew2hxMCQmTTxeTpzU
X-Google-Smtp-Source: ABdhPJyOeD0J//9JFZyoDsB4SlMzJvSF35AXh5NGNFjepx+z384wTCKXw3Vc8ULsf5kTkgBv893Z4Q==
X-Received: by 2002:a63:5d57:: with SMTP id o23mr964675pgm.263.1600234549619;
        Tue, 15 Sep 2020 22:35:49 -0700 (PDT)
Received: from mail.clickyotomy.dev ([2401:4900:33b5:8018:b140:be83:aa16:5dde])
        by smtp.gmail.com with ESMTPSA id b2sm8885010pfp.3.2020.09.15.22.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 22:35:48 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:05:43 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/7] doc: add reference for "--[no-]force-if-includes"
Message-ID: <20200916053543.GB29901@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-7-shrinidhi.kaushik@gmail.com>
 <xmqqzh5s1398.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzh5s1398.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/14/2020 14:01, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> > index 3b8053447e..b40fe7e7cf 100644
> > --- a/Documentation/git-push.txt
> > +++ b/Documentation/git-push.txt
> > @@ -320,6 +320,12 @@ seen and are willing to overwrite, then rewrite history, and finally
> >  force push changes to `master` if the remote version is still at
> >  `base`, regardless of what your local `remotes/origin/master` has been
> >  updated to in the background.
> > ++
> > +Alternatively, specifying `--force-if-includes` an an ancillary option along
> > +with `--force-with-lease[=<refname>[:expect]]` (when "<refname>" or "<expect>"
> > +values are unspecified) at the time of `push` will verify if updates from the
> > +remote-tracking refs that may have been implicitly updated in the background
> > +are integrated locally before allowing a forced update.
> 
> You cannot omit <refname> without omitting <expect>, so
> 
> 	... with "--force-with-lease[=<refname>]" (i.e. without
> 	saying what exact commit the ref on the remote side must be
> 	pointing at, or which refs on the remote side are being
> 	protected) at the time of ...
> 
> would be more appropriate.

OK, that makes sense, will update.
 
> > +--[no-]force-if-includes::
> > +	Force an update only if the tip of the remote-tracking ref
> > +	has been integrated locally.
> > ++
> > +This option verifies if the tip of the remote-tracking ref on which
> > +a local branch has based on (for a rewrite), is reachable from at
> > +least one of the `reflog` entries of the local branch about to be
> 
> If we take the "we don't have to look at a local branch's reflog;
> just check HEAD's and rebase will automatically be handled without
> expensive merge-base" approach, then
> 
>     ... if the tip of the remote-tracking ref was once checked out
>     to the working tree (for a rewrite) by seeing if it appears in
>     the reflog of "HEAD" ...
> 

Right, as mentioned in the other thread, we can go with this route,
will change in the next series.

Thanks.
-- 
Srinidhi Kaushik

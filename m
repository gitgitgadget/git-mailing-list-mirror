Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0DC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF63820890
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjzuNAA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgE0ROG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbgE0ROG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:14:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612AFC03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:14:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so1772815pjb.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HLHx2ML5ATO4AH3y4+hYoXLGOkRSEmd6oNA0FyMY+WQ=;
        b=pjzuNAA13WFllBV8JJ3S/nDthWUC+OqOzouVtERCK969YU+X1igGIi5BiRzI0Pz4vC
         pwpYtf0i474T3Vq1HQ3aPSSlE/CKRYMHMjJd8PmMfuQ6lAkrzGB7CZa9vaddTwWcHEPN
         3nS/h6NDf+qL6WPnwpKabVORK8aymDgojvWiT1JGjZ4d+QtMaQxW7b69U5UgaNWjOqay
         cakcTVDZcpkKar+AL7b+Ax8ZqNZ4xO6ouRiTdzSg13N8KqLHcVj1H/+q1SF6v9OBnVpw
         OdlSe9hzqWSa1wHltC3CraDccdA0G7XVnw0y2Ge9ExJnMnx5V4Yi7pYejMqJzxMmcmgS
         TSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HLHx2ML5ATO4AH3y4+hYoXLGOkRSEmd6oNA0FyMY+WQ=;
        b=Exo9zkCzxMGmCfhDEtJBiT5wV0qgY2dNcGNTskqMF/WeFk0uxH2T9yt8AmZXa2r5qO
         jELY9OgqWYBZRoTJQ28mqEe955Z34VXWhrR67VHHxDZDfRm+cFnOkpQ1/zyopsFzQ9ZX
         f+ZG19bUctMWEraIqvBdTwR7AiADmRKcLAWygMs9AkpA++gHaWLW7cT4go8FPCEUrW6z
         5NPGs7XapajEJULvw8lqltQppBtWnUEIOuQPvBOM9dUjMLQ66dqmUkR4xpHxXtLar+bN
         Gw9vDdRYYcjT0HtoPaAaFKUai1knxC1gfCkganZEa4YkLBjVuq1RUgFr+TiGbKmrdeI2
         rGIg==
X-Gm-Message-State: AOAM530TPbYxvlm7w5L1BD41UG07qC6p9strQzhZEfLvVtVzBKSzAegp
        ZR1NjJ5fm+nKgCIYLEC9Vqs=
X-Google-Smtp-Source: ABdhPJx/3AeHaXybCUzfI5LkvA8C4QodhSym6Ar9snVIyBGr0ID03VsD7aXudmr139Xh0Ejjb0iGqg==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr6864456plb.220.1590599645750;
        Wed, 27 May 2020 10:14:05 -0700 (PDT)
Received: from konoha ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id a16sm2665928pfl.167.2020.05.27.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:14:04 -0700 (PDT)
Date:   Wed, 27 May 2020 22:43:58 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        congdanhqx@gmail.com, gitster@pobox.com, liu.denton@gmail.com,
        sunshine@sunshineco.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200527171358.GA22073@konoha>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/05 12:19, Kaartic Sivaraam wrote:
> As '--quiet' in 'set-branch' is a no-op and is being accepted only for
> uniformity, I think it makes sense to use OPT_NOOP_NOARG instead of
> OPT__QUIET for specifying it, as suggested by Danh.
> 
> Also, the description "suppress output for setting default tracking branch"
> doesn't seem to be valid anymore as we don't print anything when set-branch
> succeeds.

I think it will all boil down to the consistency of all the subcommands.
Changing this would require making changes in various places: the C code
(obviously), the shell script (not only the cmd_set_branch() function
but the part for accepting user input as well) and the Documentation (I
might have maybe missed a couple of other changes to list here too). Its
not that I don't want to do this, but it would add unnecessary changes
don't you think? I would love it if others could weigh in their opinions
too about this.

 > +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"

> Danh questioned whether '$branch' needs to be quoted here. I too think it
> needs to be quoted unless I'm missing something.

We want to do this because $branch is an argument right?

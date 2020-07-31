Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFAFC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6222177B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DtutFycK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgGaSGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgGaSGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:06:40 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5CC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:06:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 11so29648826qkn.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Tkc0WN0zTZj76NdFJ+4QSnmyEvw798ZfsNOVXbJ2H0=;
        b=DtutFycKg2Cyr5B5UyQKBxP9VOzpZ9hULaar4OJaj+VIwd1dCb43G6yRS6wnMMJLH8
         rn5n3MaWDOldCSn+acgvTYNpk9GdUcgIOr8TjfdsjDnA4kRR0xmtAefgxzw+6E+cmvq0
         pGzOPYAlMjiaMhDoMxxDA3HhF1AEM3ha1aOucIDbnQlND6dliA1L0oCJq4pySp1FdYmZ
         iL9jZ7gsApD+whjDVCCu3ZaqKysCBkbMm3T2vL2fDCD+J44I3+Ww0xQFY79SBugDRPJR
         ulm9JxXAXYJZW9fMwCnAoDyIs79SZDtOWPZL6jTI00VNl8kBFG2RsgpjNShqEIF5taFG
         L7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Tkc0WN0zTZj76NdFJ+4QSnmyEvw798ZfsNOVXbJ2H0=;
        b=NePUp02fz0F3TyZWmacpx4Gn0Ma+H5Dy8gDls1ZdTYn8TbeNUEHXIvSL+woFILqNEM
         hy8OPGCxNCICF88lLsnYboW4j8MmzlcSBCQkm9wR80nqMDxVpQE9xwC/E/esBQlddaXa
         aztRoI74gKmdrvoMfUdBL/vxGK92rCOLXYMUALyN/qLsBNMAgz6ghp7u9tF7TUn5Rn5U
         m9zhTEJecF+d1dBffVNatLIxH10Rfcx9WAPzP8lEGwzX7sIRXF8NwHw3A2+dFKre2Mf6
         Z/WjF0i/6/Rg/naGwZIoGwmr2bvrdDFr0+DR8Zzwm1APB3IwsnNVeR2ed62jrMPcsvhN
         gmXw==
X-Gm-Message-State: AOAM532wkZpAlB3CBCTAa2eNuiSigw+k6uYx8gdBAb/BMmILonhqyPqq
        Y4V9fzJ6MErQc7eFbdZf4wkBNw==
X-Google-Smtp-Source: ABdhPJyVBtqAhCMPHQraD74dskx97yh1bDiOB29vDGJ9qlySzabT+S5nC5+JnP6WZQZVb12MWtjBgA==
X-Received: by 2002:a37:a45:: with SMTP id 66mr5377715qkk.435.1596218798717;
        Fri, 31 Jul 2020 11:06:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:45c8:9c23:8c4e:a06b])
        by smtp.gmail.com with ESMTPSA id z3sm9410276qkc.4.2020.07.31.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:06:37 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:06:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH] commit-graph: add verify changed paths option
Message-ID: <20200731180636.GA59489@syl.lan>
References: <pull.687.git.1596181765336.gitgitgadget@gmail.com>
 <xmqqh7tn4neo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7tn4neo.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 10:14:39AM -0700, Junio C Hamano wrote:
> "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Son Luong Ngoc <sluongng@gmail.com>
> >
> > Add '--has-changed-paths' option to 'git commit-graph verify' subcommand
> > to validate whether the commit-graph was written with '--changed-paths'
> > option.
>
> The implementation seems to be only about "does this section exist?"
> and not "does this section have healthy/uncorrupted data?", which
> feels a bit strange for "verify".  Instead of setting ourselves up
> to having to add "--has-this-section" and "--has-that-section" every
> time a new kind of data is added to the system, how about giving the
> verify command an option to list all the sections found in the file,
> or a separate "git commit-graph list-sections" subcommand?

Completely agreed. When I suggested that Son work on this, I more had in
mind something like 'git commit-graph verify --changed-paths' to mean
"verify the integrity of the commit-graph(s), including regenerating
changed-path Bloom filters and making sure they match".

If you are just curious whether or not the section exists, I'd rather
write a script to look for the 'BIDX' or 'BDAT' chunk IDs. That said, if
they're spread across incremental, maybe it makes more sense to extend
the commit-graph test tool.

I dunno.

Thanks,
Taylor

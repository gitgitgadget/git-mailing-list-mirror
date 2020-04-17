Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4045C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 19:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897F8206B9
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 19:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDi9u5/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgDQTga (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgDQTg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 15:36:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760AEC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 12:36:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a23so1335057plm.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVNotdFzrIZexrLf88MDyOiEh5aFFjnj1OxlzMuZ0n4=;
        b=QDi9u5/JEOm//RO7RJ3kk03O91p7cKd6PsseB1Gh6sxngSKQPApwigbmvx5Ttq2yY6
         EnjBATn/PrLG43FLMYrN9A1a/Ncch8uaMVJEGthJ0ZeflBPGNIMgoajApCuYVc8rlXTd
         NdC86GF9ZfvMpELt8Ub8vFm1ay22PbUot/YPqVS6I+7jpg2O4D7m9UQ6ZyndI/EyRF4u
         JHa/xZeQEsm8I8Yfyek8AqIEepmIN86HCaigTefJRJuP+akQe2C6Rw4o2/oaLiPeC2Fu
         rPp79UKPyRFbFRdSXyUzaaYhJZa0yh4DrsA6hkLTLaoXiVK2SyX2DX5KPs4NhrDwG3pU
         7vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVNotdFzrIZexrLf88MDyOiEh5aFFjnj1OxlzMuZ0n4=;
        b=gW6T56+WPO4iC24lhyq1z+HHjYtZVOM0khkTN/x2SuoSUAnFQrPGECO1irPXHjA3e7
         na/Ek8X0eqPPfeKayd0+6ZTDXkSb/S+4+IKLbsS/vFFbUgqUpT2Ay6AHGO3BsfWIc9j2
         IvGVfNDvzPu5glUR4iqR0vPtPsIRjbgtL2xrh6JtD8T8nVv8ySsLv32EgiUHWxxsWt1S
         PB9+j5hHjxhR5UyA8d3Kdwn+jy6IpXKdJBYL2dvMRkHpdJV0H0Y5vaHXXxT5VRiXFRWK
         LrC/9eb30pmKeIwenDf2b4aLIJfBLC4UpTzD1z/TUR/mIpA3JMtP+MLqhKUcRQgQ8zHF
         pN3w==
X-Gm-Message-State: AGi0PuY0fBBGRGz7MUna1aVKvDgJEEuL7mELOP+nxSOvRVir5sFmdbEj
        YV4fs2Xh57lDdtEdpxa9Lg0FvjdOn3A=
X-Google-Smtp-Source: APiQypLptsxaLnR82gGD+N8uvn9oJpqhty1H1wWqNE3vr+7lKjBnR9wlj6Yk+PoLbgYL6WFOpkLw2A==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr4926667pld.133.1587152187768;
        Fri, 17 Apr 2020 12:36:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h26sm3381846pgn.16.2020.04.17.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:36:27 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:36:22 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/5] help: move list_config_help to builtin/help
Message-ID: <20200417193622.GB236872@google.com>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-2-emilyshaffer@google.com>
 <xmqqd087xe9x.fsf@gitster.c.googlers.com>
 <xmqq8sivxdyv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sivxdyv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 03:28:24PM -0700, Junio C Hamano wrote:
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Forgot to proofread and edit the log message into reasonable shape
> > when you squashed two patches together?

Less "forgot" and more "wanted to preserve origin", but I'll avoid it
next time. Thanks.

> >
> > I wonder if the "squash" action of "rebase -i" can be taught to
> > detect a mistake like this?
> 
> Without waiting for an improvement to "rebase -i" ;-), here is what
> I came up with, with a minimum edit.

Sorry to make more work for you. Thanks, it looks fine.

> 
> 
> Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
> builtin/clean.o, and builtin/config.o. This meant that help.o was
> unusable outside of the context of the main Git executable.
> 
> To make help.o usable by other commands again, move list_config_help()
> into builtin/help.c (where it makes sense to assume other builtin libraries
> are present).
> 
> When command-list.h is included but a member is not used, we start to
> hear a compiler warning. Since the config list is generated in a fairly
> different way than the command list, and since commands and config
> options are semantically different, move the config list into its own
> header and move the generator into its own script and build rule.
> 
> For reasons explained in 976aaedc (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29), some build
> artifacts we consider non-source files cannot be generated in the
> Visual Studio environment, and we already have some Makefile tweaks
> to help Visual Studio to use generated command-list.h header file.
> Do the same to a new generated file, config-list.h, introduced by
> this change.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>

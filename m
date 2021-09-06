Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC018C433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DF660F4A
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 03:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbhIFDM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhIFDMy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 23:12:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADAC061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 20:11:50 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q68so5328950pga.9
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SOa7sBZRBowRTbpiQxbLkbIRv0HsFQpFL0gIehQ+5Fc=;
        b=d2eqAJzDVsSjIPaZFvv5c4NW6g0HQamgcK7O1Jz+mwTU3uXSjHLn4hGoVNtrTBRhN+
         KkXlB7XkyoU0gVxzqP5IdmGPycTqx96J7eskLQen9mP0quHMUpvSFM1c/R23U13a4Ccn
         xk8139NzTDJM51gENvSWQx7jyz+JW2qdLrzCcj4rsm79QKOCCMoU7jT72jH05l1KpbHS
         Gka/nmegEGKGlIz6cuW6SnYAKy4uQ2CpsdXdgp28gDDC7+ODB+hfdJZHAlH5KyIdFLGz
         zXfMFO18PwjoO546bifIxPIqOK5E42aB237fSJz4atwbZ/V5fBegHmKmtg2HI2rt2j6x
         ghLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SOa7sBZRBowRTbpiQxbLkbIRv0HsFQpFL0gIehQ+5Fc=;
        b=sLyPpOcZHxN/T125WP8IhU3869dHEp7eMy26/Xu5V5J+vFWIZoph/VpfBvEu8RQOxU
         n0sJMvsqCcil5L747t5TDcG3ijXWrIzXUjPWhNJ92GkwsEXpOQ02Vf//KYbjJsrStwN+
         hHFyNdQ9lkPZ+Fj0X5Ew1O7ybWcL9eh49L3dHmSEAjwUewPzGYlGadBiRI75cx3ffPL1
         wu+YKkuSUQi969h+8MdAk+nQLwpKmDcKFAeTsF4ESf9zBxHtvJXXMhNW038rIRKmY4qs
         yFJhkAeOzHp9Skg9lbEWaywT4WE6YhsJEtqvbaDan0XIjiteYoo7Ekke+WZfQEvuXzD/
         1w/w==
X-Gm-Message-State: AOAM531SlXbaO0TEM5qv17/rmuvXoVMkHTIj/Ost3yksbh+GHs9fmvCt
        Fnr9vQbVdThrne+tnWnxh0g=
X-Google-Smtp-Source: ABdhPJzMd1Wqn0zxy7Mtb0DCsn1UCSXqHaZAjEUFo1tW6km4uV+MaZtsxmbqrviqMq+m/wmE5Q41cg==
X-Received: by 2002:a63:dd46:: with SMTP id g6mr10206400pgj.347.1630897909792;
        Sun, 05 Sep 2021 20:11:49 -0700 (PDT)
Received: from localhost ([2402:800:63b8:b16f:4365:862:cbde:fdea])
        by smtp.gmail.com with ESMTPSA id o3sm5455050pji.26.2021.09.05.20.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 20:11:49 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:11:47 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Carlo Arenas <carenas@gmail.com>, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH RESEND v3] make: add INSTALL_STRIP option variable
Message-ID: <YTWG8xpoxXvRkoNV@danh.dev>
References: <20210905110417.35702-1-bagasdotme@gmail.com>
 <xmqqwnnuesrf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnnuesrf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-09-05 12:17:56-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> >  [QUESTION]: I squashed Junio's suggestion patch to produce this patch,
> >  and I want to credit his work. In such situation, what should I do the
> >  right way? For now I add From: line and S-o-b trailer with his
> >  identity, in addition to my S-o-b.
> 
> As far as I'm concerned, everything we see in this resulting patch
> (like studying how we should sift $(ALL_PROGRAMS) into two classes,
> one that can be stripped and the other that shouldn't be) came from
> your brain.  I may have helped you in writing it down in a better
> form but I see it within the usual "Helped-by:".

FWIW, it was rewrite from my original suggestion in <YSjdc/tNlhbCosC2@danh.dev>

> Applying this to the same base as the previous iteration of the
> topic that I queued in 'seen', and running "git range-diff" between
> them, I see that there is no difference at all, so I'll keep the one
> I already have, but I probably should correct the authorship
> information for it (I failed to notice you had in-body From: header
> that shifts the blame for this change on me---you should be the
> author of this change).
> 
> IOW, here is what I would expect in a situation like this.
> 
> -- >8 --
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Subject: [PATCH] make: add INSTALL_STRIP option variable
> 
> Add $(INSTALL_STRIP), which allows passing stripping options to
> $(INSTALL).
> 
> For this to work, installing executables must be split to installing
> compiled binaries and scripts portions, since $(INSTALL_STRIP) is only
> meaningful to the former.
> 
> Users can set this variable depending on their system. For example,
> Linux users can use `-s --strip-program=strip`, while FreeBSD users can
> simply set to `-s` and choose strip program with $STRIPBIN.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

So, here is my SoB, too:

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>

-- Danh

> ---
>  Makefile | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d1feab008f..ebef4da50c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -465,6 +465,9 @@ all::
>  # the global variable _wpgmptr containing the absolute path of the current
>  # executable (this is the case on Windows).
>  #
> +# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
> +# if your $(INSTALL) command supports the option.
> +#
>  # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
>  # database entries during compilation if your compiler supports it, using the
>  # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
> @@ -3004,7 +3007,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
>  endif
>  mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
>  
> -install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
> +install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
> +install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
>  
>  .PHONY: profile-install profile-fast-install
>  profile-install: profile
> @@ -3013,12 +3017,17 @@ profile-install: profile
>  profile-fast-install: profile-fast
>  	$(MAKE) install
>  
> +INSTALL_STRIP =
> +
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> +	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> +
>  ifdef MSVC
>  	# We DO NOT install the individual foo.o.pdb files because they
>  	# have already been rolled up into the exe's pdb file.
> -- 
> 2.33.0-408-g8e1aa136b3
> 

-- 
Danh

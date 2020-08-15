Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD676C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54B2204FD
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDiuUGLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgHOVxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbgHOVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCFC06134B
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 18:15:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so5143512pjx.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hWXOjmqgy0lwEYymo9PIw0unhczq+P/ANO7q7S86u8=;
        b=YDiuUGLu0i/06rghiicCSKS7EfV7yh4AC+F6n4oawBN2Thzbay/UmSpUhVZT73Chgp
         9kIwYZ3MHU08T7ECaZOlocnNWjU82mPprmwX0WJ0K2A5G6QfRfVN+Wm/FRTYjKHNjVSo
         mWIzKeARLqb5FMa1S9fGLZEVt56FwtHkIavi057E29fBFu2kRxgo7CKFKswe7FToANla
         11c36aGmrXfewZsT8UmgslSsSdw29KOYZk6PyPP8NAGiFySa6M7HUajhkTaddcpk7/iP
         XSG6QTfL5v8Kd4QC5qkts6gcCOF+yP0ozWUUJOdTGmqPJvCjKbY0HERGNDEme8hPDm0w
         PSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hWXOjmqgy0lwEYymo9PIw0unhczq+P/ANO7q7S86u8=;
        b=NZi+/Aiix3KJm6XzJ7lKw+jhRfzSwGc48dT2c+udoUgWLRzYDlYME2BOObDVc4A/RI
         khlwfzpaC7M/0EGQfABZk1cFPhsJqC7/daaP0hxKulJxltguNLVTweWJ++BKDgWPmVQZ
         nMhtN+Dnc4AIeZCPMMcrLT+54O+f6XuQEvCqXjMpoNFTvm0tTNnVNd7hnOW70o8SGoRO
         7z1FMvQOMY3PbqKkvjVD1AZ7UFxCAe+83nw73UjKzQlNUPHXRRQ5TENt7e1/ULJ1lTo+
         X1KkBad90HM7EAY9KIpdr6AzHvmvu0tG6G+mmTaIudNXAEeD+C+qfvuzOy6oTVnL4gAq
         NY9g==
X-Gm-Message-State: AOAM530dyzRLtkqBVvWuO4M4Ro3SkHbJgeuRYc/aF/TlyQ8vcdnX1AFM
        4ZpfRmxF5FKPh+qw0epc8Ow=
X-Google-Smtp-Source: ABdhPJzz0rKjrWwT+0WzSr+T6TYe9wIeYCVWe+hkkwqKxjHosKeK2kRnEp9sNOaFNCL0ivItGdSV8Q==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr4192202pjw.146.1597454159093;
        Fri, 14 Aug 2020 18:15:59 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id s8sm11050076pfc.122.2020.08.14.18.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 18:15:58 -0700 (PDT)
Date:   Sat, 15 Aug 2020 08:15:56 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Alexander Ost <ost@ieee.org>, Git List <git@vger.kernel.org>
Subject: Re: [BUG] `make install' partly ignores `NO_INSTALL_HARDLINKS'
Message-ID: <20200815011544.GB12363@danh.dev>
References: <CAGNCYk3hGWHuSb4vDzrBE54P5y6Sm+TwfVrCfHD0LnLQWSr9nA@mail.gmail.com>
 <CAPig+cQnGUyM2cwNjDm_zys15B9n82QT6-RD7Lgyz1-XSGp8yw@mail.gmail.com>
 <xmqqimdm1ae6.fsf@gitster.c.googlers.com>
 <20200814150214.GC9518@danh.dev>
 <xmqqo8ndxhof.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8ndxhof.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-14 10:26:24-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Since both git-citool and git-gui will be installed into same
> > directory "$(libexecdir)", I think it would make more sense to use:
> >
> > 	LN = ln -s
> >
> > here instead?
> 
> In the top-level Makefile, INSTALL_SYMLINKS make macro does exist,
> but it is not exported to submakes.  If it were, something like
> 
>     ifdef INSTALL_SYMLINKS
> 	LN = ln -s
>     else
>     ifdef NO_INSTALL_HARDLINKS
> 	LN = cp
>     else
> 	LN = ln
>     endif
>     endif
> 
> might become possible, but you'd need to audit what is fed to $(LN)
> at the locations the macro is used and make necessary adjustment
> accordingly.  "cp A ../B" or "ln A ../B" will make a usable copy of
> file A appear inside ../B directory, but "ln -s A ../B" will not,
> and I didn't see if all uses of $(LN) was to give synonyms to what
> is already installed, or some of them were truly installing from the
> build location when I gave the "something along this line" example.

Yes, the top-level Makefile seems to have a special branch for
BUILT_INS, in which, we will create symlink for those builtin in
libexecdr if NO_INSTALL_HARDLINKS is defined.

I was aiming for something like this to make git-gui a bit more
consistent with top-level Git, with or without INSTALL_SYMLINKS
exported:

----------8<--------
diff --git a/git-gui/Makefile b/git-gui/Makefile
index f10caedaa7..1a7d4b5075 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -48,6 +48,13 @@ endif
 RM_RF     ?= rm -rf
 RMDIR     ?= rmdir
 
+ifneq (,$(NO_INSTALL_HARDLINKS)$(INSTALL_SYMLINKS))
+	SAMEDIR_LN = ln -s
+else
+	SAMEDIR_LN = ln
+endif
+
+
 INSTALL_D0 = $(INSTALL) -d -m 755 # space is required here
 INSTALL_D1 =
 INSTALL_R0 = $(INSTALL) -m 644 # space is required here
@@ -57,7 +64,7 @@ INSTALL_X1 =
 INSTALL_A0 = find # space is required here
 INSTALL_A1 = | cpio -pud
 INSTALL_L0 = rm -f # space is required here
-INSTALL_L1 = && ln # space is required here
+INSTALL_L1 = && $(SAMEDIR_LN) # space is required here
 INSTALL_L2 =
 INSTALL_L3 =
 
@@ -87,7 +94,7 @@ ifndef V
 	INSTALL_L0 = dst=
 	INSTALL_L1 = && src=
 	INSTALL_L2 = && dst=
-	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && ln "$$src" "$$dst"
+	INSTALL_L3 = && echo '   ' 'LINK       ' `basename "$$dst"` '->' `basename "$$src"` && rm -f "$$dst" && $(SAMEDIR_LN) "$$src" "$$dst"
 
 	CLEAN_DST = echo ' ' UNINSTALL
 	REMOVE_D0 = dir=
@@ -127,6 +134,12 @@ TCL_PATH_SQ = $(subst ','\'',$(TCL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 TCLTK_PATH_SED = $(subst ','\'',$(subst \,\\,$(TCLTK_PATH)))
 
+ifneq (,$(NO_INSTALL_HARDLINKS)$(INSTALL_SYMLINKS))
+	gitexecdir_SQ_for_LN =
+else
+	gitexecdir_SQ_for_LN = $(DESTDIR_SQ)$(gitexecdir_SQ)/
+endif
+
 gg_libdir ?= $(sharedir)/git-gui/lib
 libdir_SQ  = $(subst ','\'',$(gg_libdir))
 libdir_SED = $(subst ','\'',$(subst \,\\,$(gg_libdir_sed_in)))
@@ -293,7 +306,7 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(INSTALL_X0)git-gui--askpass $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
+	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(gitexecdir_SQ_for_LN)git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
 ifdef GITGUI_WINDOWS_WRAPPER
 	$(QUIET)$(INSTALL_R0)git-gui.tcl $(INSTALL_R1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 endif
-------->8-----------

Given that, we also tried to make symlinks when NO_INSTALL_SYMLINKS is
given, I think it's fine to assume that symlink should available on
those platform.

-- 
Danh

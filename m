Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A2C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1961B60E73
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbhH0Mma (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245136AbhH0Mm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 08:42:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650FC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 05:41:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t1so5875709pgv.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2U1YZIDcqB6tnbf3PF7LfnEWLeXow99R0Yenol7r2WM=;
        b=ejylSsRVJEyFm/X2mjs00jNs+2IhPUOJ709GNUnHS8M3JEaONkwplJl1XygOipv2ag
         hqrXIWF/EgY5gva/Upb+3n0xxJfKIBzfROnMVNY8vPz35NZHkGQAYscdShmjMn7tfBbw
         kUHk93UkYjBuSOwR4asUKTRxnMu0SJcspWDNbZyZFyDniNfOvjmSxcuwRl/RwLfjtOcz
         vCk/gJUobaRbyw3rj3SC9gS7xHRYYFqvmTpSv2a0HadW5dX/IbGbL6OqVA64k51R3tPe
         riDG4gwmWAsfe9TMjTLuZKQ0lj+1A4Q6eFZERBX+3XxrYOOrCnfd7zo1ebEkO9gVPNXo
         f+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2U1YZIDcqB6tnbf3PF7LfnEWLeXow99R0Yenol7r2WM=;
        b=FLWiu5KoRhkEkvIWdjyfueg39RxzO38+8CtplWSF32FjoIx4RIH1jIBPu7Lg6mRzLp
         vw3ZKgimHl54ECwQSyAcNJBMRFCg8zDK/9ndtYkXjTeoIx+uhVBu9EuKl7rZp4laul9B
         LB91oh/0emvk8X3vp3udU7ZXPOWgAW2Co6qtqXM91kLxtzC1866SGN6JQfvcFPcgpcyE
         QowFr59aIIlsfA7xksFrLOuQEQVKe5+Otm904kVy5b1UqJUa4v2HzPsdcJKr5/r4NRiV
         AscqP0VwtGMPdPS21VSTNpTrYk3QfDAmz+3fonAxBBCGZ5oJ8Ssk5IFclGiDcGzL2Yxz
         pN6g==
X-Gm-Message-State: AOAM533LZFzwl+oBjOH+I35Yu38kVXxB9ZlLIQn7OeCQrjOVZtrMkJlr
        4EbM80yuwBsQJi3nUPJuA8A=
X-Google-Smtp-Source: ABdhPJwOQ7AlReX/G8FCyPGdILsGTT+ijxl5B/FS94hTHr0T8LfjieTJytDQbwXkVpS1R7W3akX9QQ==
X-Received: by 2002:a63:fd54:: with SMTP id m20mr7824891pgj.104.1630068100406;
        Fri, 27 Aug 2021 05:41:40 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id i6sm6463008pfa.44.2021.08.27.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 05:41:39 -0700 (PDT)
Date:   Fri, 27 Aug 2021 19:41:37 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] make: add install-stripped target
Message-ID: <YSjdc/tNlhbCosC2@danh.dev>
References: <20210826113824.50078-1-bagasdotme@gmail.com>
 <20210826113824.50078-2-bagasdotme@gmail.com>
 <xmqq8s0odl5l.fsf@gitster.g>
 <b2005b0f-9181-526b-ebf5-58fca44299b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2005b0f-9181-526b-ebf5-58fca44299b5@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-08-27 14:57:56+0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 27/08/21 03.08, Junio C Hamano wrote:
> > It also depends on "strip" not to break handlinks to the same
> > binary.  "git" is linked to many built-in command binary like
> > "git-cat-file" and "git-remote-$curl" for various protocols are
> > installed by creating links to "git-remote-http".  It seems that the
> > "strip" command from GNU binutils package strips such a binary
> > in-place, but I do not think there is no fundamental reason to
> > believe that everybody else's "strip" would behave that way.
> > 
> 
> Maybe hardlinks?
> 
> > I would have expected that 'install-stripped' and 'install' targets
> > would run the same recipe, and when $(install_bindir_programs) are
> > installed in $(bindir) using $(INSTALL), we would optionally pass
> > the '--strip' option to the $(INSTALL) program when the recipe is
> > run for the install-stripped target.  All the tricky symlinking,
> > hardlinking and copying happens only on the result of that step, and
> > the strip step should happen before that, I would think.
> > 
> 
> Did you mean copying recipe of 'install' to 'install-stripped' and the
> latter s/$(INSTALL)/$(INSTALL -s --strip-program="$(STRIP)"/)?

I think Junio meant something like this:

---- 8< ----

diff --git a/Makefile b/Makefile
index 429c276058..70b7ef9ce1 100644
--- a/Makefile
+++ b/Makefile
@@ -3004,7 +3004,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3014,18 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
-install: all
+INSTALL_OPTS :=
+
+install-strip: INSTALL_OPTS := -s --strip-program=$(STRIP)
+
+install-strip install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_OPTS) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.
---- >8 -----

-- 
Danh

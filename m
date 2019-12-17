Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26849C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED03B24655
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVqnOOL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfLQAle (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:41:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34525 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAle (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 19:41:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so4763282pfl.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 16:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NReueiXPMWjVtv8u4x6rL4ygNU/pvwQYWzdQc+TOAA8=;
        b=IVqnOOL53wxJnZkrVGd7MVokE1RT9GUEZi6ceTARoSuSGwm0NxJwTL3KLnrLAwXDzC
         svxx2GsOJXq4OXz/tGWA5eLCBuKoI3wl5wM3gVkUFZ8zEUOJwslw70jt3DopXFIzZW6h
         AHGQDWzGzO6zTo6rw0fQXp3o8NvurdXmuVnjt87zjTDKIMwyVw94UBpcIubiBvwNLcYH
         HFiPwey15PC6B9t925IH41eTwCNzlOG8VMbPxFol+RRAbs5KAzZU51/nXov8T0lnpsLT
         ApR4MrA0/g1WdW1DuRnnIxhoUfuMeLo/uLMp/EVmJ7nGDJf8CQDUouFlXUFGqQmqCyoP
         dIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NReueiXPMWjVtv8u4x6rL4ygNU/pvwQYWzdQc+TOAA8=;
        b=PUJkjkrFLYxhTABAc4CW1c5Oz0ZpF3Eh9dByfbMv8ETx0gfOYbs8RciV7bNNiPxLUb
         eGOdZYOZo6XHxyBeOE5Cum27gRec5I10qw44NBn3m6E3IKzuxEdAM3uSYv5SHIZ+Qpee
         R37YVpMdsZNxvFZYj/pVvzRpuQHqa6EzjJM+JDB/U6xIzkO5uTVRrNEOQwfDNp0iAi5G
         8ha7a37Ehr47vNcpDKD2/aEWWxUUtBExt/28iPUe5/berv2KBF4RrGfktLu33xANDxB5
         GRvrZ8G2Nb8gw+Pnze67ULmt1mJGC4xYX3e8pU5gQ44dPA+QJY7Fn1d1rTBcvr4LHg05
         WqZw==
X-Gm-Message-State: APjAAAXcsoMSNyOd4dElJUm8Kd+t9HPV9N6V87QGIG5RYy1hqDW2Ya2J
        TNh0IqIhF4TyTXIaMUDg/GLt3g==
X-Google-Smtp-Source: APXvYqxBnJ0L4aAha4eSC6Jkfph7byMoPHjVCoPTtwIw+cVEAPXw8lBrIwlXnAQxz33j3D2AjT+BoQ==
X-Received: by 2002:a63:3104:: with SMTP id x4mr21569659pgx.369.1576543292658;
        Mon, 16 Dec 2019 16:41:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u10sm23776376pgg.41.2019.12.16.16.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 16:41:31 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:41:27 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20191217004127.GP135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-10-emilyshaffer@google.com>
 <xmqq7e2zhm0i.fsf@gitster-ct.c.googlers.com>
 <20191216230124.GJ135450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216230124.GJ135450@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 03:01:24PM -0800, Emily Shaffer wrote:
> On Fri, Dec 13, 2019 at 02:57:17PM -0800, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > diff --git a/Makefile b/Makefile
> > > index c49f55a521..76dc51e2b1 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -651,7 +651,7 @@ install-perl-script: $(SCRIPT_PERL_GEN)
> > >  install-python-script: $(SCRIPT_PYTHON_GEN)
> > >  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > >  
> > > -.PHONY: clean-perl-script clean-sh-script clean-python-script
> > > +.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script-dependencies
> > >  clean-sh-script:
> > >  	$(RM) $(SCRIPT_SH_GEN)
> > >  clean-perl-script:
> > > @@ -817,6 +817,7 @@ VCSSVN_LIB = vcs-svn/lib.a
> > >  
> > >  GENERATED_H += config-list.h
> > >  GENERATED_H += command-list.h
> > > +GENERATED_H += bugreport-config-safelist.h
> > 
> > OK.
> > 
> > >  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
> > >  	$(FIND) . \
> > > @@ -2161,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Doc
> > >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> > >  		command-list.txt >$@+ && mv $@+ $@
> > >  
> > > +bugreport-config-safelist.h: generate-bugreport-config-safelist.sh
> > > +
> > > +bugreport-config-safelist.h: Documentation/config/*.txt
> > > +	$(QUIET_GEN)$(SHELL_PATH) ./generate-bugreport-config-safelist.sh \
> > > +		>$@+ && mv $@+ $@
> > 
> > OK.
> > 
> > >  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
> > >  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
> > >  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> > 
> > But bugreport.o needs this *.h file generated before a compiler
> > attempts to produce it out of bugreport.c; that dependency is
> > missing from this update to the Makefile.
> 
> Hm. Somewhere I misformatted my commits, then. My goal was to add the
> new header here, but not add it as a dependency to anybody; then, in the
> next commit, add it as a dependency to git-bugreport and start to use it
> (commit 1: make the thing; commit 2: use the thing). But now when I look
> at the next commit, I don't see a Makefile change. So I missed something
> while I was shuffling around fixups.  Thanks for noticing.
> 
> > 
> > > @@ -2791,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
> > >  .PHONY: sparse $(SP_OBJ)
> > >  sparse: $(SP_OBJ)
> > >  
> > > -GEN_HDRS := config-list.h command-list.h unicode-width.h
> > > +GEN_HDRS := config-list.h command-list.h unicode-width.h bugreport-config-safelist.h
> > >  EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
> > >  ifndef GCRYPT_SHA256
> > >  	EXCEPT_HDRS += sha256/gcrypt.h
> > > @@ -3117,7 +3124,8 @@ clean: profile-clean coverage-clean cocciclean
> > >  	$(RM) $(HCC)
> > >  	$(RM) -r bin-wrappers $(dep_dirs)
> > >  	$(RM) -r po/build/
> > > -	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
> > > +	$(RM) *.pyc *.pyo */*.pyc */*.pyo
> > > +	$(RM) config-list.h command-list.h bugreport-config-safelist.h
> > 
> > It is kind of sad that GEN_HDRS defines the list of build artifact
> > that we should be able to clean, and then we manually list them to
> > be removed here independently.  Can we fix it up too?
> 
> Yeah, I can do that. I thought so too when I was updating this.
> 
> I *think* what happened is that when I split config-list away (in the
> earleir commit in this chain) I didn't notice that command-list.h was
> already in GEN_HDRS, and instead just grepped Makefile for
> "command-list.h" and added config-list.h next to it. So I'll try to fix
> it much earlier, in that commit, and then simply add to the appropriate
> variables in this commit.
> 
> > 
> > We probably clean up the build/update procedure around unicode-width.h
> > before we can do so, probably.  It may be generatable using contrib/
> > script, but as far as our normal build is concerned, it is a tracked
> > source and not part of the build byproducts, so we probably would
> > want to remove it from GEN_HDRS.  When that happens, we can $(RM)
> > all of the $(GEN_HDRS) in the "clean" target.
> 
> Noted. Thanks.

Ah, after I sent this mail I saw your patch. For those playing along at
home, https://lore.kernel.org/xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com

Will review.

 - Emily

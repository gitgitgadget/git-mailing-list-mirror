Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D7C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5052465E
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSp7P4CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLPXBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:01:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38892 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLPXBb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 18:01:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so6432418pfc.5
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qSh1GY8z+BdYyaYU9X6RUQYwg4TKMPbbjgZrmkeF/SY=;
        b=BSp7P4CBv0D6S6PpCjpdyOF+x3kNis3Jx9/1lGBRzjgW2ezuspPou8mrfgh10QB/X5
         PUCYXC5I5rDvr53VWNKijejJTLrkrIb6pg7S5dRyaHOm1ECFg0t+Wmm8Issz1sv5X9P8
         dAil0l3U29QDbWzZFyflA7qkRgIZZF7fxG3x8IbFZR7LA/v6F9LMog+MFWqAiOwEfRF7
         zTfPvcLK53VOF1Is5y0fH6Zr5tpeeNGg7jdPzIAs7UZzMAx93Z58vwYGIUOEOeGYREla
         d6sUS3S8KzHKQl7oQn+8crl5+LfKj0HN4waJJPpvojLgzmHbfGiN4q4IGz4LdXDj+h2R
         PBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qSh1GY8z+BdYyaYU9X6RUQYwg4TKMPbbjgZrmkeF/SY=;
        b=D961rBg0fmyXGrratVxQef5tnlvnQaRjP3DJzCFk0QUax0p1Nv+gC94olja+klQjn5
         G4Dd3TF+5R2G+jcBLIY87k6jnZF7c93gSwGCwiDa2qZqIExtIrmwKHbV7raQjlsIuXpm
         ci+xsyjDy0JC3/hKjPhhQ3QWEECbybJQF7VBPHvJSxdkuSUXfVNXrUdOFL9vt8+eL7ax
         EgTy5ViiwJe9CU/tYheB7383I2pmwQ+hEv2ztZDFCtoQVM6s4sph2WYMU3GNVXif1bSQ
         adtr4v5e9O2TBpVfZHd47NGAdTvxtNGvJ0lIeO5EjZ8DwZdOiRgZVlzZeDSW5ggCXcqi
         XZAQ==
X-Gm-Message-State: APjAAAVITzbwuiqeehw+79lPJ0Y3tEpeXyh4koI6RxNF6C6/I0Ly7FZq
        pCdR0I+rfmcJTUMiNIZRP/PZ8w==
X-Google-Smtp-Source: APXvYqxsWfoTy+NpVRdyvea7IE6r3pEHXCA//32vktR++fQDiWM4iFh5sIbLrytsk0ekZOizTwL4RQ==
X-Received: by 2002:aa7:9629:: with SMTP id r9mr19139845pfg.51.1576537289929;
        Mon, 16 Dec 2019 15:01:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d2sm609743pja.1.2019.12.16.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:01:29 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:01:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20191216230124.GJ135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-10-emilyshaffer@google.com>
 <xmqq7e2zhm0i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e2zhm0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 02:57:17PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index c49f55a521..76dc51e2b1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -651,7 +651,7 @@ install-perl-script: $(SCRIPT_PERL_GEN)
> >  install-python-script: $(SCRIPT_PYTHON_GEN)
> >  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> >  
> > -.PHONY: clean-perl-script clean-sh-script clean-python-script
> > +.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script-dependencies
> >  clean-sh-script:
> >  	$(RM) $(SCRIPT_SH_GEN)
> >  clean-perl-script:
> > @@ -817,6 +817,7 @@ VCSSVN_LIB = vcs-svn/lib.a
> >  
> >  GENERATED_H += config-list.h
> >  GENERATED_H += command-list.h
> > +GENERATED_H += bugreport-config-safelist.h
> 
> OK.
> 
> >  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
> >  	$(FIND) . \
> > @@ -2161,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Doc
> >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> >  		command-list.txt >$@+ && mv $@+ $@
> >  
> > +bugreport-config-safelist.h: generate-bugreport-config-safelist.sh
> > +
> > +bugreport-config-safelist.h: Documentation/config/*.txt
> > +	$(QUIET_GEN)$(SHELL_PATH) ./generate-bugreport-config-safelist.sh \
> > +		>$@+ && mv $@+ $@
> 
> OK.
> 
> >  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
> >  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
> >  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> 
> But bugreport.o needs this *.h file generated before a compiler
> attempts to produce it out of bugreport.c; that dependency is
> missing from this update to the Makefile.

Hm. Somewhere I misformatted my commits, then. My goal was to add the
new header here, but not add it as a dependency to anybody; then, in the
next commit, add it as a dependency to git-bugreport and start to use it
(commit 1: make the thing; commit 2: use the thing). But now when I look
at the next commit, I don't see a Makefile change. So I missed something
while I was shuffling around fixups.  Thanks for noticing.

> 
> > @@ -2791,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
> >  .PHONY: sparse $(SP_OBJ)
> >  sparse: $(SP_OBJ)
> >  
> > -GEN_HDRS := config-list.h command-list.h unicode-width.h
> > +GEN_HDRS := config-list.h command-list.h unicode-width.h bugreport-config-safelist.h
> >  EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
> >  ifndef GCRYPT_SHA256
> >  	EXCEPT_HDRS += sha256/gcrypt.h
> > @@ -3117,7 +3124,8 @@ clean: profile-clean coverage-clean cocciclean
> >  	$(RM) $(HCC)
> >  	$(RM) -r bin-wrappers $(dep_dirs)
> >  	$(RM) -r po/build/
> > -	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
> > +	$(RM) *.pyc *.pyo */*.pyc */*.pyo
> > +	$(RM) config-list.h command-list.h bugreport-config-safelist.h
> 
> It is kind of sad that GEN_HDRS defines the list of build artifact
> that we should be able to clean, and then we manually list them to
> be removed here independently.  Can we fix it up too?

Yeah, I can do that. I thought so too when I was updating this.

I *think* what happened is that when I split config-list away (in the
earleir commit in this chain) I didn't notice that command-list.h was
already in GEN_HDRS, and instead just grepped Makefile for
"command-list.h" and added config-list.h next to it. So I'll try to fix
it much earlier, in that commit, and then simply add to the appropriate
variables in this commit.

> 
> We probably clean up the build/update procedure around unicode-width.h
> before we can do so, probably.  It may be generatable using contrib/
> script, but as far as our normal build is concerned, it is a tracked
> source and not part of the build byproducts, so we probably would
> want to remove it from GEN_HDRS.  When that happens, we can $(RM)
> all of the $(GEN_HDRS) in the "clean" target.

Noted. Thanks.

 - Emily

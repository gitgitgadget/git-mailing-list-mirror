Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE4C6377B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292F06124B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhGUXki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGUXkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:40:37 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93380C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:21:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bt15so3747397pjb.2
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oBaFjEwbufNsYBt+2HB8IwYmnCiVfF/Q5tVglnFHx+4=;
        b=CinHjEvLOVbIpDHJYat1MIFA8kYJ1xFEbHHpyAOeHFqVnzyl3mGzkhNF7Kbq1/SmXd
         qVmb1TQZ3eyFiztzfi7A64MuWP7e9D4LWlmINDqDNC3x5RyLHZRG84SopWl+3zPDe2I3
         fTd2AipvyEcqSt+bkOOSvza+g6UN1df9kBCpwKq1h9+1TcT6FtvtRO0pxNTwSgUODjis
         J5piPFLobzWQe+2tcM/r/AcS9blkMrdiyHefj07wUkmq5EyKrj6GwhFOCYpEApHJQi/t
         XFmyEtinHbk97EvYU1oRs8mxrAJKk/n66Z6GI2JyZ5NB7Fx/vex/zExzcvCZfYSEgdnK
         zmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oBaFjEwbufNsYBt+2HB8IwYmnCiVfF/Q5tVglnFHx+4=;
        b=Q+ZLDzNJ62LevOwAIGhEfMfEMqAGFgJf2o40J9DfZHHusLzsUyO/OQLpW+UPbvrvUI
         IIxa8qUpf+W8o96hLEWxj++j+VQcF7O4CE/5vsG49rsvQ4G+DpKQ3z8pt+ofEOqYt05X
         c4x+/VASf1VBilrmrjbJlAjjbr74ddGpyD4f+/2g5pxTkwaCzHP2E54lqFYHsnfWTwTK
         Qw0ly89ZsSavJ7jGM22qXP8BGevA7jjLJ/gKaZtcMroZjmNzzk2dQpDiyHCzzSXpzLFn
         A1ba3d57ySUVsC6UNXiYkJikzLUuyVysMIekGc/rw7d7KwMXJpYO2sxDueBpmERviZw4
         bH7A==
X-Gm-Message-State: AOAM531vldR0OGZg1HygGfctWZqCZXmhMdk+nLzmUg+ZjDhgMaL56SEm
        yU5QIE2Kp4yI+fUjp1DakDJjNw==
X-Google-Smtp-Source: ABdhPJwYOVi+eEMDECBFtmwyxEOewWgvwTbh5tkrrr1kRycNwFr/CFeEXM/aunBf9ZUl76vJpMAdmQ==
X-Received: by 2002:a05:6a00:1627:b029:333:323:2c04 with SMTP id e7-20020a056a001627b029033303232c04mr37465237pfc.78.1626913272723;
        Wed, 21 Jul 2021 17:21:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:83f3:cefc:ff34:3095])
        by smtp.gmail.com with ESMTPSA id z3sm27991951pfa.67.2021.07.21.17.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:21:12 -0700 (PDT)
Date:   Wed, 21 Jul 2021 17:21:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5] tr2: log parent process name
Message-ID: <YPi58/qRPQWhZkiI@google.com>
References: <20210608221059.1935021-1-emilyshaffer@google.com>
 <3327f108-6cd1-1d3d-eae9-2cdff96e1375@jeffhostetler.com>
 <YNux62he9Mk43Y1B@google.com>
 <87a6n7g9np.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6n7g9np.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 08:10:59AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Tue, Jun 29 2021, Emily Shaffer wrote:
> 
> > On Mon, Jun 28, 2021 at 12:45:24PM -0400, Jeff Hostetler wrote:
> >> On 6/8/21 6:10 PM, Emily Shaffer wrote:
> >> > Range-diff against v4:
> >> > 1:  efb0a3ccb4 ! 1:  7a7e1ebbfa tr2: log parent process name
> >> >      @@ compat/procinfo.c (new)
> >> >       +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> >> >       +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> >> >       +		strbuf_release(&procfs_path);
> >> >      ++		strbuf_trim_trailing_newline(&name);
> >> >       +		strvec_push(names, strbuf_detach(&name, NULL));
> >> >       +	}
> >> >       +
> >> 
> >> You're only getting the name of the command (argv[0]) and not the
> >> full command line, right?  That is a good thing.
> >
> > Roughly. The name can be reset by the process itself (that's what
> > happened, I guess, in the tmux case I pasted below) but by default it's
> > argv[0]. It's also truncated to 15ch or something.
> 
> 16 including the \0. See prctl(2). Linux has two different ways to
> set/get the name, one is the argv method, the other is
> prctl(PR_SET_NAME). They don't need to match at all. The ps(1) utility
> and some top-like utilities allow you to switch between viewing the two
> versions.
> 
> As noted in the linked manual pages you'll also potentially need to deal
> with multithreaded programs having different names for each thread.
> 
> I don't think we use this now, but FWIW one thing I've wanted to do for
> a while was to have the progress.c code update this, so you see if git's
> at N% counting objects or whatever in top.
> 
> >> > +#ifdef HAVE_PROCFS_LINUX
> >> > +	/*
> >> > +	 * NEEDSWORK: We could gather the entire pstree into an array to match
> >> > +	 * functionality with compat/win32/trace2_win32_process_info.c.
> >> > +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
> >> > +	 * gather the immediate parent name which is readily accessible from
> >> > +	 * /proc/$(getppid())/comm.
> >> > +	 */
> >> > +	struct strbuf procfs_path = STRBUF_INIT;
> >> > +	struct strbuf name = STRBUF_INIT;
> >> > +
> >> > +	/* try to use procfs if it's present. */
> >> > +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> >> > +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> >> > +		strbuf_release(&procfs_path);
> >> > +		strbuf_trim_trailing_newline(&name);
> >> > +		strvec_push(names, strbuf_detach(&name, NULL));
> >> > +	}
> >> > +
> >> > +	return;
> >> > +#endif
> >> > +	/* NEEDSWORK: add non-procfs-linux implementations here */
> >> > +}
> >> 
> >> Perhaps this has already been discussed, but would it be better
> >> to have a "compat/linux/trace2_linux_process_info.c"
> >> or "compat/procfs/trace2_procfs_process_info.c" source file and
> >> only compile it in Linux-compatible builds -- rather than #ifdef'ing
> >> the source.  This is a highly platform-specific feature.
> >> 
> >> For example, if I convert the Win32 version to use your new event,
> >> I wouldn't want to move the code.
> >> 
> >> I just noticed that you have both "BASIC_CFLAGS+=" and a "COMPAT_OBSJ+="
> >> lines.  If you made this source file procfs-specific, you wouldn't need
> >> the ifdef and you could avoid the new CFLAG.
> 
> 
> In general we've preferred not using ifdefs at all except for the small
> bits that absolutely need it.
> 
> So e.g. in this case the whole code should compile on non-Linux, we just
> need a small boolean guard somewhere to check what the platform is.
> 
> It means we don't have significant pieces of code that don't compile
> except on platform X. It's easy to get into your code not compiling if
> you overuse ifdefs.

Hmm. I see what you mean.

However, since win32 is already using some conditionally compiling code,
that's the approach I went for. It's still running CI to make sure I
didn't break Windows in the process, but I'll post it (and the Actions
runs) later today, assuming it passed.

Yes, the implementation I wrote would compile on any platform, but as I
understand it, other platforms may need drastically different
implementations which may not compile as easily as this. So, I'm not
sure if it's really appropriate to do run-time platform checks here
(which is what I think you were describing).

Anyway, I'll look forward to seeing what you folks think of the next
iteration (again, hopefully later today).

 - Emily

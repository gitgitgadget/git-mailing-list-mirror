Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46261C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 23:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A2161D7C
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 23:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhF2Xxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 19:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhF2Xxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 19:53:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D6C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 16:51:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b5so457235plg.2
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y/W2eNAM1mNvXUjLySIvONsMeGrORgK4JyDtpDRi4Qc=;
        b=S+3N2F/b36MTp+N8FhhPJpVOo9d0UOnlYyL/FNj1H6gaYLumqhtG8gyQWw+m0FeDRh
         QlXPFGbLlm7Nzu8lMpO/Ze3UVEAIVuSAAt1LbjvhmWJvMg8/rdNiwzNE3yLu5PaWcypI
         f9vgb74NVcFk6fe0SJX10WinrmwhZGdMTMOAKexYiAhxkuMqFj3mu+M+5tGkjYbf1QWC
         EQ47/8Cb9y76xxChMU+IkPut+QGRRSxC9aEcsAzqw/zLBmhCAcUvW7+ARtLics5gx1Gq
         X7Jn9s8dvNmxzca7rb4WHhz8WjgvRUmgHq6ZqOmU6mZUBYoxhyev/TzgMdbmKSs2N1O/
         OU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y/W2eNAM1mNvXUjLySIvONsMeGrORgK4JyDtpDRi4Qc=;
        b=HoAwDzbx1XssaP0GXsptqSzTwyOqwGt/4Z7wcCW9k268pwsLHtf8qNa/UHI362SV4U
         aUixfrzVALO0HKK0C94y+/jDcLJvm/IWN7UjLSOpj8n75CTT9y2V5eHC6GLLJ9mgtNLZ
         P5tfFRlJN1i3dez9deBT6s9haIWaVHYoQ3+KoDhd37pIoiSU27LzBB4YlkyMDjvequ3c
         BUGw8w9Nz9PFl5MHEZIsfi5GK8GwIw5VFBKs7g/ZmAA116oNo+KRXP1UUE9TX6b3chI2
         sz91iLFkP/e4omH9o8cNiV2eTLCMiao5sH9dzGhmAhP6aRbrwjgeT/lG2MvRWZ5bRHlX
         Q34w==
X-Gm-Message-State: AOAM530No/FKcxB3rVb7CMDm5nFermiJZblOuAMHlna/c2/Ed2ZvDyx7
        o80k8XQ1zxB8/Hu9hlwScwqD7A==
X-Google-Smtp-Source: ABdhPJyfV3q4igzoMSQ9J4+qJuBrrtR9mwTEQiI10xWGOFc3eyu1CHTVwh8U8fN16befsg8yWCQVzA==
X-Received: by 2002:a17:90a:5903:: with SMTP id k3mr1467618pji.104.1625010674494;
        Tue, 29 Jun 2021 16:51:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6474:a1d9:af86:9bc8])
        by smtp.gmail.com with ESMTPSA id s6sm4403302pgc.47.2021.06.29.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 16:51:13 -0700 (PDT)
Date:   Tue, 29 Jun 2021 16:51:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5] tr2: log parent process name
Message-ID: <YNux62he9Mk43Y1B@google.com>
References: <20210608221059.1935021-1-emilyshaffer@google.com>
 <3327f108-6cd1-1d3d-eae9-2cdff96e1375@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3327f108-6cd1-1d3d-eae9-2cdff96e1375@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 12:45:24PM -0400, Jeff Hostetler wrote:
> On 6/8/21 6:10 PM, Emily Shaffer wrote:
> > Range-diff against v4:
> > 1:  efb0a3ccb4 ! 1:  7a7e1ebbfa tr2: log parent process name
> >      @@ compat/procinfo.c (new)
> >       +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> >       +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> >       +		strbuf_release(&procfs_path);
> >      ++		strbuf_trim_trailing_newline(&name);
> >       +		strvec_push(names, strbuf_detach(&name, NULL));
> >       +	}
> >       +
> 
> You're only getting the name of the command (argv[0]) and not the
> full command line, right?  That is a good thing.

Roughly. The name can be reset by the process itself (that's what
happened, I guess, in the tmux case I pasted below) but by default it's
argv[0]. It's also truncated to 15ch or something.
> >   ------------
> > +`"cmd_ancestry"`::
> > +	This event contains the text command name for the parent (and earlier
> > +	generations of parents) of the current process, in an array ordered from
> > +	nearest parent to furthest great-grandparent. It may not be implemented
> > +	on all platforms.
> > ++
> > +------------
> > +{
> > +	"event":"cmd_ancestry",
> > +	...
> > +	"ancestry":["bash","tmux: server","systemd"]
> 
> Is the second element really "tmux: server".  Seems odd that that's what
> the command name (argv[0]) is.  Perhaps I misread something??

See above. This is what shows up in pstree, though, and by poking around in
/proc I confirmed that this is indeed the content of /proc/<tmux-pid>/comm:

        ├─tmux: server─┬─bash───mutt───open-vim-in-new───vim
        │              ├─bash───pstree
        │              └─mutt

This is a somewhat contrived example, though, because in Linux as of this patch,
only one ancestor is gathered. So maybe I had better make the doc
reflect what's actually possible. I'm planning on sending a follow-on
sometime soon exposing more generations of ancestry, so I guess I could
update the docs back to this state around then.

> 
> > +}
> 
> This array is bounded and that implies that you captured all of
> the grand parents back to "init" (or whatever it is called these
> days).

In this case it does - pid 1 is systemd, which hasn't got a parent
process.

> Is there value in having a final "..." or "(truncated)" element
> to indicate that the list incomplete?  I did the latter in the
> Windows version.

Hrm. I'm not the one who wants to parse these - it's someone else who's
working with our team internally - so I'll ask around and see what they
think is best.

> > +#ifdef HAVE_PROCFS_LINUX
> > +	/*
> > +	 * NEEDSWORK: We could gather the entire pstree into an array to match
> > +	 * functionality with compat/win32/trace2_win32_process_info.c.
> > +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
> > +	 * gather the immediate parent name which is readily accessible from
> > +	 * /proc/$(getppid())/comm.
> > +	 */
> > +	struct strbuf procfs_path = STRBUF_INIT;
> > +	struct strbuf name = STRBUF_INIT;
> > +
> > +	/* try to use procfs if it's present. */
> > +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> > +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> > +		strbuf_release(&procfs_path);
> > +		strbuf_trim_trailing_newline(&name);
> > +		strvec_push(names, strbuf_detach(&name, NULL));
> > +	}
> > +
> > +	return;
> > +#endif
> > +	/* NEEDSWORK: add non-procfs-linux implementations here */
> > +}
> 
> Perhaps this has already been discussed, but would it be better
> to have a "compat/linux/trace2_linux_process_info.c"
> or "compat/procfs/trace2_procfs_process_info.c" source file and
> only compile it in Linux-compatible builds -- rather than #ifdef'ing
> the source.  This is a highly platform-specific feature.
> 
> For example, if I convert the Win32 version to use your new event,
> I wouldn't want to move the code.
> 
> I just noticed that you have both "BASIC_CFLAGS+=" and a "COMPAT_OBSJ+="
> lines.  If you made this source file procfs-specific, you wouldn't need
> the ifdef and you could avoid the new CFLAG.

Sure, I'll investigate it, thanks.

> > +
> > +		if (names.nr == 0) {
> > +			strvec_clear(&names);
> > +			return;
> > +		}
> > +
> > +		trace2_cmd_ancestry(names.v);
> > +
> > +		strvec_clear(&names);
> 
> I agree with Junio here, it would be simpler to say it like this:
> 
> 		get_ancestry_names(&names);
> 		if (names.nr)
> 			trace2_cmd_ancestry(names.v);
> 		strvec_clear(&names);
> 

Thanks both, done locally.

> Otherwise, this looks good to me.

Thanks. Look for a v6 from me this week, hopefully with the build stuff
sorted out.

 - Emily

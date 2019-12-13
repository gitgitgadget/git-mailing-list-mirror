Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CFC2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 03:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD822077B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 03:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSfiu4XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfLMDHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:07:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45668 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbfLMDHR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 22:07:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so780945pgk.12
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 19:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=owmwgBWTSuZUqIQ4Bpx3oy21VTDuopKKQ55CV/HOry4=;
        b=qSfiu4XJc0OmSPqd+rYxt8ttqCcMX9aijFavbzL3uStCyGYmwfAmL4Orh6h3y71adr
         49QoSUPeKqXPSD998gPtEEosHys+5qphm5GINMRhBxdHWbmHbHiNcctcrWonMO2jiAv6
         n7YVPxUpee1iVdHb+2Q5bGZITvGO18XsBSMCPA2bZoPLUqUiSzEwagzO418F6UTWDLez
         XzQZuIQoGid97wQywjq2zIwAR0smBr2oxf02opXU/W9+xOge/14arboyxPbBjB7uKMYu
         u5wQtUDH9sGwZMrlgkaIahry00Nls96zWmmhtZx/BHg7WgC++fE/D5uGffknS6uHN8Me
         76Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=owmwgBWTSuZUqIQ4Bpx3oy21VTDuopKKQ55CV/HOry4=;
        b=U6oE1VVQSY4K9TTVaea5ZiQ0sjPDpMRFJ0UqD+YZsT9pCebtPKt1Qo6ZjyIktL0Jb6
         RaR/9boDPmK2G7XR5jXfIhyAf3G2Dpi+aC5iy67zFgLBiq9ty4YkEK8rl86A2kknrdmU
         SKKdCsxsQo3JjMU3z2d9b2mG1a1I/R9YMxa9oyTDcqGRHJ7S6R+wjnRfVGXm2jLl5xFv
         UAMXB53zKWP6zh1pEMovMcz9qBPYCaHXLwbcedrNGNPdVFJh88swkqFPbnYAq8QmBhbl
         MQ/rVJ+JNA+dngTQKFhuW63v5koekXmF64NCY8uiJNg+MtbxMhCQyf2A6+Sl7oPOY9Xz
         kDuQ==
X-Gm-Message-State: APjAAAVQouxn+O+OK3mRWWzRT31bT7RM0r++BQMeGij2z0OBuQldhY9Z
        YyNDYDuKExlJeHySz7CXtJ/7Zg==
X-Google-Smtp-Source: APXvYqzmSBwgTNVnuaUQFudRZV0xfpH+k/EZ3vH85PQYydcc33WuJmd44gA2DgfaJmpVlss7RNDA9w==
X-Received: by 2002:a63:338e:: with SMTP id z136mr14599843pgz.60.1576206435757;
        Thu, 12 Dec 2019 19:07:15 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e27sm9070475pfj.129.2019.12.12.19.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 19:07:14 -0800 (PST)
Date:   Thu, 12 Dec 2019 19:07:10 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
Message-ID: <20191213030710.GA135450@google.com>
References: <20191204203911.237056-1-emilyshaffer@google.com>
 <xmqq5ziv3f20.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5ziv3f20.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 04, 2019 at 02:24:07PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
> > documentation accordingly.
> >
> > This changes enables 'git grep' to receive the pathspec from a file by
> > specifying the path, or from stdin by specifying '-' as the path. This
> > matches the previous functionality of '-f', so the documentation of '-f'
> > has been expanded to describe this functionality. To let '-f' match the
> > new '--pathspec-from-file' option, also teach a '--patterns-from-file'
> > long name to '-f'.
> >
> > Since there are now two arguments which can attempt to read from stdin,
> > add a safeguard to check whether the user specified '-' for both of
> > them. It is still possible for a user to pass '/dev/stdin' to one or
> > both arguments at present; we do not explicitly check.
> 
> OK.  I guess this is good enough at least for now and possibly
> forever as that falls into the "doctor, it hurts when I do this"
> category.
> 
> > Refactored to use am/pathspec-from-file. This changes the implementation
> > significantly since v1, but the testcases mostly remain the same.
> 
> I am hoping that this topic, and Alexandr's "add" and "checkout"
> stuff, would help establishing a good pattern for other commands to
> follow.
> 
> > diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> > index c89fb569e3..56b1c5a302 100644
> > --- a/Documentation/git-grep.txt
> > +++ b/Documentation/git-grep.txt
> > @@ -24,7 +24,8 @@ SYNOPSIS
> >  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
> >  	   [-W | --function-context]
> >  	   [--threads <num>]
> > -	   [-f <file>] [-e] <pattern>
> > +	   [-f | --patterns-from-file <file>] [-e] <pattern>
> 
> OK.
> 
> > +	   [--pathspec-from-file=<file> [--pathspec-file-nul]]
> 
> OK.
> 
> > @@ -270,7 +271,10 @@ providing this option will cause it to die.
> >  	See `grep.threads` in 'CONFIGURATION' for more information.
> >  
> >  -f <file>::
> > -	Read patterns from <file>, one per line.
> > +--patterns-from-file <file>::
> > +	Read patterns from <file>, one per line. If `<file>` is exactly `-` then
> > +	standard input is used; standard input cannot be used for both
> > +	--patterns-from-file and --pathspec-from-file.
> 
> Makes sense---otherwise they would compete and we cannot know which
> kind each line in the standard input is ;-)

At one point Jonathan Nieder had suggested to me that it might be nice
to watch for "--" in the standard input. But I think I wasn't confident
in the idea that all commands which take arbitrary number of arguments,
and pathspec expect their arg list to end in <arg...> -- <pathspec>.

> 
> > @@ -289,6 +293,20 @@ In future versions we may learn to support patterns containing \0 for
> >  more search backends, until then we'll die when the pattern type in
> >  question doesn't support them.
> >  
> > +--pathspec-from-file <file>::
> > +	Read pathspec from <file> instead of the command line. If `<file>` is
> > +	exactly `-` then standard input is used; standard input cannot be used
> > +	for both --patterns-from-file and --pathspec-from-file. Pathspec elements
> > +	are separated by LF or CR/LF. Pathspec elements can be quoted as
> > +	explained for the configuration variable `core.quotePath` (see
> > +	linkgit:git-config[1]). See also `--pathspec-file-nul` and global
> > +	`--literal-pathspecs`.
> > +
> > +--pathspec-file-nul::
> > +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
> > +	separated with NUL character and all other characters are taken
> > +	literally (including newlines and quotes).
> > +
> 
> I think these matches the ones in git-reset.txt from the earlier
> work by Alexandr's, which is good.

Yes, I took them verbatim.

> 
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 50ce8d9461..54ba991c42 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -31,6 +31,7 @@ static char const * const grep_usage[] = {
> >  };
> >  
> >  static int recurse_submodules;
> > +static int patterns_from_stdin, pathspec_from_stdin;
> >  
> >  #define GREP_NUM_THREADS_DEFAULT 8
> >  static int num_threads;
> > @@ -723,15 +724,18 @@ static int context_callback(const struct option *opt, const char *arg,
> >  static int file_callback(const struct option *opt, const char *arg, int unset)
> >  {
> 
> Shouldn't this be renamed?  Earlier, the only thing that can be
> taken from a file was the patterns, but now a file can be given
> to specify a set of pathspec elements.  "patterns_file_callback()"
> or something like taht?

Done. I was hesitant to touch the other code; I guess it is fine.

> 
> >  	struct grep_opt *grep_opt = opt->value;
> > -	int from_stdin;
> >  	FILE *patterns;
> >  	int lno = 0;
> >  	struct strbuf sb = STRBUF_INIT;
> >  
> >  	BUG_ON_OPT_NEG(unset);
> >  
> > -	from_stdin = !strcmp(arg, "-");
> > -	patterns = from_stdin ? stdin : fopen(arg, "r");
> > +	patterns_from_stdin = !strcmp(arg, "-");
> 
> Totally outside the scope of this patch, but we may want to
> introduce
> 
> 	int is_stdin_cmdline_marker(const char *arg)
> 	{
> 		return !strcmp(arg, "-");
> 	}
> 
> which later can be taught also about "/dev/stdin".  Even outside the
> pathspec-from-file option, I think "diff --no-index" also has some
> special-case provision for treating "-" as "input coming from the
> standard input string", which would benefit from such a helper.

Agreed; that's probably a handy thing to put into parse-options.h. I
suggest we think of this next time we are looking for Outreachy
microprojects or similar. I'll write it down somewhere.

> 
> > +	if (patterns_from_stdin && pathspec_from_stdin)
> > +		die(_("cannot specify both patterns and pathspec via stdin"));
> 
> It's kind of sad that we need to check this in this callback and
> also inside cmd_grep() top-level we will see further down...

Another reviewer suggested not using a callback and instead waiting
until after the entire argparse to do file reads; this would let us
avoid the weird double check here. I think I will do it.

> 
> > +	if (pathspec_from_file) {
> > +		if (pathspec.nr)
> > +			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
> > +
> > +		pathspec_from_stdin = !strcmp(pathspec_from_file, "-");
> > +
> > +		if (patterns_from_stdin && pathspec_from_stdin)
> > +			die(_("cannot specify both patterns and pathspec via stdin"));
> 
> ... here.
> 
> Thanks.

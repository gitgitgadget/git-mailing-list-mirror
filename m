Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383DEC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29412166E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4I4hlt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgBDWAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:00:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDWAi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:00:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so25629pfb.11
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wCEZ5s532Ra2Ebd2TqdsoBxMGV3sWIAAXzX4XX/Epyo=;
        b=N4I4hlt2Boik6l39BiXK9tmy+76fEXGxmIhid+QmGXd3G3GFlvLr1DTQd8A2lUbeea
         wMFuFuNH+8P+PIBAMiaLSZcZqQNFgdBDJrSH+DR2SyvDNAB5Q04S6Sw+P68UhSShNCWP
         +LoPgdDIMNoQstggJYAVTRvC++IjKZ9Jbt8Sjr23NemTc+yTahpidIQIGXAF/TvJNmxE
         wXsSyrBDCXz+iTEQRFPa93qJT6ajeKtnu7IjJl6HJURFVqJ9xAlXrkuT0FBCwdTK77GN
         YLpsqywFDUosIMPKUGId1Uy+7S391YG9zrPJOnyUPIo1gngNlSlv8HzpdMY+noBJbBeV
         2WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wCEZ5s532Ra2Ebd2TqdsoBxMGV3sWIAAXzX4XX/Epyo=;
        b=rdDJTKAqqXOvZyl77CKU0pTUelEVa2jHmL/qGZEdGyoUULkwfatRLkO2XpO9etHN8r
         f88/CyFb/+1o0dr4LuE6wTWebQz0N8TNFcVw2y7F6792TUQeZXbUbXzSRVOhOmYNjH2a
         IscUiDOtyuGYcup5lPwjQUCCVCu74pfqOfKl7oPbMTvRuqCsFSTH9IfClVKeapbqNNry
         Sa/PmIS8csk5tamqJ88VAR4ycDY7Q+Q/Z+gCKKBUDMNXJvNvCwKZ+o4p96Kahi70ejpE
         JFJOLabwc79vis5O0VZovw2XugRAA3LN88GIP7r4lBfXWivtD1D1Iwz3xsAV18bn4xgc
         4/fw==
X-Gm-Message-State: APjAAAVfYJagKLAahZeLqjiwCKxQnjTINOe8fIUKQVAO6lPL7hJZv3Q6
        B9Sre/kDKODeh7LC9pLbeaiB2d3j8zM=
X-Google-Smtp-Source: APXvYqz3IpiUMB8vi0cGWWq9MP4x0X5Yd5bWc0irDTm53H4U3ek+qLHctejMPlGhH2cVNHjFfKmZaA==
X-Received: by 2002:a63:ca04:: with SMTP id n4mr12158670pgi.110.1580853637636;
        Tue, 04 Feb 2020 14:00:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id h3sm4520548pji.9.2020.02.04.14.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 14:00:36 -0800 (PST)
Date:   Tue, 4 Feb 2020 14:00:32 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 01/15] bugreport: add tool to generate debugging info
Message-ID: <20200204220032.GC87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-2-emilyshaffer@google.com>
 <CAN0heSoaASfMhgLwZx4MZAdoGOfGK1fJK5X9VfUJN5R38gFVTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoaASfMhgLwZx4MZAdoGOfGK1fJK5X9VfUJN5R38gFVTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:18:55PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 05:56, <emilyshaffer@google.com> wrote:
> >
> > From: Emily Shaffer <emilyshaffer@google.com>
> >
> > Teach Git how to prompt the user for a good bug report: reproduction
> > steps, expected behavior, and actual behavior. Later, Git can learn how
> > to collect some diagnostic information from the repository.
> 
> ("Later" meaning "later in this series", or "any day now"? ;-) )
> 
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git bugreport' [-o | --output <path>]
> 
> Hmm. Should that be "[(-o | --output) <path>]"?

Done.

> > +DESCRIPTION
> > +-----------
> > +Captures information about the user's machine, Git client, and repository state,
> > +as well as a form requesting information about the behavior the user observed,
> > +into a single text file which the user can then share, for example to the Git
> > +mailing list, in order to report an observed bug.
> 
> Nice description. Got it.
> 
> > +The following information is requested from the user:
> > +
> > + - Reproduction steps
> > + - Expected behavior
> > + - Actual behavior
> > +
> > +The following information is captured automatically:
> > +
> > + - Git version (`git version --build-options`)
> > + - Machine information (`uname -a`)
> > + - Versions of various dependencies
> > + - Git config contents (`git config --show-origin --list`)
> > + - The names of all configured git-hooks in `.git/hooks/`
> 
> I would have expected these points to appear later, both to make it
> clear what this does commit does (and not), and to highlight what
> user-visible (documentation-worthy) changes later commits bring along.

Sure, agreed.

> 
> > +OPTIONS
> > +-------
> > +-o [<path>]::
> > +--output [<path>]::
> 
> Drop the "[" and "]"? If you give -o, you'd better give a path as well?

Done.

> > +       Place the resulting bug report file in <path> instead of the root of the
> 
> `<path>`

Done.

> > +"Please review the rest of the bug report below.\n"
> > +"You can delete any lines you don't wish to send.\n");
> 
> "send" sounds like we're *just* about to send this report somewhere, but
> it's "only" going to be written to the disk. Maybe "share", instead?

Nice turn of phrase, done.

> > +       if (option_output) {
> > +               strbuf_addstr(&report_path, option_output);
> > +               strbuf_complete(&report_path, '/');
> > +       }
> 
> I thought I'd use `-o` to indicate the filename, but it turns out it's
> the *directory* where the file (of some semi-random, generated name)
> will end up. Re-reading the docs further up, I can see how this is
> consistent. I sort of wonder if this should be `--output*-directory*`
> for symmetry with `git format-patch`.

Sure.

> > +       strbuf_addstr(&report_path, "git-bugreport-");
> > +       strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
> > +       strbuf_addstr(&report_path, ".txt");
> > +
> > +
> 
> (Double blank line?)

Done.
 
> > +       get_bug_template(&buffer);
> > +
> > +       report = fopen_for_writing(report_path.buf);
> 
> Report might be NULL here.

Nice.

> If there's already such a file, we overwrite. Should we generate the
> filename using not just today's date (two bug reports in a day wouldn't
> be unheard of?) but also something like hh:mm:ss?

Sure. For the sake of brevity I'll probably neglect seconds; I hope
someone is spending more than 1 minute filling in the provided form.

I'm a little worried about including : in a filename, so I went for
'git-bugreport-YYYY-MM-DD-HHMM' (24-hour).

As I started to write a test to ensure duplicate filenames were handled
well, Jonathan Tan pointed out that it would be easy to add an arg like
--suffix to allow specifying a custom strftime string. That would allow
users to easily create a file named
`git-bugreport-fetch-failing.txt` or `git-bugreport-March-19.txt` or
whatever they want; it also makes testing easy. So I'll add this for the
next rollup.

> 
> > +       strbuf_write(&buffer, report);
> > +       fclose(report);
> 
> Maybe clear the strbuf around here...
> 
> > +       launch_editor(report_path.buf, NULL, NULL);
> > +       return 0;
> 
> ... and/or UNLEAK it here, together with report_path.
> 
> Maybe "return -launch_editor(...)"?

Hm, sure. I see that builtin/tag.c does mark strbufs this way, so I
don't see a problem using UNLEAK and tail-calling launch_editor().


As a final bonus, I also added a line to report to stderr the name of
the file that was created. I noticed it's sort of unclear what the
command actually did otherwise.

> > +#!/bin/bash
> 
> Use /bin/sh instead?

Yeah, doing so immediately pointed out the bashisms you mentioned, plus
some more. :facepalm:

> 
> > +# Headers "[System Info]" will be followed by a non-empty line if we put some
> > +# information there; we can make sure all our headers were followed by some
> > +# information to check if the command was successful.
> > +HEADER_PATTERN="^\[.*\]$"
> > +check_all_headers_populated() {
> > +       while read -r line; do
> > +               if [$(grep $HEADER_PATTERN $line)]; then
> 
> I think this is a bash-ism.
> 
> > +                       read -r nextline
> > +                       if [-z $nextline]; then
> 
> Likewise.
> 
> > +                               return 1;
> > +                       fi
> > +               fi
> > +       done
> > +}
> > +
> > +test_expect_success 'creates a report with content in the right places' '
> > +       git bugreport &&
> > +       check_all_headers_populated <git-bugreport-* &&
> > +       rm git-bugreport-*
> > +'
> > +
> > +test_expect_success '--output puts the report in the provided dir' '
> > +       mkdir foo/ &&
> 
> If foo isn't there, do we not create it? Apparently not -- in my
> testing, we segfault. (We don't check for NULL after opening the file.)

Yeah, at the moment I just added a die() if we can't open the provided
path. I think other utilties can create the path (e.g. git-format-patch)
but where it makes sense to do so, I'd prefer to keep bugreport very
simple.

I'll die instead of overwriting, too; you're right that spending quite a
while on a bug report and then accidentally writing over it with a blank
one would be a very bad user experience.

> 
> > +       git bugreport -o foo/ &&
> > +       test -f foo/git-bugreport-* &&
> 
> test_path_is_file

Sure.

> > +       rm -fr foo/
> > +'
> > +
> > +test_expect_success 'incorrect arguments abort with usage' '
> > +       test_must_fail git bugreport --false 2>output &&
> > +       grep usage output &&
> > +       test ! -f git-bugreport-*
> 
> test_path_is_missing

OK.

Thanks very much, Martin, for the thorough review. This is incredibly
helpful.

 - Emily

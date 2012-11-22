From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Requirements for integrating a new git subcommand
Date: Thu, 22 Nov 2012 11:17:34 -0800
Message-ID: <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com>
References: <20121122053012.GA17265@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcMq-0008De-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898Ab2KVTWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:22:44 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56008 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965125Ab2KVTRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:17:55 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so5937075qcr.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mbM9oSsWhTEegiEERL/Um+SfkeagXiXp2DBgzKoEiao=;
        b=KyE+Tzbl6fDsj5qwNeVl20sqaLzqtikLUIIO+9ESYlKQB6pWwzPP7Ja/rUiz0hmaWD
         jUzImwEYQgyaZAnRCXmoVZPm0Gzq068XejB/Sy4Dt4Mz9pKlwBjOqtAieYhOU+VMF7qX
         kNDNKYXGjk0UbMXci4mcHrU44k9J/4RnNwgxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=mbM9oSsWhTEegiEERL/Um+SfkeagXiXp2DBgzKoEiao=;
        b=A/HfCKXCduImXlB3pnaYXp8ouhuLsdrXS0H7Yrrz/61LmfMXtnM8x5jK+UJ4tPVQWl
         PRgh/u1WBXObrVTIZ6id84gTVFwmraPgSjRzGyIJpX+2otNc+zBZVO/QueGu2SM7kdkT
         iquhq38p750D/odGLiJdej85D2GbL5YUOlz5S0Dz4nCbqv03BmjpB+jtmAypR+pZoCei
         C742V/OZKuaJMkw9PkjEZ9e3/hnA4lQjHXTAmGC1h3ZVt/8HKJBwj1nvkYUbcMGy9uuO
         MNsjo3NUF2qOiorvun2PW2Vf0Wl8Z2lvYXk5KqMWYNgX0Wy7hzP0W1TsTcA+f8t2jEpM
         vOxw==
Received: by 10.224.19.74 with SMTP id z10mr2092468qaa.96.1353611874377; Thu,
 22 Nov 2012 11:17:54 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Thu, 22 Nov 2012 11:17:34 -0800 (PST)
In-Reply-To: <20121122053012.GA17265@thyrsus.com>
X-Gm-Message-State: ALoCoQkMXIYBQ079YksfdytnFvQgAdQIUrdXXGNhlJjM3F62/JXj1fo+UqRvthifL08Eq+Y+Z1lc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210194>

On Wed, Nov 21, 2012 at 9:30 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> I have completed work on git-weave (the tool I had called 'gitpacker' in some
> previous postings).  I want to submit a patch that integrates it into git;
> in hopes of smoothing the process I have some technical and procedural
> questions.
...
> Now *my* questions:
>
> 1. I have a round-trip test for the tool that I can very easily adapt
> to speak TAP.  To function, the test will require a small linear
> history to operate on in the form of an import-stream file (so the
> result of round-tripping through a weave-unravel can be diffed against
> the original).  Does the distribution include any test repos?  If
> so, where can I find them?

No. We create the repositories from scratch using a series of
commands. If you look at the test library the environment is set in a
predictable way so the author, committer and timestamps are all set to
a single well known value, allowing Git to create a commit that is
reproducible on all platforms. A test_tick function is used in the
scripts to move the clock, allowing different times to be used. For an
example see t7502-commit.sh, or really any script in that directory.

> 2. I understand that a "git foo" command is typically implemented
> as "git-foo" binary or script in /usr/lib/git-core.  What I don't
> know is what the other interfacing requirements are.  Are they
> documented anywhere?  In particular...

Nope. "git foo" will invoke "git-foo" with GIT_DIR set in the
environment, so you know what repository to act against, and so does
any git command you recursively invoke. Other than that there really
aren't any interface requirements. Your program is executed with
whatever arguments the caller gave you. Its pretty simple UNIX stuff.
:-)

> 3. Is there any registration protocol other than simply installing
> the extension in the subcommand library?

Nope. Running "git whatever-this-is-i-have-no-idea" will try to
execute "git-whatever-this-is-i-have-no-idea" via $PATH, after adding
/usr/lib/git-core to the front of $PATH. Its pretty simple actually.
If your standard C library can find the program in $PATH its run, if
it can't find it, it dies.

> 4. How does "git help" work?  That is, how is a subcommand expected
> to know when it is being called to export its help text?

IIRC "git help foo" runs "man git-foo".

> 5. I don't see any extensions written in Python.  Are there any special
> requirements or exclusions for Python scripts?

Nope, it just has to be executable. We don't have any current Python
code. IIRC the last Python code was the implementation of
git-merge-recursive, which was ported to C many years ago. We avoid
Python because it is not on every platform where Git is installed. Yes
Python is very portable and can be installed in many places, but we
prefer not to make it a requirement.

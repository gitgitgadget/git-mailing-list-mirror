From: John Szakmeister <john@szakmeister.net>
Subject: Re: [msysGit] Re: Git for Windows and line endings
Date: Fri, 19 Oct 2012 17:53:17 -0400
Message-ID: <CAEBDL5UX+bT5eSf4_QxfcOgwH0Vtco43rM78HKUJTr75uUXhFA@mail.gmail.com>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
	<CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
	<alpine.DEB.1.00.1210190801490.2695@bonsai2>
	<CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPKVW-0002tz-1a
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933048Ab2JSVxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 17:53:19 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36969 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab2JSVxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 17:53:18 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1360585iea.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 14:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=xyC3Zb3TUyFGG090qGph56zsM5dJC+2nTqM3jEGAemU=;
        b=edB1mNBZ/69/MTFNXe1uHZ5vEjQ4qiWKeeovC4v0ruWEwuJaVlup8NnRAEqKCNRXc6
         8+0z9O1EQJo1DzcicFrMN8GfFL0JIMCd0nsFUrZVzs3gv0/8EXmtPTxohAUYVAZQ80oX
         RQ2ekobKXp8WrO6tk75i9Z1HZfKpJ6CpFj+zRascLxgsiXcNF3zdLrY5GslCxBz6YH3I
         I3ylRRGjvaa/xenPat/9cQ7acCihPh9QRIujU5uboSyIZ3GA2ZZheSFNZHFNGu6hamCX
         R20CaCrjDY5P2zReQGl5PuR5tfw11GO1gPM7QVcbzM/G/vB4EhU9ekQ3c7tm08dHDUu4
         gaTw==
Received: by 10.50.37.168 with SMTP id z8mr10182281igj.1.1350683597378; Fri,
 19 Oct 2012 14:53:17 -0700 (PDT)
Received: by 10.50.2.106 with HTTP; Fri, 19 Oct 2012 14:53:17 -0700 (PDT)
In-Reply-To: <CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
X-Google-Sender-Auth: dB8piOmEDvzEZqol-xIuleSq6zg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208072>

On Fri, Oct 19, 2012 at 10:39 AM, Chris B <chris.blaszczynski@gmail.com> wrote:
[snip]
> - Windows has been able to cope with UNIX line endings a long time; no
> developer is using a default Notepad to open files with high
> expectations. Any Windows development tool and editor worth anything
> I've used is able to handle both just fine.

That's simply not a true, across the board statement.  I really wish
it was, because I find the issue troublesome as well.  Unfortunately,
there are still plenty of applications that don't cope with mixed line
endings very well.  We have a backend that targets several platforms,
and the Windows toolchain is quite keen on having CRLF endings, but we
like LF under Linux, and others.

I also wish that no developers were using Notepad either.  Any time
I've run across it, I've tried to point folks at much more capable
environments... but that only has moderate success.  Of course, it's
even worse these days because Notepad puts a BOM at the front of the
file, making Git think it's a binary file.

One thing I do wish is that I didn't have to do the song and dance to
convert all the files when I set gitattributes:

    $ echo "* text=auto" >>.gitattributes
    $ rm .git/index     # Remove the index to force git to
    $ git reset         # re-scan the working directory
    $ git status        # Show files that will be normalized
    $ git add -u
    $ git add .gitattributes
    $ git commit -m "Introduce end-of-line normalization"

One thing that I like about Subversion was that when you set
svn:eol-style, it took.

-John

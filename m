From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Thu, 9 Aug 2007 23:23:15 +0200
Message-ID: <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFT3-000832-0Q
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbXHIVWq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXHIVWp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:22:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:36952 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942AbXHIVWo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 17:22:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l79LMQdd001391;
	Thu, 9 Aug 2007 23:22:26 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l79LMQ7q015171
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 9 Aug 2007 23:22:26 +0200 (MEST)
In-Reply-To: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55475>


On Aug 9, 2007, at 9:24 AM, Steffen Prohaska wrote:

> Does 'git gui' work for you in msysgit?
>
> I get
>
> Invalid command name "git-version"
>   while executing
> "git-version >= 1.5.3"
>    (in namespace eval "::blame" script line 36)
> [...]
>
> with msysgit (v1.5.3-rc2-690-g8ca1f6a)

Ok this is a bit complex but simple to solve: I created a
symlink from tclsh84.exe to tclsh.exe, that is

    cd /mingw/bin
    ln -s tclsh84.exe tclsh.exe

And than run

    make install

[
offtopic:
I also hacked the Makefile to set GIT_VERSION to normal
version number, like 99.9, because git gui complained that
it failed to parse the version number.

I'll look into this later.
]

Now the long story.

mingw only contains tclsh84 but not tclsh. This causes
the Makefile in git-gui to fail on the creation of
lib/tclIndex. Therefore git gui decides to take the slow
path of sourcing the files in lib explicitly but this failes
because they are sourced before git-version is defined.
Therefore blame.tcl reports the error mentioned above.

Johannes (or someone else from the msysgit team),
We should modify mingw to contain the symlink to tclsh.
Or something similar, at least 'tclsh' should be there.

Shawn,
The fallback mechanism of sourcing files from lib is broken.
Either git-version must be defined before sourcing them, or
the auto_index must always work.

	Steffen

From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Tue, 1 Nov 2005 09:13:41 +1300
Message-ID: <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
References: <43652934.8000308@zytor.com>
	 <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	 <20051031064105.GV8041@shell0.pdx.osdl.net>
	 <43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:15:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWg2M-0007zd-36
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVJaUNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVJaUNn
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:13:43 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:65137 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964823AbVJaUNm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:13:42 -0500
Received: by xproxy.gmail.com with SMTP id i30so1066007wxd
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 12:13:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hwAnkQL2LlH9bZig767kqsYntaXBMgwABEOaEhNEq96jBwsO8I+9H/AMCrk+cR6AnuOICoAPI0ox+fPxbwt02dQriV/PCuJIDrWj7M+5V3/VZtYUZ10NF2Qol7mguCrcGncwycAy8U4TZHBkTc0eIe3jbWaRZZR+FLacy41mc5k=
Received: by 10.65.205.1 with SMTP id h1mr473506qbq;
        Mon, 31 Oct 2005 12:13:41 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 31 Oct 2005 12:13:41 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10880>

On 11/1/05, Junio C Hamano <junkio@cox.net> wrote:
> git-tla-import, git-cvs-import, git-svn-import, ...::
>         Importers, one per foreign SCMs.

I concur generally with the plan, except that I think we should wrap
the import/export scripts together(*). One-script-per-package is
pretty awkward, and yet the dependencies for a
git-export-import-scripts packages are going to be awful as they'll
often pull a whole raft of SCMs.

Hmmm.

Perhaps git-tla-glue, git-cvs-glue, git-svn-glue, where glue stands
for importers, exporters, tools, etc?

*- I'm starting to think that the script to replay git commits into
cvs that I posted last week (cleaned up patch coming soon)  should
follow the git-cvsimport convertion and be something along the lines
of git-cvsexportpatch, to be followed by git-cvsexport which would
automate discovering what patches need exporting and drive
git-cvsexportpatch.

> git-docs::
>         Generated documentation from Documentation hierarchy.
>
> git-core::
>         All the rest, plus man pages.  We could separate out
>         commit walkers if we wanted to, but I do not think that
>         is necessary.

git-gitk ;-)

> I am currently generating i386 RPMs and i386 debs myself but I
> am not particularly proud of the current setup.  I do not have
> an RPM based machine that I can install the result myself to
> test (which is what started this thread).  Since I am not a
> Debian developer (and I do not particularly wish to become one
> myself), the debs I generate will not be official anyway.
> Personally I'd be happier if I can just lose rpm and deb targets
> from the "upstream" Makefile (git-core.spec file and debian/
> subdirectory as well while we are at it), ask "packaging
> maintainers" to pull from kernel.org/ tree and do RPMs and Debs
> outside.

I'd say you can probably keep the current setup, and as distro
(format?) specific maintainers show up and start maintaining bits and
pieces, merge from them. git should make that easy ;-)

I'm not a DD -- but I'm on the 'NM queue' which means I'm in the
process of turning into one (delayed at the moment, but hapenning
soonish). Have a package in the archive, and a few sponsors who are
generally happy to upload my work. Would be happy to give it a go if
noone else steps up.

(Sebastian _did_ indicate interest, and fought a long, hard battle in
debian-devel about the naming of the git and cg utilities. I haven't
seen him around lately (last post:
http://marc.theaimsgroup.com/?l=git&m=112747921603277&w=2 ). May be on
holiday? CC'd)

> On the other hand, having the basic support for packagers in the
> upstream might be easier for port maintainers.  I honestly do
> not know.

I think it'd be easier for all people involved if each port/packjage
maintainer keeps a published repo and you merge from them. Patches
have higher visibility and easier path towards "upstream".   
Maintainers want to keep the delta between their package and upstream
to the bare minimum.

> One thing we could do without breaking much of the current
> arrangement is to have a team of people to help porting for
> major packaging formats (RPMs and Debs mostly but I know we have
> OpenBSD and Darwin people here too), and ask them to feed me the
> updates to rpm/deb/whatever target in the Makefile as needed.

That's another good strategy. I suspect that you can push work towards
maintainers, so they publish 2 branches: one of forupstream patches
and one of 'local' patches. They have to do that anyway ;-)

cheers,


martin

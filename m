From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: NYU Open Source Programming Class Releases JavaGit API 0.1.0
	Alpha
Date: Mon, 4 Aug 2008 10:54:03 -0700
Message-ID: <20080804175403.GG27666@spearce.org>
References: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Linder <james.h.linder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 19:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ4H2-0004eZ-7K
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 19:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYHDRyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 13:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYHDRyH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 13:54:07 -0400
Received: from george.spearce.org ([209.20.77.23]:36842 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbYHDRyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 13:54:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F13E038419; Mon,  4 Aug 2008 17:54:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91382>

James Linder <james.h.linder@gmail.com> wrote:
> This summer, New York University held a class called Open Source
> Programming.  One of the projects to come out of the class is JavaGit,
> an API providing access to git repositories for Java applications.
> Today the JavaGit team has released version 0.1.0 Alpha of the JavaGit
> API.  The announcement is listed below.

This is interesting work.  Competition is good, but I think many
of us, especially those involved in egit and jgit, would wonder
why a new project was started instead of contributing to one that
already is established.
 
> JavaGit is engineered to provide the developer with access to the raw
> git commands through a command API as well as an object API designed
> to represent the .git repository, the working tree and other, familiar
> git concepts. JavaGit uses the git binaries installed on the host
> machine to provide git functionality and has been designed to easily
> accommodate additional methods of access to git repositories.

One of the primary drivers behind why jgit does not call out to C
Git is to remove the need to install Git binaries on the system.
Some of the Eclipse IDE distributions won't bundle a plugin that
depends upon GPL executables, and hence won't bundle an Eclipse
Git plugin like that.

Another is performance.  Although jgit is written in Java it can
beat the performance of C Git for certain operations due to its
ability to avoid fork+exec.  I've actually had a few times where
writing something in Java against jgit turned out to be easier
and faster than writing it in Perl/Python/Tcl/shell against the C
Git binary, because I was able to avoid the fork+exec overheads.
Although I suspect C Git would have performed a lot better if we
had proper library bindings into say Perl.


I would like to correct one statement in both the JavaGit and
gitclipse FAQ's:

>From http://gitclipse.sourceforge.net/docs/faq.php:
> How is this different from egit/jgit?
> 
> Who/What?!

Seriously?  egit and jgit is a 2.5 year old project that has a
Google Summer of Code student working on it this summer, and is
seeing 20+ patch clusters at least once a month on this list.
You cannot really claim we aren't visible in the Git community.

> No seriously, we have a lot of respect for the egit/jgit project
> they have done a lot of good work. There are several things that
> differentiate us.
> 
>     * egit/jgit are being developed together as one project
>     whereas our API is developed seperately by a different team
>     of developers. This allows our development team to focus our
>     development efforts on our plug-in and not get hung up on
>     API issues.

They are only in the same repository because they started out that
way for convience when it comes to committing.  jgit is completely
seperate from egit and comes with a build process to compile a
stand-alone command line interface based entirely on jgit.

The _only_ reason they haven't been split into two different Git
repositories is because we just haven't wanted to slow down our
development for such a trivial administrative item.

If this really was something that was holding back the adoption
of and contribution to jgit, we'd split it tomorrow, and suffer
the pain of needing to segment development branches.

>From http://javagit.sourceforge.net/faq.php:
> How is JavaGit different from Jgit/Egit?
> 
> Who/What?
> 
> No. But seriously now. JavaGit was conceived of as a complementary
> project to the GitClipse projct, an Eclipse plugin to provide git
> support. It was a logical choice for us to split the project into
> the user oriented project, Gitclipse, and the developer oriented
> project, JavaGit. Since the projects are separate, the JavaGit
> project is free to concentrate on providing a top-notch library/API
> for use in other applications.

Oddly enough this is how jgit and egit came along.  I wanted to
build an Eclipse plugin, but also wanted to make sure that the
majority of the implementation code was not tied to the Eclipse
platform APIs or to the UI so that we could reuse it on other
IDEs (e.g. NetBeans), or on build tools (Maven, Ant, ...), or
for a command line based tool (e.g. jgit's .pgm package).

> Jgit/Egit, on the other hand, appear to be tightly integrated with
> Jgit primarily supporting Egit.

That's not really true.  jgit has two major users: egit and its
related jgit.pgm package (which offers a CLI).  Its sad that there
are not yet more jgit users.  But jgit itself has no dependency on
egit, and is not tightly integrated with it.

I could claim that gitclipse and javagit are tightly integrated
because they are both hosted on SVN on sourceforge.net.  That's
about the same level of "tightly integrated" that jgit and egit are.

> Another difference between JavaGit and Jgit/Egit is that the JavaGit
> team wanted to quickly implement access to git repositories. This
> goal lead us to start by forking to git itself to provide git
> functionality. Knowing that this may be a short-term solution,
> we built JavaGit so that we can easily replace the command line
> interface (CLI) functionality with JNI, pure Java, or some other
> implementation in the future. Jgit/Egit only provides a pure Java
> implementation.

Maybe I'm missing something, but I think egit has more features
available in its UI, and all of those are implemented directly
by jgit.  We even have a graphical history viewer with renderers
built in both AWT and SWT, and the SWT one is available in Eclipse.
So I'm not sure I follow this argument that JavaGit enabled the
team to produce an Eclipse plugin that offers more features, quicker.

-- 
Shawn.

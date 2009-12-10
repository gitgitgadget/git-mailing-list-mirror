From: Yann Dirson <ydirson@linagora.com>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Thu, 10 Dec 2009 09:35:14 +0100
Message-ID: <20091210083514.GA5971@linagora.com>
References: <20091208132857.GB5425@linagora.com>
 <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
 <4B1E57BF.1000500@pelagic.nl>
 <40aa078e0912080623q108b2affk80534ccd5fd7ace3@mail.gmail.com>
 <20091208143700.GC5425@linagora.com>
 <4B200EF5.2060606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Ferry Huberts <ferry.huberts@pelagic.nl>,
	GIT ml <git@vger.kernel.org>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 09:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK6QL-0007qC-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 09:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753139AbZLNIgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 03:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZLNIgi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 03:36:38 -0500
Received: from [194.206.158.221] ([194.206.158.221]:34507 "EHLO
	cyann.linagora.lan" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752131AbZLNIgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 03:36:37 -0500
Received: from yann by cyann.linagora.lan with local (Exim 4.69)
	(envelope-from <yann@linagora.com>)
	id 1NIeUU-0001fO-An; Thu, 10 Dec 2009 09:35:14 +0100
Content-Disposition: inline
In-Reply-To: <4B200EF5.2060606@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135171>

On Wed, Dec 09, 2009 at 09:56:21PM +0100, Marius Storm-Olsen wrote:
> Yann Dirson said the following on 08.12.2009 15:37:
> >On Tue, Dec 08, 2009 at 03:23:55PM +0100, Erik Faye-Lund wrote:
> >>You can follow the discussion here:
> >>http://code.google.com/p/msysgit/issues/detail?id=288
> >>
> >>I believe the reason is something like "because someone suggested
> >>it, and no one disagreed". Do you have a good argument why it
> >>shouldn't be the default (other than "it's a change", because
> >>changing it back now would also be a change)?
> >
> >Depending on the opinion of the Eclipse guys on this issue about
> >"writing to hidden files only says 'could not write'", which
> >arguably could be seen as a bug on their side, we can see changing
> >this behaviour back to the default on the msysgit side as either a
> >(possibly temporary) workaround for a known eclipse bug, or as
> >getting again interoperable with egit.
> 
> Dot-files on unix are considered hidden. It's the only way files are
> hidden there. Not so on Windows. Dot-files are just like any normal
> file, and you need to mark a file hidden.
> 
> So, the logic of egit, that *actually* hidden files should not be
> written to, but dot-files should, seems to me to be a bug in egit.
> There should be no reason why egit shouldn't be able to write to any
> file, pending permissions. I'd say file a bug report with egit.

Actually it is not egit who is unable to write to the file, but
eclipse itself, and I do tend to think it is a bug in eclipse.  But
now, even if we can convince the eclipse guys that it is a bug, it
will be some time before a new release with this bug fixed gets
published.

So IMHO it would makes sense, for the sake of usability, to not
activate the "hide dotfiles" feature by default.  It is easier for
someone seeing unwanted dotfiles to find the switch to hide them, than
for someone getting a "could not write" message from eclipse to
understand that there is a seemingly-unrelate switch for msysgit to
avoid this situation.

But maybe the situation is not so clear.  That "hide dotfiles" was
implemented so that ".git" at first, and then ".git*" files do not
clutter the view of the project.  But then, if a git repo has other
dotfiles, those are really *part of* the versionned stuff, so I do not
see why those should be hidden at all.  After all, the .project,
.classpath, and other eclipse project files have that name on windows
too, and it will indeed *confuse* people to get them hidden.

So should we have 2 classes of dotfiles, those "private to git", and
the others, one class being hidden while the others are not ?  I am
not sure at all this would be a good idea either.  Or maybe we should
only get .git hidden - after all, that one is the only real metadata
not part of the versionned stuff itself ?

Maybe we should add some sort of "core.hidedotfiles = dotgitonly"
setting, and make that the default ?  That one does not appear to
cause any problems to jgit, and eclipse itself has not business with
it, so it would IMHO make sense.

Opinions ?

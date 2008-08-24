From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 01:40:41 -0700
Message-ID: <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
	<7vsksw92nh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 10:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXBAX-0001xl-Si
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 10:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYHXIkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 04:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYHXIkq
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 04:40:46 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:52944 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYHXIkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 04:40:43 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id B44A834567; Sun, 24 Aug 2008 01:40:41 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7vsksw92nh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 22 Aug 2008 14\:10\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93521>

>>>>> On 2008-08-22 14:10 PDT, Junio C Hamano writes:

    Junio> Karl Chen <quarl@cs.berkeley.edu> writes:
    >> Another idea is to have a non-absolute path be interpreted
    >> relative to the location of .gitconfig.

    Junio> If we were to support relative paths, I think it would
    Junio> be useful and consistent if a relative path found in
    Junio> ".git/config" is relative to the work tree root, in
    Junio> "config" in a bare repository relative to the bare
    Junio> repository, and in "$HOME/.gitconfig" relative to
    Junio> $HOME.

Makes sense to support it everywhere.  For .git/config, isn't it
more consistent for it to be relative to .git?

    Junio> I am not sure what a relative path in "/etc/gitconfig"
    Junio> should be relative to, though.

Why not just relative to the location of that file?  Normally
/etc, but if some distro customizes the location of /etc/gitconfig
(/etc/git/config), or on non-Linux/posix systems it's somewhere
else, or git is installed in /usr/local or /opt or $HOME, then
it's still relative to the location of system gitconfig.

    Junio> However, this has a technical difficulty.  When
    Junio> configuration values are read, the code that knows what
    Junio> the value means does not in general know which
    Junio> configuration file is being read from.

Sounds like a refactoring issue.

    Junio> It is quite likely that somebody would want you to
    Junio> interpret "~name/" if you advertize that you support
    Junio> "~/", so you would need to call getpwuid() eventually
    Junio> if you go down this path.  I wonder how this would
    Junio> affect Windows folks.

I would be happy either way.  Though since git uses getenv("HOME")
to find ~/.gitconfig, I can see arguments for looking for the
ignore file there also, in case it's different.

    Junio> we would need a "--path" option to "git config" (the
    Junio> idea is similar to existing "--bool" option) so that
    Junio> calling scripts can ask the same "magic" performed to
    Junio> configuration variables' values before being reported.

Sounds fine.

So, being new to git development, am I correctly assessing your
response as "with refinement this can be included in git"?

Relative paths and ~ (and $HOME) are all mutually compatible so
they could all be implemented.  If $HOME were supported directly
(either just "$HOME" or parsing all $ENVVARS) then it'd be easier
to decide to use getpwuid for ~.  Personally I'd use: 1) relative
path, 2) $HOME (as "~" or "$HOME"), 3) getpwuid (as "~")

Karl

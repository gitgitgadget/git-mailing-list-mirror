From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Fri, 27 Mar 2015 00:17:48 +0300
Message-ID: <871tkblapv.fsf@javad.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbFIG-00085e-FT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 22:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbbCZV0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 17:26:18 -0400
Received: from mail.javad.com ([54.86.164.124]:55580 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbbCZV0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 17:26:16 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2015 17:26:15 EDT
Received: from osv (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 8107661AAD;
	Thu, 26 Mar 2015 21:17:50 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84)
	(envelope-from <sorganov@gmail.com>)
	id 1YbF9w-0002Bs-Ro; Fri, 27 Mar 2015 00:17:48 +0300
In-Reply-To: <xmqqd23vzkon.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Mar 2015 11:18:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266352>

Junio C Hamano <gitster@pobox.com> writes:

[...]

> I think the current preserve-merges considers everything between
> <upstream> and <branch> as "commits to be rebased", and recreate
> merges across these rebased tips of branches that are merged.
>
> There however were repeated wishes (or wishful misunderstandings ;-)
> that there were a mode to rebuild the trunk, considering only the
> commits on the first-parent chain as "commits to be rebased",
> recreating the history by replaying the merge commits (whose first
> parent might be rewritten during the rebase, but the tips of side
> branches these merges bring into the history are kept intact).
>
> Surely there is no such mode right now,

Isn't it what Johannes Sixt <j6t@kdbg.org> mentions here?:

[QUOTE]
If you want a version of --preserve-merges that does what *you* need,
consider this commit:

  git://repo.or.cz/git/mingw/j6t.git rebase-p-first-parent

Use it like this:

  git rebase -i -p --first-parent ...

Beware, its implementation is incomplete: if the rebase is interrupted,
then 'git rebase --continue' behaves as if --first-parent were not given.
[/QUOTE].

ref: http://permalink.gmane.org/gmane.comp.version-control.git/263584

If so, then I'd say such mode almost exists.

> but I am fairly sure that I wouldn't have any objection against a
> patch to implement such a feature (perhaps "--first-parent
> --preserve-merges"?),

It'd be very welcome feature here, preferably along with a way to pass
it to 'git pull --rebase', including a way to configure it to be the
default. 

> and with or without such a feature in the system, I would be happier
> if we made sure that the description we are discussing to update makes
> it clear that the current behaviour is "everything between <upstream>
> and <branch>", and cannot be misread as "do not touch side branches
> instead of dropping merged commits".

I'd also suggest to somehow warn in the manual that current modes of
operation silently drop changes to merge commits that were made to
non-conflicting paths (either during conflict resolution or otherwise.)

-- Sergey.

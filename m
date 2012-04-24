From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 13:59:28 -0400
Message-ID: <201204241759.q3OHxSbH017287@no.baka.org>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de>
        <nngbomh3uz0.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, greened@obbligato.org
To: dag@cray.com
X-From: git-owner@vger.kernel.org Tue Apr 24 20:00:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMk2J-00023W-EY
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 20:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190Ab2DXSAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 14:00:17 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:42164 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756842Ab2DXSAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 14:00:16 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q3OHxT3v009415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 24 Apr 2012 13:59:29 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q3OHxSbH017287;
	Tue, 24 Apr 2012 13:59:28 -0400
In-reply-to: <nngbomh3uz0.fsf@transit.us.cray.com>
Comments: In reply to a message from "<dag@cray.com>" dated "Tue, 24 Apr 2012 12:22:59 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196233>


In message <nngbomh3uz0.fsf@transit.us.cray.com>, dag@cray.com writes:

    > I agree and am willing to provide information about submodule use=
 cases,
    > advantages and problems, but I'm not a user of subtree so I can't=
 really
    > comment on it. Now that subtree is in git core, what about puttin=
g such
    > a comparison under Documentation/subproject-support.txt?

    That would be great.  Do you want to start work on that?  I can
    contribute some text about git-subtree.

I have a document I created for gitslave which I have cleaned up a bit
and might be the start of such comparison.

----------------------------------------------------------------------
git-submodules is the legacy solution for putting repositories inside
of other repositories.  With git submodules, the submodule is checked
out to a semi-fixed commit, typically on a detached HEAD. To make a
change to the subproject, you need to check the submodule repository
out onto the correct branch, make the desired change (possibly
involving pull), commit, and then go into the superproject and commit
the commit (or at least record the new location of the submodule). It
was designed for third party projects which you typically do not doing
active development on. Many/most git commands performed on the
superproject will not recurse down into the submodules.  submodules
give you a tight mapping between subproject commits and superproject
commits (you always know which commit a subproject was in for any
given superproject commit).  git-submodules is considered difficult to
use for less experienced git developers who need to modify the
subproject.

Another option is to stick everything in one giant repository,
typically by using git-subtree.  This might make your repository large
and you have to manually run git-subtree commands to export your
changes back out to the individual non-aggregated repositories.  All
git commands run as normal, though when examining pre-subtree history,
you can see the individual lines of development on different branches.

gitslave creates a federation of git repositories=E2=80=94a superprojec=
t
repository and a number of slave repositories=E2=80=94all of which may =
be
concurrently developed on and on which all desired git operations will
touch.  In a typical use case, you would branch all repositories (to
the same branch name) at the same time, and checkout or tag or get of
the status of all repositories at the same time.  For essentially any
git command, you simply replace "git" with "gits" to get the specified
git command to run on all repositories.  Of course, some commands do
not necessarily make a great deal of sense to run over all git
repositories (eg. `git add filename`), but you are allowed to run any
normal git command on any of the repositories at any time.  gitslave
provides a loose binding so that it is not necessarily completely
clear which revision one repositories was at when a commit was made in
a different repository, except after tag operations.

Another options include repo from Google, used with Android. Repo
seems to work much like gitslave from a high level perspective, but
there isn't a lot of documentation on using it for other projects.

Still another option is kitenet's mr which supports multiple
repository types (CVS, SVN, git, etc). It is absolutely the solution
for multi-SCM projects, but since it works on the lowest common
denominator you would lose much of the expressive power of git.

The final option is to just put git repositories inside of other
repositories.  However, you must be sure to add the subproject into
the superproject's .gitignore to prevent `git add` from adding the
subproject as a broken submodule commit (broken because no .gitmodules
or git-config entry will exist for it).
----------------------------------------------------------------------

					-Seth Robertson

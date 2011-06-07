From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [rfd] auto-following tags upon "git push"?
Date: Tue, 7 Jun 2011 10:21:29 -0700
Message-ID: <BANLkTikyd9x6+CBdq_yBTPCNYXWVq9qKF+MXbPMk2QRqmU0qhA@mail.gmail.com>
References: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:21:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzyV-0001XR-RL
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab1FGRVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 13:21:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59079 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946Ab1FGRVt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 13:21:49 -0400
Received: by gxk21 with SMTP id 21so2072094gxk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:21:49 -0700 (PDT)
Received: by 10.236.190.170 with SMTP id e30mr1210444yhn.226.1307467309131;
 Tue, 07 Jun 2011 10:21:49 -0700 (PDT)
Received: by 10.147.182.11 with HTTP; Tue, 7 Jun 2011 10:21:29 -0700 (PDT)
In-Reply-To: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175227>

On Tue, Jun 7, 2011 at 09:33, Junio C Hamano <gitster@pobox.com> wrote:
>
> Which also means that there is a social convention among everybody in=
 the
> project how public tags are named. Using a tag v2.4.3 to mark your pr=
ivate
> progress point, when the project uses tags that match "v*.*.*" to mar=
k
> public releases, is not something any sane person would do.
=2E..
> This is just me thinking out loud, but a typical end-user transcript =
may
> look something like this:
>
> =A0 Tell git that v*.* and v*.*.* are release tags (one-time set-up).
> =A0 $ git config --unset-all push.autotag
> =A0 $ git config --add push.autotag 'v*.*'
> =A0 $ git config --add push.autotag 'v*.*.*'
=2E..
> =A0 $ git tag v1.2.0
>
> =A0 Push it out, with the usual matching (or "upstream") semantics pl=
us
> =A0 the new auto-follow tags feature. Note that "wip" tag will not be=
 sent.
> =A0 $ git push

Questions:

Does push.autotag apply to all remotes? I'm debating with myself if I
really want a tag I have created locally immediately pushed to a
backup repository. Just because I have tagged something on my primary
work repository, doesn't mean I want that public yet. I may have
temporarily tagged something, started building a release, then run a
"git push backup" to send my branch tips to a private backup
repository and jumped on the transit system to head home.
Automatically pushing my newly created tag to my backup may be useful,
but if I later move that tag before I make it public pushes to my
backup might start failing. If my backup remote doesn't have a
remote.backup.push refspec that includes refs/tags/* namespace, should
push.autotag really send there?

Does push.autotag trigger if I specify push refspecs on the command
line? It probably should, as the user might have specifically
configured certain refs (maint, master, next, pu, todo) to be
published. Unless the user is pushing to Gerrit Code Review's magical
"refs/for/*" destination namespace... in which case that tag might
still only be a tentative tag and isn't really part of the project
history yet.


In general I agree with this idea. Its similar to the tag following we
are doing on fetch/clone, and its similar to the tag visibility that
Gerrit Code Review does with per-branch access controls.

Unfortunately you need to configure the patterns up front. This is
advanced user space. But the feature is most likely to help the new
project maintainer more than an existing user.

--=20
Shawn.

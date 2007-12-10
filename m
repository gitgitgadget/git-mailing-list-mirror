From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: backups with git and inotify
Date: Mon, 10 Dec 2007 22:57:46 +0100
Message-ID: <20071210215746.GA3022@atjola.homenet>
References: <20071210202911.GA14738@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 22:58:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qdg-0003ke-IE
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbXLJV5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXLJV5u
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:57:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:57729 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751543AbXLJV5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:57:49 -0500
Received: (qmail invoked by alias); 10 Dec 2007 21:57:47 -0000
Received: from i577B9DF1.versanet.de (EHLO localhost) [87.123.157.241]
  by mail.gmx.net (mp007) with SMTP; 10 Dec 2007 22:57:47 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+fUIJdNuqfeHrFQQjatD/kHC9tI0UujXYCEALp6x
	yB/HSvuaDgZHA6
Content-Disposition: inline
In-Reply-To: <20071210202911.GA14738@bit.office.eurotux.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67763>

On 2007.12.10 20:29:11 +0000, Luciano Rocha wrote:
>=20
> Hello,
>=20
> The following is a work in progress. There are some problems in how I=
'm
> using git and recording the history:
>=20
> 1. I use an opened fd for each monitored directory (and subdirectorie=
s),
>    (inotify_add_watch_at would be nice).
>    I fchdir(fd) when a change happens to register and commit it.
>=20
> 2. git-rm dir/file also removes <dir> if file was the only entry of
>    <dir>. So, when committing the removal, git complains that it can'=
t
>    find cwd. So I record the parent directory, do the git command, ch=
eck
>    if getcwd() works, and if not do the commit in the parent director=
y.
>=20
> 3. git-rm (empty) directory fails
>=20
> 4. Changes aren't atomic, but I can live with that and I doubt I woul=
d
>    be able to make it atomic without implementing a filesystem (FUSE =
or
>    not).
>=20
> I can work around most of the problems, and rewrite to use recorded p=
ath
> names instead of directories fd, but before I do that, and while I'm
> at the beginning, I'd like to probe for opinions and suggestions.
>=20
> So, please, suggest.

I posted an extremely simple bash script here:
http://lkml.org/lkml/2007/12/7/279

It just employs inotifywait to do all watching and just needs to
translate the events to the different git command. Did just glance over
your code, but it seems to do basically the same thing, just that it's =
a
lot shorter. The overhead of being a shell script is probably neglible,
as the amount of git calls are likely dominating anyway.

=46eel free to ignore my comments on why I think that that is crap anyw=
ay
and do whatever you want with the script.

HTH
Bj=F6rn

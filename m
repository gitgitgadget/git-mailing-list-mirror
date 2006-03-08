From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Update hook in Cygwin
Date: Wed, 8 Mar 2006 09:44:13 -0500
Message-ID: <20060308144413.GA516@spearce.org>
References: <ad8ce5c20603080416g5ed6d77el@mail.gmail.com> <440EDDE4.9070405@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Niklas =?iso-8859-1?Q?H=F6glund?= <nhoglund@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 15:46:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGzts-0001dj-3O
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 15:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWCHOoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Mar 2006 09:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCHOoY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 09:44:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56038 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751494AbWCHOoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 09:44:23 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FGztb-0003Ke-KJ; Wed, 08 Mar 2006 09:44:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 580A120FBAC; Wed,  8 Mar 2006 09:44:13 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <440EDDE4.9070405@op5.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17374>

Andreas Ericsson <ae@op5.se> wrote:
> Niklas H=F6glund wrote:
> >Hi.
> >
> >After creating a couple of repositories and pushing and cloning them=
,
> >I get the following:
> >
> >$ git push --all origin
> >...
> >hooks/update: line 88: mail: command not found
> >
> >This is in cygwin. I'm rather glad I don't have the mail command
> >installed, as I don't want mails going anywhere.
> >
> >The update hook contains the following comment:
> >
> ># To enable this hook:
> ># (1) change the recipient e-mail address
> ># (2) make this file executable by "chmod +x update".
> >
> >But my impression after a cursory look at it is that it would always
> >call "mail" whenever it is run, and since all files are executable i=
n
> >Windows (AFAIK), it would always be run.
>=20
>=20
> I was under the impression that the cygwin abstraction layer had some=
=20
> unixy permission thing on top of NTFS. Perhaps that's wrong. If you=20
> remove the hook it won't be called.

I've seen the same thing with the hooks on Cywin.  I would consider
it to be a bug in either GIT or Cygwin but I haven't decided
which yet.

If you look at the share/git-core/templates directory on a real
UNIX system would see that the hooks are not marked executable by
default when installed.  They are copied non-executable into each
new repository by git-init-db. Since they aren't executable they
don't get run.


But on Cygwin the hooks appear to be getting installed and are marked
executable in share/git-core/templates.  So when git-init-db copies
them over to the new repository they are by default enabled.

Removing the execute bit from the files in share/git-core/templates
doesn't help; for some reason git-init-db is still copying them with
the execute bit enabled.  I haven't spent the time to figure out why
yet; so I just run rm .git/hooks/* on every repository I come across.

BTW: chmod a-x .git/hooks/* also works as the Cygwin unixy permission
layer will remember the change.

--=20
Shawn.

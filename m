From: axel.ml@laposte.net
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 13:21:18 +0200 (CEST)
Message-ID: <5222475.65704.1302693678918.JavaMail.www@wwinf8226>
References: <4DA57183.6040308@laposte.net>
 <m3sjtm2z8e.fsf@localhost.localdomain>
Reply-To: axel.ml@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 13:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ycS-00033T-Av
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 13:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab1DMLwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 07:52:22 -0400
Received: from out1.laposte.net ([193.251.214.118]:50684 "EHLO
	out2.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754234Ab1DMLwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 07:52:20 -0400
X-Greylist: delayed 1859 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 07:52:20 EDT
Received: from out1.laposte.net (unknown [10.98.49.224])
	by mwinf8205.laposte.net (SMTP Server) with ESMTP id F15541C0022F
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 13:21:43 +0200 (CEST)
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8211.laposte.net (SMTP Server) with ESMTP id 01352700009E
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 13:21:19 +0200 (CEST)
Received: from wwinf8226 (unknown [10.98.49.225])
	by mwinf8211.laposte.net (SMTP Server) with ESMTP id E2F3E7000099;
	Wed, 13 Apr 2011 13:21:18 +0200 (CEST)
X-ME-UUID: 20110413112118929.E2F3E7000099@mwinf8211.laposte.net
In-Reply-To: <m3sjtm2z8e.fsf@localhost.localdomain>
X-Originating-IP: [82.247.209.197]
X-Wum-Nature: EMAIL-NATURE
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-REPLYTO: |~|
X-me-spamlevel: not-spam
X-me-spamrating: 39.799999
X-me-spamcause: OK, (-5)(0000)gggruggvucftvghtrhhoucdtuddrfeduiedrfeejucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecujhgvucdlqdehmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171444>


Message du 13/04/11 13:00
> De : "Jakub Narebski"=20
> A : "Axel"=20
> Copie =C3=A0 : git@vger.kernel.org
> Objet : Re: REMOTE_USER value propagation through http push
>
>=20
> Axel  writes:
>=20
> > I set up a git server with HTTP authentication with Apache through
> > LDAP (Debian Squeeze + Apache 2.2 + mod_authnz_ldap).
> >=20
> > I m using gitweb for browsing the repositories. At this moment, the
> > commiter name appears to be the local user who called "git push". T=
he
> > username used for HTTP authentication is not used as commiter name,
> > though the REMOTE_USER environment variable is defined.
> >=20
> > After a quick look at http-backend.c it looks like the
> > GIT_COMMITER_NAME variable should have been defined with the
> > REMOTE_USER variable. Is this right ?
> >=20
> > In Apache access logs, the REMOTE_USER appears to be defined in the
> > last request of the push :
> >=20
> > 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "GET
> > /git/sandbox/info/refs?service=3Dgit-receive-pack HTTP/1.1" 200 467=
 "-"
> > "git/1.7.2.5"
> > 127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "POST
> > /git/sandbox/git-receive-pack HTTP/1.1" 401 618 "-" "git/1.7.2.5"
> > 127.0.1.1 - ldapuser [13/Apr/2011:11:45:08 +0200] "POST
> > /git/sandbox/git-receive-pack HTTP/1.1" 200 353 "-" "git/1.7.2.5"
> >=20
> > Is this behaviour expected ?
>=20
> I don't quite understand.
>=20
> With push over _any_ transport you transfer commits from your
> repository to remote repository *without changing them*. Committer is
> a person who created a commit, i.e. did "git commit" (or "git am", or
> "git rebase", or "git merge").
>=20
> The only place where user who did "git push" can appear in is _reflog=
s_
> (I don't know if it appears or not)... but gitweb doesn't show wny
> reflog information. That of course can be improved...
>=20

Indeed I wrongly used the "commit" word. I m switching from SVN/WebDAV,=
 and the HTTP authentication name is usually used as the commiter name =
in the SVN repository. This name was informative only but useful when b=
rowsing repository and logs.

I would have enjoy to reproduce this behavior with git/http, since it s=
 common (in our organisation at least) that the commiter is the pusher.=
 In fact until today the authentication was almost only used as tracing=
 commiters in logs and not really for security considerations.

So I assume that it s cannot be done for the moment :)
Thanks for your answer !

Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net

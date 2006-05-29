From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 23:28:30 +0200
Message-ID: <20060529212830.GA4074@limbo.home>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca> <e5d6i0$rnf$1@sea.gmane.org> <Pine.LNX.4.63.0605290910210.8863@wbgn013.biozentrum.uni-wuerzburg.de> <447ADAEF.3030806@Intel.com> <Pine.LNX.4.64.0605290956190.5623@g5.osdl.org>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Salikh Zakirov <Salikh.Zakirov@Intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:29:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkpIX-0006Rx-1X
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWE2V26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 29 May 2006 17:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWE2V24
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:28:56 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10980 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751385AbWE2V2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 17:28:52 -0400
Received: from fwd33.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1FkpI6-0002zm-04; Mon, 29 May 2006 23:28:46 +0200
Received: from tigra.home (ZBPDiGZYoewLQCqI9B6Ev7lsQKEsTXbEiN24ktPi+SCcWwsRtB+S8h@[84.160.119.236]) by fwd33.sul.t-online.de
	with esmtp id 1FkpI5-2ARoZs0; Mon, 29 May 2006 23:28:45 +0200
Received: from limbo.home (unknown [192.168.1.26])
	by tigra.home (Postfix) with ESMTP id 399AC277B5;
	Mon, 29 May 2006 23:28:44 +0200 (CEST)
Received: by limbo.home (Postfix, from userid 1000)
	id 86DB2EC446; Mon, 29 May 2006 23:28:30 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605290956190.5623@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ID: ZBPDiGZYoewLQCqI9B6Ev7lsQKEsTXbEiN24ktPi+SCcWwsRtB+S8h
X-TOI-MSGID: f39dcac2-4d6e-4251-8491-ec5f94e16396
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20975>

Linus Torvalds, Mon, May 29, 2006 19:00:42 +0200:
>=20
> I realize that you already found the solution (Core.SharedRepository)=
,=20
> but:
>=20
> On Mon, 29 May 2006, Salikh Zakirov wrote:
> >=20
> > 2) I have 'umask 002' in my ~/.profile. Somehow, it does not help,
> > because ~/.profile is not read on non-interactive SSH sessions
> > (to verify that, just try to do 'ssh somehost umask')
>=20
> The ".profile" thing is indeed read only for interactive tasks.
>=20
> So use ".bashrc" instead.
>=20

Will not work:

$ man bash
=2E..
       When  an  interactive  shell  that is not a login shell is
       started, bash reads and executes commands from  ~/.bashrc,
       if  that  file exists. ...

Besides, not everyone has bash as their login shell.

Reading man sshd:

     $HOME/.ssh/rc
             If this file exists, it is run with /bin/sh after reading =
the
             environment files but before starting the user's shell or =
com=AD
             mand.  It must not produce any output on stdout; stderr mu=
st be
             used instead.  If X11 forwarding is in use, it will receiv=
e the
             "proto cookie" pair in its standard input (and DISPLAY in =
its
             environment).  The script must call xauth(1) because sshd =
will
             not run xauth automatically to add X11 cookies.
and

     /etc/ssh/sshrc
             Like $HOME/.ssh/rc.  This can be used to specify machine-s=
pecific
             login-time initializations globally.  This file should be
             writable only by root, and should be world-readable.


This guaranteed to work (at least for ssh).

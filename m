From: Jan =?UTF-8?B?U3TEmXBpZcWE?= <jan@stepien.cc>
Subject: Re: [PATCH] fetch-pack: make the ssh connection quiet
Date: Thu, 28 Oct 2010 11:14:03 +0200
Message-ID: <20101028111403.db0f8593.jan@stepien.cc>
References: <1288189628-4883-1-git-send-email-jstepien@users.sourceforge.net>
	<7v1v7bclhe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 11:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBOYn-0000rX-Ub
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 11:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0J1JOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 05:14:08 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:44127 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab0J1JOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 05:14:07 -0400
Received: from jan-sl300-ubuntu (coi-nat.rtr.pw.edu.pl [194.29.130.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 967F72A10378;
	Thu, 28 Oct 2010 11:14:04 +0200 (CEST)
In-Reply-To: <7v1v7bclhe.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160164>

On Wed, 27 Oct 2010 15:35:41 -0700
Junio C Hamano <gitster@pobox.com> wrote:
> Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:
> > The --quiet option passed to fetch-pack did not affect the ssh chil=
d
> > process. When an ssh server sent a motd it was displayed because th=
e ssh
> > client wasn't launched with the -q option.
>=20
> This is curious for a couple of reasons:
>=20
> 1. "-q" option to "ssh" is not meant to supress "motd"; it is about
>    warning and diagnostics.  From man ssh(1):
>=20
>      -q Quiet mode.  Causes most warning and diagnostic messages to b=
e
>         suppressed.  Only fatal errors are displayed.  If a second -q=
 is
>         given then even fatal errors are suppressed, except for those
>         produced due solely to bad argu=E2=80=90 ments.
>=20
> 2. "PrintMotd" defaults to "yes" but it is to specify whether the dae=
mon
>    should print /etc/motd when a user logs in interactively.  I didn'=
t
>    think fetch-pack logged in interactively, so why should this matte=
r?
>=20

You're right, fetch-pack doesn't log in interactively so the actual mot=
d
is not displayed. I made some research and it turned out that what I
described in the commit message as the "motd" was in fact the Banner.
Quoting man sshd_config(5):

  Banner  The contents of the specified file are sent to the remote
          user before authentication is allowed.  If the argument is
          =E2=80=9Cnone=E2=80=9D then no banner is displayed.  This opt=
ion is only
          available for protocol version 2.  By default, no banner
          is displayed.

=46rom what I've read it seems that the Banner is generally used to
display some legal information, such as "this system can be used by
authorised personnel only, others will be prosecuted".

I'd say that suppressing such information along with diagnostic
messages might be expected after adding the "-q" flag to fetch-pack
and other similar commands. Fatal errors will be printed anyway. The
question is whether "--quiet" should suppress warnings as well. From my
point of view it is reasonable or at least acceptable. An alternative
solution might be to add another level of verbosity, namely "--silent".

Thanks,
--=20
Jan St=C4=99pie=C5=84 <jan@stepien.cc>

From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: got wet with make --dry-run
Date: Thu, 1 Jan 2009 20:44:59 +0100
Message-ID: <200901012045.02734.trast@student.ethz.ch>
References: <87eizn0xhd.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3441800.DuYGEHRp6r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 20:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LITUk-0003S4-VA
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 20:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZAATow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZAATow
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 14:44:52 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:40773 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbZAATov (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 14:44:51 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 20:44:47 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 1 Jan 2009 20:44:47 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87eizn0xhd.fsf@jidanni.org>
X-OriginalArrivalTime: 01 Jan 2009 19:44:47.0535 (UTC) FILETIME=[672043F0:01C96C49]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104311>

--nextPart3441800.DuYGEHRp6r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jidanni@jidanni.org wrote:
> Gentlemen, make --dry-run is booby trapped to still execute commands:
> $ (cd Documentation; make --dry-run); find -mtime -1 -type f
> ./Documentation/doc.dep
> ./GIT-VERSION-FILE
> Forgot $(MAKEFLAGS)? (info "(make)Options/Recursion").

A two minute check into Makefile shows that the recursion is
implemented via $(MAKE), which is the recommended way to do it.  It's
impossible to "forget" $(MAKEFLAGS), since the docs clearly say that
it is always exported unless explicitly unexported.

The *real* reason why it rebuilds GIT-VERSION-FILE is that the
Makefile says '-include GIT-VERSION-FILE', and uses the version info
to decide some parts of the build process.  (It'll also do a similar
thing with the $CFLAGS detection code.)  Since this influences the
actual commands executed, it seems sensible to run them even under
'make -n'.

> By the way, why would an offline make need
> /bin/sh: curl-config: command not found

=46rom somewhere near the top of Makefile, which is definitely a
recommended read:

# Define NO_CURL if you do not have libcurl installed.  git-http-pull and
# git-http-push are not built, and you cannot use http:// and https://
# transports.


Next time please take the time to investigate at least a little bit
into your "issues" before starting to cry foul.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3441800.DuYGEHRp6r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkldHT4ACgkQqUud07tmzP0rSgCgoCHluc+Yi1lKCfv745FnhLRk
iJ8An1zbZGsRX8qTstOtqRTRb9EK6mbN
=AGa0
-----END PGP SIGNATURE-----

--nextPart3441800.DuYGEHRp6r--

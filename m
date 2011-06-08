From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 17:58:00 +0200
Message-ID: <vpqtyc0wc1j.fsf@bauges.imag.fr>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
	<20110608150106.GB7805@sigill.intra.peff.net>
	<vpqhb8049m3.fsf@bauges.imag.fr>
	<BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:59:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUL9u-0000CK-Ew
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396Ab1FHP6N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 11:58:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60356 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab1FHP6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:58:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p58FvxFg023899
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 8 Jun 2011 17:57:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QUL8r-0003nD-84; Wed, 08 Jun 2011 17:58:01 +0200
In-Reply-To: <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com>
 (=?iso-8859-1?Q?=22J=E9r=E9mie?=
	NIKAES"'s message of "Wed, 8 Jun 2011 17:46:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jun 2011 17:57:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p58FvxFg023899
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308153480.29351@3RADTH8rOXQCZpVb7NIdfg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175389>

J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:

> 2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>
>> open(my $git, "-|:encoding(UTF-8)", "git cat-file -p $sha1");

there should probably have been a $/ =3D 1; or some other perl magic to
make sure we don't read only the first line there:

>> my $file_content =3D <$git>;
>> close($git);
>
> Yes, that did it ! Thank you boss :-)

Then, make it a helper function to call like

my $file_content =3D run_git("cat-file -p $sha1");

and use it where needed.

> Although, I'm still encountering issues regarding encoding file names
> though, I am going to look deeper now that i have this solution.

My advice, at least in the short-term (already discussed offline): use
urlencode ( http://php.net/manual/en/function.urlencode.php ) on pull,
and don't bother with encoding on push. Non-ascii characters in
filenames are a nightmare ...

If you go for utf8 filenames, you should test that your script works in
various environments, like

LANG=3Dfr_FR.ISO-8859-1 xterm
(launch a terminal with latin-1 encoding inside)

and Mac OS X (which does some weird utf-8-normalization on filenames),
and probably windows (no idea how filename encoding works there).

If it doesn't work in one of them, you'll have to provide a fall-back t=
o
plain ascii for these users, which will most likely be the short-term
solution I'm proposing.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: fREW Schmidt <frioux@gmail.com>
Subject: Bug when moving submodules (I think?)
Date: Wed, 18 Dec 2013 17:32:05 -0600
Message-ID: <20131218233146.GR17291@wanderlust>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53TzBEXPl5+8hjUY"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 19 00:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtQbS-0005oN-CA
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 00:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab3LRXcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 18:32:10 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37532 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3LRXcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 18:32:08 -0500
Received: by mail-oa0-f52.google.com with SMTP id h16so419431oag.39
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=YK1HB9qGPofMdQ+ysl3/OAB9WveWEvb2QQldN7wSoqU=;
        b=YIOkweotwxDs4Tx6i/Wynm12IjfiXKocxEpn1PY9I6Dv5dY+yDysPzlbPMcNkuqjBZ
         AKloX9HBc9NaG1xi1XUR0rGjCzMK3sksxvXWagFSaXiADKS3Mtg2oU5YHR2kNjXyjOrx
         k/39SsOvCqCw02+1M95eUt58c9UrPmN8BdSyBErHx6CwXYLfHSWDWGHY1wz2iLyiuzC+
         UgMOOtID76FWlZn7zJB3qIMRXtUOfFLmJ48ZTB78G28zpbe93wruHEksufu9F82mXtz+
         aXbCGf63WU147saIjPSS5OWbZqUbgwaw9j9eA2IY3g6Q7+ttuHp7kp6Gc6S0pCrJeQAQ
         c6nA==
X-Received: by 10.60.51.102 with SMTP id j6mr22641408oeo.6.1387409527968;
        Wed, 18 Dec 2013 15:32:07 -0800 (PST)
Received: from localhost (24-182-106-91.dhcp.ftwo.tx.charter.com. [24.182.106.91])
        by mx.google.com with ESMTPSA id fz6sm2287451obb.3.2013.12.18.15.32.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 15:32:06 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239499>


--53TzBEXPl5+8hjUY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I tried to make a script to repro this from scratch but ran into other
issues, which may or may not be a bug.  I'll put that at the end.

To repro all you have to do is:=20

 git checkout git://github.com/frioux/dotfiles
 git reset --hard 92c85161ceec9e52b0b2d2de893ba11f49c80198
 git mv zsh .zsh

(sha included so this email continues to be valid in the future)

You can now see that .git/index.lock has been left behind.  On a
non-fresh checkout (I'm not sure why my old checkout is special) I get
the following error:

 git: builtin/mv.c:248: cmd_mv: Assertion `pos >=3D 0' failed.

I assumed this was just related to moving submodules that are in
subdirectories, but when I do that from a fresh repo I get a different
error.

 mkdir -p test/a test/b
 cd test/a
 git init
 touch a.txt
 git add a.txt
 git ci -m 'initial commit'
 cd ../b
 git init
 mkdir c
 touch c/c.txt
 git submodule add ../a c/a
 git ci -m 'initial commit'
 git mv c d
 git status

And the error:

 fatal: Could not chdir to '../../../../c/a': No such file or directory
 fatal: 'git status --porcelain' failed in submodule d/a

I am using git v1.8.5.1 built from source on the latest ubuntu.  If
there is anything else I can do to help repro this please do not
hesitate to ask.
--=20
fREW Schmidt
http://blog.afoolishmanifesto.com

--53TzBEXPl5+8hjUY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAABCgAGBQJSsjB0AAoJEG6zMC9zenWC3RcP/j7XsjyPrQfT/zP0vyHVBPO4
akgYJ/Bfh9GTTfHbwS4CX5dJLs4dBw8/dMy1yhlNEG1QkJf8x2jpGUoWKqLWT5Dh
TWCzwzK3g9LZqp7kaxE46Xt5/eFoak9HS5ywYo5th63h83Cual/JMP9M+W+z6Fug
MU7SKBj0n1VDrcIyLGuUbBKVNClDZWb0+2H5MnufR9dyGdzS3eacDczB7porbTsr
dhgUa58/kBvSSs9qCneydazEFuWb4DlOkziXR8FD8u2dYmAHQK5v7Yf9bKq+9FnE
ytAjkAO8RZSBXXUx6qzXZdXFUqJ9r3g+Chxk4NHyBy/iENNYo1tdyBIg6WJ8nykW
pVATefdlYDTamff74Cv/Al2R+kIPXE7iImM04v86+ylCegYr3MQataMR3EFHnFq5
0o2fdKzwl2N49zjS+OI52qe95fML828VY86PZXXYT9G4wl1sOtVJg7vB+/VouJZC
ko7HHHT08+alWnecIoR/5rLMgdjqm9aQwlHZpPF/AuUfH0a3yJwTT/5xka96vsGv
W42IUsLUBkG8jZC9olAUbeQwtssVhLbLm2DsPoZjPgSdMUHe+7XdtJLM+S9o8077
wayBHOI9cw2XW58a//dIMuFFK8Nb+RUhjFbud2PASN9V8dq8VqXDz3bjje65Lhym
9d4yo7wztaAqxDcRaacV
=G5+q
-----END PGP SIGNATURE-----

--53TzBEXPl5+8hjUY--

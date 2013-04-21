From: William Giokas <1007380@gmail.com>
Subject: [BUG] Filenames with single colon being treated as remote repository
Date: Sat, 20 Apr 2013 23:53:29 -0500
Message-ID: <20130421045329.GB30538@WST420>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: fsckdaemon@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 21 07:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTmPM-0007xN-LR
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 07:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab3DUFBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 01:01:34 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:49047 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab3DUFBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 01:01:33 -0400
Received: by mail-yh0-f49.google.com with SMTP id i72so820680yha.36
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=xgjFlb6Ww8xckeri7p7eZgKKKa1cfFWdPzKfi7qtPvE=;
        b=OLHOCye+MO0MVJYriirY/NrLLuIhfSGp8osMetT+Rij90lRROTYtUVJtRZyyeKcT5v
         r+grt4OFXv9YvxO/RQQE5rBKNSsBvCaur0yfk1pwLjCPC2N0ezzZ6Os6v7lffwMWhcLU
         GEECXWHiLmhtqLmX5QcNrBgqC73wWce25IN9MY3Dw5YL1rmH9og3q6ECSL+5qkgt2K70
         Q5LRo0WfZMb4qfolT7UXJev9M/js2ezvZuFDxNHcIKsHYAnCY4MbPFNjF17Bny4JEN0k
         ML2HL6hFPDnQQuIfBfoPp20NBtOo6uAcg9tqah2l4HMbgMBTJ7A4hcbyLGv7tXgQVY23
         YD2w==
X-Received: by 10.236.110.207 with SMTP id u55mr14382476yhg.135.1366520023174;
        Sat, 20 Apr 2013 21:53:43 -0700 (PDT)
Received: from localhost (adsl-99-141-217-199.dsl.emhril.sbcglobal.net. [99.141.217.199])
        by mx.google.com with ESMTPS id l70sm34758510yha.1.2013.04.20.21.53.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 21:53:42 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221891>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All,

It was brought to my attention today that git has some weird behaviour
when colons (:) are used in directory names.

In my distros packaging system, for git repositories we clone a bare
repo and then clone that bare repo locally as a temporary build
directory (no, we can't use cp, it's a bare repository). Say we have a
directory, /tmp/foo:bar/baz, that is a git repository. If I want to get
a clone of that repository locally, using all of the local
optimizations, then I need to run::

    $ git clone /tmp/foo:bar/baz /tmp/new-baz

but running this gives me this output::

    Cloning into 'new-baz'...
    ssh: Could not resolve hostname /tmp/foo: Success
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
   =20
which it should not be doing. It is possible to use a file:// url to
clone it, but then the --local option is ignored and no optimizations
are made. After asking on #git, I was directed to the transport.c file,
but I don't know what in that is failing. We ran some tests on the
is_local function and it seems to work correctly.

Any ideas on how to debug this further?

Thank you,
--=20
William Giokas | KaiSforza
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRc3DJAAoJEGkCBthzzQnP/GYP/2Jd9/wt0C8tCB60bVJ5C81c
+6VCBTaPPnq09BeM0GVjCvowJ/1va96fPWUH8bDXiXhwXYx884aFbi9Aap3ipB7x
HzrnB3SUiVNx1n5ROq5I4qzSvAMjTjxQkjx0XYAKSkIfM3cSexGxzxiJrn3B5nbF
bH+396AimG7NyVkzoiE1MhFq46nJ3pe4tKW0NNnIVrdLUSiPxrRRYkj2oWs3jbTD
pypQAvXm+4wYyIk5vouZ+5Wj0zk6Q4eZflV9ENVYUulgWcV7syvuEP7qAv5zwOBt
EN9c+vP1fJ+J4poN1u3BcsBK9O3Y3Z+IL/bYsQUW00XvK6jdKj+SJ68ohCJSZp7y
gSBwua//I3fVeTEqRcNhW4vbjib7RTvhgMNjb46FcaBPBQL3l18AlCr6V79iIL0e
5fsZEHmhInFJATTz8WTAXb8ldELp4tF8Z76u0/cVScK+cHzQTyV48A9tvDv/+n3w
GH+GDSM3Ppi0/4IR6Eot9bBnIoGB3W/G0DChwek5F4WSauBeFBb933cjIBdYkg/u
SbOB0i1wWp2RqoJR/MuBh64XoS1iSCUgiBeVQBPCcHebLXPhy5rg90YxKJfXXDC8
KcjlPUmCdW8k309ukB7zE88n1kmLnogWafhZsjdg2ze3rTx7be7whmOw+mDBG47k
a79f2yFJSWMlWDKoQ9vq
=QaWt
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

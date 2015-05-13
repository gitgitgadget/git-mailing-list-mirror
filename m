From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Clone hangs when done over http with --reference
Date: Wed, 13 May 2015 17:04:36 -0400
Message-ID: <20150513210436.GA7407@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:04:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysdpq-0000i6-IB
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 23:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555AbbEMVEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 17:04:53 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38650 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965383AbbEMVEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 17:04:39 -0400
Received: by igbhj9 with SMTP id hj9so56622647igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=eLENpWt1kCSZsM8VFf7KlqXKwfw9qjqJPj9LjOJSNH8=;
        b=YLdvINKWWcx/m0WTeK/3RWbHDhmSO42nFI+QHyMNyJsqyCmlsruYc6ym2dHT0DQGYy
         kGANoqR6jWfxMTWWRE0oy6onzgwf/Hmm67XVIzCUq78ovXCsuUA7tF1NZE7iaFz4z8yW
         O1tXsz+hCCwrbsXWzt4kjk6EcnfCO+Idrn2eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=eLENpWt1kCSZsM8VFf7KlqXKwfw9qjqJPj9LjOJSNH8=;
        b=ko879pmVMTKIJs5nqvluELF+s0R3oOG8Sozfl2kbRbvpr0g9ssNt5tkJaxLA1+Ez0V
         4o3zU2EPs6BGaofbGfOM/pkXhgCd8uYH+Z/DqZGZQxiStRezSjK5kRvcuCtsJaX1KOTe
         fz6PlZNAKxCdqsc647NLfrMJZAU9YVZFoFnoavA6f2yIEZZCwKGJiZJu/iEpUqzOB2oB
         bt3lBtEIaUBLoP/I0P1P9iVDWA07bGtWCSGbMbqbIwU61EBY/4zM0v/x/+ZXBKShKg2T
         ySAt3DLc0qH8QRM82NT1QL7MDPlyKQTV7OdKU2WKVwqGAiurJcfhpRErGvqAlGHhp9Js
         p8CQ==
X-Gm-Message-State: ALoCoQnq/PPcbo0HIoxs3k3QSXx7U2ooAnShTWgC6TCDkthCiN7p1ndTkSlkeR+Dz8+v+Rb3s8l6
X-Received: by 10.50.137.100 with SMTP id qh4mr13085635igb.1.1431551078843;
        Wed, 13 May 2015 14:04:38 -0700 (PDT)
Received: from gmail.com (198-84-251-213.cpe.teksavvy.com. [198.84.251.213])
        by mx.google.com with ESMTPSA id b8sm15069585ioe.23.2015.05.13.14.04.38
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 14:04:38 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269009>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a reproducible case where git clone --reference hangs when
performed over http://, but not when performed over git://

The repository in question is very large, which possibly plays a role in
this. Unfortunately, I was not able to reproduce this with any other
repository, so if anyone wants to try this, they will have to suffer
through 2.5GB downloads.

To reproduce on the client:

git clone --mirror \
http://source.codeaurora.org/mirrors/chromium.googlesource.com/chromium/src
(completes after downloading ~2.5GB)

git clone --reference ./src.git --mirror \
http://source.codeaurora.org/quic/chrome4sdp/chromium/src.git foo.git
(this hangs forever)

If you do this over git:// protocol, it will work:

git clone --reference ./src.git --mirror \
git://source.codeaurora.org/quic/chrome4sdp/chromium/src.git foo.git
(completes after downloading ~100MB)

It will also work if you clone the same repo without --reference. Both
repositories pass fsck checks.

I reproduced it with git-2.4.0 on the server, and it appears to be
unrelated to the Apache/Nginx versions nor various httpd daemon
settings, at least not in my testing. No errors are generated in the
logs. The process just appears to be stuck not doing anything.

To reproduce locally, simply set up these two repositories in
/var/lib/git (one can be a --reference clone of the other -- it didn't
matter in my tests), and put this in /etc/httpd/conf.d/git.conf,
assuming Fedora or Centos7 system:

SetEnv GIT_PROJECT_ROOT /var/lib/git
SetEnv GIT_HTTP_EXPORT_ALL 1

AliasMatch ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$             /var/li=
b/git/$1
AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$    /var/li=
b/git/$1

ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

<Directory "/var/lib/git">
    AllowOverride None
    Options None
    Require all granted
</Directory>
<Directory "/usr/libexec/git-core">
    AllowOverride None
    Options None
    Require all granted
</Directory>

Not sure what is going on, but it appears that the hang is on the
server. Hope someone can figure it out.

Best,
--=20
Konstantin Ryabitsev
Linux Foundation Collab Projects
Montr=C3=A9al, Qu=C3=A9bec

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCAAGBQJVU7xhAAoJEDZgaZyZ4FVXrW4IAJlDvrf6HZqwXYKm6/w+7SrC
eP6tGbvw1+uwDARmyPUz6QWX4rb6xZDIdBnuOLVMKByVpravz7wBbzj4qaCUpxpD
GZ+BYS5sk606hBXK5fkhzexsOVeYRQEQM5esOh209eoAgFCnlVpAaSi0UtWpL8wk
Pix4SzXnH5JjZIMvS+dbolf/d78WPp00JZnbBVoUaJcB/s3aEJ9R5Oi/8omiRpZp
HmInL6t0U979P9JQFyR5R/VSwf62kV4Qit03yj4JSKZlkK3Va+aCK7vrxPxzujJ+
Nw/a7T16BkfpxugmzV6wpoA648ASolMuW3B/og8lIARC/UEXvm0xdb9E6W9bvuM=
=KReO
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

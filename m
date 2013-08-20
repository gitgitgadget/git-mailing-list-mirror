From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCHv4] repack: rewrite the shell script in C.
Date: Tue, 20 Aug 2013 23:24:02 +0200
Message-ID: <5213DE72.3000308@googlemail.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA426E7FA91ECE61AEFC5E716"
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Aug 20 23:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtPR-0002nf-3X
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab3HTVYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:24:08 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:58303 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab3HTVYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:24:07 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so448656eaj.41
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type;
        bh=WY2BAYf3vY6so6iVJXCcdItnij6wdIwQR4xh800QVUA=;
        b=KX83sCOBF5HfgRJxDsuyC8+72/pfcHIp+LCDirWFy2qeZNFcdYKquz0XWZCFHYVSV0
         assPaIHpkpNOEYpxD2QvNpIIYaz6cUfTuxLeeWU79oZq0bxu5tGzZZR+zZnnfPDhkRXm
         ra7wtwyr4oXG4Ai7LTcLLzj+4bUdQdxFy/b0j7et7JqF/+T4b3Xf/82QihdR2xNI0ws3
         MKcMKh1zMKTYUPjgoF+X9BYvob+lw7GNkE0j8XayxR7Qv5kcV5mPLUcM+B9ySCq8om8Z
         ELFE1u3E4zhkf8Uaw3QEpEhf7jLKkDd0J0q8E1oPq86C34JcU16Ue6XB+KZNTFFyPLkV
         VYSA==
X-Received: by 10.15.43.13 with SMTP id w13mr4549518eev.37.1377033845873;
        Tue, 20 Aug 2013 14:24:05 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a43sm4890450eep.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 14:24:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <52136F9C.6030308@kdbg.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232648>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA426E7FA91ECE61AEFC5E716
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>=20
>> +    packdir =3D mkpathdup("%s/pack", get_object_directory());
>> +    packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>=20
> Should this not be
>=20
>     packdir =3D xstrdup(git_path("pack"));
>     packtmp =3D xstrdup(git_path("pack/.tmp-%d-pack", getpid()));

Just a question for documentational purpose. ;)
Am I right suggesting the following:

`mkpathdup`::
	Use parameters to build the path on the filesystem,
	i.e. create required folders and then return a duplicate
	of that path. The caller is responsible to free the memory

`xstrdup`::
	Duplicates the given string, making the caller responsible
	to free the return value. (No side effects to fs,
	other global memory). Basically the same as man 2 strdup
	with errorhandling.

`git_path`::
	Returns a pointer to a static string buffer, so it can just
	be used once or must be duplicated using xstrdup. The path
	given is relative and is inside the repository.


Stefan


--------------enigA426E7FA91ECE61AEFC5E716
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE953AAoJEJQCPTzLflhqzGgQAKAF6gjVfXvIJyHRSaznGela
oPTGi3b1QLx5boCKBNX9Q6+mRakwwvk8oWM6sPIA+KbDhRcbGarmviz98yLIEX8/
swNeFZZgdsuqfLENHNxS5+grji75vxEwHUNN2i8p66o+MMFyGoS8tdaZu6UU9/Z4
Z4Zh5nT6OKlRcdXsnCRAeLSoXqPKqPosiHfnbizfFKk7x0y/Mf9uaYISxQI1eOBD
JNY/D+VDBBK9wcYYtrENEdDYV9uThlcF+rfuLipIjsEYo5B1nF+UkO4XE7Bfj9w3
1SJ9XFfuDdiabzMBYloEwO1VLcpgB4qNRaA0nWSO0BLKg5ce7hORmxfbbtwGZqRw
j0Mmcv/2NDPCXrCJBoW4Q7p7vQ29zQ5wtoqeTj9pq+DxtLYrIKk4peAEv/5fHYLj
enx6QC21JXX9nDhV9d1JK4ZU/3m3zcW3pTp3JHH6lKgRHACIDlR1XMJAdvBzK5A1
w4Op/3lYYYspfljvzomSHTBOOyuwMtGZBjQ5qfufT5Yrwlfo0IhkXZuboqo2kOkU
+91YJbKZhBoaCWZ/a7XG9RwVgcOTZpTmFtLZl7qRApK5jVq/1x8w6UlevDOMqdYe
GDopiA0Aopqyh2BeueFZHORAI7tV9Gorlvh3dAv15mt1RZ1d4ej40Jg0xW8cdw8+
MFnwGsV52RrQemXPDZJs
=6rkK
-----END PGP SIGNATURE-----

--------------enigA426E7FA91ECE61AEFC5E716--

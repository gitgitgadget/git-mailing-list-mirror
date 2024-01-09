Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA13E46A
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gYdrA+MX"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2A52A5A391;
	Tue,  9 Jan 2024 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704840970;
	bh=YaijnmMrf/M5so6WIVF22N5BaQau0exiw5TTRGNgC98=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gYdrA+MXRPCBggp2Mm5M0WPkzPY9PHZq2ZnLArcGw/0grA9DS+s4GBsq5oiS4DiXm
	 vzqZgJzIFxP5hfoErEiI5Bk74yA67mwftpHdaaoaNAcOpYCS0eHw5lco1W9esRdjFm
	 PaFn0Bu3Ry67v1wqP5I5aQIBLGWIcf9Ridifv3hd8JzmQTfvHa7E1X3FHNxxMo8YEC
	 exgxBnzOBQJhQ6NN/Z45DvOR9chky7204JxCfnJBvP4dYKX9GSeBr5XLgSmER5w1Lf
	 uQ7nGClHiTa7/BUOV/I/rtbhOJ8I+jWwNX/FSiv+HzUaPoQTAO3R49qfRPVPUQJbxb
	 QftXqvdBYvF9uigFLICJGmziJIDgahCqCKl9l0C8/kJCe/iEzVAPt/V+Yve1LMqRXU
	 cZCIHw27/4jJISV4wkImtFN3rIrdkquV8xWy4pif+iW07q/q0FDanyak5qKzK5S4h2
	 oTfp1TRONWPIb5OY6IWJlk6BJZb0qLkKB/r37tkEdDVCBS8hrj2
Date: Tue, 9 Jan 2024 22:56:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Domen Golob <domen.golob.px@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: Git spawns subprocesses on windows
Message-ID: <ZZ3PB9mq8GTpGITC@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Domen Golob <domen.golob.px@gmail.com>, git@vger.kernel.org
References: <CAF6dN-oEy-svp+6Bw_NAeOMrWc61ObcZ4Q2huVj9PPK1EQHquw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3ttroOPOv/imSJ5"
Content-Disposition: inline
In-Reply-To: <CAF6dN-oEy-svp+6Bw_NAeOMrWc61ObcZ4Q2huVj9PPK1EQHquw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--s3ttroOPOv/imSJ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-09 at 15:33:43, Domen Golob wrote:
> Hello,
> the problem is exactly the same as what was reported here on stackoverflo=
w:
> c# - Git for windows seems to create sub-processes that never die -
> Stack Overflow
> https://stackoverflow.com/questions/69579065/git-for-windows-seems-to-cre=
ate-sub-processes-that-never-die
>=20
> Additionally I have found out that:
> - a Git for Windows subprocess is created for each repository and
> every time a git command is issued this process grows in size and it
> never dies.
> - you cannot delete the .git folder from the terminal, but it works
> via file explorer
> - deleting the .git folder kills the Git for windows process
> - creating changes in several repos creates multiple processes, and
> sometimes the process is created as a subprocess

You probably want to contact Git for Windows at
https://github.com/git-for-windows/git.  The reason I suggest that is
that this is usually not a behaviour we see on Unix, and seems to be
Windows-specific.

I don't know if it's possible to see command-line arguments of processes
on Windows like it is with `ps` on Unix, but including that information
if possible will be very useful to the maintainers.  Without knowing
that information, it's very unlikely that anyone will be able to help
you since we don't know what's going on.

There are some possibilities of what's going on here:

* git gc is running.
* git maintenance or the fsmonitor is configured and is running.
* You have a non-default antivirus or monitoring software that causes
  processes to hang or not complete, so one of Git's subprocesses can't
  exit.  If you're using such software, we usually recommend completely
  removing it completely (disabling it is usually not sufficient),
  rebooting, and testing again to make sure it's not the problem.
* You have some other process which is running which spawns Git commands
  (editors, content indexers, etc.).
* We actually have a bug and some process is not waited for correctly,
  and zombie processes manifest differently on Windows than on Unix.
* Something else I haven't considered.

However, as I said, you'll probably want to contact the Git for Windows
folks through their issue tracker.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--s3ttroOPOv/imSJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZ3PBwAKCRB8DEliiIei
gVuZAP9M32dcISDquH8ypzqvdyISr0q36/86eEurqOUGdoWRZwEA5SEFJc+UqEtr
tJYCrbZVRdQR46ny8HeGS5v9jZVXcAM=
=EBUi
-----END PGP SIGNATURE-----

--s3ttroOPOv/imSJ5--

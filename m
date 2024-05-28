Received: from kitenet.net (kitenet.net [66.228.36.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC16EADA
	for <git@vger.kernel.org>; Tue, 28 May 2024 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.36.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862449; cv=none; b=VBXjgXfYR9AkQcaeksSMUR7XGsZpk6X6FRZ3htJty5zONfXoEiNvsZlpt6qq9Qgfp/o+SbI2Ho+3jzFLXFAjUpGYrEvQZnyeaPjKSMn66vaLFuGVFuwIn4ZHGjocalV55HTtwU2T2Ifm+L2/gg34GVJbcgvZU+BCsFJzweDwF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862449; c=relaxed/simple;
	bh=ykv+scU8uUpleCRou1fYFLBgDLqxqGsqf3cg2MI51o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5EefXuBtPRmE4GfJu77QB0bDKMinRtbPcGhm5GgwQyobOz6jrciMTs3KavnMvfn9MON88Z9UNGRPXgKAkg0zAIKqg8lgOzxqth+Evp0EG0VSJfT1LbyN900SJehdFRrCmXQiVfIl+qC0T5Ygj5k4bz+v2m/dr9SHetNVZk1s+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name; spf=pass smtp.mailfrom=kitenet.net; dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b=i5+YfEEU; arc=none smtp.client-ip=66.228.36.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joeyh.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitenet.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joeyh.name header.i=@joeyh.name header.b="i5+YfEEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=joeyh.name; s=mail;
	t=1716862435; bh=ykv+scU8uUpleCRou1fYFLBgDLqxqGsqf3cg2MI51o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5+YfEEUpnxmj8ry4XZlKrNCFBg6a6ZkDcix7yuMDTzxDs+nK/w0NvXtAT/fbcePU
	 Uk9uY4JCFeZfPETDlTbNACbNR5eTmFx/ld7PfFH5XJoxcBTO4PpuLJNQJJImHBEmGj
	 7eE6gW00BKQh59aTrhcJCOpUBzaxhMAT8a/WfHvk=
X-Question: 42
Date: Mon, 27 May 2024 22:13:55 -0400
From: Joey Hess <id@joeyh.name>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Message-ID: <ZlU94wcstaAHv_HZ@kitenet.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
 <0f7597aa-6697-9a70-0405-3dcbb9649d68@gmx.de>
 <ZkO-b6Nswrn9H7Ed@tapette.crustytoothpaste.net>
 <Zk2_mJpE7tJgqxSp@kitenet.net>
 <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HK9WlZtkSaT6Ey5w"
Content-Disposition: inline
In-Reply-To: <fbb89826-0d83-d4f9-bab4-9fba69e0e22d@gmx.de>


--HK9WlZtkSaT6Ey5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> > More than one major project; they also broke git-annex in the case where
> > a git-annex repository, which contains symlinks into
> > .git/annex/objects/, is pushed to a bare repository with
> > receive.fsckObjects set. (Gitlab is currently affected[1].)
>=20
> This added fsck functionality was specifically marked as `WARN` instead of
> `ERROR`, though. So it should not have failed.

A git push into a bare repository with receive.fsckobjects =3D true fails:

joey@darkstar:~/tmp/bench/bar.git>git config --list |grep fsck
receive.fsckobjects=3Dtrue
joey@darkstar:~/tmp/bench/bar.git>cd ..
joey@darkstar:~/tmp/bench>cd foo
joey@darkstar:~/tmp/bench/foo>git push ../bar.git master
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 12 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 324 bytes | 324.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
remote: error: object ea461949b973a70f2163bb501b9d74652bde9e30: symlinkPoin=
tsToGitDir: symlink target points to git dir
remote: fatal: fsck error in pack objects
error: remote unpack failed: unpack-objects abnormal exit
To ../bar.git
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to '../bar.git'

So I guess that the WARN doesn't work like you expected it to in this case =
of
receive.fsckobjects checking.

> > This means that symlinks to eg "git~1" are also warned about,
> > which seems strange behavior on eg Linux.
>=20
> Only until you realize that there are many cross-platform projects, and
> that Windows Subsystem for Linux is a thing.

I realize that of course, but I also reserve the right to make git repos th=
at
contain files named eg "CON" if I want to. Git should not demand
filename interoperability with arbitrary OSes.

> > +                               backslash =3D memchr(p, '\\', slash - p=
);
> >
> > This and other backslash handling code for some reason is also run on
> > linux, so a symlink to eg "ummmm\\git~1" is also warned about.
>=20
> Right. As far as I can tell, there are very few Linux-only projects left,
> so this is in line with many (most?) projects being cross-platform.

We may have very different lived experiences then.

--=20
see shy jo

--HK9WlZtkSaT6Ey5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmZVPeMACgkQ2xLbD/Bf
jzjorxAAnV6TFaEKYgpJKF2McqMD2/6fiTdpZa7809ukudBRk8KbQ5Z5FIHcoJWB
tWmW91m1UObvNesnx5gRybDzU5J5gzSUDrXSMHQWN9lN6cqlmuIHhMUMec2r1W/G
ZKVyKNBlWRT6UCGiYsdkg+jAhvGEdQGxDWntcHxZWJVs1ctzrejNFNDn30sELq8G
ltTkIA2EjuH5QIGIjuQrumF8ySYQuaJcCqrGMeQLjEWo1+HKJP5s469Gj6rRzty6
ugiQkSlIIHm+xDneOyPKTBDe8o7mziJIiwZi5un1pGEGvTexjJx62+FspSr2ji+V
bZ9x13lI8eNDHpr7Szz7UZuxVsmWSQBKrJP2qCmdbD4am04Uf85ErOzwC6b/9Yks
r3+LCjns+Fi7Zk6a1oKCghy1hIbousXvdQXzPUUOP/fWotMKNi4qag0HFfKhDf+j
Qxum38W4Bv5r89ZZ8T3UvnRAc4EuPyjb2X2yDJXImLyoaAz7bkY6NGCgMl4mJFFc
2yuCkkLFg9XhifFIbhtNMbG36bfyxKZ5QZoSRo8ImFjENqo2WN7T8N1hN9ySZPYn
CNp7nF4XUFx23xyAh2lwnPApct00jfN4xDEfb/izpkG2Mu2JRVCTS/dJthAubMMv
64ltl3ysMFkbIYCfKyW+2+LZAGea/Z+zztSeZIlwXWnrPdPvPKg=
=YqDH
-----END PGP SIGNATURE-----

--HK9WlZtkSaT6Ey5w--

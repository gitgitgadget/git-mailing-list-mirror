Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF910E4
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404932; cv=none; b=I4V13nMPCgd8Peh3A4hbi0a64rNah6tSIdOBfIlUBkZxkoFEk7UUpQvMrhtV8jE18UxecJV/LU/hkPFD6z3lk5TAwOUfBGHNCYChoup323Gf8Iu9dQI/MVdsb1TDz16iQiCzoBnVp05zKHzt0wJmHneHZYFi027mFzw0OUVawv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404932; c=relaxed/simple;
	bh=vlD/NwPs971qwbFP10HC4rCa40Q6AKjJ/7TZtCbMWlE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EvbTIs2l6MeizZzDBvSYKnp3d1CFOXXHbWlfURzhvsPj8riQkrP26m5QIIv7UqLwTW+bVLpZaLnbdUStQqmbskqP1HkS/RcvtWddAyxfFDIG8swWo4R5FZrVCcIsnnrlFEkIwstqYb3rLLeO48d0Wvu5DGjLjGTocQIigt5qqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gwsXTjY5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gwsXTjY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739404921;
	bh=vlD/NwPs971qwbFP10HC4rCa40Q6AKjJ/7TZtCbMWlE=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=gwsXTjY5mPK9LnB5J1j1pnIhK1fMsyjSG57Onrsf+Eb2Yr48dXLn9ZfzG/tid9mz3
	 +mjnnUOFNAHAsACdYvMey60zC8OBWQKQ4l8T5ju2kb0ub6ZoGhmRfmy3LG52e167Jm
	 qnL+9aoQQvbPtQmmxm3KWploKvakFJ7MRhiPIXxpLsbt02kNgBFGEgVGwErqkZZZ1l
	 qRSn0pwPk0FcmFMtJBaXDjcm0UfqxovJyG4m9lS3MK3nkIvsYjaYAu9pOJmyXNorzf
	 +kPWfbGC6MtGvBbQA7x1x0EWsVldJq5ZI8aPu9JX2CHu+5IA9ggaJPW7FBFYSYEKgW
	 6j1kLd88FBEJSC5ZrAN++LAUmRIAqDZqe8QHXx66RUBuYC/udij/xVmVjNEi1HuQYV
	 oKFRXumfJOYedCJoCBaG4F3RFobtcK+3L1vOj/Kq3H7TfjhF8r2+2IlNa4Dat2vjgC
	 QPA2S4eXAvYkt6D4G3w3aoCUsoI1IC/FOGFlZdF8zlD/SKPKqm4
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 56D3220076;
	Thu, 13 Feb 2025 00:02:01 +0000 (UTC)
Date: Thu, 13 Feb 2025 00:01:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Poor performance using reftable with many refs
Message-ID: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yO53n4mgNlTvRCZA"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--yO53n4mgNlTvRCZA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been doing some testing of reftable at $DAYJOB and I found an
interesting performance problem when creating many refs.

I've attached a script which takes 50,000 recent commits, creates a file
suitable for `git update-ref --stdin`, deletes all of the existing refs,
and then uses that file to create the 50,000 refs.  The ref creation is
timed using Linux's `/usr/bin/time`.  (This is partially extracted from
a larger script, so please accept my apologies for some untidiness.)

With the files backend, the output is as below:

  1.75user 3.73system 0:05.50elapsed 99%CPU (0avgtext+0avgdata 166344maxres=
ident)k
  0inputs+442880outputs (0major+27962minor)pagefaults 0swaps

With the reftable backend, this is the output:

  56.91user 0.52system 0:57.44elapsed 99%CPU (0avgtext+0avgdata 160416maxre=
sident)k
  0inputs+6784outputs (0major+26151minor)pagefaults 0swaps

Both measurements are on next, so they should have all relevant patches
that I'm aware of.  I've tested on two X1 Carbons, one with Ubuntu 24.04
and one with Debian unstable, so they're both reasonably beefy machines
with modern Linux OSes.

It takes about 30 times as long to perform using the reftable backend,
which is concerning.  While this is a synthetic measurement, I had
intended to use it to determine the performance characteristics of
the reference update portion when pushing a large repository for the
first time.

I admit I haven't done any other particular investigation as to what's
going wrong here, but the behaviour is very noticeable so it may be easy
to profile.

One note: the script will be faster and more useful to reproduce if you
change the repository source to a local clone of the Linux repo.

----
#!/bin/sh -e
# This script will reproduce a performance problem with many (50000) refs u=
sing
# the current version of reftable in next.  The directory `testcase` under =
the
# current directory will be removed and replaced.
#
# Once the script is finished, you can do `cat testcase/tracedir/*/re-creat=
ion`
# to see the performance characteristics of the files backend (first) and t=
he
# reftable backend (second).

# Your friendly neighbourhood Linux repository.  This may be any valid remo=
te,
# including an HTTPS or SSH URL.
REPO_SRC=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git"
TAG=3D"v6.13"

export GIT_CONFIG_GLOBAL=3D/dev/null

timed_op () {
  local output=3D"$1"
  local message=3D"$2"
  shift
  shift
  printf '%s...' "$message" >&2
  /usr/bin/time -o "$TRACEDIR/$output" "$@"
  printf 'done.\n' >&2
}

delete_refs () {
  local output=3D"$1"
  (
    echo "start"
    git for-each-ref --format=3D"%(refname)" | sed -e 's/^/delete /'
    echo "prepare"
    echo "commit"
  ) | timed_op "$output" "Deleting all references" git update-ref --stdin
}

fake_refs=3Dtrue
while [ $# -gt 0 ]
do
  case "$1" in
    --real-refs)
      fake_refs=3Dfalse
      shift
      ;;
    *)
      break
      ;;
  esac
done

rm -fr testcase
mkdir testcase
cd testcase
git clone --bare "$REPO_SRC" repo

mkdir tracedir

for backend in files reftable
do
  git clone --bare repo $backend
  (
    set -e
    cd $backend
    TRACEDIR=3D"$(realpath "../tracedir/$backend")"
    mkdir -p "$TRACEDIR"

    if [ "$backend" =3D reftable ]
    then
      timed_op "migration" "Migrating to reftable" git refs migrate --ref-f=
ormat=3Dreftable
    fi

    if $fake_refs
    then
      git rev-list "$TAG" | head -n 50000 | perl -pe '
        $count++;
        $choice =3D $count % 4;
        if ($choice =3D=3D 0) {
          s!^(.*)$!create refs/heads/ref-$count $1!;
        } elsif ($choice =3D=3D 1) {
          s!^(.*)$!create refs/remotes/bk2204/ref-$count $1!;
        } elsif ($choice =3D=3D 2) {
          s!^(.*)$!create refs/remotes/origin/ref-$count $1!;
        } elsif ($choice =3D=3D 3) {
          s!^(.*)$!create refs/tags/tag-$count $1!;
        }
      ' | sort >all-refs
    else
      git for-each-ref --format=3D"%(refname) %(objectname)" | sed -e 's/^/=
create /' >all-refs
    fi
    delete_refs "deletion"
    timed_op "re-creation" "Re-creating refs" git update-ref --stdin <all-r=
efs
  )
done
----
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--yO53n4mgNlTvRCZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ602dwAKCRB8DEliiIei
gYzoAQCOU4own09McAYLjePtoz1OHZ5mzMLoWkpCwksUikvLBAD/aYe2JGL3WCjZ
Mu0HjdR/r0UTdUXs6Z4jLkYx6Q1v2wc=
=5ebC
-----END PGP SIGNATURE-----

--yO53n4mgNlTvRCZA--

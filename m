Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB219186A
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Received: from localhost (unknown [185.22.237.37])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by redcrew.org (Postfix) with ESMTPSA id 99D0069
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 17:24:54 +0100 (CET)
Content-Type: multipart/signed;
 boundary=512d1ab57d4d8e1811b4147751d8801b7e80152def1a8e8083a4e57aa6f3;
 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 15 Jan 2024 17:24:54 +0100
Message-Id: <CYFF4ELXFAXS.3RLW2GBX2DZFN@cepl.eu>
Subject: git-request-get ?
From: =?utf-8?q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.16.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

--512d1ab57d4d8e1811b4147751d8801b7e80152def1a8e8083a4e57aa6f3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hello,

I am still haunted by my own ancient comment on
https://gitlab.com/gitlab-org/gitlab/-/issues/14116:

> Well, the minimal solution [to federated merge requests]
> would be a parser for the git-request-pull(1), which would
> check every comment and if recognized the comment as the
> pull request, it would add button for the owner of the repo
> (e.g., [Create Pull Request]). After pressing that (so it is
> constantly under the control of the owner repo), gitlab would
> setup new remote (if doesn't exist still), fetch it, and create
> a merge request.

Of course, the part with a button has to be resolved in a
particular web application, but I am still wondering whether
there isn=E2=80=99t any way how to make consuming git-request-pull(1)
generated emails more easily digestable and thus promote the use
of the tool.

First I created rather complicated bash script
(https://da.gd/pSgdc), but then I have read CodingGuidelines and
found that I need to keep myself to the POSIX shell script, so
I have simplified a lot. Besides, I don=E2=80=99t think the complicated
part (like adding remotes) is necessarily a good thing (???).
Currently I have just this:

    #!/bin/sh
    set -eu

    STR=3D"$(cat)"

    URL=3D"$(echo "$STR" | sed -n -e '/^are available in the Git repository=
 at:/,+2 {
    s/[[:space:]]\+//
    s/\(=3D[[:digit:]]\{2\}\)\+$//
    /^\(http\|git\)/p
    }')"

    END=3D"$(echo "$STR" | awk '/^for you to fetch changes up to / { print =
$NF }' | sed -e 's/[=3D:]*$//')"
    git fetch "$URL" "$END"
    git checkout -B _4review FETCH_HEAD

Do you think this is a good idea at all? Should we be more
complicated or less? Should we do some fun things like parsing
and adding remotes, parsing email addresses or something to
create individualized branch names for review? Stuff like that.

Looking forward to any feedback.

Best,

Mat=C4=9Bj

--=20
http://matej.ceplovi.cz/blog/, @mcepl@floss.social
GPG Finger: 3C76 A027 CA45 AD70 98B5  BC1D 7920 5802 880B C9D8
=20
Those to whom evil is done \ Do evil in return.
    -- W. H. Auden, September 1, 1939
       http://www.poets.org/viewmedia.php/prmMID/15545


--512d1ab57d4d8e1811b4147751d8801b7e80152def1a8e8083a4e57aa6f3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGwEABECACwWIQSJ70vGKIq/QxurJcPgn+8l2WSErAUCZaVcVg4cbWNlcGxAY2Vw
bC5ldQAKCRDgn+8l2WSErPx4AJ4otqpl82HBcYJHQxZhc++2B11nmgCfTlRUKlor
pGDoXP+EWBBtemJhFXI=
=MqJh
-----END PGP SIGNATURE-----

--512d1ab57d4d8e1811b4147751d8801b7e80152def1a8e8083a4e57aa6f3--

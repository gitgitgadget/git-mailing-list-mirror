Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B52500BD
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492079; cv=none; b=JOFrFdrty6JqUfUkGIjG22sC60Y7xULYYpTLogF/njuCBrWU0cB4PuiH07xPQ2raDcxH3QCtjUcydL8ahcxXwHfu8Qx7IkFpCHL8D/7nnDKbXeEtPgA/H7czhs2oly39rflAG21osDlLdkoc1UEMTpCteA3VKIqdtVivp+4Kutc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492079; c=relaxed/simple;
	bh=mHiy70wKc1GCjBfMtn4kUYf5W4RTl8O/ussDyskU2ps=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=tlCzD1ncjQtwXi/QYyOprUwoqKeZPvE6AFNMMdIB868V2GXNIZIr8GgedNQW7QOl+lfCEFRSQ6Nmry001F/FzZCaQmqggNWC8gKaRgGMGupHqqtohgt3SdDj3kuasbR6v7jQQykZuCaig3ZrX6z0SDOHSG1P4So4RCl+CiF8ams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M79giFiE; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M79giFiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732492069; x=1732751269;
	bh=mHiy70wKc1GCjBfMtn4kUYf5W4RTl8O/ussDyskU2ps=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=M79giFiEhgbCAao+utxfwT7msRpcH3MZEM3k+1uOMrEg03teoQ8PvpbnEtxNFiazE
	 DEfcGWZgVFmGVJNCSJojDrTiqTbbLOZuZ0Oi7RDrAv5OtY2ItDO2QWlzfveNcmfYvg
	 CvVLiL49pgfZu1VUM5EeWtfiqZxbyu8zqtT66TG8xTNseoASoYfz3FngueogtdwxWZ
	 qccT4RXhFgsOJ5k1QbMiLE7kSjLFz8qSkKCNgC4b7x11XeKUykf0WO4zzhf3synN6p
	 4tCm+zPT+PFsbChazaVdTE1xbeXggD5+B+Acx7lIJLd/71Hd/atdLCHtygajy0beOE
	 ZdHaTkt8b64fg==
Date: Sun, 24 Nov 2024 23:47:43 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [bug] user may be cornered into delete files #9901
Message-ID: <S5PSH8NN2iTlSlWbEi3lixncKj_ShJU5Cpvselj_d-WnTJvq8YCT65k1VR7dB8m0FRTj0nyQ-eXx6W8LlSeN0OnzoK8KxCkCP3OK46LRN8w=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 64c2075e546bb599f17970b6b755861e9d413194
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_CERFqSiZ26LuHlO7GdkXh7FIi6jbD66cArcl5dO5ODY"

--b1=_CERFqSiZ26LuHlO7GdkXh7FIi6jbD66cArcl5dO5ODY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



NEEDS TESTING [bug] user may be cornered into delete files #9901

Look wheather you call it a "landmine" or "bug" this is a defect in the sof=
tware application git.

The defect is: user may be cornered into having to delete files.

Steps to reproduce: if for any reason the push fails during the intial crea=
tion and upload of files to a git repository then the user is left with thr=
ee options reset modes soft, mixed, and hard. Because GitHub hangs up durin=
g the compression of many files being pushed these files must be pushed 1 b=
y 1. If the user wants to repush the files the user must be able to undo th=
e tracked files and repush them 1 by 1. Hard is immediatly excluded because=
 it deletes files. Mixed likely deletes files also because it wipes the ind=
ex of the CWD after the files have been 'add'. While soft may not delete th=
e files it would not wipe the index, the index is needed to be wiped to all=
ow for the files to be re add, commit, and pushed.=20

I am working from an android so it is hard to setup computer lab tests. Som=
ebody should be able to setup experimental git repos to reproduce and CONFI=
RM the bug. You will be looking to CONFIRM that neither modes soft or mixed=
 will allow the user to undo tracked files for repush.=20

What I did was copy the files out to be safe and a soft reset and I workaro=
und the problem but the user should not need to copy anf make backups of fi=
les because this is the intended afvantage anf purpose of git. Because I di=
d a workaround the bugreport still need's to be tested and CONFIRMED.=20

from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdDuxwJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAFO6AP918fCRKPBij1LgVOttJepAslX9VqSfrhjT3VnygJAfpgEA34dE
IWoJx9beK7zLk6NlDc+0iU7DEXcaSxK86atsXAQ=3D
=3Du2Tz
-----END PGP SIGNATURE-----

--b1=_CERFqSiZ26LuHlO7GdkXh7FIi6jbD66cArcl5dO5ODY
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_CERFqSiZ26LuHlO7GdkXh7FIi6jbD66cArcl5dO5ODY
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdDuxwJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAKB4AQD2r002
yN60pskJld6zKctVvteKqFt6Gkq5gAvcacEFrQD9FW8wJLuWLkSm+xydZqouG/7R+JBc35xkTW6A
8iFoWgA=

--b1=_CERFqSiZ26LuHlO7GdkXh7FIi6jbD66cArcl5dO5ODY--


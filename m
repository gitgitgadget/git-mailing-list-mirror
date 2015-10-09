From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] filter-branch: remove multi-line headers in msg filter
Date: Fri, 9 Oct 2015 09:07:24 +0200
Message-ID: <561767AC.6060503@drmicha.warpmail.net>
References: <20151009002113.GA329@freya.jamessan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: James McCoy <vega.james@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 09:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkRm9-0003rC-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 09:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbbJIHH2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2015 03:07:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57591 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750701AbbJIHH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2015 03:07:27 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 8FD80202EC
	for <git@vger.kernel.org>; Fri,  9 Oct 2015 03:07:26 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 09 Oct 2015 03:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=3tlUel+tMCxsUHVYKtqn6ShNcSc=; b=Hs1bOG
	ypOM5eRDZy20s0srNSwRAO2V0bsxnLz4keX7EHEp5G6fDVkQxyo9O9YI0nULh4of
	zumB8FfzSd5bEIeNE7fu8BHGLnwsp+vRl6HOeJESdCGvCGa/JKuDXaLodt5BF8e2
	YHtgz2jWkTrq7hvQ53CwokikFAgZlw0wXBdSc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3tlUel+tMCxsUHV
	YKtqn6ShNcSc=; b=iGZajKsc/nB7DjS+jKYzwXhJFrv+uRwAtE/SnRyR4GRsHxS
	enfcUCfzboT/+acQLWia9aGm6RhfZXPXFI4c8Zk0AX34Mv0D+1OFOGH11cGHD5Dx
	CoG5XIE/Lx4kZAKhiBPLEdp/Zc8+PD2u7eGzNi2g4NeNoKHZioc5buTqCB4g=
X-Sasl-enc: +pAUc6Dk+KeMuHRNqE/joPnRr3uc/REeBAN1bswxsYZG 1444374446
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F1D55C00019;
	Fri,  9 Oct 2015 03:07:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151009002113.GA329@freya.jamessan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279302>

James McCoy venit, vidit, dixit 09.10.2015 02:21:
> df062010 (filter-branch: avoid passing commit message through sed)
> introduced a regression when filtering commits with multi-line header=
s,
> if the header contains a blank line.  An example of this is a gpg-sig=
ned
> commit:
>=20
>   $ git cat-file commit signed-commit
>   tree 3d4038e029712da9fc59a72afbfcc90418451630
>   parent 110eac945dc1713b27bdf49e74e5805db66971f0
>   author A U Thor <author@example.com> 1112912413 -0700
>   committer C O Mitter <committer@example.com> 1112912413 -0700
>   gpgsig -----BEGIN PGP SIGNATURE-----
>    Version: GnuPG v1
>=20
>    iEYEABECAAYFAlYXADwACgkQE7b1Hs3eQw23CACgldB/InRyDgQwyiFyMMm3zFpj
>    pUsAnA+f3aMUsd9mNroloSmlOgL6jIMO
>    =3D0Hgm
>    -----END PGP SIGNATURE-----
>=20
>   Adding gpg
>=20
> As a consequence, "filter-branch --msg-filter cat" (which should leav=
e the
> commit message unchanged) spills the signature (after the internal bl=
ank
> line) into the original commit message.
>=20
> The reason is that although the signature is indented, making the lin=
e a
> whitespace only line, the =E2=80=9Cread=E2=80=9D call is splitting th=
e line based on
> the shell's IFS, which defaults to <space><tab><newline>.  The leadin=
g
> space is consumed and $header_line is empty, causing the =E2=80=9Cski=
p header
> lines=E2=80=9D loop to exit.
>=20
> The rest of the commit object is then re-used as the rewritten commit
> message, causing the new message to include the signature of the
> original commit.
>=20
> Set IFS to an empty string for the =E2=80=9Cread=E2=80=9D call, thus =
disabling the word
> splitting, which causes $header_line to be set to the non-empty value=
 '
> '.  This allows the loop to fully consume the header lines before
> emitting the original, intact commit message.
>=20
> Signed-off-by: James McCoy <vega.james@gmail.com>
> ---

Thanks for hanging in :)

Reviewed-by: Michael J Gruber <git@drmicha.warpmail.net>

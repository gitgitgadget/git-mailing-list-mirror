From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 19:31:16 -0400
Message-ID: <201009151931.23482.ComputerDruid@gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14463090.vnp1Tmei22";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1Qk-0004xN-UO
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab0IOXaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:30:12 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42940 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0IOXaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:30:10 -0400
Received: by qyk33 with SMTP id 33so694315qyk.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LDPidh739Nw3dsZK056YoUkBlLm5lI7JnioxNQwkrBs=;
        b=fLd6aYVMXtjZPQk9Zw3892SmKar2a2ym5lhfhskhgh4bkxFOVi8oXgHzG23tcbGh8M
         CRFQJcdUKT3PQmszkGpl0aeAPK43sH6kv8n8nBQ3pGJTJDOoUJn1dyCxIeRPvydNA4lw
         uGNiKsdN6UPreAL+wtnlaaQ/pj/7ycjKns6zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=p4+6UweNO332hP/E2dQ3D1ydPkc9QkOc62BALQQwfZqJOBMt64epmwHw0mqOJZI0sd
         iBEHE9WjKoNW4DM7Z1XQMVSO6YvdBzbZteXn4++A4z2vQrskMwmtoKXwGB4WEmFkJnSV
         ++vLKWE2MoBwMQjcJVbRJdWhoU4E74tZqT75I=
Received: by 10.224.10.211 with SMTP id q19mr1550669qaq.394.1284593409571;
        Wed, 15 Sep 2010 16:30:09 -0700 (PDT)
Received: from hyperion.localnet ([129.21.115.212])
        by mx.google.com with ESMTPS id r1sm1939598qcq.22.2010.09.15.16.30.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Sep 2010 16:30:08 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35.3; KDE/4.5.0; x86_64; ; )
In-Reply-To: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156275>

--nextPart14463090.vnp1Tmei22
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 15 September 2010 18:40:20 Jay Soffian wrote:
> Am I missing something really obvious here?
> kore:~/Repos/git (master)$ git ls-files | wc -l
>     2009
> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
>     2009
> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
>     2009
> kore:~/Repos/git (master)$ git version
> git version 1.7.3.rc1.5.g95127

=46or fun, I bisected this. This behavior changed in the following commit.=
=20
Before this, it worked as you expected. The other replies seem to explain t=
his=20
more.

b5227d80aee5173bfda6aa43a890d03110b0df26 is the first bad commit
commit b5227d80aee5173bfda6aa43a890d03110b0df26
Author: Jeff King <peff@peff.net>
Date:   Mon Oct 12 01:11:57 2009 -0400

    ls-files: excludes should not impact tracked files
   =20
    In all parts of git, .gitignore and other exclude files
    impact only how we treat untracked files; they should have
    no effect on files listed in the index.
   =20
    This behavior was originally implemented very early on in
    9ff768e, but only for --exclude-from. Later, commit 63d285c
    accidentally caused us to trigger the behavior for
    --exclude-per-directory.
   =20
    This patch totally ignores excludes for files found in the
    index. This means we are reversing the original intent of
    9ff768e, while at the same time fixing the accidental
    behavior of 63d285c. This is a good thing, though, as the
    way that 9ff768e behaved does not really make sense with the
    way exclusions are used in modern git.
   =20
    Signed-off-by: Jeff King <peff@peff.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

--nextPart14463090.vnp1Tmei22
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyRV0sACgkQhP2Vm0oJTtxy6QCZAdIv2wK1zzz3iNRizARffl5G
KlIAn39KOhTuPsJFdGtDLb1wPoDZQzGD
=4lUb
-----END PGP SIGNATURE-----

--nextPart14463090.vnp1Tmei22--

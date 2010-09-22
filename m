From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Wed, 22 Sep 2010 00:12:30 +0000
Message-ID: <AANLkTi=zSPegcPNY8jr4S5qeXWHrxuC+0SY-h5EhyA+6@mail.gmail.com>
References: <20100921205914.GA1166@sigill.intra.peff.net>
	<20100921211303.GB1188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 02:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyCwz-0004wa-H8
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab0IVAMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 20:12:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48988 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab0IVAMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 20:12:31 -0400
Received: by iwn5 with SMTP id 5so5553918iwn.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e34NnKkZ5wg1fLyhBTPA1QR+5sPbspzJf6nmV/DZtfc=;
        b=bIh3GAqKtndipzmTRFPuujaNlytgcpeMdayRVOEHGdQxM8lWwjW4/KrsXhsHx9dXy5
         MWE2B5y4ocvtyiZGP+0N3d2RZr+gxMb4LdYYshs3mUOyF4j0dVuzQC+o+Dfnnqyly6H5
         BTEHpVld0trN/dyVMbb6MosW4G4YuHM8+aTXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KgIHMziTGj37d8XNUpgDcEf3cz8+7wOL+53dLJ1mgDcygqk6g3xiKKKcqeLxeqvZfb
         GyAKAK/IPvQm+w6/srJwv6ynLCNLIVym2KPsGoWeiJD4pA9W0Mn/73k/r2zoqkXCip/y
         +u6X6mp8MNXh/mrSEdDsUYhlAOlrMC/97b0fQ=
Received: by 10.231.183.200 with SMTP id ch8mr12780372ibb.124.1285114350426;
 Tue, 21 Sep 2010 17:12:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 21 Sep 2010 17:12:30 -0700 (PDT)
In-Reply-To: <20100921211303.GB1188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156771>

2010/9/21 Jeff King <peff@peff.net>:
> +However, it may happen that you do want to change the diff parameter=
s
> +specifically for symlinks. You can do that by configuring the specia=
l
> +"SYMLINK" diff driver. For example, to add a newline to the end of
> +the symlink contents (and suppress the usual "no newline at end of f=
ile"
> +warning), you could configure:
> +
> +-----------------------------
> +[diff "SYMLINK"]
> + =C2=A0 =C2=A0 =C2=A0 textconv =3D perl -pe 's/$/\n/'
> +-----------------------------

That'll turn every \n in the stream into \n\n, not add a newline to
the end of the file. Don't you mean:

    perl -0666 -pe 's/$/\n/'

Or, more efficiently:

    perl -ple 'END { print }'

?

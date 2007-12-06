From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: fetch_refs_via_pack() discards status?
Date: Wed, 5 Dec 2007 22:38:35 -0200
Message-ID: <b8bf37780712051638x5a2ea5d4i61631f31af65cb54@mail.gmail.com>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
	 <20071122160959.GA3411@steel.home>
	 <b8bf37780711221427q5dda709dt38ce1837c0e56c1f@mail.gmail.com>
	 <b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
	 <7v3aunqvha.fsf_-_@gitster.siamese.dyndns.org>
	 <7vk5nt1v7k.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0712051356040.5349@iabervon.org>
	 <7vwsrsonqm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 01:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J04lW-0006Vm-5T
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 01:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbXLFAii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbXLFAii
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 19:38:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:62043 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXLFAih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 19:38:37 -0500
Received: by nf-out-0910.google.com with SMTP id g13so11547nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9RBuCO4+zZrTd2/SPE+L41dY5s3CmI2UO7eT86ND+DE=;
        b=TWY9ilCcOkOyHHuHvICqtLiNo/UKMaRdQOpZWNSOfWKMELigB7/qxETO1eipvnRk0t3kPMaNZ+yBA8iZ65ZwTN8dIZEbXATirwpBWgyphFc+HKuLioDBHHZgRrkYAO7W2fVubpWZEiqHsXQTH6bOCOwLSUXi6lFn9tV0/Ur/OQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p8GCANPygfRLt1s0uPKuRndng3Y5g4Fiag0JaYC5REPJyvuNo4GB2dVHy/OuEXRyhdPkX8ZU7RXHCyGXwanTwGN/P3xu0bAcMG3r8IovPf8qhvMQ5f12s2UBgjq68c+Aa7Ne8Sbs2MkXLdWKcoU9rpjWMZGu2ZieybcQZetsPv0=
Received: by 10.78.136.9 with SMTP id j9mr1558661hud.1196901515623;
        Wed, 05 Dec 2007 16:38:35 -0800 (PST)
Received: by 10.78.100.6 with HTTP; Wed, 5 Dec 2007 16:38:35 -0800 (PST)
In-Reply-To: <7vwsrsonqm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67215>

On Dec 5, 2007 7:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>
> > On Tue, 4 Dec 2007, Junio C Hamano wrote:
> >
> >> The code calls fetch_pack() to get the list of refs it fetched, an=
d
> >> discards refs and always returns 0 to signal success.
> >>
> >> But builtin-fetch-pack.c::fetch_pack() has error cases.  The funct=
ion
> >> returns NULL if error is detected (shallow-support side seems to c=
hoose
> >> to die but I suspect that is easily fixable to error out as well).
> >>
> >> Shouldn't fetch_refs_via_pack() propagate that error to the caller=
?
> >
> > I think that's right. I think I got as far as having the error stat=
us from
> > fetch_pack() actually returned correctly, and then failed to look a=
t it.
> > I'd personally avoid testing a pointer to freed memory, but that's
> > obviously not actually wrong.
> >
> >       -Daniel
>
> Hmph, is that an Ack that the patchlet is actually a bugfix?
>

Hi, Mr. Junio!

     My 2 cents: I think he means that we should not test a freed point=
er:

       free_refs(refs);
       free(dest);                     <=3D=3D=3D
-       return 0;
+       return (refs ? 0 : -1);     <=3D=3D=3D

Best regards,
--=20
[]s,
Andr=E9 Goddard

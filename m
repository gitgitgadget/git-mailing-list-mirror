Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B0C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 06:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjBJGRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 01:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBJGRD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 01:17:03 -0500
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74936087
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 22:16:56 -0800 (PST)
Received: from tilde.club (tor-exit-35.for-privacy.net [185.220.101.35])
        by tilde.club (Postfix) with ESMTPSA id 668EB220C8162;
        Fri, 10 Feb 2023 06:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 668EB220C8162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1676009812; bh=qWJefq3rcaoqKwy7e1mxE+EmDvCqbJ5Mvi2VuuZmpiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4bTy4+cCPDji+zuBUxV+5glOQmLa2xP0xmUekb+p0E6V/4RlAB9DDg2SCNwFBO97
         elK2mr/i6h0TnGYDv/JTCJ8FPEIjTOfnGW0TCcPGP8LoVsmZRZBOBSkmi0aND6j4ob
         pSebwXtybEZAdRSERJMGsMYXRinGUiI15zvvteXQ=
Date:   Fri, 10 Feb 2023 06:16:39 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: Note SSH and X.509 signature
 delimiters
Message-ID: <Y+XhPeh76D6/Uz6C@tilde.club>
References: <20220120053223.221667-1-gwymor@tilde.club>
 <xmqq7daui4s8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7daui4s8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-01-20 11:30:15-0800, Junio C Hamano wrote:
> Gwyneth Morgan <gwymor@tilde.club> writes:
> > This document only explained PGP signatures, but Git now supports X.509
> > and SSH signatures.
> 
> This is technically incorrect as the original text does talk about
> MESSAGE that is used by X.509.
> 
> But the change does make it more clear to help readers not to make
> the same mistake as the above sentence.  In 3-item enumeration, it
> is very clear what we now support ;-)

I believe the existing language is referring to the
"-----BEGIN PGP MESSAGE-----" format GPG outputs in RFC 1991 mode,
rather than the "-----BEGIN SIGNED MESSAGE-----" that X.509 uses.

> > diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
> > index 166721be6f..c148d4c750 100644
> > --- a/Documentation/technical/signature-format.txt
> > +++ b/Documentation/technical/signature-format.txt
> > @@ -9,9 +9,22 @@ is about to create an object or transaction determines a payload from that,
> >  calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
> >  embeds the signature into the object or transaction.
> >  
> > -Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
> > -and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
> > -produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
> > +Signatures always begin and end with a delimiter, which differs
> 
> The term "signature delimiter" is understandable, but is that the
> term used by the users and the developers of OpenPGP, X.509 and SSH
> who know and use such an ascii-armored signatures?  Just making sure
> we do not accidentally "invent" a new word that the upstream/wider
> community has an established word for.
> 
> 	... Goes and looks ...
> 	https://www.rfc-editor.org/rfc/rfc4880.html#section-7
> 	seems to use "Armor Header and Armor Tail Lines" to refer to
> 	the BEGIN and the END delimiter lines, respectively.
> 
> Other than that, the patch looks good to me.

OpenSSH's signature format documentation says:


	The Armored SSH signatures consist of a header, a base64
	encoded blob, and a footer.

	The header is the string "-----BEGIN SSH SIGNATURE-----"
	followed by a newline. The footer is the string
	"-----END SSH SIGNATURE-----" immediately after a newline.
(https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/PROTOCOL.sshsig?rev=1.4&content-type=text/x-cvsweb-markup)

This is sufficiently similar to the nomenclature in RFC 4880 to call
these "Armor Header Line and Tail Line" without any misunderstanding (or
"footer line" if that's preferred). I did not find documentation on what
X.509 calls these.

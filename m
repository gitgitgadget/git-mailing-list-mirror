From: KellerFuchs <KellerFuchs@hashbang.sh>
Subject: Re: [PATCH] Documentation: clarify signature verification
Date: Mon, 11 Apr 2016 00:32:42 +0000
Message-ID: <20160411003242.GC9034@hashbang.sh>
References: <20160409200756.GA22694@hashbang.sh>
 <xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 02:33:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apPmy-0000dk-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 02:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbcDKAdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2016 20:33:06 -0400
Received: from mail.hashbang.sh ([104.236.230.244]:37514 "EHLO
	mail.hashbang.sh" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcDKAdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 20:33:05 -0400
Received: from to1.hashbang.sh (to1.hashbang.sh [104.245.37.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hashbang.sh (Postfix) with ESMTPS id 00B9139DE;
	Mon, 11 Apr 2016 00:33:02 +0000 (UTC)
Received: by to1.hashbang.sh (Postfix, from userid 3412)
	id 77AF2E00BA; Mon, 11 Apr 2016 00:32:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291197>

On Sun, Apr 10, 2016 at 11:46:10AM -0700, Junio C Hamano wrote:
> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -89,8 +89,10 @@ option can be used to override --squash.
> > =20
> >  --verify-signatures::
> >  --no-verify-signatures::
> > -	Verify that the commits being merged have good and trusted GPG si=
gnatures
> > +	Verify that the commits being merged have good and valid GPG sign=
atures
> >  	and abort the merge in case they do not.
> > +	For instance, when running `git merge --verify-signature remote/b=
ranch`,
> > +	only the head commit on `remote/branch` needs to be signed.
>=20
> The first part of this change and all other changes are of dubious
> value, but the last two lines is truly an improvement--it adds
> missing information people who use the feature may care about.

The reason for the first edit is that =E2=80=9Ctrusted=E2=80=9D and =E2=
=80=9Cvalid=E2=80=9D are OpenPGP
  concepts: a key is trusted if the user set a trust level for it,
  and a uid is valid if it has been signed by a trusted key [0].

Most of my confusion came from this, since it sounded like the signatur=
e
  would only be accepted if it came from a key with a non-zero ownertru=
st.

[0] That actually only holds for the default trust model,
    so I'm oversimplifying a bit here.

> I'd suggest doing the addition of the last two lines as a standalone
> patch, and make the remainder a separate patch on top.

Sure, will do when submitting for inclusion.

> > diff --git a/Documentation/pretty-formats.txt b/Documentation/prett=
y-formats.txt
> > index 671cebd..29b19b9 100644
> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -143,8 +143,8 @@ ifndef::git-rev-list[]
> >  - '%N': commit notes
> >  endif::git-rev-list[]
> >  - '%GG': raw verification message from GPG for a signed commit
> > -- '%G?': show "G" for a Good signature, "B" for a Bad signature, "=
U" for a good,
> > -  untrusted signature and "N" for no signature
> > +- '%G?': show "G" for a good (valid) signature, "B" for a bad sign=
ature,
> > +  "U" for a good signature with unknown validity and "N" for no si=
gnature
>=20
> The reason I said the other changes are of dubious value is shown
> very well in this hunk.  I am not sure if it is an improvement to
> rephrase "Good" to "good (valid)" and "untrusted" to "good signature
> with unknown validity".  They are saying pretty much the same thing,
> no?

As said above, it was about consistency with the OpenPGP terminology.

If git wants to have it's own vocabulary for that (which I would argue
  against), then it would need to be defined somewhere.

> > diff --git a/Documentation/pretty-options.txt b/Documentation/prett=
y-options.txt
> > index 54b88b6..62cbae2 100644
> > --- a/Documentation/pretty-options.txt
> > +++ b/Documentation/pretty-options.txt
> > @@ -78,5 +78,5 @@ being displayed. Examples: "--notes=3Dfoo" will s=
how only notes from
> >  endif::git-rev-list[]
> > =20
> >  --show-signature::
> > -	Check the validity of a signed commit object by passing the signa=
ture
> > -	to `gpg --verify` and show the output.
> > +	Check the validity of a signed commit object, by passing the sign=
ature
> > +	to `gpg --verify`, and show the output.
>=20
> The update one may be gramattically correct, but I personally find
> the original easier to read.  Is there a reason for this change?

That one is arguably more dubious, and I would happily drop it.
=46or some reason, I kept parsing it as =E2=80=9CCheck the validity [..=
=2E] by
  (passing the signature to `gpg --verify` and showing the output)=E2=80=
=9D.


Best regards,

  kf

From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] git submodule purge
Date: Thu, 26 Mar 2015 14:30:52 +0100
Message-ID: <20150326133052.GA382@pks-pc.localdomain>
References: <20150316134407.GA31794@pks-tp.elego.de>
 <20150316200353.GB5186@google.com>
 <20150317075636.GA354@pks-pc>
 <5510866B.40501@web.de>
 <20150325090631.GA370@pks-pc.localdomain>
 <551310EF.8050700@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:31:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb7sq-0000t7-3F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 14:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbbCZNbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 09:31:35 -0400
Received: from sender1.zohomail.com ([74.201.84.155]:30476 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbbCZNbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 09:31:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=a1US6HSiV/GVw1dhtIl3j3mQHtk5sbnvRM+TwcNE3VaUNjZ17i3qIDK0eUM8+VmIlYdaBDfcDdYp
    jTMGv6QOovoIe2gj2mZ75tS3htWzPNGuuiLGh+MUk+ncHUHXJ7PBImNElSYTv2JoJzkSfa/m8VNt
    4xwG+fJTVK7fe9fVrEU=  
Received: from localhost (e179167002.adsl.alicedsl.de [85.179.167.2]) by mx.zohomail.com
	with SMTPS id 1427376689994433.25935097623756; Thu, 26 Mar 2015 06:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <551310EF.8050700@web.de>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266328>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 08:47:59PM +0100, Jens Lehmann wrote:
> Am 25.03.2015 um 10:06 schrieb Patrick Steinhardt:
> > On Mon, Mar 23, 2015 at 10:32:27PM +0100, Jens Lehmann wrote:
> >> Am 17.03.2015 um 08:56 schrieb Patrick Steinhardt:
[snip]
> >> Hmm, cmd_deinit() seems to cope with submodules removed by the
> >> user just fine (as long as they are still present in the index).
> >> To me it feels natural to extend deinit to remove the repo from
> >> .git/modules too when --purge is given (as long as no unpushed
> >> commits are present or -f is given).
> >>
> >>> `git gc` feels saner in that regard, but I don't think it would
> >>> be easy to spot for users as this command is in general not used
> >>> very frequently by them. One could argue though that it does not
> >>> need to be discoverable.
> >>
> >> The error message of "git submodule deinit --purge" for a
> >> submodule that isn't recorded in the index anymore could point
> >> the user to the appropriate gc command. But how do we tell gc
> >> which submodule it should purge? "--purge=3D<submodule-name>"
> >> maybe?
> >
> > This might work, but at least the option would need to provide a
> > hint to the user that it has something to do with submodules. So
> > if the feature was implemented by `git gc` I'd rather name the
> > parameter "--purge-submodule=3D<submodule-name>" which in my
> > opinion clearly states its intention, even though it is longer to
> > type. But with working bash-completion this should be non-issue,
> > especially as this command would not need to be run frequently.
>=20
> Agreed.
>=20
> > That said, I think by now I agree with the common (?) opinion
> > that the command is best placed in `git submodule deinit --purge`
> > and I will likely implement it there.
>=20
> Me thinks that makes sense. But be aware that this will only work
> for those submodules that are still present in the current index.
>=20
> > Optionally I could
> > implement `git gc --purge-submodule=3D<submodule-name>` as a second
> > way to access the feature so that we have a way of purging them
> > without using the submodules-interface. I doubt though that this
> > will provide much of a benefit as the user still has to be aware
> > that he is working with submodules as he has to provide the
> > `--purge-submodule` option, so there is not much to be gained by
> > this.
>=20
> Hmm, I still believe cleaning up a submodule repo which is already
> deinited makes sense. Using 'rm -rf .git/modules/<submodulename>'
> will work just fine, but is missing any safeguards. The deinit
> command takes submodule paths, not submodule names. So it looks
> to me like 'git gc --purge-submodule=3D<submodule-name>' would make
> sense here (and this command should check that the submodule has
> already been deinited and fail otherwise telling the user so).

Ah, okay. I thought your intention was to provide `git gc
--purge-sm` _instead_ of `git sm deinit --purge`. Guess it makes
sense to have both available for the different use cases
(explicitly removing a submodule vs removing unreferenced ones).
I guess one could even provide another option
`--purge-submodules` in addition to `--purge-sm=3D<smname>` that
will remove all deinitialized submodules without local commits.
Maybe its desirable to have a `--dry-run` flag as well that would
print which repositories would be deleted by `--purge-sms`.


Patrick

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFAoMAAoJEBF8Z7aeq/EsHSgP/3tLLbMQpbY8TZ+GZDem5NAN
yhta4sRiYpTRdYBZfSVLztrd6ZxtdgXja+CcngU/gnH2154zcdNJCDx7Z82AVZwt
60vsA+oGtczLGC15Vr7GIvp3mOYRiMhjwAj4RjyqIuHcWq2zDenHcEEGilaM3xFU
wpl657lbv381/bsijfFJ9759J+XXXTuYAnaeMRMj0OJl2qXtOgJDEInKlgBNqpVN
N96i3Kb5CmAWNrjOyo3Uww3Sn7FFRChZoHW4i20xVKma/w7nYbBvyu3r/kk+5I9e
Lg0SEQLYeorcQIqnMiq8lLw9T0tzY/HlmplHqShoy5jcOC8QwmBp+P+lrQTT2Whr
WOOn3fPuKB8v8tniEaODnK3YKKrkUnzFyovhueI/AcXe03A3mV90qEkCfvISsYgR
R6Y7RLfSPqvN+inibWOLZiAscw1MZk2GA81Fe5ifPW5tMXjpEP/8cmTev51jHiE3
vmYS0OxYWAGPxrwkunoQkuMkfu7+BA5abJaBgLqqQyOeuYFRb8xNOTM32zUzvkmS
cPHcsHgipkiEwZL82+cIM66M+k9Sy0fPdmGK7rV6H1RNG0vdq8jp2np8+DU+F5ho
DJXzl4b0BlPeMCH1ER5NqvIlAn7AKcSdMntEWu/OPDdp9+udUmoMqCL5CVI75dNy
zsCYXLS+4Svom6x/8ZYR
=REva
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Mon, 30 May 2011 16:17:58 +1000
Message-ID: <20110530061757.GC3723@Imperial-SD-Longsword>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
 <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
 <20110529044656.GA8881@brick.ozlabs.ibm.com>
 <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
 <m3mxi4yco5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 08:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQvno-0005Iw-1J
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 08:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab1E3GSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 02:18:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36111 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1E3GSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 02:18:04 -0400
Received: by pvg12 with SMTP id 12so1482779pvg.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 23:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=covOp17QQRZg0ep5Yv03ldidtJ7rxCHUNQIm1aUhrw8=;
        b=vTumsBqQllAGSQULaBsU1oqE1SvUROsIQ0UzApxJlW3XwqjJ99Ct3NDzFgDagbdvHP
         hqR9eWWhI13VLoMaQPT5MmR+0ZNXX8CgwDuLqBult5KGyt/cTHsKyYunZVlf0yhHpbtE
         7JCI09iE1gbyu0xccuTwBeOIJB1+plT0htr24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M0wi3zcx+hUsII4d4mmxOJgVaUvmG5g9AL6VMxWawxTCLtVJdg19eGb2547lDknszs
         AxuxL0O+zHfthGzUn4mPTXipBKn5ynaHWqibCN6vCy3mxr4Bc0Dmdw/Z7ZMkTx5/dDkt
         dLKX383ckKEU3v+aOjRi1vgebDn2cyoqDOAiY=
Received: by 10.68.68.106 with SMTP id v10mr1887931pbt.115.1306736283859;
        Sun, 29 May 2011 23:18:03 -0700 (PDT)
Received: from longsword.imperial.fleet (c114-76-222-200.rivrw3.nsw.optusnet.com.au [114.76.222.200])
        by mx.google.com with ESMTPS id w2sm2618173pbg.37.2011.05.29.23.18.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 23:18:03 -0700 (PDT)
Received: from tim by longsword.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-sd-longsword>)
	id 1QQvna-0001Li-OV; Mon, 30 May 2011 16:17:58 +1000
Content-Disposition: inline
In-Reply-To: <m3mxi4yco5.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174724>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 29, 2011 at 10:35:08PM -0700, Jakub Narebski wrote:
> Anders Kaseorg <andersk@MIT.EDU> writes:
> > On Sun, 29 May 2011, Paul Mackerras wrote:
>=20
> > > > @@ -11018,7 +11018,18 @@ proc prefsok {} {
> > > >  proc formatdate {d} {
> > > >      global datetimeformat
> > > >      if {$d ne {}} {
> > > > -	set d [clock format [lindex $d 0] -format $datetimeformat]
> > > > +	if {[string match {*%[zZ]*} $datetimeformat]} {
> > > > +	    if {[catch {set d [clock format [lindex $d 0] -timezone [lind=
ex $d 1] -format $datetimeformat]}]} {
> > > > +		# Tcl < 8.5 does not support -timezone.
> > > > +		global env
> > > > +		set zone [lindex $d 1]
> > > > +		set env(TZ) "IDK[string range $zone 0 2]:[string range $zone 3 e=
nd]"
> > >=20
> > > What is this about?  Where is the IDK prefix for timezones defined or
> > > described?
> >=20
> > Yeah, sorry, that deserved a bit more explanation.  This is a kludge to=
=20
> > get Tcl 8.4 to format dates in the right timezone.  IDK is an arbitrary=
=20
> > made up 3-letter code (=E2=80=9CI Don=E2=80=99t Know=E2=80=9D), since a=
 UTC offset can=E2=80=99t generally=20
> > be converted into a zone name.  The format of TZ is described at:
> > http://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html
> > http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html
> >=20
> > Actually, reading that again, I just realized that I need to invert the=
=20
> > sign.  Also that it can be longer than 3 letters; I=E2=80=99ll use =E2=
=80=9CUnknown=E2=80=9D=20
> > instead.
>=20
> Why not use UTC+N timezone (note: please check of for +HHMM it is
> UTC+HH or UTC-HH) for timezone with given numeric offset from
> Coordinated Universal Time?
>=20
> BTW. UTC because http://www.nist.gov/pml/div688/utcnist.cfm#cut

But what of half-hour offsets, in that case?  A better idea would be
UTC+HHMM or UTC-HHMM.  As an example, SA (CST) has a timezone of
UTC+0930.


Tim

--=20
lt.infiltrator@gmail.com

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN4zaVAAoJEGNoa2q+dzQWJKQQAPRNt9pYB/ZwLoz+QvYy/pQy
Jl1bpBCRoSxE/T/yukc8n7bFcu9Z5LU5DrR7jMowhVi3hLCuinbPOJSgib7TNQ1u
WN7UUxmbIMEG1YVscKd7xcEe+i1T8qDRg26a71PBORSH7fDIOSwtJLlivAM6JymP
ISBZ0qdTrCpjK5gJp9yMRRDvdzeC3Q3sg8BdSXCt1pRQ+uiBRQc76I6GTs4eIP4S
l0oY6MAIOAL8zuhl76C3HW5U0hV50aUQ+Oc9H2W0PcBmWa9OYDKi72W482l4cYHG
Kz5FsWOHAYQii2qs0yN+krKd89dFMUKzNe4DWlGATbXiQEn+CUFoZ6n4elQ0kqTO
b/VQMBhVbOnGB6BcwM+VE8bvTdsGqd7GD7etZHeW65Z1tVzfTeFriaSazNd9C3Zf
HHBM54JJtFrOcmbruOlvHKz93iiQIe0R4XmY8ytBoLPFqyUREYJqIhgLkPKZumXj
Sh/JZxF9VioK2sBaHTaMoyibPwcHXL8Pz3VFWCeaHB0hif3aq7LYFv2VJIxn+8/y
57OmXnCpYxJL8z9O9irQA7ZfcLI6TgSaVHI8Xz5smrsPPvu2f1uR3MTaVP2wK3vB
FXtAk1fA1AOhrXXWI7sz1qSVicre+f86Z9QeYvwkQSuW+t8KL28QYvrFPnprKvDq
qSuRtMyOtu7JHLziys9E
=TOwI
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

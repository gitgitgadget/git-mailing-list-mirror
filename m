From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: cloud tags feature produces malformed XML for errors
Date: Wed, 2 Mar 2011 01:05:00 +0100
Message-ID: <201103020105.04440.jnareb@gmail.com>
References: <20110301190229.11297.17767.reportbug@cassiopeia.kleinek> <20110301222141.GB7918@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 01:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuZZL-0005Za-0c
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 01:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab1CBAFU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 19:05:20 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49335 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1CBAFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 19:05:19 -0500
Received: by wwb22 with SMTP id 22so5165677wwb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2l6qj94KcrP7Tgp2BTo74UBMAc2cQzBeUuExPWWaMTM=;
        b=tWwW7Pn/zn/ycNrR5MtAqS7KnOW2aFEjJwjWEoflAIgMQWWnAZnblnfJJSS0s/3+WA
         cSPeP0tQJjIdhsNfKFbICp4qfrQ51UD2l/joX+m+19rOtO2UETNmvE/5NpYINEfINHRq
         NubJtiPTE/aCFnd004DIxKEW8lPNsu+X4q9Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OIZgEpgi1aghYLM2A4mLNbVt13XSplBe57iD//1tWKM3cZ+szJhsMNKD4xvGsyA7tC
         imvZ6uUqAg08UXQtAVxrPbeohlQMqRVcWmtsS7YGUzUgymbSG8b9kVmDR6n/uDpCdRCV
         HHB5mU5aEGEEG+0CGf1iSy9JEjEYJoIUmm+EY=
Received: by 10.216.155.75 with SMTP id i53mr4076842wek.27.1299024317876;
        Tue, 01 Mar 2011 16:05:17 -0800 (PST)
Received: from [192.168.1.13] (abvt248.neoplus.adsl.tpnet.pl [83.8.217.248])
        by mx.google.com with ESMTPS id o33sm2787634wej.37.2011.03.01.16.05.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 16:05:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110301222141.GB7918@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168282>

On Tue, 1 Mar 2011, Jonathan Nieder wrote:
> Uwe Kleine-K=C3=B6nig wrote [1]:
> [1] http://bugs.debian.org/616005

> > I experiment with $feature{'ctags'}.  After installing
> > libhtml-tagcloud-perl (0.34-1) and adding
> >
> >	$feature{'ctags'}{'default'} =3D [1];
> >
> > to gitweb.conf and doing
> >
> > 	mkdir ctags
> > 	echo Linux > ctags/Linux

This is invalid usage.  See below for details.

> >
> > in the only repository served by gitweb makes iceweasel barf on the
> > output (see attachment).
>=20
> With chromium I get:
>=20
> 	This page contains the following errors:
>=20
> 	error on line 26 at column 6: XML declaration allowed only at the st=
art of the document
> 	Below is a rendering of the page up to the first error.
>=20
> First, we hit
>=20
> 	if ($show_ctags) {
> 		my %ctags;
> 		foreach my $p (@projects) {
> 			foreach my $ct (keys %{$p->{'ctags'}}) {
> 				$ctags{$ct} +=3D $p->{'ctags'}->{$ct};
>=20
> which produces a warning warning in error.log:
>=20
> 	index.cgi: Argument "Linux" isn't numeric in addition (+) at /usr/sh=
are/gitweb/index.cgi line 4819.
>=20
> in error.log.

Well, blame Pasky for not describing 'ctags' in more detail.  Value of
tag is its weight, so instead of

 	mkdir ctags
	echo Linux > ctags/Linux

one should use

 	mkdir ctags
	echo 1 > ctags/Linux

Admittedly gitweb should be more defensive about invalid input...

> Then we hit git_show_project_tagcloud, which dies in=20
> "$cloud->html_and_css($count);" with
>=20
> 	HTML::TagCloud..
> 	index.cgi: Can't take log of 0 at /usr/share/perl5/HTML/TagCloud.pm =
line 67.
>=20
> For some reason, the result is an _embedded_ error page:
>=20
> 	<form method=3D"get" action=3D"/gitweb/" enctype=3D"application/x-ww=
w-form-urlencoded">=20
> 	<p class=3D"projsearch">Search:
> 	<input type=3D"text" name=3D"s"  />=20
> 	</p>=20
> 	</form>=20
> 	Content-type: {a content type which shall not be named}
> 	=20
> 	<?xml version=3D"1.0" encoding=3D"utf-8"?>=20
>  [...]
> 	500 - Internal Server Error
>=20
> So I suspect there are two bugs here.

This I think is caused by the fact that error ("die") occurs after gitw=
eb
have send some output to web browser already.  That would be harder to =
fix.


--=20
Jakub Narebski
Poland

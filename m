From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: Version independent mod_perl woes
Date: Thu, 21 Dec 2006 19:09:35 +0100
Message-ID: <200612211909.35615.jnareb@gmail.com>
References: <200612211807.54668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Dec 21 19:07:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxSJo-0000tF-GE
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 19:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWLUSG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWLUSG5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 13:06:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:7006 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423000AbWLUSG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 13:06:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2724734uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:06:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HyVKcDMFd//YacxGI3dKI+wySvHXlFCKGF3RrRdqvEo9sogF0Ko2qUqqQMbD6pOAS5OQQ1zyTS+9e4Gx27ioLSUdVFC2zXh1CmH6I+1F7QapWf6BnvwmK0+8By/ql2480sZFjIIdLv1aBsAUiHOPmgP0KZnReieBqtPoa8h+a+c=
Received: by 10.66.248.5 with SMTP id v5mr11174566ugh.1166724415161;
        Thu, 21 Dec 2006 10:06:55 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id 5sm12131002ugc.2006.12.21.10.06.54;
        Thu, 21 Dec 2006 10:06:54 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612211807.54668.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35076>

Jakub Narebski wrote:
> -- >8 --
> # Set the constant MP_GEN to 0 if mod_perl is not available,
> # to 1 if running under mod_perl 1.0
> # and 2 for mod_perl 2.0
> use constant MP_GEN =3D> $ENV{'MOD_PERL'}
> =A0=A0=A0=A0=A0=A0=A0=A0? { ( exists $ENV{'MOD_PERL_API_VERSION'} and=
=20
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0$ENV{'MOD_PERL_API_VERSION'} >=3D=
 2 ) ? 2 : 1 }
> =A0=A0=A0=A0=A0=A0=A0=A0: 0;

Actually, the error was here. It works like expected for

 use constant {
 	MP_GEN =3D> ($ENV{'MOD_PERL'}
 	           ? ( exists $ENV{'MOD_PERL_API_VERSION'} and=20
 	               $ENV{'MOD_PERL_API_VERSION'} >=3D 2 ) ? 2 : 1
 	           : 0),
 };

> # use appropriate mod_perl modules (conditional use)
> BEGIN {
> =A0=A0=A0=A0=A0=A0=A0=A0if (MP_GEN =3D=3D 2) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache2::Requ=
estRec;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache2::Serv=
erRec;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache2::Resp=
onse;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache2::Cons=
t;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0import Apache2::Reque=
stRec;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0import Apache2::Serve=
rRec;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Apache2::Const->impor=
t(-compile =3D> qw(:common :http));
> =A0=A0=A0=A0=A0=A0=A0=A0} elsif (MP_GEN =3D=3D 1) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0require Apache::Const=
ants;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0import Apache;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Apache::Constants->im=
port(qw(:common :http));
> =A0=A0=A0=A0=A0=A0=A0=A0}
> }
>=20
> # mod_perl request
> my $r;
> $r =3D shift @_ if MP_GEN;
> -- >8 --

Sorry for the noise.
--=20
Jakub Narebski
Poland

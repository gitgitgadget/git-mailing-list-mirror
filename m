From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Thu, 8 Jul 2010 09:01:23 +0200
Message-ID: <201007080901.23771.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com> <201007072205.14345.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 09:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWl76-0007fp-8S
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 09:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab0GHHBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 03:01:34 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59249 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0GHHBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 03:01:33 -0400
Received: by bwz1 with SMTP id 1so233035bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fiK9MMR+sp3TnHCAhsxv/jbKyy7Mi58GA1j8zoKqBVg=;
        b=XJpBwci91fpCjaO7ExUM7TqQM2bWMiMypBDdRBg2pI5qEzKVO3j7PA3Wkz6uSXUpso
         bjp+brAEmSxoxa+zkeEVj96QqHl1EaXaQEBPISrjuflcYPV127oLk1u/zsLA+5CrdHCr
         CCCx3xvEJiF30oEZsCaGR9erz7LgsXXcV6+sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LlktcftR0DveWSzEq9eS3ogpp0hxhi12AgJRuygTOownMpF02ek6RQbVHNpsTklbKl
         MHEY2hjV9qAIWm9av0leo/B5ly+1gFosRJF8DScHazFceWRTmhtlcWug1iZUe97E8M4p
         dX29plOLOtXPPDMUZJB6jTXZjVVV4ImeiiwQw=
Received: by 10.204.81.14 with SMTP id v14mr5944324bkk.7.1278572491915;
        Thu, 08 Jul 2010 00:01:31 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id s17sm28632399bkx.18.2010.07.08.00.01.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 00:01:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007072205.14345.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150543>

Jakub Narebski wrote:
> On Wed, 7 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napisa=C5=82=
:
> > On Wed, Jul 7, 2010 at 09:57, Jakub Narebski <jnareb@gmail.com> wro=
te:
> > > [...]
> > > =C2=A0use strict;
> > > =C2=A0use warnings;
> > > +
> > > +use File::Spec;
> > > +# __DIR__ is taken from Dir::Self __DIR__ fragment
> > > +sub __DIR__ () {
> > > + =C2=A0 =C2=A0 =C2=A0 File::Spec->rel2abs(join '', (File::Spec->=
splitpath(__FILE__))[0, 1]);
> > > +}
> > > +use lib __DIR__ . '/lib';
> > > +
> >=20
> > What was the result of the discussion about using __DIR__ again? Yo=
u
> > only need to use that method when you call a perl program whith *th=
en*
> > includes a module. If you just need to add the lib/ directory relat=
ive
> > to the script you're invoking you can use FindBin:
> >=20
> >     use FindBin qw($Bin);
> >     use lib "$Bin/lib";
>=20
> It's
>=20
>       use lib "$Bin/../lib";
>=20
> (I don't like this ../lib here, but that's my personal preference).
>=20
> But you might be right that I am overly cautious in avoiding FindBin.
> It is nowadays not recommended solution (on #perl, for example), but
> it is perhaps true that the conditions where it fails are not fulfill=
ed
> for the case of gitweb.
>=20
> Or perhaps not:
>=20
>   KNOWN ISSUES
>=20
>   If there are two modules using FindBin from different directories
>   under the same interpreter, this won't work. Since FindBin uses a
>   BEGIN block, it'll be executed only once, and only the first caller
>   will get it right. This is a problem under **mod_perl** and other
>   persistent Perl environments, where you shouldn't use this module.
>=20
> Gitweb can be used under mod_perl (to be more exact ModPerl::Registry=
).

And there is also nowadays 'plackup' option for git-instaweb, which
also would have, I think, this problem with FindBin.

--=20
Jakub Narebski
Poland

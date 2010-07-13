From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 14 Jul 2010 00:24:57 +0200
Message-ID: <201007140024.58446.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com> <201007072205.14345.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnum-0003qH-OG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab0GMWZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 18:25:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61825 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0GMWZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:25:16 -0400
Received: by bwz1 with SMTP id 1so573017bwz.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BPoHoZdxSP2s66XgSOg86AvIaRSPW/2IJI1hTjEDeCA=;
        b=e5niKpoDLf0D7+bq83LRMS3QD9NmxK3nHCSMUhlUUweXVOSFlUSShDI8UHEXGvoDwg
         Af2LBvUpvyojba+D4NSHGjk8erOgiBkTWPqz4JNAtdaMhcZYs6/Pj4p9LZ+EpsC6N17B
         rC654DayPZLivtaiwxMKzVo2aql5ZLa4TPdVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xbgO6m34ICF2anzHhVaGtFLi1zY2QW6mswQYx85/VRZ1jI/c93bEbbIU517KKkIQ8W
         EW4vxoCAcI+WPyz9NjEx0U+zMsCVhw8UyOvDvuZTRwkxMjETsR8TdtBoH2BNwVGegPiH
         rV+ayl5ZDU+1lKQ+jbYKQN2gw/ZKafm93BSic=
Received: by 10.204.81.166 with SMTP id x38mr12643533bkk.88.1279059915144;
        Tue, 13 Jul 2010 15:25:15 -0700 (PDT)
Received: from [192.168.1.13] (abvb104.neoplus.adsl.tpnet.pl [83.8.199.104])
        by mx.google.com with ESMTPS id s17sm26676794bkx.18.2010.07.13.15.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 15:25:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007072205.14345.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150933>

On Wed, 7 Jul 2010, Jakub Narebski wrote:
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

Actually for gitweb, where gitweb.cgi is put in "top" directory, and
lib/ directory is in the same directory that the script is, it would
be

        use FindBin qw($Bin);
        use lib "$Bin/lib";

The documentation says that $FindBin::Bin is

        $Bin    - path to bin directory from where script was invoked

so it is path to directory, not to script itself.

If it worked...

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

I wrote simple script that tests result of __DIR__ and $FindBin::Bin.
=46or cgi-bin / mod_cgi it was:

  __DIR__       =3D /var/www/cgi-bin/gitweb (symlink to /home/local/git=
web)
  $FindBin::Bin =3D /home/local/gitweb

=46or mod_perl (ModPerl::Registry handler) it was

  __DIR__       =3D /var/www/perl/gitweb (symlink to /home/local/gitweb=
)
  $FindBin::Bin =3D /

As you can see it's useless.  I have't checked the FastCGI case...

--=20
Jakub Narebski
Poland

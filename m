From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 08/17] gitweb: Add optional output caching
Date: Thu, 7 Oct 2010 01:06:30 +0200
Message-ID: <201010070106.30864.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-9-git-send-email-jnareb@gmail.com> <AANLkTi=RFu5PzBfbF0qVjFnSHnf5GGedkgqKAA4v4nVG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3d4N-0000uW-W4
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757966Ab0JFXGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:06:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33679 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab0JFXGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 19:06:36 -0400
Received: by bwz11 with SMTP id 11so81511bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GOGt5vt15fb7AyZNF901FAvTi617LqyRrRuSELa5x1U=;
        b=jTvNYQfWSPgkM42RRgc9B9581KL4myqUX4ryoooC9NANJMC5gq7W2RqJ++P6zJvIRL
         orUbNZKtRBQ25fZkbkpDmv1AakMZ+p8x/5g26o6vvFo8tCInacmdwiQMDhGbXZqp1iUN
         /EEuGuA4fxb+Jt5nxMzSdrxqSJGX62tyDz61U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aLsK+Vna5dEByN0h6FEUzpFZ4LQmKEeYVHr9Dd3z15xGOT1naZ4FhlAdyU0wim2XKD
         EqYBpba55I2SFVqaU5rc7bZl5EiLWKytXnnFmSQHCceLrOH+XtlFD+1kGH/aBcpceTRw
         TNNSQXm1Gt+rQCBjYVn9bj4davUYL2gi4d4os=
Received: by 10.204.112.146 with SMTP id w18mr9932771bkp.16.1286406395121;
        Wed, 06 Oct 2010 16:06:35 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id d27sm1081874bku.22.2010.10.06.16.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:06:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=RFu5PzBfbF0qVjFnSHnf5GGedkgqKAA4v4nVG@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158348>

On Thu, 7 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote=
:
>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cache ||=3D 'Gi=
twebCache::SimpleFileCache';
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval "require $c=
ache";
>=20
> Just:
>=20
>     eval { require $cache };
>=20
> Instead?

Wouldn't work correctly.  We want to use 'require BAREWORD' version,
where BAREWORD is name of module, e.g. GitwebCache::SimpleFileCache,
and which makes Perl to search for GitwebCache/SimpleFileCache.pm
in @INC.

The 'require STRING' version loads file given by a *path*, and it
doesn't do library lookup.

=46rom `perldoc -f require`:

   But if you try this:

      $class =3D 'Foo::Bar';
      require $class;      # $class is not a bareword
      #or
      require "Foo::Bar";  # not a bareword because of the ""

   The require function will look for the "Foo::Bar" file in the @INC a=
rray
   and will complain about not finding "Foo::Bar" there.  In this case =
you
   can do:

      eval "require $class";


Well, we could insert hooks into @INC, but I don't think we want to use
such hack.

--=20
Jakub Narebski
Poland

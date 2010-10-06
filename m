From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 06/17] gitweb/lib - Simple select(FH) based output capture
Date: Thu, 7 Oct 2010 01:26:25 +0200
Message-ID: <201010070126.26242.jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com> <1286402526-13143-7-git-send-email-jnareb@gmail.com> <AANLkTikVumyaJoM3=Nbf9igVheLvMB5tcc5+E+wSkb40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dNe-0002oh-KK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348Ab0JFX0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:26:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52319 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0JFX0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:26:31 -0400
Received: by bwz11 with SMTP id 11so90101bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2mLere18yyUU8K4O/ogUcvF16EAGBBkp2fwTyCdfzbs=;
        b=lE9YPynkg75dLW/EH4oSw/1D8sn27xiMlMwKCzh/U3lUBwksvEkfJNq8PF/1ifmO3R
         BJNCLKfpHuJJb3wfLKjy8wKwtLbAi2kqlaEbhtfvnrup1l/N/6Pkig2Do8opaoPkcQ/d
         /6S8t3jbJJwkY1UfszyvO2k4u2RNKrKKEsnik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uGcQc3nEOtXlqWMCJbHL52SdW/+9bdaOErHn2WX0tMaknk/PYEYFhpSAFhCSNVcWBt
         Icxxn2gYHJHithhiwNRzvBgum0dW9zCBPpEcudj72zDyTCXBia6xRVQTxZqAgg5ppnxW
         PrVe2ciYD1YNQf2chQH1R3PijtecXSqEOJxRY=
Received: by 10.204.45.207 with SMTP id g15mr10462599bkf.14.1286407590529;
        Wed, 06 Oct 2010 16:26:30 -0700 (PDT)
Received: from [192.168.1.13] (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id f10sm1099200bkl.5.2010.10.06.16.26.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 16:26:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikVumyaJoM3=Nbf9igVheLvMB5tcc5+E+wSkb40@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158354>

On Thu, 7 Oct 2010 01:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote=
:
>=20
> > * The most important issue is that I/O "layers" (PerlIO), like ':ut=
f8'
> > =C2=A0or ':raw', are *already applied* to the output that is captur=
ed.
> > =C2=A0This means that captured output is *always* in binary (':raw'=
) mode.
> > =C2=A0In Perl 6 language it means that data returned by capturing e=
ngine
> > =C2=A0is an equivalent of Buf, a collection of bytes, whether Buf o=
r Str
> > =C2=A0(a colection of logical characters) is printed.
>=20
> > + =C2=A0 =C2=A0 =C2=A0 # note: this does not cover all cases
> > + =C2=A0 =C2=A0 =C2=A0 binmode select(), ':utf8'
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((PerlIO::get=
_layers($self->{'oldfh'}))[-1] eq 'utf8');

Sidenote: I just realized that we can simply try to replay all but
special layers from 'oldfh'.
=20
> I'm not sure but maybe we want to use ":Encoding(UTF-8)" everywhere i=
n
> this series where you've used ":utf8". I.e. use the Encoding UTF-8
> layer instead of the internal utf8 layer.
>=20
> It's more strict, see perldoc Encode's "UTF-8 vs. utf8 vs. UTF8". But
> maybe we don't care.

I think for the time being we don't care.=20

In the future we could perhaps update gitweb to use ':encoding(UTF-8)'
PerlIO layer rather than ':utf8' layer, and update capturing engine(s)
appropriately.

--=20
Jakub Narebski
Poland

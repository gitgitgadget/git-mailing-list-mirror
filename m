From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix handling of fractional timezones in parse_date
Date: Fri, 25 Mar 2011 18:47:38 +0100
Message-ID: <201103251847.39881.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <AANLkTik5bLaR_0uhqGrNWW6U7z82KfmpNTyvRwkKFfj+@mail.gmail.com> <7v8vw36s0r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Cernekee <cernekee@gmail.com>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3B77-0000N2-Oh
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab1CYRrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 13:47:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34503 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab1CYRrv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 13:47:51 -0400
Received: by bwz15 with SMTP id 15so1083033bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=LFmECa+A3JfKBautgF2+bnY2q3C9ZdwSwlRxetzIPhs=;
        b=wXMfXYDIUHem4dIYoN5XgFDec+veSdYVephJuKQxF36Ttjtiv/Oy6o5vmGB0TyNn+7
         Kzjx1Tb5B17FSXRvSLqFxrrRNigoQ0oJd7fYWm33QPta2Geg22n5KBMLCsR6kA0d0lBj
         aezH9T7NTeaAZfIgdkDyqr/rPhM7gWBMgSv4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VcesOSk0gv4PRAyK0XR6WUqta6lkbLmoMrsEVcOXKGUxcxWNoT67veL2+bugG98/rU
         uyfK2b48qZQpGNXLYDoO22cMIYVJLiUNXDl7u7M1t/841NRHSXF990GzqezzrVv/ZXY4
         /MzLS3ubUcTWHI9lw0HBZ9pkBAHUWSMJvDH2c=
Received: by 10.204.154.88 with SMTP id n24mr1074879bkw.38.1301075270113;
        Fri, 25 Mar 2011 10:47:50 -0700 (PDT)
Received: from [192.168.1.13] (abwo211.neoplus.adsl.tpnet.pl [83.8.238.211])
        by mx.google.com with ESMTPS id z18sm919989bkf.8.2011.03.25.10.47.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 10:47:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vw36s0r.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170002>

Junio C Hamano wrote:
> Kevin Cernekee <cernekee@gmail.com> writes:
>=20
> > It's just a matter of personal preference, but I would find this
> > regexp slightly easier to read:
> >
> > +               ($tz =3D~ m/^([+\-])([0-9]{2})([0-9]{2})$/);
>=20
> I'd say "^([-+])(\d\d)(\d\d)$" makes it the most clear.

But what does 'digit character' mean?  Is "\d" Unicode-aware, because
if it is it might match other digits than 0-9?

#perl says:

<rindolf> ShadeHawk: hi.
<rindolf> ShadeHawk: \d matches Unicode digits in unicode contexts I th=
ink.
<rindolf> ShadeHawk: like the ones used for Written Arabic.
<rindolf> ShadeHawk: let's see.
<rindolf> perlbot: eval: ["=D9=A3" =3D~ /\d/ ? "Match" : "Nomatch"]
<perlbot> rindolf: ["Match"]
<rindolf> Yay!
<rindolf> That's three in http://en.wikipedia.org/wiki/Hindu%E2%80%93Ar=
abic_numeral_system

Anyway gitweb uses \d in various regexps, so it shouldn't be worse
than it is now. =20

[...]

> Care to re-roll the patch?

Will do.=20

--=20
Jakub Narebski
ShadeHawk on #git and #perl
Poland

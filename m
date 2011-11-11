From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] i18n: add infrastructure for translating Git with gettext
Date: Fri, 11 Nov 2011 02:27:21 -0800 (PST)
Message-ID: <m31utfnedi.fsf@localhost.localdomain>
References: <1320970164-31694-1-git-send-email-avarab@gmail.com>
	<1320970164-31694-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 11:27:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROoKg-0000KZ-DT
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 11:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab1KKK1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 05:27:25 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61870 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab1KKK1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 05:27:24 -0500
Received: by fagn18 with SMTP id n18so1569817fag.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 02:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=DpzOCZBzQ6LdrTO+zEYMTxczDrfNWmrdxbUh+xENECw=;
        b=YSIUzCTFoNQ7d6oJKyjL48lpSezKfIlTsYY7B+hzw0J5/U75PwEzPT1bgplRXbHNDW
         dUTjY5WB1ReJwPXrwjB5YIxg0DYTFR1Sm4TsL6+jOSifF1Of3nfYLE0e6rkh3iboSykx
         XT8VY5N81B5VfFvDHZB7b7AnYBcFWjaeVzvRo=
Received: by 10.223.58.8 with SMTP id e8mr18170400fah.27.1321007243256;
        Fri, 11 Nov 2011 02:27:23 -0800 (PST)
Received: from localhost.localdomain (abvw113.neoplus.adsl.tpnet.pl. [83.8.220.113])
        by mx.google.com with ESMTPS id y2sm15044054fag.12.2011.11.11.02.27.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 02:27:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pABARH3r008956;
	Fri, 11 Nov 2011 11:27:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pABAR6MJ008949;
	Fri, 11 Nov 2011 11:27:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1320970164-31694-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185261>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> =3D Perl
>=20
> Perl code that wants to be localized should use the new Git::I18n
> module. It imports a __ function into the caller's package by
> default.
>=20
> Instead of using the high level Locale::TextDomain interface I've
> opted to use the low-level (equivalent to the C interface)
> Locale::Messages module, which Locale::TextDomain itself uses.

Nice of you using libintl-perl instead of old Locale::MakeText
(with gettext compatibility layer).

> See <AANLkTilYD_NyIZMyj9dHtVk-ylVBfvyxpCC7982LWnVd@mail.gmail.com> fo=
r
> a further elaboration on this topic.

http://thread.gmane.org/gmane.comp.version-control.git/148446/focus=3D1=
48478

> =3D Shell
>=20
> Shell code that's to be localized should use the git-sh-i18n
> library. It's basically just a wrapper for the system's gettext.sh.
>=20
> If gettext.sh isn't available we'll fall back on gettext(1) if it's
> available. The latter is available without the former on Solaris,
> which has its own non-GNU gettext implementation. We also need to
> emulate eval_gettext() there.
>
> If neither are present we'll use a dumb printf(1) fall-through
> wrapper.
>=20
> I originally tried to detect if the system supported `echo -n' but
> I found this to be a waste of time. My benchmarks on Linux, Solaris
> and FreeBSD reveal that printf(1) is fast enough, especially since
> we aren't calling gettext() from within any tight loops, and
> unlikely to ever do so.

Didn't we decide that the only sane way to handle eval_gettext
is to provide minimal implemetation in the form of external command?
=20

Thanks for working on this.
--=20
Jakub Nar=C4=99bski

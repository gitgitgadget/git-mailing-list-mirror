From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: NO_REGEX defaults on obscure platforms
Date: Wed, 08 Sep 2010 10:31:44 -0500
Message-ID: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
References: <AANLkTimYY_KHwqWWXTxFqW67FHYtJJkLuA-6WVc6wzO5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Gary V. Vaughan" <gary@thewrittenword.com>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Robert Schiele <rschiele@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:43:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMnz-0008CV-Qf
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab0IHPnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 11:43:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37157 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab0IHPnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:43:17 -0400
Received: by mail.nrlssc.navy.mil id o88FVi0K009987; Wed, 8 Sep 2010 10:31:44 -0500
In-Reply-To: <AANLkTimYY_KHwqWWXTxFqW67FHYtJJkLuA-6WVc6wzO5@mail.gmail.com>
X-OriginalArrivalTime: 08 Sep 2010 15:31:44.0792 (UTC) FILETIME=[F18DC980:01CB4F6A]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155795>

On 09/08/2010 10:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 6, 2010 at 07:41, Junio C Hamano <gitster@pobox.com> wrot=
e:
>=20
>> There are a few leftover bits in 'next' that need to be merged to 'm=
aster'
>> before we declare a real -rc cycle, so tonight's pushout is -rc0.
>=20
> One thing that's almost certainly wrong in v1.7.3-rc0 is the NO_REGEX
> defaults. It's a non-issue for people who run the configure script,
> but the Makefile probably has the wrong defaults on some obscure
> platforms.
>=20
> I've CC'd people involved in Tru64, UnixWare, SCO, HP/UX, IRIX etc. I=
t
> would be really useful if you could:
>=20
>   1. Get v1.7.3-rc0
>   2. Compile with the defaults, and NO_REGEX=3DYesPlease
>   3. Run `cd t && ./t7008-grep-binary.sh` and report the results.
>=20
> That test is probably failing on some of these platforms.

Yes, I've already tested and IRIX does indeed need to use the compat
regex, i.e. IRIX needs NO_REGEX=3DYesPlease.

> Alternatively, just check for REG_STARTEND in regex.h (or the include=
s
> it pulls in):
>=20
>     $ grep REG_STARTEND /usr/include/regex.h
>     #define REG_STARTEND (1 << 2)

Unfortunately, IRIX actually defines REG_STARTEND in its regex.h, but
the feature does not seem to work.  This also means the configure scrip=
t
will give a false negative and indicate that NO_REGEX should _not_ be
set, when it actually should be.

I have a few other patches, in addition to this NO_REGEX setting, that
I haven't found time to submit, but my feelings won't be hurt if someon=
e
else beats me to it. (hint, hint :)

-Brandon

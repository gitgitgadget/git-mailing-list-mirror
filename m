From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 25 May 2010 09:33:52 +0200
Message-ID: <4BFB7D60.6090602@drmicha.warpmail.net>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>	 <4BF2BABC.2010405@drmicha.warpmail.net>	 <1274202486.4228.22.camel@localhost> <1274720888.4838.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Tue May 25 09:34:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoeT-0002AY-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab0EYHeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 03:34:07 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33951 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754040Ab0EYHeG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 03:34:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DB1E2F80F2;
	Tue, 25 May 2010 03:34:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 25 May 2010 03:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kwS4mFBS0JnBJF04xGzXtkhpIVs=; b=jEvUMsM6xc0YIit/2aWXqL1FrH627EX4i1nbj1ilJgu89r4Oi6HDi2GrSqFzntZ75irMC0WpWKsPDKcqT5N3NtuMnfzFwkcRTKGbogNeVqY8nGO1adbK0oooRPM7El/6nTNOApSu5Gmbc99lEG9zqqPgq5UMVm/SJjwNGTQ0FTY=
X-Sasl-enc: jNkght4AeQCGEO2dhwJgSeeDdhZsJ2bNoVlxbz7dBJ1p 1274772845
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EA8DE4E2AAB;
	Tue, 25 May 2010 03:34:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <1274720888.4838.13.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147679>

Yann Droneaud venit, vidit, dixit 24.05.2010 19:08:
> Le mardi 18 mai 2010 =C3=A0 19:08 +0200, Yann Droneaud a =C3=A9crit :
>> Le mardi 18 mai 2010 =C3=A0 18:05 +0200, Michael J Gruber a =C3=A9cr=
it :
>>> Yann Droneaud venit, vidit, dixit 18.05.2010 16:41:
>>>> Since I don't have en_US.utf8, some tests failed:
>>
>>>>
>>>> On my system locale -a reports:
>>>>
>>>>    en_US
>>>>    en_US.ISO-8859-1
>>>>    en_US.UTF-8
>>>>
>>>
>>> locale -a|grep en_US
>>> en_US
>>> en_US.iso88591
>>> en_US.iso885915
>>> en_US.utf8
>>>
>>> This is on Fedora 13, which is not exactly exotic. What is your sys=
tem?
>>>
>>
>=20
> I've checked carefully multiple system and configuration, and found w=
hy
> we have some little locale problem here.
>=20
> Since glibc 2.3, a file can hold all locales in file "locale-archive"
> instead of having a tons of directory. To store all the locales in th=
is
> file, it uses an index based on a "normalized" codeset, e.g. it conve=
rts
> codeset to lowercase, removes dash and minus.=20
> So when one ask for the locale list, locale first go through the
> "locale-archive" content and report normalized codeset (utf8)  instea=
d
> of canonical codeset (UTF-8), then it proceed with the legacy locales
> directories, using for them the canonical codeset.
>=20
> Until recently, Mandriva Linux doesn't make use of "locale-archive", =
so
> UTF-8 locales were reported. Version in development uses
> "locale-archive" + legacy locale directories, hence the mix I've
> reported. Other Linux distributions like Fedora and Ubuntu uses only
> "locale-archive" and so, have only "normalized" codeset.
> POSIX doesn't specify the output of locale -a, so it's not really a b=
ug
> to show "normalized" codeset name.
>=20
> But all others "POSIX" system I've found report "canonical" codeset,
> e.g. UTF-8 (all but latest cygwin).=20
>=20
> Here's the bug report:
> http://sourceware.org/bugzilla/show_bug.cgi?id=3D11629

Thanks a lot for doing the leg work! Is there any way to, say,
set_local(a) and check whether get_locale() =3D=3D a up to equivalence?

>=20
> BTW, I will shortly provided a fix for the testcase, which will handl=
e
> all cases.
>=20
> Regards.
>=20

Thanks,
Michael

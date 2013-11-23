From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 0/2] thin-pack capability for send-pack/receive-pack
Date: Sat, 23 Nov 2013 16:09:22 +0100
Message-ID: <1385219362.2665.18.camel@centaur.cmartin.tk>
References: <1383750263-32495-1-git-send-email-cmn@elego.de>
	 <xmqqbo1x8e60.fsf@gitster.dls.corp.google.com>
	 <1383774082.2850.10.camel@centaur.cmartin.tk>
	 <CAJo=hJtUMZit8Mtt7NQ=SiAXmnHf3xQqCKMo3F3XksHoq0tCkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 23 16:09:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkEq3-0003FY-21
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 16:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754264Ab3KWPJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Nov 2013 10:09:29 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:57330 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab3KWPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 10:09:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 177A7DE05B;
	Sat, 23 Nov 2013 16:09:26 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-TKKKkmpS5T; Sat, 23 Nov 2013 16:09:26 +0100 (CET)
Received: from [192.168.1.4] (p57A1F0F3.dip0.t-ipconnect.de [87.161.240.243])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id C625BDE056;
	Sat, 23 Nov 2013 16:09:25 +0100 (CET)
In-Reply-To: <CAJo=hJtUMZit8Mtt7NQ=SiAXmnHf3xQqCKMo3F3XksHoq0tCkw@mail.gmail.com>
X-Mailer: Evolution 3.8.5-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238235>

On Wed, 2013-11-06 at 15:42 -0800, Shawn Pearce wrote:
> On Wed, Nov 6, 2013 at 1:41 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.d=
e> wrote:
> > On Wed, 2013-11-06 at 12:32 -0800, Junio C Hamano wrote:
> >> I'll queue these for now, but I doubt the wisdom of this series,
> >> given that the ship has already sailed long time ago.
> >>
> >> Currently, no third-party implementation of a receiving end can
> >> accept thin push, because "thin push" is not a capability that nee=
ds
> >> to be checked by the current clients.  People will have to wait
> >> until the clients with 2/2 patch are widely deployed before starti=
ng
> >> to use such a receiving end that is incapable of "thin push".
> >>
> >> Wouldn't the world be a better place if instead they used that tim=
e
> >> waiting to help such a third-party receiving end to implement "thi=
n
> >> push" support?
> >>
> >
> > Support in the code isn't always enough. The particular case that
> > brought this on is one where the index-pack implementation can deal=
 with
> > thin packs just fine.
> >
> > This particular service takes the pack which the client sent and do=
es
> > post-processing on it to store it elsewhere. During the receive-pac=
k
> > equivalent, there is no git object db that it can query for the mis=
sing
> > base objects. I realise this is pretty a unusual situation.
>=20
> How... odd?
>=20
> At Google we have made effort to ensure servers can accept thin packs=
,
> even though its clearly easier to accept non-thin, because clients in
> the wild already send thin packs and changing the deployed clients is
> harder than implementing the existing protocol.

It is harder, but IMO also more correct, as thin packs are an
optimisation that was added somewhat later. Not to say it shouldn't be
something you should attempt to do, but it's a trade-off between the
complexity of the communication between the pieces and the potential
amount of extra data you're willing to put up with.

The Google (Code) servers don't just support thin packs, but for
upload-pack, they force it upon the client, which is quite frustrating
as it won't even tell you why it closes the connection but sends a 500
instead, but that's a different story.

>=20
> If the server can't complete the pack, I guess this also means the
> client cannot immediately fetch from the server it just pushed to?

Not all the details have been worked out yet, but the new history shoul=
d
be converted into the target format before reporting success and closin=
g
the connection. The Git frontend/protocol is one way of putting data
into the system, but that's not its native data storage format. The
database where this is getting stored only has very limited knowledge o=
f
git.

I'll reroll the series with "no-thin" as mentioned elsewhere in this
thread.

   cmn

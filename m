From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Tue, 15 Mar 2011 18:27:41 +0100
Message-ID: <1300210062.19100.46.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
	 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
	 <7vpqptb976.fsf@alter.siamese.dyndns.org>
	 <1300190396.19100.31.camel@bee.lab.cmartin.tk>
	 <1300192832.19100.35.camel@bee.lab.cmartin.tk>
	 <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzY2D-00070D-61
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758129Ab1COR1r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 13:27:47 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:38018 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab1COR1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 13:27:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 42DCC1B4B18;
	Tue, 15 Mar 2011 18:27:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q+X9h1cZObQz; Tue, 15 Mar 2011 18:27:40 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id BD1101B4B04;
	Tue, 15 Mar 2011 18:27:40 +0100 (CET)
In-Reply-To: <7vd3lsb9m3.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169080>

On mar, 2011-03-15 at 10:02 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > On mar, 2011-03-15 at 12:59 +0100, Carlos Mart=C3=ADn Nieto wrote:
> >> On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
> >> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> > [...]
> >> >=20
> >> > >  There is however the extra functionality the function offers,=
 namely
> >> > > resolving links. It might be good to split it into two functio=
ns so each
> >> > > caller can specify what it wants.
> >> >=20
> >> > Probably.
> >>=20
> >>  With the changes mentioned earlier, if you want an absolute pathn=
ame,
> >> you'd call absolute_path/make_nonrelative_path and if you want to =
make
> >> sure you have the real path of the target file, you'd use real_pat=
h just
> >> as you'd use realpath on a sane system, with
> >
> >  ... a comment on the functions and maybe some documentation in
> > Documentation/techncal, as it doesn't seem to exist yet.
>=20
> We probably should involve Nguy=E1=BB=85n in this thread as his finge=
rs are
> everywhere on the codepaths related to setup.
>=20

 I've been changing this a bit, trying to make all the paths normalized=
,
but it'll take a bit longer. I'll send a partial patch when I've
finished something worth seeing (for the moment, the test fail if there
is a symlink somewhere in the tree, as I've mixed
real_path/make_absolute_path and absolute_path/make_nonrelative_path a
bit).

 Is it a good idea to normalize the paths? Otherwise, everything could
be replaced by real_path/make_absolute_path (as most calls already are)=
=2E
As it's transitive and these paths aren't stored permanently (other tha=
n
with clone), as long as we agree on one representation, it should be
fine.

 Is there a performance hit if we resolve links all the time? If we run
everything through normalize_path(_copy), is it slower than resolving
links?

   cmn

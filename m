From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Tue, 15 Mar 2011 12:59:49 +0100
Message-ID: <1300190396.19100.31.camel@bee.lab.cmartin.tk>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
	 <1300130318-11279-2-git-send-email-cmn@elego.de>
	 <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
	 <1300140128.4320.39.camel@bee.lab.cmartin.tk>
	 <7vpqptb976.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzSv9-0003rA-04
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 13:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757511Ab1COMAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 08:00:08 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:34072 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab1COMAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 08:00:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 09E091B4BC8;
	Tue, 15 Mar 2011 13:00:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buRqdu-CXP7G; Tue, 15 Mar 2011 12:59:56 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CEC8E1B4BC5;
	Tue, 15 Mar 2011 12:59:55 +0100 (CET)
In-Reply-To: <7vpqptb976.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169063>

On lun, 2011-03-14 at 15:58 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> >> I don't think it is a bad idea per-se to avoid a copy from the sam=
e memory
> >> location into the same memory location, but independent of the nec=
essity
> >> of fixes at the low-level, shouldn't we fix the callers that do no=
t check
> >> if what they have is already absolute?
> >
> > If we'd like the semantics to be "whatever I had, I now know what t=
he
> > absolute path is" then we could make the check in the beginning of =
the
> > function, to centralise the check. If the semantics should be "I do=
n't
> > have an absolute path, so I need to figure out what it is", then th=
ere
> > should be a check before calling make_absolute_path() (the name sug=
gests
> > the second).
>=20
> Good thinking, and I think the former semantics would be easier to us=
e.

 I was asking about why we didn't just use realpath, but it seems there
is no portable way of dealing with it (even without counting NFS over
different systems).

 I'm thinking of renaming make_absolute_path to real_path as it's in
fact our implementation of realpath (and actually describes what it
does), without a is_absolute_path check, as a path could be absolute bu=
t
point to a link, adding a comment to say that if you don't mind links,
you should use make_nonrelative_path (I'd rename it to absolute_path,
but that may be too close to the old make_absolute_path)

>=20
> >  There is however the extra functionality the function offers, name=
ly
> > resolving links. It might be good to split it into two functions so=
 each
> > caller can specify what it wants.
>=20
> Probably.

 With the changes mentioned earlier, if you want an absolute pathname,
you'd call absolute_path/make_nonrelative_path and if you want to make
sure you have the real path of the target file, you'd use real_path jus=
t
as you'd use realpath on a sane system, with

   cmn

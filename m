From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Tue, 22 Jul 2008 20:09:44 +0200
Message-ID: <20080722180944.GB3561@efreet.light.src>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org> <1214338474-16822-2-git-send-email-madcoder@debian.org> <7vbq1oqbjg.fsf@gitster.siamese.dyndns.org> <20080626213304.GA22111@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 20:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLMK2-0001qc-Vt
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 20:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbYGVSJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jul 2008 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbYGVSJv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 14:09:51 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:36455 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbYGVSJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 14:09:50 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jul 2008 14:09:50 EDT
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 55ED2572AA;
	Tue, 22 Jul 2008 20:09:49 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id X43jzMAz3wd7; Tue, 22 Jul 2008 20:09:46 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D44675725E;
	Tue, 22 Jul 2008 20:09:44 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KLMIy-0001MJ-8S; Tue, 22 Jul 2008 20:09:44 +0200
Content-Disposition: inline
In-Reply-To: <20080626213304.GA22111@artemis.madism.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89508>

On Thu, Jun 26, 2008 at 23:33:04 +0200, Pierre Habouzit wrote:
> On Thu, Jun 26, 2008 at 06:46:43PM +0000, Junio C Hamano wrote:
> > The user would also need to worry about not freeing the original
> > allocation pointer when something is realloc(3)ed, which means eith=
er
> > finding the last realloc(3) of the object (that is logically the sa=
me, but
> > just being extended) and mark the pointer as leaky() after that rea=
lloc,
> > or unregister the original pointer from leaks before calling reallo=
c and
> > register what comes back.  It will easily get messy.
>=20
>   Hmm indeed, maybe it isn't such a good idea then.

I don't think it's necessary either. Valgrind (unlike other leak detect=
ors
the poor windows folks are stuck with) is quite smart and will only rep=
ort
memory as leaked when there is no pointer to it. So it should not repor=
t any
memory pointed to by index or any other static structure.

Additionally since valgrind allows one to write rules to exclude
uninteresting reports. So a good approach would be to just keep such
exclusion file around in git with the known uninteresting cases.

> > By the way, the series queued in your repository still has "s/pring=
/print/"
> > typo in 4/7 and "argv not NULL terminated" comment in 6/7.
>=20
>   I'll fix that and pushed again, without the leaky() series dependen=
cy
> (I've put in a comment that I'm aware that it's a leak), and with the
> two fixes you mention done.
>=20
> --=20
> =C2=B7O=C2=B7  Pierre Habouzit
> =C2=B7=C2=B7O                                                madcoder=
@debian.org
> OOO                                                http://www.madism.=
org


--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

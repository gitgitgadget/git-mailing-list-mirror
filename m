From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH 17/18] Place the open() call inside the do{} struct and
 prevent failing close
Date: Fri, 07 Jun 2013 00:16:55 +0200
Message-ID: <51B10A57.6060900@ensimag.fr>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr> <1370547263-13558-18-git-send-email-celestin.matte@ensimag.fr> <7vhahbx7r7.fsf@alter.siamese.dyndns.org> <51B0FF75.9070506@ensimag.fr> <7vbo7iyk8e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 00:19:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkiWJ-0008P7-4L
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 00:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab3FFWSw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 18:18:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45937 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab3FFWSu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 18:18:50 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r56MGoBQ027513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 00:16:50 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r56MGrPC022825;
	Fri, 7 Jun 2013 00:16:53 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r56MGqcx024549;
	Fri, 7 Jun 2013 00:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vbo7iyk8e.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Jun 2013 00:16:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r56MGoBQ027513
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: celestin.matte@ensimag.fr
MailScanner-NULL-Check: 1371161812.92995@J3SsVIUtY3VUNHn+UDrAag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226568>

Le 06/06/2013 23:58, Junio C Hamano a =C3=A9crit :
> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>=20
>> So using autodie may not be a good idea.
>> But the problem is that in the current state, open() return values a=
re
>> checked, but print ones are not, although it should be.
>=20
> I tried "man autodie" and tried to spot 'print' in the categories
> list that shows things like ":all covers :default which in turn
> covers :io which in turn covers read, seek, ..." and didn't see any.
>=20
> Running the attached as
>=20
> 	$ perl ad.perl >&-
>=20
> gave me "Hi" (i.e. no failure from print) but of course killed a
> failing syswrite().

You're right, print is not in the list of function checked by autodie.

> So I am not sure your "we must check print" matches well with use of
> autodie, either.

So I'm not sure what we should do for print calls: should we
systematically check them all? That would be a painful and less-readabl=
e
thing to do. We may just not bother about it, after all...

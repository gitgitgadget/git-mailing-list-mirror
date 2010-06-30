From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Wed, 30 Jun 2010 10:01:09 +0200
Message-ID: <20100630080109.GA4264@neumann>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
	<7vy6dx90uk.fsf@alter.siamese.dyndns.org>
	<4C2AE04E.9090901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 30 10:01:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTsEX-00024h-1e
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 10:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab0F3IBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 04:01:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57198 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0F3IBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 04:01:18 -0400
Received: from [127.0.1.1] (p5B130904.dip0.t-ipconnect.de [91.19.9.4])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYcHS-1OgP9I0xEY-00VlXZ; Wed, 30 Jun 2010 10:01:11 +0200
Content-Disposition: inline
In-Reply-To: <4C2AE04E.9090901@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/i8xOUNGcUUTOpeMZYhXqR8Vkb+ZGkBbe4uQC
 f0lYYUNWivsq6AxorrAZEebYIp3xf/xRDP7sY+hb2y81sXGS7O
 YADId8oNCkOb+6EZURgIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149950>

Hi,

thank you both for your comments.


On Wed, Jun 30, 2010 at 08:12:30AM +0200, Johannes Sixt wrote:
> Am 6/29/2010 19:59, schrieb Junio C Hamano:
> > One possibility is to look at the timestamp of the directory itself
> > instead.  Then we can safely gc otherwise-unused "thisimage" file w=
hen
> > rerere is not in use.  I wonder if directory m_time timestamps are =
usable
> > for this purpose on non-POSIX platforms?
>=20
> I don't think that will work at all: We only use fopen() to write
> thisimage, which only truncates the file, but doesn't modify mtime of=
 the
> directory. Nor do we create any other (temporary) directory entries t=
hat
> would modify the mtime.

Indeed; on Linux I have:

drwxr-xr-x 2 szeder szeder 4096 2010-06-24 10:59 .git/rr-cache/13e67fee=
b07f97d6fccc2257d793d93ec4e730bf/

-rw-r--r-- 1 szeder szeder 3095 2010-06-30 04:56 .git/rr-cache/13e67fee=
b07f97d6fccc2257d793d93ec4e730bf/thisimage


> Would it be possible to update the timestamp of preimage every time i=
t is
> used (e.g., in rerere.c:merge()), and check for that?

Will take a look.


Best,
G=E1bor

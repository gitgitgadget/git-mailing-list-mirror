From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 19:16:24 +0200
Message-ID: <4E1F2468.6080409@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:16:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhPWk-0007b9-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab1GNRQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 13:16:37 -0400
Received: from india601.server4you.de ([85.25.151.105]:41618 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab1GNRQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:16:36 -0400
Received: from [192.168.2.106] (p4FFD9551.dip.t-dialin.net [79.253.149.81])
	by india601.server4you.de (Postfix) with ESMTPSA id 0C0E62F802F;
	Thu, 14 Jul 2011 19:16:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110714015656.GA20136@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177135>

Am 14.07.2011 03:56, schrieb Jeff King:
> On Wed, Jul 13, 2011 at 06:34:32PM -0500, Neal Kreitzinger wrote:
>> Working syntax starting points for git-archive and tar:
>>
>> git archive --format=3Dtar -o my.tar HEAD Web/Templates/
>> tar -cvf my.tar --transform 's,^Web/Templates/,myPath/myWeb/Template=
s/,'=20
>> WebPortal/Templates/
>>
>> Failed syntax attempts for feeding tar option to git-archive:
>>
>> git archive --format=3Dtar -o my.tar HEAD --transform=20
>> 's,^Web/Templates/,myPath/myWeb/Templates/,' WebPortal/Templates/
>> error: unknown option `transform'
>>
>> git archive --format=3Dtar -o my.tar --transform=20
>> 's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD WebPortal/Template=
s/
>> error: unknown option `transform'
>=20
> Yeah, that won't work, because there is no such option. We do have
> "--prefix", but I suspect that's not flexible enough for what you wan=
t.

If you only need a single subdirectory with a custom prefix you could d=
o
something like this (variables only used to keep the lines short):

	$ subdir=3DWebPortal/Templates
	$ prefix=3DmyPath/myWeb/Templates/
	$ (cd "$subdir" && git archive --prefix=3D"$prefix" HEAD) >my.tar

The output file can be specified with -o as well, of course, but you'd
either need to use an absolute path or add "../" for each directory
level you descend into (-o ../../my.tar in this case).

Ren=C3=A9

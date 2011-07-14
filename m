From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 19:45:07 +0200
Message-ID: <4E1F2B23.1020908@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 19:45:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhPya-0006Zq-SV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 19:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239Ab1GNRpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 13:45:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:36685 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab1GNRpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 13:45:14 -0400
Received: from [192.168.2.106] (p4FFD9551.dip.t-dialin.net [79.253.149.81])
	by india601.server4you.de (Postfix) with ESMTPSA id 380F32F802F;
	Thu, 14 Jul 2011 19:45:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110714172718.GA21341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177138>

Am 14.07.2011 19:27, schrieb Jeff King:
> On Thu, Jul 14, 2011 at 07:16:24PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>>>> git archive --format=3Dtar -o my.tar --transform=20
>>>> 's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD WebPortal/Templa=
tes/
>>>> error: unknown option `transform'
>>>
>>> Yeah, that won't work, because there is no such option. We do have
>>> "--prefix", but I suspect that's not flexible enough for what you w=
ant.
>>
>> If you only need a single subdirectory with a custom prefix you coul=
d do
>> something like this (variables only used to keep the lines short):
>>
>> 	$ subdir=3DWebPortal/Templates
>> 	$ prefix=3DmyPath/myWeb/Templates/
>> 	$ (cd "$subdir" && git archive --prefix=3D"$prefix" HEAD) >my.tar
>>
>> The output file can be specified with -o as well, of course, but you=
'd
>> either need to use an absolute path or add "../" for each directory
>> level you descend into (-o ../../my.tar in this case).
>=20
> Couldn't you also do:
>=20
>   git archive --prefix=3D$prefix HEAD:$subdir >my.tar
>=20
> ? I guess that loses the pax header with the commit sha1 in it, thoug=
h,
> because you are feeding a straight tree instead of a commit.

Yes, and yes.

> We didn't when git-archive was written, but these days we have
> get_sha1_with_context to remember incidental things about an object w=
e
> look up. It should perhaps remember the commit (if any) we used to re=
ach
> a treeish, and then the above command line could still insert the pax
> header.

That's a good idea to increase consistency, as there shouldn't really b=
e
a difference in output between the two subdirectory syntaxes.

I always wondered, however, if the embedded commit ID has really been
used to identify the corresponding version of an archive that somehow
lost its filename (due to being piped?).

Ren=C3=A9
